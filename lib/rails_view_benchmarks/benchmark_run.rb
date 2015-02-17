$: << File.join(File.dirname(__FILE__), 'lib')

require 'rails_view_benchmarks/configured_rails_server'
require 'rails_view_benchmarks/run_options'
require 'rails_view_benchmarks/benchmark_alias'
require 'rails_view_benchmarks/engine_alias'

require 'yaml'

module RailsViewBenchmarks
  class BenchmarkRun
    def initialize(yaml_file, temp_directory)
      @yaml_file = yaml_file
      @temp_directory = temp_directory

      @run_options = nil
      @benchmark_aliases = nil
      @engine_aliases = nil
    end

    def say(s, newline = true)
      if newline
        $stderr.puts s
      else
        $stderr << s
      end

      $stderr.flush
    end

    def run!
      load_from_file!

      for_all_benchmark_aliases do |benchmark_alias|
        for_all_engine_aliases(" ...") do |engine_alias|
          run_for!(benchmark_alias, engine_alias)
        end
      end
    end

    private
    def for_all_benchmark_aliases(indent = "")
      @benchmark_aliases.each do |benchmark_alias|
        if benchmark_alias.enabled?
          say "#{indent}BENCHMARK #{benchmark_alias.name}"
          yield benchmark_alias
        else
          say "#{indent}     skip #{benchmark_alias.name}"
        end
      end
    end

    def for_all_engine_aliases(indent = "")
      @engine_aliases.each do |engine_alias|
        if engine_alias.enabled?
          say "#{indent}ENGINE #{engine_alias.name}"
          yield engine_alias
        else
          say "#{indent}  skip #{engine_alias.name}"
        end
      end
    end

    def load_from_file!
      yaml_hash = YAML.load_file(@yaml_file)

      run_options_yaml = yaml_hash['run_options'] || raise("You must supply a 'run_options' section of your YAML file.")
      @run_options = ::RailsViewBenchmarks::RunOptions.from_yaml(run_options_yaml)

      benchmark_hashes = yaml_hash['benchmarks'] || raise("You must supply a 'benchmarks' section of your YAML file.")
      raise "Your 'benchmarks' YAML key must be an Array, not: #{benchmark_hashes.inspect}" unless benchmark_hashes.kind_of?(Array)
      @benchmark_aliases = benchmark_hashes.map do |benchmark_hash|
        raise "Your benchmark must be a Hash, not: #{benchmark_hash.inspect}" unless benchmark_hash.kind_of?(Hash)
        ::RailsViewBenchmarks::BenchmarkAlias.new(benchmark_hash)
      end

      engine_hashes = yaml_hash['engines'] || raise("You must supply an 'engines' section of your YAML file.")
      raise "Your 'engines' YAML key must be an Array, not: #{engine_hashes.inspect}" unless engine_hashes.kind_of?(Array)
      @engine_aliases = engine_hashes.map do |engine_hash|
        raise "Your engine must be a Hash, not #{engine_hash.inspect}" unless engine_hash.kind_of?(Hash)
        ::RailsViewBenchmarks::EngineAlias.new(engine_hash)
      end
    end

    def run_for!(benchmark_alias, engine_alias)
      benchmark = benchmark_alias.benchmark
      engine = engine_alias.engine

      say "[configure]", false
      crs = ::RailsViewBenchmarks::ConfiguredRailsServer.new(@temp_directory, nil, engine_alias.engine, benchmark_alias.benchmark, @run_options)
      crs.configure!
      say "[start]", false
      crs.start!

      begin
        say "[html]", false
        html = crs.rendered_html

        if @run_options.run_time?
          say "[time]", false
          time_results = crs.benchmark_memory
        end

        if @run_options.run_memory?
          say "[memory]", false
          memory_results = crs.benchmark_time
        end
      ensure
        say "[stop]", false
        crs.stop!
      end

      say "[done]"
    end
  end
end

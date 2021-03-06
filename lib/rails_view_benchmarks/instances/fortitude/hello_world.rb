require 'rails_view_benchmarks/instances/dsl_style/hello_world'
require 'rails_view_benchmarks/instances/fortitude/common'

module RailsViewBenchmarks
  module Instances
    module Fortitude
      class HelloWorld < ::RailsViewBenchmarks::Instances::DslStyle::HelloWorld
        include ::RailsViewBenchmarks::Instances::Fortitude::Common
      end
    end
  end
end

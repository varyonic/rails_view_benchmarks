require 'rails_view_benchmarks/instances/dsl_style/partial_hell'
require 'rails_view_benchmarks/instances/fortitude/common'

module RailsViewBenchmarks
  module Instances
    module Fortitude
      class PartialHell < ::RailsViewBenchmarks::Instances::DslStyle::PartialHell
        include ::RailsViewBenchmarks::Instances::Fortitude::Common
      end
    end
  end
end

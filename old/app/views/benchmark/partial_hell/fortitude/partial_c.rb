class Views::Benchmark::PartialHell::Fortitude::PartialC < Fortitude::Widgets::Html5
  needs :value

  def content
    widget Views::Benchmark::PartialHell::Fortitude::PartialB.new(:value => value)
    widget Views::Benchmark::PartialHell::Fortitude::PartialB.new(:value => value)
  end
end

class Views::Benchmark::PartialHell::Fortitude::PartialP < Fortitude::Widget::Html5
  needs :value

  def content
    widget Views::Benchmark::PartialHell::Fortitude::PartialO.new(:value => value)
    widget Views::Benchmark::PartialHell::Fortitude::PartialO.new(:value => value)
  end
end

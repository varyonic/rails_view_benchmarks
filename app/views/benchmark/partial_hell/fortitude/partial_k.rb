class Views::Benchmark::PartialHell::Fortitude::PartialK < Fortitude::Widget::Html5
  needs :value

  def content
    widget Views::Benchmark::PartialHell::Fortitude::PartialJ.new(:value => value)
    widget Views::Benchmark::PartialHell::Fortitude::PartialJ.new(:value => value)
  end
end

require 'rails_view_benchmarks/instances/base'

module RailsViewBenchmarks
  module Instances
    module Haml
      class Siannopollo < ::RailsViewBenchmarks::Instances::Base
        def configure!(c)
          c.main_view <<-EOS
!!!
%html{"lang" => "en-US"}
  %head
    %title Hampton Catlin Is Totally Awesome
    %meta{"http-equiv" => "Content-Type", :content => "text/html; charset=utf-8"}
  %body
    / You're In my house now!
    .header
      Yes, ladies and gentileman. He is just that egotistical.
      Fantastic! This should be multi-line output
      The question is if this would translate! Ahah!
      = 1 + 9 + 8 + 2 #numbers should work and this should be ignored
    #body= " Quotes should be loved! Just like people!"
    - 120.times do |number|
      = number
    Wow.|
    %p{:'data-code' => 1 + 2}
      = "Holy cow        " + |
        "multiline       " + |
        "tags!           " + |
        "A pipe (|) even!"   |
      = [1, 2, 3].collect { |n| "PipesIgnored|" }.join
      = [1, 2, 3].collect { |n|     |
          n.to_s                    |
        }.join("|")                 |
    - bar = 17
    %div.silent{:'data-foo' => bar}
      - foo = String.new
      - foo << "this"
      - foo << " shouldn't"
      - foo << " evaluate"
      = foo + " but now it should!"
      -# Woah crap a comment!

    -# That was a line that shouldn't close everything.
    %ul.really.cool
      - ('a'..'f').each do |a|
        %li= a
    #combo.of_divs_with_underscore= @should_eval = "with this text"
    = "foo".each_line do |line|
      - nil
    .footer
      %strong.shout= "This is a really long ruby quote. It should be loved and wrapped because its more than 50 characters. This value may change in the future and this test may look stupid. \\nSo, I'm just making it *really* long. God, I hope this works"
EOS
        end
      end
    end
  end
end

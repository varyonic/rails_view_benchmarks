require 'rails_view_benchmarks/instances/base'

module RailsViewBenchmarks
  module Instances
    module Erb
      class Siannopollo < ::RailsViewBenchmarks::Instances::Base
        def configure!(c)
          c.main_view <<-EOS
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang='en-US'>
  <head>
    <title>Hampton Catlin Is Totally Awesome</title>
    <meta content='text/html; charset=utf-8' http-equiv='Content-Type' />
  </head>
  <body>
    <!-- You're In my house now! -->
    <div class='header'>
      Yes, ladies and gentileman. He is just that egotistical.
      Fantastic! This should be multi-line output
      The question is if this would translate! Ahah!
      <%= 1 + 9 + 8 + 2 %>
      <%# numbers should work and this should be ignored %>
    </div>
    <% 120.times do |number| -%>
      <%= number %>
    <% end -%>
    <div id='body'><%= " Quotes should be loved! Just like people!" %></div>
    Wow.
    <p data-code="<%= 1 + 2 %>">
      <%= "Holy cow        " +
          "multiline       " +
          "tags!           " +
          "A pipe (|) even!"  %>
      <%= [1, 2, 3].collect { |n| "PipesIgnored|" }.join %>
      <%= [1, 2, 3].collect { |n|
          n.to_s
        }.join("|") %>
    </p>
    <% bar = 17 %>
    <div class='silent' data-foo="<%= bar %>">
      <% foo = String.new
         foo << "this"
         foo << " shouldn't"
         foo << " evaluate" %>
      <%= foo + "but now it should!" %>
      <%# Woah crap a comment! %>
    </div>
    <ul class='really cool'>
      <% ('a'..'f').each do |a|%>
      <li><%= a %></li>
      <% end %>
    </ul>
    <div class='of_divs_with_underscore' id='combo'><%= @should_eval = "with this text" %></div>
    <%= "foo".each_line do |line|
      nil
    end %>
    <div class='footer'>
      <strong class='shout'>
        <%= "This is a really long ruby quote. It should be loved and wrapped because its more than 50 characters. This value may change in the future and this test may look stupid.\n" +
"        So, I'm just making it *really* long. God, I hope this works" %>
      </strong>
    </div>
  </body>
</html>
EOS
        end
      end
    end
  end
end

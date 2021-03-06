class Views::Benchmark::PlacePage::Fortitude::Surfers < Views::Benchmark::PlacePage::Fortitude::Base
  needs :surfers, :place

  def content
    div :class => 'well people_container' do
      h3 :class => 'holder_header' do
        text t('surfers.title')
      end
      surfers.each do |s|
        widget Views::Benchmark::PlacePage::Fortitude::Surfer.new(:surfer => s)
      end
      div :class => 'big_cta_btn' do
        a(:class => 'link_button button', :force_login => 'true', :href => ('/n/travelers/in/place/' + (place.path.html_safe)), :id => 'autogen_id_for_tracking_place_ocrs_clicked_more_1', :title => (t('surfers.host'))) do
          text t('surfers.host')
        end
      end
    end
  end
end

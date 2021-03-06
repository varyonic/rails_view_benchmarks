class Views::Benchmark::CommentRemove < Views::Benchmark::Base
  def content
    div :class => 'modal hide fade remove-thread-modal' do
      div :class => 'modal-header' do
        button :class => 'close', 'data-dismiss' => 'modal', :type => 'button' do
          rawtext '&times;'
        end
        h3
        div do
          text t('comment.remove.title')
        end
      end
      div :class => 'modal-body' do
        div do
          text t('comment.remove.confirm')
        end
        br
        br
        div :class => 'actions' do
          a :class => 'confirm btn btn-danger', :href => 'javascript://' do
            text t('comment.remove.confirm_button')
          end
          rawtext '&nbsp;'
          a :class => 'cancel btn', 'data-dismiss' => 'modal', :href => 'javascript://' do
            text t('buttons.cancel')
          end
        end
      end
    end
  end
end

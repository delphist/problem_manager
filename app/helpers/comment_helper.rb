module CommentHelper
  def format_comment comment
    result = h(comment.body)
    comment.body.scan(/\@u(\d+)/).map { |e| e[0] }.each do |user_id|
      mentioned_user = User.where(:id => user_id).first
      result.gsub!("@u#{user_id}", link_to(mentioned_user.name, "#", class: "mention-user", "data-user-id" => mentioned_user.id)) unless mentioned_user.nil?
    end
    result.gsub! "\n", "<br />"
    result.html_safe
  end
end
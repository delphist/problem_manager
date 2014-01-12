class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates :body, presence: true, length: { in: 1..5000 }
  validates :user, presence: true
  validates :problem, presence: true

  normalize_attributes :body

  after_create :process_mentions

  def process_mentions
    user_ids = body.scan(/\@u(\d+)/).map { |e| e[0] }.uniq

    if user_ids.count > 0
      users = User.where(:id => user_ids)
      users.each do |to_user|
        UserMailer.mention_email(to_user, self.user, self).deliver
      end
    end
  end
end

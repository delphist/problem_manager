class Task < ActiveRecord::Base
  belongs_to :executor, :class_name => "User", :foreign_key => :executor_id
  belongs_to :director, :class_name => "User", :foreign_key => :director_id
  belongs_to :problem

  validates :director, presence: true
  validates :executor, presence: true
  validates :title, presence: true, length: { in: 1..100 }
  validates :description, presence: true, length: { in: 1..10000 }
  validates :deadline_at, presence: true, timeliness: { type: :date }

  normalize_attributes :title, :description

  def deadline_days
    (Time.zone.now - deadline_at).to_i / 1.day
  end

  def status_title
    if completed
      "Выполнена"
    else
      if completed_request
        "Ожидает подтверждения о выполнении"
      else
        "В процессе выполнения"
      end
    end
  end
end
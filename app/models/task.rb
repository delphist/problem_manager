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

  after_create :notification_create

  def deadline_days
    (deadline_at - Date.today).to_i
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

  def notification_create

  end

  def accept
    self.completed_request = false
    self.completed = true
    self.completed_at = Time.now
  end

  def decline
    self.completed_request = false
    self.completed = false
  end

  def complete
    self.completed_request = true
    self.completed = false
  end

  def cancel
    self.completed_request = false
    self.completed = false
  end

  def accept!
    accept
    save!
  end

  def decline!
    decline
    save!
  end

  def complete!
    complete
    save!
  end

  def cancel!
    cancel
    save!
  end
end
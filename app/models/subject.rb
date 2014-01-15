class Subject < ActiveRecord::Base
  belongs_to :parent_subject, :class_name => "Subject", :foreign_key => "parent_id"

  has_many :child_subjects, :class_name => "Subject", :foreign_key => "parent_id"
  has_many :problems

  normalize_attributes :title

  validates :title, :presence => true, :length => { :in => 2..255 }

  def full_title
    result = []
    result = parent_subject.full_title unless parent_subject.nil?
    result << title
    result
  end

  def full_title_joined
    full_title.join " → "
  end
end

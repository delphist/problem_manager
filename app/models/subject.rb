class Subject < ActiveRecord::Base
  belongs_to :parent_subject, :class_name => "Subject", :foreign_key => "parent_id"

  has_many :child_subjects, :class_name => "Subject", :foreign_key => "parent_id"
  has_many :problems

  normalize_attributes :title

  validates :title, :presence => true, :length => { :in => 2..255 }
end

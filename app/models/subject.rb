class Subject < ActiveRecord::Base
  has_many :problems

  validates :title, :presence => true, :length => { :in => 2..255 }
end

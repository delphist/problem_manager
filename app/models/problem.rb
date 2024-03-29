class Problem < ActiveRecord::Base
  belongs_to :subject
  belongs_to :status

  has_many :comments

  validates :subject, :presence => true
  validates :status, :presence => true
  validates :email, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :vk, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :link, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :address, :presence => false, :length => { :in => 2..255 }, :allow_nil => true
  validates :person, :presence => true, :length => { :in => 2..255 }
  validates :description, :presence => true, :length => { :in => 2..60000 }
  validates :title, :presence => true, :length => { :in => 2..255 }
  validates :rating, :presence => true, :numericality => true, :inclusion => { :in => 0..10 }
  validates :phone, :presence => false

  normalize_attributes :email, :vk, :link, :address, :person, :description, :title, :phone

  def distance_car_km
    if distance_car.nil?
      ""
    else
      (distance_car / 1000).round(2)
    end
  end

  def distance_km
    if distance.nil?
      ""
    else
      (distance / 1000).round(2)
    end
  end
end

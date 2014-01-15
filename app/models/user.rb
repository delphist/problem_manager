class User < ActiveRecord::Base
  ACCESS_LEVELS = { :full => "Полный", :read => "Только чтение", :read_comment => "Чтение и написание комментариев" }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :comments

  validates :name, presence: true, length: { in: 2..100 }
  validates :access_level, presence: true, inclusion: { in: ["full", "read", "read_comment"] }

  normalize_attributes :name

  def access_level? param
    param == access_level.to_sym
  end

  def access_level_title
    ACCESS_LEVELS[access_level.to_sym] unless access_level.nil?
  end
end

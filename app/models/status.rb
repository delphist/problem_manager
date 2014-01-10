class Status < ActiveRecord::Base
  COLORS = {
      :night => "235395",
      :lightblue => "77B4EE",
      :grey => "ACABA6",
      :green => "53CC3F",
      :orange => "DD8A53",
      :darkgreen => "178B04",
      :darkblue => "3341E4",
      :blue => "1C9CFF",
      :black => "283140",
      :brown => "916033",
      :yellow => "CDBF20",
      :white => "EEEEEE",
      :violet => "BB23FF",
      :red => "F85151",
      :pink => "EF92EA",
      :darkorange => "C86521",
  }

  has_many :problems

  validates :title, :presence => true, :length => { :in => 2..255 }

  def map_color_css
    COLORS[map_color.to_sym]
  end
end

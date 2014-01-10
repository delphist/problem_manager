class Problem < ActiveRecord::Base
  belongs_to :subject
  belongs_to :status
end

class Project < ActiveRecord::Base
  belongs_to :customer
  validates :title, presence: true
  validates :status, presence: true
end

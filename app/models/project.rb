class Project < ActiveRecord::Base
  belongs_to :customer
  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :status, presence: true
end

class Customer < ActiveRecord::Base
  has_many :projects
  validates :title, presence: true,
                    length: { minimum: 2 }
end

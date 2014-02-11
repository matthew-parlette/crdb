class Customer < ActiveRecord::Base
  has_many :projects
  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :importance, :numericality => {:only_integer => true}
end

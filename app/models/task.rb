class Task < ActiveRecord::Base
  belongs_to :project
  
  validates :title, presence: true
  validates :project_id, presence: true
end

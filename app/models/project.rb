include ApplicationHelper

class Project < ActiveRecord::Base
  include ActiveModel::Dirty
  
  belongs_to :customer
  
  before_save :update_completed_date
  
  validates :title, presence: true
  validates :status, presence: true
  validates_inclusion_of :status, :in => status_options()

  private
    
    #update the completed_date if the status was changed to completed
    def update_completed_date
      if self.status_changed?
        if self.status == 'complete'
          self.completed_date = Date.today
        end
      end
    end
end

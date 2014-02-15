class Project < ActiveRecord::Base
  belongs_to :customer
  
  validates :title, presence: true
  validates :status, presence: true
  
  private
    #format_links: ensure the links field is a comma-separated list.
    def presave
      #split on newline and comma
      self.links = self.links.split(/[\n,]/).join(",")
    end
    
    def preload
      #convert comma-separated links to a list
      self.links = self.links.split(",")
    end
end

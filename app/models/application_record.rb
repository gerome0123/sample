class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def creator
    return 'Unknown' if paper_trail.originator.blank?
    User.find_by(username: paper_trail.originator)
  end
end

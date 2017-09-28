class Base < ActiveRecord::Base
  self.abstract_class = true

  has_paper_trail

  def creator
    return 'Unknown' if paper_trail.originator.blank?
    User.find_by(username: paper_trail.originator)
  end
end

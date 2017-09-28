class Ability
  include CanCan::Ability

  attr_accessor :user

  def initialize(user)
    @user = user || User.new

    can :manage, :all
    # can :index, Bank
    # can :index, Document::Type, division_id: user.division.id
    # can %i[index show create], Matter, division_id: user.division.id
    # can %i[index show], Document, matter: { division_id: user.division.id }
    # can %i[index show create update], Document
    # can %i[index show create], Attachment
    # can %i[index show], Division, id: user.division.id
    # can %i[index show], Document::Type, division_id: user.division.id
  end
end

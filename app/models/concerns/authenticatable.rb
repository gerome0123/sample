module Authenticatable
  extend ActiveSupport::Concern

  included do
    rolify strict: true
    devise :database_authenticatable, :lockable, :recoverable, :registerable,
           :rememberable, :trackable, :timeoutable, :validatable

    def active_for_authentication?
      super && active
    end
  end
end

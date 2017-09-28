require 'api_responder'

module Api
  class BaseController < ActionController::API
    include ActionController::ImplicitRender
    include CanCan::ControllerAdditions
    include ActionController::Serialization
    include PaperTrail::Rails::Controller

    self.responder = ::ApiResponder

    respond_to :json

    before_action :authenticate_user!
    # before_action :set_paper_trail_whodunnit

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    # rescue_from CanCan::AccessDenied, with: :unauthorized

    def _serialization_scope
      :current_ability
    end

    private

    def not_found
      render(head: true, status: :not_found) && return
    end

    def unauthorized
      render(head: true, status: :unauthorized) && return
    end
  end
end

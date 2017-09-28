require 'responders'

class ApiResponder < ActionController::Responder
  include ::Responders::HttpCacheResponder

  def api_behavior
    raise MissingRenderer, format unless has_renderer?

    if get?
      display resource
    elsif post?
      display resource, status: :created, location: api_location
    elsif patch? || put?
      display resource, status: :ok, location: api_location
    else
      head :no_content
    end
  end
end

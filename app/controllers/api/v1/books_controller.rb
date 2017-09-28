module Api
  module V1
    class BooksController < BaseController
      include Books::Common

      load_and_authorize_resource :book, class: 'Book'

      # GET /v1/books
      # POST /v1/books
      # POST /v1/books/:id
      # PATCH/PUT /v1/books/:id
      # DELETE /v1/books/:id
      %i[index create show update destroy].each do |action|
        send "add_#{action}_books_action"
      end
    end
  end
end

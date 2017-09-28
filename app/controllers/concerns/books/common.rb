module Books
  module Common
    extend ActiveSupport::Concern

    private

    def book_params
      params.permit(:title)
    end

    def book_path
      api_book_path(@book)
    end

    class_methods do
      def add_index_books_action
        define_method :index do
          respond_with(@books)
        end
      end

      def add_create_books_action
        define_method :create do
          @book.save
          respond_with(@book, location: -> { book_path })
        end
      end

      def add_show_books_action
        define_method :show do
          @book.save
          respond_with(@book)
        end
      end

      def add_update_books_action
        define_method :update do
          book.update(book_params)
          respond_with(@book, location: -> { book_path })
        end
      end

      def add_destroy_books_action
        define_method :destroy do
          @book.destroy
          respond_with(@book)
        end
      end
    end
  end
end

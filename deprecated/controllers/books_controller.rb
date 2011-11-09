class BooksController < ApplicationController
  respond_to :html, :js, :json

  expose(:shelf) { load_shelf }
  expose(:shelf?) { shelf.present? }
  expose(:books) { current_camp.books }
  expose(:book)

  def index
    redirect_to shelf? ? shelf : root_path
  end

  expose(:latest_books) { current_camp.books.order('id DESC').limit(5) }
  expose(:commented_books) { current_camp.books.where('comments_count > 0').order('comments_count DESC').limit(5) }
  expose(:like_it_books) { current_camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(5) }
  expose(:read_later_books) { current_camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(5) }

  def statistics
  end

  expose(:search_results) { RefSearch.new(current_camp.books).search(params[:term]) }

  def search

  end

  def view
    render :layout => false
  end

  def show
    respond_with :book
  end

  def new
    book.include_in_shelf_id = params[:shelf_id]
    authorize! :new, book
  end

  def edit
    authorize! :edit, book
  end

  def create
    book.user = current_user
    book.camp = current_camp
    authorize! :create, book
    flash[:notice] = t('books.notice.create') if book.save
    respond_with book
  end

  def update
    authorize! :update, book
    rol = current_user.rol ? current_user.rol.to_sym : nil
    book.update_attributes(params[:book], :as => rol)
    respond_with book
  end

  def destroy
    authorize! :destroy, book
    book.destroy
    respond_with book, :location => root_path
  end

  protected
  def load_shelf
    params.each do |name, value|
      if name =~ /(.*_?shelf)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
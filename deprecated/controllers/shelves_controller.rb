class ShelvesController < ApplicationController
  respond_to :html, :js, :json

  expose(:shelves) { current_camp.shelves }
  expose(:shelf)

  # SEARCH
  expose(:autoshelf) { AutoShelf.find(params[:id], current_camp) }

  def browse
  end

  def index
  end

  def auto

  end

  def show
  end

  def new
    authorize! :new, Shelf
  end

  def edit
    authorize! :edit, shelf
  end

  def create
    shelf.user = current_user
    shelf.camp = current_camp
    authorize! :create, shelf
    flash[:notice] = "Lista creada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

  def update
    authorize! :update, shelf
    flash[:notice] = "Lista modificada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

  def destroy
    authorize! :destroy, shelf
    if shelf.books.count == 0
      flash[:notice] = t('shelves.notice.destroy') if shelf.destroy
      respond_with shelf, :location => shelves_path
    else
      flash[:notice] = t('shelves.notice.not_empty')
      respond_with shelf
    end
  end

end
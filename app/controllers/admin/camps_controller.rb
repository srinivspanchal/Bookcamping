class Admin::CampsController < Admin::ApplicationController
  before_filter :require_super
  respond_to :html
  expose(:camps) { Camp.all }
  expose(:camp)

  def index

  end

  def show

  end

  def enter
    if Rails.env.development?
      session[:camp_id] = params[:id]
      flash[:notice] = "Nos vamos"
    end
    redirect_to root_path
  end

  def edit
    authorize! :edit, camp
  end

  def update
    authorize! :update, camp
    flash[:notice] = t('camps.notice.update') if camp.update_attributes(params[:camp])
    respond_with camp, :location => root_path
  end

end

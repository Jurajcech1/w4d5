class SubsController < ApplicationController
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    @posts = @sub.posts
    flash[:sub_id] = @sub.id
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(subs_params)
    @sub.moderator_id = current_user.id
    if @sub
      @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    if is_authorized?(@sub.moderator_id)
      render :edit
    else
      redirect_to sub_url(@sub)
    end
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update(subs_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private

  def subs_params
    self.params.require(:sub).permit(:title, :description)
  end

end

class PostsController < ApplicationController


  def new
    @post = Post.new
    flash[:sub_id] = flash[:sub_id]

    render :new
  end

  def show
    @post = Post.find_by_id(params[:id])
    render :show
  end



  def create
    @post = Post.new(posts_params)
    @post.sub_id = flash[:sub_id]
    @post.author_id = current_user.id
    if @post
      @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    if is_authorized?(@post.author_id)
      render :edit
    else
      redirect_to post_url(@post)
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(posts_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def posts_params
    self.params.require(:post).permit(:title, :content, :url)
  end

end

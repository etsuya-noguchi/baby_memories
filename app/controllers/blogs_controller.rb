class BlogsController < ApplicationController
   before_action :set_blog, only: [:show, :edit, :update, :destroy]
   before_action :logged_in?, only: [:new, :edit, :show, :destroy]
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
     @blog = Blog.new(blog_params)
     @blog.image.retrieve_from_cache! params[:cache][:image]if params[:cache][:image].present?
    else
     @blog = Blog.new
    end

  end

  def edit
    # @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache!  params[:cache][:image]if params[:cache][:image].present?
    if @blog.save
      redirect_to blogs_path, notice: "写真を投稿しました！"
    else
      render 'new'
    end
  end


  def show
    @blog = Blog.find(params[:id])
    # @user = User.find_by(id: @blog.user_id)
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)

  end

  def update
   @blog = Blog.find(params[:id])
   if @blog.update(blog_params)
     redirect_to blogs_path, notice: "写真を編集しました！"
   else
     render 'edit'
   end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"写真を削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
     render :new if @blog.invalid?
  end



  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :user_id)
  end

  def set_blog
   @blog = Blog.find(params[:id])
  end

  def logged_in?
    if current_user.nil?
      redirect_to new_session_path
    end
  end
end

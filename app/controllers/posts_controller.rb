class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :edit, :update, :destroy]
  def index
    # @posts = Post.all
    @posts = Post.find_newest_post(params[:page]).with_user_and_comment
    @comment = Comment.new
  end

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    # @post = Post.new(post_params) # ストロングパラメータを引数に
    @post = current_user.posts.new(post_params)
    @post.save # saveをしてデータベースに保存する。
    # redirect_to @post # showページにリダイレクト
    # redirect_to @post, notice: '投稿を保存しました' # showページにリダイレクト
    if @post.save
      redirect_to @post, notice: "投稿を登録しました。"
    else
      render :new
    end
  end

  def show
    # @post = Post.find(params[:id])

    @post = Post.with_attached_image.includes(comments: [user: [ avatar_attachment: :blob ]], user: [ avatar_attachment: :blob ]).find(params[:id])

    @comment = Comment.new
    
  end

  def edit
    # @post = Post.find(params[:id])
  end
  def update
    # @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params # ストロングパラメータを定義する
    # params.require(:post).permit(:caption)
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

class PostsController < ApplicationController

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    @post = Post.new(post_params) # ストロングパラメータを引数に
    @post.save # saveをしてデータベースに保存する。
    redirect_to @post # showページにリダイレクト
  end

  private

  def post_params # ストロングパラメータを定義する
    # params.require(:post).permit(:caption)
    params.require(:post).permit(:caption, :image)
  end
end

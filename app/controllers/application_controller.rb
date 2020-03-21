class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_search

  def after_sign_in_path_for(resource)
    # mypage_root_path # ログイン後に遷移するpathを設定
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    new_user_session_path # ログアウト後に遷移するpathを設定
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result.find_newest_post(params[:page]).with_user_and_comment
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :description, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :avatar])
  end
end

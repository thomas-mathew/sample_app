class UsersController < ApplicationController
  include SessionsHelper
  before_filter :signed_in_user, :only => [:index, :edit, :update]
  before_filter :correct_user,   :only => [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the QVB Project!"
      redirect_to @user
      UserMailer.welcome_email(@user).deliver
    else
      render 'new'
    end
  end

def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

def index
    @users = User.paginate(page: params[:page])
end

private
  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
      #Note that this is equivalient to below:
      #unless signed_in?
        #flash[:notice] = "Please sign in."
        #redirect_to signin_url
      #end
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end

end
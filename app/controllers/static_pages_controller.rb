class StaticPagesController < ApplicationController
include SessionsHelper

  def home
  	#if current_user.present?
  	#	redirect_to current_user
  	#end
  end

  def help
  end

  def about
  end

  def contact
  end
end

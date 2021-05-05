class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to rooms_path
    end
  end
end

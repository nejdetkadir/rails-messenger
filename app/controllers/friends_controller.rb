class FriendsController < ApplicationController
  
  def destroy
    @user = User.friendly.find(params[:id])
    
    if current_user.friends_with?(@user)
      current_user.remove_friend(@user)
      flash[:notice] = "#{@user.username} successfully removed from your friends list"
    else
      flash[:alert] = "An error has occurred"
    end

    redirect_to root_path
  end

  def search
    @user = User.where(username: search_params[:username])
    
    if @user.any?
      @user = @user.first
      if current_user.friends_with?(@user)
        flash[:alert] = "You are already friend with #{@user.username}"
      else
        current_user.friend_request(@user)
        @user.accept_request(current_user)
        flash[:notice] = "You added #{@user.username} as a friend"
      end
    else
      flash[:alert] = "No user could be found belonging to this information"
    end

    redirect_to root_path
  end

  private
    def search_params
      params.require(:user).permit(:username)
    end
end
class UsersController < ApplicationController
    
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      @gifts = @user.gifts

      erb :'users/show'
    end

end

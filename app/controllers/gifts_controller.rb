require 'sinatra/base'


class GiftsController < ApplicationController

 enable :sessions
 enable :method_override

    get '/gifts' do
        if logged_in?(session)
            @user = current_user(session)
            @gifts = Gift.all 
            @users = current_user(session)
        else
            redirect to "/login"
        end
        erb :'gifts/gifts'
    end

    get '/gifts/new' do
        if logged_in?(session)
            erb :'gifts/add_gift'
        else
            redirect to "/login"
        end
    end

    post '/gifts/new' do 
        if logged_in?(session)
            erb :'gifts/add_gift'
        else
            redirect to "/login"
        end
    end

    post '/gifts' do
        @gift = Gift.new(params)
        if @gift.content == ""
          redirect to "/gifts/new"
        else
            @gift.save
            @user = current_user(session)
            @user.gifts << @gift
            redirect to "/gifts"
        end
    end
    
    get '/gifts/:id' do
        if logged_in?(session)
            @gift = current_gift(params[:id])
            erb :'gifts/show_gifts'
        else
            redirect to "/login"
        end
    end

    get '/gifts/:id/edit' do
        if logged_in?(session)
            @gift = current_gift(params[:id])
            erb :'gifts/show_gift'
        else
            redirect to "/login"
        end
    end

    post '/gifts/all' do 
        @user = current_user(session)
        @gifts = Gift.all
        @users = User.all 
        erb :'gifts/all_gifts'
    end 

    post '/gifts/:id/edit' do
        if logged_in?(session)
            @gift = current_gift(params[:id])
            erb :'gifts/show_gift'
        else
            redirect to "/login"
        end
    end

    patch '/gifts/:id' do
        @gift = current_gift(params[:id])
        @user = current_user(session)
        if @gift.user_id == @user.id
            if params["content"] != ""
                @gift.content = params["content"]
                @gift.save
                "Successfully updated gift."
                redirect to "/gifts"
            else 
                "Your gift can't be empty"
                redirect to "/gifts/#{@gift.id}/edit"
            end
        else
            "You can only edit and delete your own gifts"
            redirect to "/gifts"
        end
    end

    delete '/gifts/:id' do
        if logged_in?(session)
            @user = current_user(session)
            @gift = current_gift(params[:id])
            if @gift.user_id == @user.id
                @gift.delete
                redirect to '/gifts'
            else
                redirect to "/gifts"
            end
        end
    end
end


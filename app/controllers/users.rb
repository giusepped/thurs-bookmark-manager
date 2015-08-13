require_relative './base'

module Armadillo
  module Routes
    class Users < Base
      get '/users/new' do
        @user = User.new
        erb :'users/new'
      end

      post '/users' do
        @user = User.create(email: params[:email],
                           password: params[:password],
                           password_confirmation: params[:password_confirmation])
        if @user.save
          session[:user_id] = @user.id
          redirect to('/')
        else
          flash.now[:errors] = @user.errors.full_messages.join(', ')
        end
      end

    end
  end

end
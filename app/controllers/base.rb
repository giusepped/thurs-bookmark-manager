require 'sinatra/base'
require 'sinatra/flash'
require_relative '../data_mapper_setup'

module Armadillo
  module Routes
    class Base < Sinatra::Base
      enable :sessions
      register Sinatra::Flash
      set :session_secret, 'super secret'
      use Rack::MethodOverride
      set :views, proc { File.join(root, '..', 'views') }

      helpers do
        def current_user
          current_user ||= User.get(session[:user_id])
        end
      end
    end
  end
end
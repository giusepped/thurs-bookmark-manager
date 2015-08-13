require_relative './base'

module Armadillo
  module Routes
    class Index < Base
      get '/' do
        erb :root
      end
    end
  end
end
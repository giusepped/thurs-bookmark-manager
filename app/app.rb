require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'controllers/controller_init'

module Armadillo
  class App < Sinatra::Base
    use Routes::Index
    use Routes::Links
    use Routes::Users
    use Routes::Sessions
    # use Models::Link

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end

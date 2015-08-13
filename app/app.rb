require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

require_relative 'controllers/index'
require_relative 'controllers/links'
require_relative 'controllers/users'
require_relative 'controllers/sessions'


module Armadillo
  class App < Sinatra::Base
    use Routes::Index
    use Routes::Links
    use Routes::Users
    use Routes::Sessions

    # start the server if ruby file executed directly
    run! if app_file == $0
  end

end

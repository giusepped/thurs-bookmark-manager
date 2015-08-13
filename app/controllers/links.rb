require_relative './base'

module Armadillo
  module Routes
    class Links < Base
      get '/links' do
        @links = Link.all
        erb :index
      end

      get '/links/new' do
        erb :new_link
      end

      post '/links' do
        link = Link.new(url: params[:url], title: params[:title])
        params[:tag].split(" ").each do |name|
          tag = Tag.create(name: name.downcase)
          link.tags << tag
        end
        link.save
        redirect '/links'
      end

      get '/tags/:name' do
        tag = Tag.first(name: params[:name].downcase)
        @links = tag ? tag.links : []
        erb :index
      end

    end
  end

end
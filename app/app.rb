ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'tilt/erb'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
    use Rack::MethodOverride
    
    enable :sessions
    set :session_secret, 'super secret'
    
    register Sinatra::Flash
    
    helpers do
        def current_user
            @current_user ||= User.get(session[:user_id])
        end
    end
    
    get '/' do
        redirect '/links'
    end
    
    get '/users/new' do
        @user = User.new
        erb :'users/new'
    end
    
    post '/users' do
        @user = User.create( email: params[:email], 
                            password: params[:password],
                            password_confirmation: params[:password_confirmation])
        if @user.save
            session[:user_id] = @user.id
            redirect '/'
        else
            flash.now[:errors] = @user.errors.full_messages
            erb :'users/new'
        end
    end
    
    get '/links' do
        @links = Link.all
        erb :'links/index'
    end
    
    post '/links' do
        link = Link.create(url: params[:url], title: params[:title])
        params[:tags].split.each do |tag|
            link.tags << Tag.first_or_create(name: tag)
        end
        link.save
        redirect '/links'
    end
    
    get '/links/new' do
        erb :'links/new'
    end
    
    get '/tags/:name' do
        tag = Tag.first(name: params[:name])
        @links = tag ? tag.links : []
        erb :'links/index'
    end
    
    get '/sessions/new' do
        erb:'sessions/new'
    end
    
    post '/sessions' do
        user = User.authenticate(params[:email], params[:password])
        if user
            session[:user_id] = user.id
            redirect '/links'
        else
            flash.now[:errors] = ["The email or password is incorrect"]
            erb :'sessions/new'
        end
    end
    
    delete '/sessions' do
        session[:user_id] = nil
        flash.keep[:notice] = 'Farewell!'
        redirect to '/links'
    end
    
    # start the server if ruby file executed directly
    run! if app_file == $0
end
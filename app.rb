require 'sinatra/base'
require 'tilt/erb'

class Bookmark < Sinatra::Base
    enable :sessions

    # start the server if ruby file executed directly
    run! if app_file == $0
end
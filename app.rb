require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/bookmark'
require_relative './lib/comment'
require_relative './lib/user'
require_relative './lib/tag'
require_relative './lib/bookmark_tag'
require './database_connection_setup'
require 'uri'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
  end

  enable :sessions, :method_override
  
  get '/' do
    'Bookmark Manager'
  end
  
  get '/users/new' do
    erb :'users/new'
  end
  
  post '/users' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec_params("INSERT INTO users (email, password) VALUES ($1, $2);", [params[:email], params[:password]])
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @user = User.find(id: session[:user_id])
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL" unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec_params("INSERT INTO comments (text, bookmark_id) VALUES ($1, $2);", [params[:comment], params[:id]])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'tags/new'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:tag])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec_params("INSERT INTO tags (content) VALUES ($1);", [params[:tag]])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end

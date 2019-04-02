
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/:id' do
    @id = params[:id].to_i
    @article = Article.find(@id)

    erb :show
  end

  patch '/articles/:id' do
    binding.pry
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect  "/articles/#{ @article.id }"
  end

  get '/articles/:id/edit' do
    @id = params[:id].to_i
    @article = Article.find(@id)

    erb :edit
  end

  post '/articles' do
    @article_title = params[:title]
    @content = params[:content]
    @article = Article.create(title: @article_title, content: @content)

    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @id = params[:id].to_i
    Article.find(@id).destroy
    redirect "/articles"
  end
end

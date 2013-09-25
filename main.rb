require 'sinatra'
require 'json'
require 'cgi'

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    @config = JSON.parse(File.read("config.json"))
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [@config['user'], @config['password']]
  end
end

get '/' do
  @config = JSON.parse(File.read("config.json"))
  protected! if @config['user'] && @config['password']
  @posts = JSON.parse(File.read("posts.json"))
  @posts.each do |post|
    post['body'] = CGI.unescapeHTML(post['body'])
  end

  erb :index
end

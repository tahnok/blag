require 'sinatra'
require 'json'
require 'cgi'

get '/' do
  @config = JSON.parse(File.read("config.json"))
  @posts = JSON.parse(File.read("posts.json"))
  @posts.each do |post|
    post['body'] = CGI.unescapeHTML(post['body'])
  end

  erb :index
end

require 'sinatra'
require 'json'

get '/' do
  @blog = JSON.parse(File.read("blog.json"))
  erb :index
end

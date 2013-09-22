require 'redcarpet'
require 'cgi'
require 'json'

task :default => [:server]

task :server do
  ruby "main.rb"
end

task :generate do
  @posts = []
  renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  Dir.glob('posts/*.md') do |post|
    @posts << {
      time: File.open(post).mtime.to_i,
      title: post.basename,
      body: CGI.escapeHTML(renderer.render(File.read(post)))
    }
  end
  @posts.sort!{|a,b| a[:time] <=> b[:time] }
  File.open('posts.json', 'w').write(@posts.to_json)
end

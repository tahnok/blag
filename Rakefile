require 'redcarpet'
require 'cgi'
require 'json'

task :default => [:server]

desc "Run the blag platform"
task :server do
  ruby "main.rb"
end

desc "run blag with rerun to reload whenever the code changes"
task :development do
  system "rerun main.rb"
end

desc "generate posts.json from markdown files in posts/"
task :generate do
  @posts = []
  renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  Dir.glob('posts/*.md') do |post|
    @posts << {
      time: File.open(post).mtime.strftime('%F %R'),
      title: File.basename(post, '.md').gsub('_', ' '),
      body: CGI.escapeHTML(renderer.render(File.read(post)))
    }
  end
  @posts.sort!{|a,b| b[:title] <=> a[:title] }
  File.open('posts.json', 'w').write(@posts.to_json)
end

desc "make a new post, optionally passing in filename/title"
task :new, :title do |t, args|
  if ARGV[1]
    title = ARGV[1]
  else
    puts "enter new title:"
    title = STDIN.gets.chomp
  end
  title.gsub!(' ', '_')
  title.squeeze!('_')
  post_path = "posts/#{title}.md"
  if File.exists?(post_path)
    puts "error, name already taken"
  else
    File.open(post_path, 'w').write('')
    if ENV['EDITOR']
      system "#{ENV['EDITOR']} #{post_path}"
    end
  end
end

desc "combines new and generate"
task :blog, :title do |t, args|
  Rake::Task[:new].invoke(args)
  Rake::Task[:generate].invoke
end

#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require "thor"

class Post < Thor
  desc "create", "creates a post file in markdown for jekyll"
  def create(title="new post")
    slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    begin
      date = (ENV['date'] ?
        Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
    end
    filename = File.join("./", "#{date}-#{slug}.md")
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end

    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: #{title.gsub(/-/,' ').capitalize}"
      post.puts "description:"
      post.puts "category:"
      post.puts "tags: []"
      post.puts "---"
    end
  end # task :post
end

#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require "thor"

class RbProject < Thor
  desc "init", "creates a ruby project with rspec"

  def init(title="new_project")
    Dir.mkdir(title)
    Dir.chdir(title)
    Dir.mkdir("spec")
    Dir.mkdir("lib")
    filename = "#{title}"

    open(File.new("README.md", "w"), "w") do |note|
      note.puts "# #{title}"
    end

    open(File.new("Gemfile", "w"), "w") do |my_gem|
      my_gem.puts "ruby '2.0.0'"
      my_gem.puts "gem 'rspec'"
    end

    open(File.new(filename, "w"), "w") do |launcher|
      launcher.puts "#!/usr/bin/env ruby"
      launcher.puts "# #{filename}"
      launcher.puts "# #{Time.now.strftime("%d-%b-%Y")}"
      launcher.puts "#"
      launcher.puts "# Usage:"
      launcher.puts "#"
      launcher.puts "$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))"
      launcher.puts "require '#{filename}'"
      launcher.puts "#{camelize(filename)}.new"
    end

    open(File.new("lib/#{filename}.rb", "w"), "w") do |spec|
      spec.puts "class #{camelize(filename)}"
      spec.puts "end"
    end

    open(File.new("spec/spec_helper.rb", "w"), "w") do |spec|
      spec.puts "$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))"
      spec.puts "require 'rspec'"
      spec.puts "require '#{filename}'"
    end

    open(File.new("spec/#{filename}_spec.rb", "w"), "w") do |spec|
      spec.puts "require 'spec_helper'"
      spec.puts ""
      spec.puts "describe #{camelize(filename)} do"
      spec.puts "  before (:each) {  }"
      spec.puts "  xit 'should pass'"
      spec.puts "end"
    end
  end

  private
    def camelize(snake)
      title = snake.split('_').each do |word|
        word.capitalize!
      end
      title.join('')
    end
end
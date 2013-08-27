#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require "thor"

class RbProject < Thor
  desc "init", "creates a ruby project with rspec"

  def init(title="newProject")
    Dir.mkdir(title)
    Dir.chdir(title)
    Dir.mkdir("spec")
    Dir.mkdir("lib")
    filename = "#{title}"

    open(File.new("README.md", "w"), "w") do |note|
      note.puts "# #{title}"
    end

    open(File.new("lib/#{filename}.rb", "w"), "w") do |spec|
      spec.puts "class #{title.capitalize}"
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
      spec.puts ""
      spec.puts "describe #{filename.capitalize} do"
      spec.puts "before do"
      spec.puts "end"
      spec.puts "it 'should pass'"
      spec.puts "end"
    end
  end
end
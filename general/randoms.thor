#!/usr/bin/env ruby
require "rubygems"
require "thor"

class Randoms < Thor
  desc "gen", "generates random words - defaults to 2 if no integer provided"

  attr_accessor :word_array, :dictionary

  def gen(number=2)
    get_started
    get_dictionary
    get_words(number.to_i)
  end

  private
    def get_started
      @dictionary = "/usr/share/dict/british-english"
      @word_array = []
    end

    def get_dictionary
      File.open(dictionary, "r") do |infile|
        process_file(infile)
      end
    end

    def process_file(infile)
      while (line = infile.gets)
          word_array << line.chomp unless line.match(/'|[A-Z]/)
      end
    end

    def get_words(number)
      number.times do
        puts word_array[rand(word_array.length)]
      end
    end
end
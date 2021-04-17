require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters  = []
    9.times do
      @letters << ("A".."Z").to_a[rand(26)]
    end
    @letters 
  end

  def score
    # raise
    @word = params[:word]
    @letters = params[:letters].split(" ")
    @valid_letters = valid_letters?(@word, @letters)
    @in_dictionary = in_dictionary?(@word)
  end

  private

  def valid_letters?(word, letters)
    valid_answer = true
    letters_used = word.upcase.split("")
    
    letters_used.each do |letter_used|
      valid_answer = false unless letters.count(letter_used) >= word.upcase.count(letter_used)
    end
    valid_answer
  end

  def in_dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = open(url).read
    result = JSON.parse(serialized)
    result["found"]
  end
end

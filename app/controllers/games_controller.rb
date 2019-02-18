require 'open-uri'
require 'JSON'

class GamesController < ApplicationController
  LETTERS = ('A'..'Z').to_a
  VOWELS = ['A', 'E', 'I', 'O', 'U']

  def new
    @letters = []
    8.times { @letters << LETTERS.sample(1) }
    2.times { @letters << VOWELS.sample(1) }
    @letters.flatten!
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters].downcase.split
    guess = @word.split('')
    if guess.all? { |letter| guess.count(letter) <= @letters.count(letter) }
      json = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      @object = JSON.parse(json)
      @result = "Congratulations! #{@word} is a valid word!" if @object['found'] == true
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    end
    # go through each letter of the word, if the letter is present remove it from the
    # original letters array
  end
end

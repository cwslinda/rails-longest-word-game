require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end


  def score
    @words = params[:words]
    @letters = params[:letters]
    @check = []
    @message = ''
    url = "https://wagon-dictionary.herokuapp.com/#{@words}"
    result = URI.open(url).read
    json_result = JSON.parse(result)

      @words.split("").each do |letter|
        if @letters.include?(letter.upcase)
          @check << true
        else
          @check << false
        end
      end

    if @check.include?(false)
      @message = "Sorry but #{@words} can't be bulit out of #{@letters}"
    elsif @check.all?(true) && json_result['found'] == true
      @message = "Congratualation #{@words} is valid English word!"
    else
      @message = "Sorry but #{@words} does not seem to be a valid English word. "
    end
  end
end

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses


  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(candidate)
    if (invalid_guess?(candidate)) || (candidate == '')
      raise ArgumentError.new("Your guess was invalid")
    elsif candidate == nil
      throw :ExceptionError
    elsif @guesses.include?(candidate.downcase) or @wrong_guesses.include?(candidate.downcase)
      result = false
    else
      if do_they_match?(@word, candidate)
        @guesses << candidate.downcase
        result = true
      else
        @wrong_guesses << candidate.downcase
        result = true
      end
      return result
    end
  end

  def word_with_guesses
    result = ''
    @word.each_char do |letter|
      begin
        if @guesses.include?(letter)
          result += letter
        else
          result += '-'
        end
      end
    end
    result
  end

  def check_win_or_lose
    if @wrong_guesses.length > 6
      return :lose
    elsif not word_with_guesses.include?('-')
      return :win
    else
      return :play
    end
  end

  def do_they_match?(word, expression)
    word.include?(expression)
  end

  def invalid_guess?(letter)
    return true unless !!(/[a-zA-Z]/ =~ letter)
    return false
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

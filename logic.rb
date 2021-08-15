# class containing game logic
class Game
  attr_reader :game_over

  def initialize(code, game_type)
    @game_type = game_type
    @guesses = 0
    @secretcode = code.code
    @game_over = false
    @@correct_numbers = 0
    @@close_numbers = 0
  end

  def self.correct_numbers
    @@correct_numbers
  end

  def self.close_numbers
    @@close_numbers
  end

  def guess(guess)
    @guess = guess
    @guesses += 1
    if !@guess.valid?
      @guesses -= 1
      Output.invalid
      guess(Input.code_input)
    elsif win?
      correct_guess
    elsif lose?
      last_guess
    else
      wrong_guess
    end
  end

  def win?
    true if @guess.code == @secretcode
  end

  def lose?
    true if @guesses >= 12
  end

  def correct_guess
    Output.guess(@guess.code, @game_type)
    if @game_type == 'maker'
      puts "\nYou lost :( the computer guessed your secret code :#{Output.color(@secretcode)}\n\n"
    else
      puts "\nCongratulations! You've won!! the code was #{Output.color(@secretcode)}\n\n"
    end
    @game_over = true
  end

  def last_guess
    Output.guess(@guess.code, @game_type)
    if @game_type == 'breaker'
      puts "\nYou lose :( the secret code was #{Output.color(@secretcode)}\n\n"
    else
      puts "\nYou win!! the computer couldn't guess your secret code :#{Output.color(@secretcode)}\n\n"
    end
    @game_over = true
  end

  def wrong_guess
    @@correct_numbers = 0
    @@close_numbers = 0
    guess_array = []
    @guess.code.each { |num| guess_array << num }
    @secretcode.each_with_index do |num, index|
      @@correct_numbers += 1 if num == @guess.code[index]
    end
    @secretcode.each do |num|
      if guess_array.include?(num)
        @@close_numbers += 1
        guess_array[guess_array.find_index(num)] = ''
        @guess.code
      end
    end
    MastermindAI.a_i_update(@@correct_numbers, @@close_numbers, @guess.code) if @game_type == 'maker'
    Output.guess(@guess.code, @game_type)
    puts "Guess ##{@guesses}! #{12 - @guesses} left!!"
    puts "The guess included #{@@close_numbers - @@correct_numbers} of the numbers included in the code, but in the wrong position!"
    puts "The guess included #{@@correct_numbers} of the correct numbers in the correct position!\n\n"
  end
end

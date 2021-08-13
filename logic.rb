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
    p guess
    @guess = guess
    @guesses += 1
    if !@guess.valid?
      @guesses -= 1
      Output.invalid
      guess(Input.code_input)
    elsif win?
      puts "\nCongratulations! You've won!! the code was #{Output.color(@secretcode)}\n\n"
      @game_over = true
    elsif lose?
      puts "\nYou lose :( the secret code was #{Output.color(@secretcode)}\n\n"
      @game_over = true
    else
      wrong_guess
    end
  end

  def win?
    false
    true if @guess.code == @secretcode
  end

  def lose?
    false
    true if @guesses >= 12
  end

  def wrong_guess
    @@correct_numbers = 0
    @@close_numbers = 0
    guess_array = []
    @guess.code.each { |num| guess_array << num }
    @secretcode.each_with_index do |num, index|
      if num == @guess.code[index]
        @@correct_numbers += 1
      end
    end
    @secretcode.each do |num|
      if guess_array.include?(num)
        @@close_numbers += 1
        guess_array[guess_array.find_index(num)] = ''
        @guess.code
      end
    end
    Output.guess(@guess.code)
    puts "You've guessed #{@guesses} times! you have #{12 - @guesses} left!!"
    puts "Your guess included #{@@close_numbers - @@correct_numbers} of the numbers included in the code, but in the wrong position!"
    puts "Your guess included #{@@correct_numbers} of the correct numbers in the correct position!\n\n"

  end
end

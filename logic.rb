# class containing game logic
class Game
  attr_reader :game_over, :guesses

  # Initialize a new game with default state
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

  # Method for checking if a guess is correct, and if the game is over do to running out of guesses
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

  # Method for win checking
  def win?
    true if @guess.code == @secretcode
  end

  # Method for lose checking
  def lose?
    true if @guesses >= 12
  end

  # Method that changes the game state to over, and outputs to the user when the code is guessed correctly
  def correct_guess
    Output.guess(@guess.code, @game_type)
    if @game_type == 'maker'
      puts "\nYou lost :( the computer guessed your secret code :#{Output.color(@secretcode)}\n\n"
    else
      puts "\nCongratulations! You've won!! the code was #{Output.color(@secretcode)}\n\n"
    end
    @game_over = true
  end

  # Method that changes the game state to over, and outputs to the user when the guesser has run out of guesses
  def last_guess
    Output.guess(@guess.code, @game_type)
    if @game_type == 'breaker'
      puts "\nYou lose :( the secret code was #{Output.color(@secretcode)}\n\n"
    else
      puts "\nYou win!! the computer couldn't guess your secret code :#{Output.color(@secretcode)}\n\n"
    end
    @game_over = true
  end

  # Method that evaluates an incorrect guess to give feedback on how close to correct a guess was
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

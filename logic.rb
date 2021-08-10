#class containing game logic
class Game
  attr_reader :game_over
  def initialize(code)
    @guesses = 0
    @secretcode = code
    @game_over = false
    @correct_numbers = 0
  end

  def guess(guess)
    @guess = guess
    @guesses += 1
    if !@guess.valid?
      @guesses -= 1
      puts Output.invalid
      guess(Input.code_input)
    elsif win?
      puts "\nCongratulations! You've won!!\n\n"
      @game_over = true
    elsif lose?
      puts "you lose :( the secret code was #{Output.color(@secretcode)}"
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
    @correct_numbers = 0
    @secretcode.each_with_index do |num, index|
      if num == @guess.code[index]
        @correct_numbers += 1
        p @correct_numbers
      end
    end
    Output.guess(@guess.code)
    puts "You've guessed #{@guesses} times! you have #{12 - @guesses} left!!"
    puts "Your guess included #{@correct_numbers} of the correct numbers in the correct position!\n\n"
  end
end

class Output
  def self.color(array)
    string = ''
    array.reverse!
    4.times do
      string += "  #{color_choice(array.pop.to_s)}"
    end
    string
  end

  def self.guess(array, game_type)
    if game_type == 'breaker'
      puts "\nYou guessed\n #{color(array)}"
    else
      puts "\nThe computer guessed\n #{color(array)}"
    end
  end

  def self.color_choice(string)
    case string
    when '1'
      string.black.on_red
    when '2'
      string.black.on_blue
    when '3'
      string.black.on_magenta
    when '4'
      string.black.on_green
    when '5'
      string.black.on_cyan
    when '6'
      string.black.on_yellow
    end
  end

  def self.invalid
    puts "\nInvalid input! please enter 4 numbers between 1 and 6, with no spaces!\n\n"
  end

  def self.start
    puts "\nWelcome to Mastermind!\nWould you like to play as the\n1.Codemaker?\n2.Codebreaker?"
  end

  def self.prompt
    puts 'Enter a code!'
  end

  def self.codebreaker
    puts 'As the codebreaker you will have to guess the code that the computer has made, you have 12 chances. Good luck!'
  end

  def self.codemaker
    puts 'As the codemaker you will make a code, and the computer will have 12 tries to guess it. Good luck!'
  end
end

class Input
  def self.code_input
    puts Output.prompt
    Code.new(gets.chomp.split('').map(&:to_i))
  end

  def self.game_choice
    puts 'Enter your selection! (either 1, or 2)'
    gets.chomp
  end
end

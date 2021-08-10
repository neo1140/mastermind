class Output
  def self.color(array)
    string = ''
    array.reverse!
    4.times do
      string += color_choice(array.pop().to_s)
    end
    string
  end

  def self.guess(array)
    puts "\nYou guessed #{self.color(array)}"
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
    "\nInvalid input! please enter 4 numbers between 1 and 6, with no spaces!\n\n"
  end

  def self.start
    "\nWelcome to Mastermind!\n\n"
  end
  def self.prompt
    'Enter a code!'
  end
end

class Input
  def self.code_input
    puts Output.prompt
    Code.new(gets.chomp.split('').map{ |item| item.to_i })
  end
end

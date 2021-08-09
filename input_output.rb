class Output
  def self.invalid
    'Invalid input! please enter 4 numbers, with no spaces!'
  end
  def self.start
    'Welcome to Mastermind!'
  end
end

class Input
  def self.code_input
    puts "Enter a code!"
    # code = Code.new(gets.chomp.split('').map{ |item| item.to_i })
    code = Code.new
    p code.code
  end
end

require_relative 'code'
require_relative 'input_output'
require_relative 'logic'
require 'colorize'

def game_loop
  puts Output.start
  code = Code.new
  p code.code
  game = Game.new(code.code)
  until game.game_over == true
    game.guess(Input.code_input)
  end
  puts "Would you like to play again? enter 'Y' if you do!"
  if gets.chomp.upcase == 'Y'
    game_loop
  else
    puts 'Thanks for playing!'
  end
end
game_loop




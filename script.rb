require_relative 'code'
require_relative 'input_output'
require_relative 'logic'
require 'colorize'
require_relative 'mastermind_ai'

def game_loop
  Output.start
  game_choice = nil
  game_choice = Input.game_choice while game_choice != '1' && game_choice != '2'
  if game_choice == '2'
    Output.codebreaker
    code = Code.new
    game = Game.new(code, 'breaker')
    until game.game_over == true
      game.guess(Input.code_input)
    end
    puts "Would you like to play again? enter 'Y' if you do!"
    if gets.chomp.upcase == 'Y'
      game_loop
    else
      puts 'Thanks for playing!'
    end
  else
    puts "testing enter a code for comp to guess"
    code = Input.code_input
    until code.valid?
      Output.invalid
      code = Input.code_input
    end
    game = Game.new(code, 'maker')
    a_i = MastermindAI.new
    until game.game_over == true
      p a_i
      game.guess(a_i.comp_guess)
      puts "hit enter to continue"
      gets.chomp
    end
    game_loop
  end
end
game_loop

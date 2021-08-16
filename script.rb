require_relative 'code'
require_relative 'input_output'
require_relative 'logic'
require 'colorize'
require_relative 'mastermind_ai'

# Class that contains the decisions the player will make during the game
class GameTree

  # Method for the main game loop in which the player will choose to guess the code or make the code
  def self.game_loop
    Output.start
    game_choice = nil
    game_choice = Input.game_choice while game_choice != '1' && game_choice != '2'
    if game_choice == '1'
      codemaker
    else
      codebreaker
    end
  end

  # Method that lets the player make a code for the computer to guess
  def self.codemaker
    Output.codemaker
    code = Input.code_input
    until code.valid?
      Output.invalid
      code = Input.code_input
    end
    game = Game.new(code, 'maker')
    a_i = MastermindAI.new
    until game.game_over == true
      game.guess(a_i.comp_guess(game.guesses))
      puts 'AI is thinking. . .'
      a_i.cleanup
      puts 'Hit ENTER to continue'
      gets.chomp
    end
    game_end
  end

  # Method that loops until the player guesses the code correctly, or runs out of chances
  def self.codebreaker
    Output.codebreaker
    code = Code.new
    game = Game.new(code, 'breaker')
    game.guess(Input.code_input) until game.game_over == true
    game_end
  end

  # Method for ending the game and giving the option to play again
  def self.game_end
    puts "Would you like to play again? enter 'Y' if you do!"
    if gets.chomp.upcase == 'Y'
      game_loop
    else
      puts 'Thanks for playing!'
    end
  end
end

# Calls game_loop method, starting the program
GameTree.game_loop

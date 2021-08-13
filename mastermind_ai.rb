class MastermindAI
  def initialize
    @guesses = 0
    @correct_numbers = []
  end

  def comp_guess
    if @correct_numbers.length < 4
      Game.close_numbers.times do
        @correct_numbers << @guesses
      end
    end
    if @correct_numbers.length == 4
      return Code.new(@correct_numbers.shuffle)
    else

    @guesses += 1 if @guesses < 6
    array = []
    4.times do
      array << @guesses
    end
    Code.new(array)
    end
  end
end

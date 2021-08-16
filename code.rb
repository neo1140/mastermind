# Class that handles the creation of secret codes and guesses, so that they are readable
class Code
  attr_reader :code

  # Creates codes
  def initialize(array = nil)
    if array.nil?
      @code = []
      4.times do
        @code << (rand(1..6))
      end
    else
      @code = array
    end
  end

  # Checks codes for validity
  def valid?
    if @code.length == 4 && @code.none? { |num| (num < 1 || num > 6) }
      true
    else
      false
    end
  end
end

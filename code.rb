class Code
  attr_reader :code

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

  def valid?
    if @code.length == 4 && @code.none? { |num| (num < 1 || num > 6) }
      true
    else
      false
    end
  end
end

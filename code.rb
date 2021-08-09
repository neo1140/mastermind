class Code
  attr_reader :code
  def initialize(array=nil)
    if array == nil
      @code = []
      4.times do
        @code << (rand(5) + 1)
      end
    else
      @code = array
    end
    if !self.valid?
      Output.invalid
      Input.code_input
    end
  end
  def valid?
    if @code.length == 4 && !@code.any?{ |num| (num < 1 || num > 6) }
      true
    else
      false
    end
  end
end


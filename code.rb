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
      puts "invalid code try again!"
    end
  end
  def valid?
    if @code.length == 4 && !@code.any?(0)
      true
    else
      false
    end
  end
end
code = Code.new(gets.chomp.split('').map{ |item| item.to_i })

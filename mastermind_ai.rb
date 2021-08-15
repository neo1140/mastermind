class MastermindAI
  def initialize
    @guesses = 0
    @correct_numbers = []
    @@array = []
    (1111..6666).each do |num|
      next if num.to_s.include?('0') || num.to_s.include?('7') || num.to_s.include?('8') || num.to_s.include?('9')

      @@array << num.to_s.split('').map(&:to_i)
    end
  end

  def self.a_i_update(correct_numbers, close_numbers, last_guess)
    @@array.each do |group|
      include_count = find_close(group, last_guess)
      match = find_correct(group, last_guess)
      @@array.delete(group) if include_count != close_numbers && match != correct_numbers
    end
  end

  def self.find_correct(group, last_guess)
    match = 0
    group.each_with_index do |num, index|
      match += 1 if num == last_guess[index]
    end
    match
  end

  def cleanup
    @@array.reject!(&:empty?)
    p @@array
  end

  def self.find_close(group, last_guess)
    guess_shadow = []
    last_guess.each { |num| guess_shadow << num }
    include_count = 0
    group.each do |num|
      if guess_shadow.include? num
        include_count += 1
        guess_shadow[guess_shadow.find_index(num)] = ''
      end
    end
    include_count
  end

  def comp_guess
    Code.new(@@array.sample)
  end
end
  # def comp_guess
  #  if @correct_numbers.length < 4
  #    Game.close_numbers.times do
  #      @correct_numbers << @guesses
  #    end
  #  end
  #  if @correct_numbers.length == 4
  #    return Code.new(@correct_numbers.shuffle)
  #  else

  #  @guesses += 1 if @guesses < 6
  #  array = []
  #  4.times do
  #    array << @guesses
  #  end
  #  Code.new(array)
  #  end
  #end
#end

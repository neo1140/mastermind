# Class that contains the logic for the AI
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

  # Method to delete all of the results that canot possibly be the secret code
  def self.a_i_update(correct_numbers, close_numbers, last_guess)
    @@array.each do |group|
      include_count = find_close(group, last_guess)
      match = find_correct(group, last_guess)
      @@array.delete(group) if (include_count - match) != (close_numbers - correct_numbers) || match != correct_numbers
    end
  end

  # Method that finds the number of common numbers in the correct position between the last guess and all the possible guesses
  def self.find_correct(group, last_guess)
    match = 0
    group.each_with_index do |num, index|
      match += 1 if num == last_guess[index]
    end
    match
  end

  # Method that removes empty elements from the array,
  # in the future would like to make it sort the array so that the computers best play is in position 0
  def cleanup
    @@array.reject!(&:empty?)
    @@array.sort! do |group1, group2|
      group1_value = 0
      group2_value = 0
     # @@array.each do |comp|
     #   group1.each_with_index { |num, index| group1_value += 1 if comp[index] == num || comp.include?(num) }
     #   group2.each_with_index { |num, index| group2_value += 1 if comp[index] == num || comp.include?(num) }
     # end
      if group2_value < group1_value
        group2 <=> group1
      else
        group1 <=> group2
      end
    end
  end

  # Method that finds the number of common numbers between the last guess and all remaining possible guesses
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

  # Method that sends the computers guess to the logic class
  def comp_guess(guesses)
    if guesses == 0
      Code.new([1, 1, 2, 2])
    elsif guesses < 6
      Code.new(@@array[0])
    else
      Code.new(@@array.sample)
    end
  end
end

  # Old AI method, add multiple difficulty selections to game tree?

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

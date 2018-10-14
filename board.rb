require './colorize.rb'

class Board
  attr_reader :board_rows

  def initialize
    @board_rows = []
  end

  def populate(current_attempt, code_key)
    set_new_row(current_attempt, code_key)
    draw
  end

  def set_new_row(attempt, solution)
    new_row = [[],[]]
    new_row[0] = attempt.chars
    new_row[1] = get_round_feedback(attempt, solution)
    @board_rows << new_row
  end

  def get_round_feedback(attempt, solution)
    round_feedback = Array.new(4, '•'.gray)
    exact_matches = []
    close_matches = []
    mod_solution = solution.chars

    i = 0
    while i < attempt.length
      if mod_solution[i] == attempt[i]
        exact_matches << '•'.green
        attempt.slice!(i)
        mod_solution.slice!(i)
        i -= 1
      end
      i += 1
    end
    i = 0
    while i < attempt.length
      if mod_solution.include?(attempt[i])
        close_matches << '•'.red
        mod_solution.slice!(mod_solution.index(attempt[i]))
        attempt.slice!(i)
        i -= 1
      end
      i += 1
    end

    all_matches = exact_matches + close_matches
    all_matches.each_with_index do |match, i|
      round_feedback[i] = match
    end
    round_feedback
  end

  def draw
    puts "     Guess         Feedback"
    @board_rows.each do |row|
      print "|  "
      row[0].each { |char| print '•  '.colorize(char) }
      print "|  "
      row[1].each { |feedback| print feedback + '  ' }
      print "|\n"
      puts
    end
  end
end

class CodeBreaker
  attr_reader :current_attempt

  def initialize
    @current_attempt = ""
  end

  def guess_code
    puts "Enter a four letter combination of any of the following letters:"
    puts "(R)ed ".red + "(G)reen ".green + "(Y)ellow ".yellow + "(B)lue ".blue + "(C)yan ".cyan + "(M)agenta".magenta
    @current_attempt = gets.chomp.downcase
    until @current_attempt.length == 4 && /[rgybcm]{4}/.match?(@current_attempt)
      puts "Invalid format. Enter a four letter combination of any of the following letters: 'R' 'G' 'Y' 'B' 'C' or 'M'"
      puts "Example: RYGR"
      @current_attempt = gets.chomp.downcase
    end
    @current_attempt
  end
end

class CodeMaker
  attr_reader :code_key

  def initialize
    @code_key = ""
  end

  def set_key
    pegs = ["r", "g", "y", "b", "c", "m"]
    4.times do
      @code_key += pegs[rand(5)]
    end
  end
end

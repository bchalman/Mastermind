require './colorize.rb'
require './players.rb'
require './board.rb'

class Game
  attr_reader :player_1, :player_CM, :board

  def initialize
    @board = Board.new
    @attempts_remaining = 12
    @player_1 = CodeBreaker.new()
    @player_CM = CodeMaker.new()
    play_game()
  end

  private

  def play_game
    write_instructions()
    @player_CM.set_key
    loop do
      play_turn()
      break if game_over?
    end
  end

  def play_turn
    puts "Attempts remaining: #{@attempts_remaining}"
    @player_1.guess_code
    @board.populate(@player_1.current_attempt, player_CM.code_key)
    @attempts_remaining -= 1
  end

  def write_instructions
    print "Initializing"
    3.times do
      print "."
      sleep(0.7)
    end

    puts "\n\nThere's a flash of light, and suddenly you're in a bleak, white, nearly-empty room.".italic
    puts "A lone console flashes on a central pedestal.".italic
    puts
    puts "Welcome to THE END. Care to escape? I'll give you one chance...".cyan
    puts "All you have to do is beat the MASTERMIND!".cyan
    puts "The rules are simple:".cyan
    puts "\nThere are two players, the Code Maker (that's me) and the Code Breaker (you)".cyan
    puts "The Code Maker will create a security code consisting any combination of four colors from the following:".cyan
    puts "\n\t(R)ed ".red + "(G)reen ".green + "(Y)ellow ".yellow + "(B)lue ".blue + "(C)yan ".cyan + "(M)agenta".magenta
    puts "\nThe Code Breaker will have 12 attempts to discover the code...".cyan
    puts "- After entering the code, the system will display feedback indicating whether the attempt includes:".cyan
    puts "\t#{'•'.green} -- A guess that is in the code and in the correct position."
    puts "\t#{'•'.red} -- A guess that is in the code and not in the correct position."
    puts "\t#{'•'.gray} -- A guess that is not in the code."
    puts "\nThe position of the feedback indicator does not always correspond".cyan
    puts "to the same position of the guess in the submitted code.".cyan
    puts "\nGuess wrong too many times, and you die.".cyan
    puts "  O  O"
    puts "\\______/"
    puts "Press ENTER to play!".cyan
    gets
  end

  def game_over?
    if @board.board_rows[-1][1] == ['•'.green, '•'.green, '•'.green, '•'.green]
      win_message
      return true
    elsif @attempts_remaining <= 0
      loss_message
      return true
    end
    false
  end

  def win_message
    puts "You... win?".cyan
    puts "I guess you won't die this time. What a shame.".cyan
    puts "Until next time...".cyan
    sleep(1.5)
    puts "A grinding sound echoes behind you as a wall of the room opens to bright light...".italic
    sleep(1.5)
    puts "YOU WIN!"
  end

  def loss_message
    puts "Oh... Look at that. You're all out of turns.".cyan
    puts "I had fun watching you fail.".cyan
    puts "Goodbye now.".cyan
    sleep(1.5)
    puts "GAME OVER"
  end
end


play_again = "y"
while play_again == "y"
  game = Game.new()
  puts "Would you like to play again? (y/n)"
  play_again = gets.chomp.downcase
  until play_again == "y" || play_again == "n"
    puts "Invalid response. Please enter 'y' if you would like to play again, and 'n' if not."
    play_again = gets.chomp.downcase
    end
end
puts "Powering down..."

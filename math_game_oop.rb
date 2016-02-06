require 'colorize'

class Player

  attr_reader :name
  attr_accessor :lives, :points

  def initialize(name)
    @name = name
    @lives = 3
    @points = 0
  end

end


class Game

  attr_reader :players
  attr_accessor :turn

  def initialize
    @players = []
  end

  def create_names
    puts "Player 1, enter your name"
    player_one = gets.chomp
    player_one = Player.new(player_one)
    @players << player_one

    puts "Player 2, enter your name"
    player_two = gets.chomp
    player_two = Player.new(player_two)
    @players << player_two
  end

  def ask_question
    question_one = rand(1..20)
    question_two = rand(1..20)
    puts "what is #{question_one} + #{question_two}?"
    result = question_one + question_two
  end

  def verify_answer (result, user_answer)
    is_correct = (result == user_answer)
    if is_correct
      puts "NIIICE!"
      return true
    else
      puts "Better Luck Next Time!"
      return false
    end
  end

  def decrease_lives(player)
    player.lives -= 1
    puts "Lives: #{player.lives}"
    puts "Points: #{player.points}"
  end

  def increase_points(player)
    player.points += 1
    puts "Lives: #{player.lives}"
    puts "Points: #{player.points}"
  end

  # def set_turn #switches turns
  #   if @turn == "#{@player_one.name}"
  #     @turn = "#{@player_two.name}"
  #     puts "Player Turn: #{@player_two.name}".red
  #   else @turn == "#{@player_two.name}"
  #     @turn = "#{@player_one.name}"
  #     puts "Player Turn: #{@player_one.name}".blue
  #   end
  #   return @turn
  # end


  def declare_winner(player)
    puts "#{player.name} WINS!".green
    puts "#{player.name} has #{player.points} POINTS!".yellow
  end
end


def start_game
  @game = Game.new
  @game.create_names
  @player_one = @game.players[0]
  @player_two = @game.players[1]
  while (@player_one.lives > 0) && (@player_two.lives > 0)
    if @game.turn == @player_one
      @game.turn = @player_two
      puts "Turn: #{@player_two.name}".blue
    else
      @game.turn = @player_one
      puts "Turn: #{@player_one.name}".red
    end
    answer = @game.ask_question
    user_answer = gets.chomp.to_i
    if @game.verify_answer(answer,user_answer)
      @game.increase_points(@game.turn)
    else
      @game.decrease_lives(@game.turn)
    end
  end
  if @game.turn == @player_one
    @game.declare_winner(@player_two)
  else
    @game.declare_winner(@player_one)
  end
end


start_game

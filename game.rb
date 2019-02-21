require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'interface.rb'

class Game
  BET = 10

  def initialize
    @interface = Interface.new
    @player = new_player
    @dealer = Dealer.new
  end

  def new_player
    name = @interface.take_name
    Player.new(name)
  end

  def start_game
    loop do
      start_round
      make_moves
      end_round

      if @player.money < BET
        @interface.no_money
        break
      end

      @interface.everything_win  if @dealer.money < BET

      return unless @interface.continue_game?
    end
  end

  def start_round
    make_bets
    @deck = Deck.new
    @player.clear_hand
    @dealer.clear_hand
    2.times do
      @player.take_card @deck.deal_card.face_up
      @dealer.take_card @deck.deal_card
    end
  end

  def make_moves
    loop do
      @interface.print_player(@player)
      case @interface.player_choice
      when 2 then @player.take_card(@deck.deal_card.face_up)
      when 3 then
        @dealer.take_card(@deck.deal_card)
        break
      end

      @dealer.take_card(@deck.deal_card)

      break if @player.hand.full? && @dealer.hand.full?
    end
  end


  def end_round
    @dealer.show_hand
    @interface.game_status([@dealer, @player])
    winner = get_winner
    if winner
      @interface.print_winner(winner)
      winner.win_bank(@player.bet + @dealer.bet)
    else
      @interface.print_draw
      @player.take_bet_back(@player.bet)
      @dealer.take_bet_back(@player.bet)
    end
    @interface.balance_status([@dealer, @player])
  end

  def get_winner
    return if @player.hand.busted? && @dealer.hand.busted?
    return if @player.hand.value == @dealer.hand.value
    return @player if !@player.hand.busted? && @dealer.hand.busted?
    return @dealer if @player.hand.value < @dealer.hand.value || @player.hand.busted?
    return @player if @player.hand.value > @dealer.hand.value || @dealer.hand.busted?
  end

  def make_bets
    @player.make_bet(BET)
    @dealer.make_bet(BET)
  end

  def deal_cards; end
end

Game.new.start_game

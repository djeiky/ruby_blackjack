require_relative 'player.rb'

class Dealer < Player
  MAX_VALUE = 17

  def initialize
    super('Dealer')
  end

  def take_card(card)
    super(card) unless @hand.value >= MAX_VALUE
  end

  def show_hand
    hand.cards.each(&:face_up)
    super
  end
end

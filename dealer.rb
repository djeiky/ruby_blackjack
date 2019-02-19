require_relative "player.rb"

class Dealer < Player

  def initialize
    super('Dealer')
  end

  def show_hand
    self.hand.cards.each {|card| card.face_up}
    super
  end
  
end

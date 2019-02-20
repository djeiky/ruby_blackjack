require_relative 'card.rb'

class Hand
  attr_reader :cards

  MAX_POINTS = 21
  MAX_CARDS = 3

  def initialize
    @cards = []
  end

  def take_card(card)
    @cards << card unless full?
  end

  def full?
    @cards.size >= MAX_CARDS
  end

  def busted?
    value > MAX_POINTS
  end

  def to_s
    v = @cards.find(&:face_down) ? '?' : value
    str = @cards.join ', '
    str + " value - #{v}"
  end

  def value
    val = @cards.map(&:value).sum
    ace = @cards.find(&:ace?)
    val += 10 if ace && (val <= (MAX_POINTS - 10))
    val
  end
end

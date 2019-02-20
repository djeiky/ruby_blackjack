class Card
  attr_reader :face, :suit, :face_down

  def initialize(face, suit)
    @face = face
    @suit = suit
    @face_down = true
  end

  def face_up
    @face_down = false
    self
  end

  def ace?
    @face == 'A'
  end

  def value
    case @face
    when 2..10 then @face
    when 'J', 'Q', 'K' then 10
    when 'A' then 1
    end
  end

  def to_s
    @face_down ? '*' : "#{@face}#{@suit}"
  end
end

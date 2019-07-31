require 'hand'

describe "Hand" do
  card1 = Card.new(10, "H")
  card2 = Card.new(10, "D")
  card3 = Card.new(2, "C")
  card4 = Card.new(5, "S")
  card5 = Card.new("Q", "S")
  card6 = Card.new(4, "D")
  dealt_cards = [card1, card2, card3, card4, card5]

  subject(:hand) { Hand.new(dealt_cards) }
  let(:cards) { hand.instance_variable_get(:@cards) }

  describe "#initialize" do
    it "initializes with an array of cards" do
      expect(cards.values.flatten).to eq(dealt_cards)
    end

    it "is hidden" do
      expect { hand.cards }.to raise_error(NoMethodError)
    end

    it "only accepts 5 cards" do
      dealt_cards << card6
      expect { Hand.new(dealt_cards) }.to raise_error(ArgumentError)

      # remove the extra card
      dealt_cards.pop
    end
  end

  describe "#playable_hands" do
    before(:each) do
      @hands = [:straight_flush, :four_of_a_kind, :full_house, :flush, :straight, :three_of_a_kind, :two_pairs, :one_pair]
      @card1 = Card.new(10, "H")
      @card2 = Card.new(10, "D")
      @card3 = Card.new(2, "C")
      @card4 = Card.new(5, "S")
      @card5 = Card.new("Q", "S")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
    end

    it "returns a hash representing all possible hands" do
      expect(@hand.playable_hands.keys).to eq(@hands)
    end

    it "sets a hand to true if it's playable" do
      expect(@hand.playable_hands[:one_pair]).to be_truthy
      expect(@hand.playable_hands[:two_pairs]).to be false
    end
  end

  describe "#play" do
    before(:each) do
      @card1 = Card.new(10, "H")
      @card2 = Card.new(10, "D")
      @card3 = Card.new(5, "C")
      @card4 = Card.new(5, "S")
      @card5 = Card.new("Q", "S")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
    end

    it "returns the best hand that can be played" do
      expect(@hand.play).to eq(:two_pairs)
    end

    it "returns the high card when no hands can be played" do
      @card2 = Card.new(3, "C")
      @card3 = Card.new(2, "H")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])

      expect(@hand.play).to be(@card5)
    end
  end

  describe "#one_pair" do
    it "returns the pair if the hand contains one pair" do
      expect(hand.one_pair).to eq([card1, card2])
    end
  end

  describe "#two_pairs" do
    before(:each) do
      @card1 = Card.new(10, "H")
      @card2 = Card.new(10, "D")
      @card3 = Card.new(5, "C")
      @card4 = Card.new(5, "S")
      @card5 = Card.new("Q", "S")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
    end

    it "returns the pairs if the hand contains two pairs" do
      expect(@hand.two_pairs).to eq([@card1, @card2, @card3, @card4])
    end
  end

  describe "#three_of_a_kind" do
    before(:each) do
      @card1 = Card.new(10, "H")
      @card2 = Card.new(10, "D")
      @card3 = Card.new(10, "C")
      @card4 = Card.new(5, "S")
      @card5 = Card.new("Q", "S")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
    end

    it "returns the cards if hand contains three of a kind" do
      expect(@hand.three_of_a_kind).to eq([@card1, @card2, @card3])
    end
  end

  describe "#four_of_a_kind" do
    before(:each) do
      @card1 = Card.new(10, "H")
      @card2 = Card.new(10, "D")
      @card3 = Card.new(10, "C")
      @card4 = Card.new(10, "S")
      @card5 = Card.new("Q", "S")
      @hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
    end

    it "returns the cards if hand contains four of a kind" do
      expect(@hand.four_of_a_kind).to eq([@card1, @card2, @card3, @card4])
    end
  end

  describe "#straight" do
    before(:each) do
      @card1 = Card.new(3, "C")
      @card2 = Card.new(2, "C")
      @card3 = Card.new(4, "C")
      @card4 = Card.new(5, "C")
      @card5 = Card.new(6, "C")
    end

    it "returns the straight if hand contains 5 sequential cards" do
      straight_hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
      expect(straight_hand.straight).to eq([@card2, @card1, @card3, @card4, @card5])
    end

    it "returns the straight if hand contains an ace-low straight" do
      @card5 = Card.new("A", "H")
      hand = Hand.new([@card1, @card2, @card3, @card4, @card5])

      expect(hand.straight).to eq([@card5, @card2, @card1, @card3, @card4])
    end
  end

  describe "#flush" do
    before(:each) do
      @card1 = Card.new(3, "C")
      @card2 = Card.new(2, "C")
      @card3 = Card.new(4, "C")
      @card4 = Card.new(5, "C")
      @card5 = Card.new(6, "C")
    end

    it "returns the hand if all cards are in the same suit" do
      hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
      expect(hand.flush).to eq([@card1, @card2, @card3, @card4, @card5])
    end

    it "is false when the hand contains 4 of the same suit" do
      @card5 = Card.new(6, "D")
      hand = Hand.new([@card1, @card2, @card3, @card4, @card5])

      expect(hand.flush).to be false 
    end
  end

  describe "#high_card" do
    before(:each) do
      @card1 = Card.new(3, "C")
      @card2 = Card.new(2, "C")
      @card3 = Card.new("J", "C")
      @card4 = Card.new(5, "C")
      @card5 = Card.new(6, "C")
    end
    it "returns the highest value card in a hand" do
      hand = Hand.new([@card1, @card2, @card3, @card4, @card5])
      expect(hand.high_card).to be(@card3)
    end
  end
end

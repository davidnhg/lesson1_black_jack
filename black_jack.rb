# Author:  David Nguuyen
# Created: 10/2/2014
#
# File:  black_jack.rb
#
# Steps/rules:
#
# => 1.  Create a deck of 52 cards so we can clone it.
# => 2.  Make a clone of the deck from step 1.
# => 3.  Create a hand so we can clone it.
# => 4.  Clone a hand for dealer and one for player.
# => 5.  Start dealing the hands, one card at a time, first to player, then dealer, then player, then dealer.  One of dealer's cards will be faced down.
# => 6.  If player is 21 with 2 cards, he has Black Jack!  Dealer needs to check hole-card:  if dealer doesn't have Black Jack, player wins.
# => 7.  If dealer has Black Jack with 2 cards, dealer will win unless player is also Black Jack.
# => 8.  Ask if player wants to hit/stay.  If hit:
# =>     8.1  If player is more than 21, player is busted and dealer wins.
# =>     8.2  If player is 21, he has to stay.
# =>     8.3  If player is less than 21, ask him to hit/stay.  Then repeat 8.
# => 9.  If player stays, it's dealer's turn.
# =>     9.1  If dealer has 17 or more, stay.
# =>     9.2  If dealer has less than 17, must hit.
# =>     9.3  If dealer is more than 21, busted!  Player wins.
# =>     9.4  Repeat 9
# => 10. After every card is dealt, remove it from the clone.  Also, record it in the correct player/dealer's hand.  Draw the card table.

require 'pry'

# Set up deck
DECK = { 
          1 =>  {name: 'Ace',   suit: 'of Spade', soft: 11,  hard: 1},
          2 =>  {name: 'Two',   suit: 'of Spade', soft: 2,   hard: 2},
          3 =>  {name: 'Three', suit: 'of Spade', soft: 3,   hard: 3},
          4 =>  {name: 'Four',  suit: 'of Spade', soft: 4,   hard: 4},
          5 =>  {name: 'Five',  suit: 'of Spade', soft: 5,   hard: 5},
          6 =>  {name: 'Six',   suit: 'of Spade', soft: 6,   hard: 6},
          7 =>  {name: 'Seven', suit: 'of Spade', soft: 7,   hard: 7},
          8 =>  {name: 'Eight', suit: 'of Spade', soft: 8,   hard: 8},
          9 =>  {name: 'Nine',  suit: 'of Spade', soft: 9,   hard: 9},
          10 => {name: 'Ten',   suit: 'of Spade', soft: 10,  hard: 10},
          11 => {name: 'Jack',  suit: 'of Spade', soft: 10,  hard: 10},
          12 => {name: 'Queen', suit: 'of Spade', soft: 10,  hard: 10},
          13 => {name: 'King',  suit: 'of Spade', soft: 10,  hard: 10},
          14 => {name: 'Ace',   suit: 'of Heart', soft: 11,   hard: 1},
          15 => {name: 'Two',   suit: 'of Heart', soft: 2,   hard: 2},
          16 => {name: 'Three', suit: 'of Heart', soft: 3,   hard: 3},
          17 => {name: 'Four',  suit: 'of Heart', soft: 4,   hard: 4},
          18 => {name: 'Five',  suit: 'of Heart', soft: 5,   hard: 5},
          19 => {name: 'Six',   suit: 'of Heart', soft: 6,   hard: 6},
          20 => {name: 'Seven', suit: 'of Heart', soft: 7,   hard: 7},
          21 => {name: 'Eight', suit: 'of Heart', soft: 8,   hard: 8},
          22 => {name: 'Nine',  suit: 'of Heart', soft: 9,   hard: 9},
          23 => {name: 'Ten',   suit: 'of Heart', soft: 10,  hard: 10},
          24 => {name: 'Jack',  suit: 'of Heart', soft: 10,  hard: 10},
          25 => {name: 'Queen', suit: 'of Heart', soft: 10,  hard: 10},
          26 => {name: 'King',  suit: 'of Heart', soft: 10,  hard: 10},
          27 => {name: 'Ace',   suit: 'of Diamond', soft: 11, hard: 1},
          28 => {name: 'Two',   suit: 'of Diamond', soft: 2, hard: 2},
          29 => {name: 'Three', suit: 'of Diamond', soft: 3, hard: 3},
          30 => {name: 'Four',  suit: 'of Diamond', soft: 4, hard: 4},
          31 => {name: 'Five',  suit: 'of Diamond', soft: 5, hard: 5},
          32 => {name: 'Six',   suit: 'of Diamond', soft: 6, hard: 6},
          33 => {name: 'Seven', suit: 'of Diamond', soft: 7, hard: 7},
          34 => {name: 'Eight', suit: 'of Diamond', soft: 8, hard: 8},
          35 => {name: 'Nine',  suit: 'of Diamond', soft: 9, hard: 9},
          36 => {name: 'Ten',   suit: 'of Diamond', soft: 10, hard: 10},
          37 => {name: 'Jack',  suit: 'of Diamond', soft: 10, hard: 10},
          38 => {name: 'Queen', suit: 'of Diamond', soft: 10, hard: 10},
          39 => {name: 'King',  suit: 'of Diamond', soft: 10, hard: 10},
          40 => {name: 'Ace',   suit: 'of Club', soft: 11,  hard: 1},
          41 => {name: 'Two',   suit: 'of Club', soft: 2,  hard: 2},
          42 => {name: 'Three', suit: 'of Club', soft: 3,  hard: 3},
          43 => {name: 'Four',  suit: 'of Club', soft: 4,  hard: 4},
          44 => {name: 'Five',  suit: 'of Club', soft: 5,  hard: 5},
          45 => {name: 'Six',   suit: 'of Club', soft: 6,  hard: 6},
          46 => {name: 'Seven', suit: 'of Club', soft: 7,  hard: 7},
          47 => {name: 'Eight', suit: 'of Club', soft: 8,  hard: 8},
          48 => {name: 'Nine',  suit: 'of Club', soft: 9,  hard: 9},
          49 => {name: 'Ten',   suit: 'of Club', soft: 10, hard: 10},
          50 => {name: 'Jack',  suit: 'of Club', soft: 10, hard: 10},
          51 => {name: 'Queen', suit: 'of Club', soft: 10, hard: 10},
          52 => {name: 'King',  suit: 'of Club', soft: 10, hard: 10}
}
DEALER_HAND = { full_name: 'Dealer', card1: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card2: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card3: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card4: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card5: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card6: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card7: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     count: 0,
                                     soft_total: 0,
                                     hard_total: 0
}
PLAYER_HAND = { full_name: 'Player', card1: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card2: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card3: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card4: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card5: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card6: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     card7: {name: ' ', suit: ' ', soft: 0, hard: 0},
                                     count: 0,
                                     soft_total: 0,
                                     hard_total: 0
}
TWENTY_ONE = 21
SIXTEEN = 16

def say(something)
  puts something
end

def draw_board(dealer, player, hole_card_hidden = true)
  puts "     Welcome #{player[:full_name]}!".center(40)
  puts "-".center(40, '-')
  puts "-" + "Dealer's Hand".center(38, ' ') + "-"
  puts "-".center(40, '-')

  if hole_card_hidden
    puts "-" + "Card--Hidden".center(38, ' ') + "-"
  else
    puts "#{dealer[:card1][:name]} #{dealer[:card1][:suit]}"
  end

  puts "#{dealer[:card2][:name]} #{dealer[:card2][:suit]}"
  puts "#{dealer[:card3][:name]} #{dealer[:card3][:suit]}"
  puts "#{dealer[:card4][:name]} #{dealer[:card4][:suit]}"
  puts "#{dealer[:card5][:name]} #{dealer[:card5][:suit]}"
  puts "#{dealer[:card6][:name]} #{dealer[:card6][:suit]}"
  puts "#{dealer[:card7][:name]} #{dealer[:card7][:suit]}"

  puts "-".center(40, '-')
  puts "-" + "Your Hand".center(38, ' ') + "-"
  puts "-".center(40, '-')
  puts "#{player[:card1][:name]} #{player[:card1][:suit]}"
  puts "#{player[:card2][:name]} #{player[:card2][:suit]}"
  puts "#{player[:card3][:name]} #{player[:card3][:suit]}"
  puts "#{player[:card4][:name]} #{player[:card4][:suit]}"
  puts "#{player[:card5][:name]} #{player[:card5][:suit]}"
  puts "#{player[:card6][:name]} #{player[:card6][:suit]}"
  puts "#{player[:card7][:name]} #{player[:card7][:suit]}"
  puts "-".center(40, '-')
end

def deal_card(deck)
  # Return a card as a hash
  card_number = deck.sample
  deck.delete(card_number)
  DECK[card_number]
end

def record_card(hand, card)
  case hand[:count]
  when 0
    card_key = :card1
  when 1
    card_key = :card2
  when 2
    card_key = :card3
  when 3
    card_key = :card4
  when 4
    card_key = :card5
  when 5
    card_key = :card6
  when 6
    card_key = :card7  
  end

  hand[card_key] = card
  hand[:count] += 1
  calculate_hand_value(hand)
end

def calculate_hand_value(hand)
  hand[:soft_total] = 0
  hand[:hard_total] = 0

  hand.each do |key, value|
    if key =~ /card/
      hand[:soft_total] += hand[key][:soft]
      hand[:hard_total] += hand[key][:hard]
    end
  end
end

def get_soft_value(hand)
  return hand[:soft_total]
end

def get_hard_value(hand)
  return hand[:hard_total]
end

def is_busted?(hand)
  if (get_soft_value(hand) > TWENTY_ONE) && (get_hard_value(hand) > TWENTY_ONE)
    return true
  else
    return false
  end
end

def is_twenty_one?(hand)
  if (get_soft_value(hand) == TWENTY_ONE) && (get_hard_value(hand) == TWENTY_ONE)
    return true
  else
    return false
  end
end

def is_sixteen_or_less?(hand)
  get_soft_value(hand) <= SIXTEEN ? true : false
end

def is_blackjack?(hand)
  if hand[:count] == 2
    if (get_soft_value(hand) == TWENTY_ONE) || (get_hard_value(hand) == TWENTY_ONE)
      return true
    else
      return false
    end
  end
end

def init_game(deck, dealer_hand, player_hand, player_name = 'Player')
  deck << DECK.keys
  deck.flatten!
  dealer_hand.merge!(DEALER_HAND)
  player_hand.merge!(PLAYER_HAND)
  player_hand[:full_name] = player_name
end

def get_player_name
  puts "What is your name?"
  return gets.chomp
  #hand[:full_name] = gets.chomp
end

def choose_winner(dealer_hand, player_hand)
  if get_soft_value(dealer_hand) > TWENTY_ONE
    dealer_total = get_hard_value(dealer_hand)
  else
    dealer_total = [get_soft_value(dealer_hand), get_hard_value(dealer_hand)].max
  end

  if get_soft_value(player_hand) > TWENTY_ONE
    player_total = get_hard_value(player_hand)
  else
    player_total = [get_soft_value(player_hand), get_hard_value(player_hand)].max
  end

  if dealer_total > player_total
    say "Dealer won!"
  elsif dealer_total == player_total
    say "It's a tie!"
  else
    say "You won!"
  end
end

def play_again?
  # Ask if player wants to play again
  say "Play again? [y/n]: "
  response = gets.chomp.upcase
  response == 'Y' ? true : false
end

###########################################################
#                           Main
###########################################################

# Start the game by initializing some variables and draw board
deck = [] # array holding available cards from which we draw
dealer_hand = {}
player_hand = {}

continue = 'Y'
player_name = get_player_name

while continue != 'N'
  # Init
  deck.clear
  dealer_hand.clear
  player_hand.clear
  init_game(deck, dealer_hand, player_hand, player_name)

  # Start dealing out the hands
  1.upto(4) do |i|
    card = deal_card(deck)
    i.odd? ? record_card(player_hand, card) : record_card(dealer_hand, card)
  end

  # Draw the board
  draw_board(dealer_hand, player_hand)

  # Check if user has Blackjack
  if is_blackjack?(player_hand) && is_blackjack?(dealer_hand)
    say "You hit Blackjack!  But Dealer also has Blackjack.  It's a tie."
    # Draw the board
    draw_board(dealer_hand, player_hand)
    play_again? ? next : break

  elsif is_blackjack?(player_hand) && !is_blackjack?(dealer_hand)
    say "Blackjack!  You won!"
    # Draw the board
    draw_board(dealer_hand, player_hand)
    play_again? ? next : break
  elsif is_blackjack?(dealer_hand)
    say "Dealer hit blackjack!  You lost.  Sorry!"
    # Draw the board
    draw_board(dealer_hand, player_hand)
    play_again? ? next : break
  end

  # Working with the player
  input = 'H'  # S: stay; H: hit
  while !is_busted?(player_hand) && !is_twenty_one?(player_hand) && input != 'S'
    say "Would you like to hit or stay? [H/S]:"
    input = gets.chomp.upcase
    if input == 'H'
      card = deal_card(deck)
      record_card(player_hand, card)
    end
    # Draw the board
    draw_board(dealer_hand, player_hand)
  end

  # Draw the board
  draw_board(dealer_hand, player_hand, false)

  # Is the player busted?
  if is_busted?(player_hand)
    say "Your hand is busted.  You lost.  Sorry!"
    play_again? ? next : break
  end

  while is_sixteen_or_less?(dealer_hand)
    card = deal_card(deck)
    record_card(dealer_hand, card)
    # Draw the board
    draw_board(dealer_hand, player_hand, false)
    sleep(3)
  end

  # Is the dealer busted?
  if is_busted?(dealer_hand)
    say "Dealer is busted.  You won!"
    play_again? ? next : break
  end

  # Decide winner
  choose_winner(dealer_hand, player_hand)
  play_again? ? next : break
end # while true
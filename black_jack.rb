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
          1 =>  {name: 'Ace',   suit: 'Spade', value1: 1,   value2: 11},
          2 =>  {name: 'Two',   suit: 'Spade', value1: 2,   value2: 0},
          3 =>  {name: 'Three', suit: 'Spade', value1: 3,   value2: 0},
          4 =>  {name: 'Four',  suit: 'Spade', value1: 4,   value2: 0},
          5 =>  {name: 'Five',  suit: 'Spade', value1: 5,   value2: 0},
          6 =>  {name: 'Six',   suit: 'Spade', value1: 6,   value2: 0},
          7 =>  {name: 'Seven', suit: 'Spade', value1: 7,   value2: 0},
          8 =>  {name: 'Eight', suit: 'Spade', value1: 8,   value2: 0},
          9 =>  {name: 'Nine',  suit: 'Spade', value1: 9,   value2: 0},
          10 => {name: 'Ten',   suit: 'Spade', value1: 10,  value2: 0},
          11 => {name: 'Jack',  suit: 'Spade', value1: 10,  value2: 0},
          12 => {name: 'Queen', suit: 'Spade', value1: 10,  value2: 0},
          13 => {name: 'King',  suit: 'Spade', value1: 10,  value2: 0},
          14 => {name: 'Ace',   suit: 'Heart', value1: 1,   value2: 11},
          15 => {name: 'Two',   suit: 'Heart', value1: 2,   value2: 0},
          16 => {name: 'Three', suit: 'Heart', value1: 3,   value2: 0},
          17 => {name: 'Four',  suit: 'Heart', value1: 4,   value2: 0},
          18 => {name: 'Five',  suit: 'Heart', value1: 5,   value2: 0},
          19 => {name: 'Six',   suit: 'Heart', value1: 6,   value2: 0},
          20 => {name: 'Seven', suit: 'Heart', value1: 7,   value2: 0},
          21 => {name: 'Eight', suit: 'Heart', value1: 8,   value2: 0},
          22 => {name: 'Nine',  suit: 'Heart', value1: 9,   value2: 0},
          23 => {name: 'Ten',   suit: 'Heart', value1: 10,  value2: 0},
          24 => {name: 'Jack',  suit: 'Heart', value1: 10,  value2: 0},
          25 => {name: 'Queen', suit: 'Heart', value1: 10,  value2: 0},
          26 => {name: 'King',  suit: 'Heart', value1: 10,  value2: 0},
          27 => {name: 'Ace',   suit: 'Diamond', value1: 1, value2: 11},
          28 => {name: 'Two',   suit: 'Diamond', value1: 2, value2: 0},
          29 => {name: 'Three', suit: 'Diamond', value1: 3, value2: 0},
          30 => {name: 'Four',  suit: 'Diamond', value1: 4, value2: 0},
          31 => {name: 'Five',  suit: 'Diamond', value1: 5, value2: 0},
          32 => {name: 'Six',   suit: 'Diamond', value1: 6, value2: 0},
          33 => {name: 'Seven', suit: 'Diamond', value1: 7, value2: 0},
          34 => {name: 'Eight', suit: 'Diamond', value1: 8, value2: 0},
          35 => {name: 'Nine',  suit: 'Diamond', value1: 9, value2: 0},
          36 => {name: 'Ten',   suit: 'Diamond', value1: 10, value2: 0},
          37 => {name: 'Jack',  suit: 'Diamond', value1: 10, value2: 0},
          38 => {name: 'Queen', suit: 'Diamond', value1: 10, value2: 0},
          39 => {name: 'King',  suit: 'Diamond', value1: 10, value2: 0},
          40 => {name: 'Ace',   suit: 'Club', value1: 1,  value2: 11},
          41 => {name: 'Two',   suit: 'Club', value1: 2,  value2: 0},
          42 => {name: 'Three', suit: 'Club', value1: 3,  value2: 0},
          43 => {name: 'Four',  suit: 'Club', value1: 4,  value2: 0},
          44 => {name: 'Five',  suit: 'Club', value1: 5,  value2: 0},
          45 => {name: 'Six',   suit: 'Club', value1: 6,  value2: 0},
          46 => {name: 'Seven', suit: 'Club', value1: 7,  value2: 0},
          47 => {name: 'Eight', suit: 'Club', value1: 8,  value2: 0},
          48 => {name: 'Nine',  suit: 'Club', value1: 9,  value2: 0},
          49 => {name: 'Ten',   suit: 'Club', value1: 10, value2: 0},
          50 => {name: 'Jack',  suit: 'Club', value1: 10, value2: 0},
          51 => {name: 'Queen', suit: 'Club', value1: 10, value2: 0},
          52 => {name: 'King',  suit: 'Club', value1: 10, value2: 0}
}

DEALER_HAND = { full_name: 'Dealer', card1: {}, card2: {}, card3: {}, card4: {}, card5: {}, card6: {}, card7: {}, total: 0}

PLAYER_HAND = { full_name: 'Player', card1: {}, card2: {}, card3: {}, card4: {}, card5: {}, card6: {}, card7: {}, card8: {}, card9: {}, card10: {}, card11: {}, total: 0}


puts DEALER_HAND
puts PLAYER_HAND
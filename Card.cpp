#include "Card.h"
#include <iostream>
#include <string>
#include <cstring>
using namespace std;

string rankarr[13] = {"Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace"};
string suitarr[4] = {"Spades", "Hearts", "Clubs", "Diamonds"};

Card::Card() {
	rank = TWO;
	suit = SPADES;
}

Card::Card(Rank rank_in, Suit suit_in) {
	rank = rank_in;
	suit = suit_in;
}

Card::Rank Card::get_rank() const{
	return rank;
}

Card::Suit Card::get_suit() const{
	return suit;
}

std::ostream& operator<< (std::ostream& os, const Card& c) {
	os << rankarr[c.get_rank()] << " of " << suitarr[c.get_suit()];
	return os;
}

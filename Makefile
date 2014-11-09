CXX     := g++
CXXFLAGS := -Wall -Werror -pedantic -O1

deck_test_src = $(wildcard Deck_test[0-9][0-9].cpp)
deck_test_exes = $(deck_test_src:.cpp=_exe)

player_test_src = $(wildcard Player_test[0-9][0-9].cpp)
player_test_exes = $(player_test_src:.cpp=_exe)

Card_test00 : Card_test00.cpp Card.cpp
	$(CXX) $(CXXFLAGS) Card_test00.cpp Card.cpp -o Card_test00

Deck_test00 : Deck_test00.cpp Deck.cpp Card.cpp
	$(CXX) $(CXXFLAGS) Deck_test00.cpp Deck.cpp Card.cpp -o Deck_test00

Player_test00 : Player_test00.cpp Card.cpp Hand.cpp Deck.cpp Player.cpp rand.cpp
	$(CXX) $(CXXFLAGS) Player_test00.cpp Card.cpp Hand.cpp Deck.cpp Player.cpp rand.cpp -o Player_test00

blackjack :  Card.cpp rand.cpp Hand.cpp Deck.cpp Player.cpp blackjack.cpp
	$(CXX) $(CXXFLAGS) Card.cpp rand.cpp Hand.cpp Deck.cpp Player.cpp blackjack.cpp -o blackjack

test : blackjack Card_test00 Deck_test00 Player_test00
	./Card_test00
	./Deck_test00
	./Player_test00
	./blackjack 100 3 simple > blackjack.out
	diff -q blackjack_test00.out.correct blackjack.out

Deck_tests : $(deck_test_exes)
Player_tests : $(player_test_exes)

.PHONY: test my_tests clean

my_tests : Deck_tests Player_tests
	@python run_my_tests.py

Deck_test%_exe : Deck_test%.cpp Deck.cpp Card.cpp
	$(CXX) $(CXXFLAGS) $^ -o $@

Player_test%_exe : Player_test%.cpp Card.cpp Hand.cpp Deck.cpp Player.cpp rand.cpp
	$(CXX) $(CXXFLAGS) $^ -o $@

tar: group.txt Card.cpp Hand.cpp Deck.cpp Player.cpp blackjack.cpp Deck_test.overview \
	           Deck_test[0-9][0-9].cpp Player_test.overview Player_test[0-9][0-9].cpp
	tar -czvf submit.tar.gz $^

clean :
	rm -vf blackjack *.out \
         Card_test[0-9][0-9] \
         Deck_test[0-9][0-9] \
         Player_test[0-9][0-9] \
         *_test*_exe

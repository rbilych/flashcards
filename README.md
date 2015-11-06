[![Alt text](https://api.travis-ci.org/rbilych/flashcards.svg)](https://travis-ci.org/rbilych/flashcards)
[![Code Climate](https://codeclimate.com/github/rbilych/flashcards/badges/gpa.svg)](https://codeclimate.com/github/rbilych/flashcards)

# FlashCards App

[flashcards.pp.ua](http://flashcards.pp.ua/)

---

You can create cards with original and translated text. Also you can add image to card. Cards can be grouped to decks. You can set deck to current, and for review will be able only card from this deck. For best memorization, app use [SuserMemo2 algorithm](http://www.supermemo.com/english/ol/sm2.htm).

###### The application used:
* authentication: sorcery
* image upload: paperclip + AWS S3
* tests: rspec, factorygirl, capybara
* deploy: AWS E2, nginx, passenger, capistrano

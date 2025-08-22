# YUGIOH CARD VIEWER

## About

This website displays cards from the game "Yu Gi Oh" with reformatted text for readability and accessibility.

The text reformatting is done automatically via javascript. The backend is a standard Ruby on Rails application with a Postgres database.

The card text itself is written by [Konami](https://www.yugioh-card.com/), and the database is seeded by referencing [YGOPRODeck's API](https://ygoprodeck.com/api-guide/).

## How To Use

[Visit the active deployment of the website here.](https://ygo-card-reader-beaa7b503767.herokuapp.com/home?) Cards can be searched for by name using the bar at the top.

## Development Environment Setup

[rails demos and deets](https://rails-demos-n-deets-2023.herokuapp.com/demos/development-environment) has a sufficient guide for setting up the development environment necessary for this project.

## License

This project is licensed under the [Apache-2.0 License](https://github.com/aCactusOrSomething/Yu-Gi-Oh-Card-Reader/blob/main/LICENSE).

## Current TODO List

* refactor the card text processing algorithm into ruby, so that it can be run on the backend (and so that the rendering view logic can be separated from the business logic)
* "Advanced Search" UI cleanup:
  * text fields should not be selectible via tab navigation while minimized
  * it should be made more obvious that this is a dropdown menu

### Far Future Goals

* Rewrite text processing algorithm entirely. this is currently on hold until the end of the Fall 2025 semester - I'm taking some courses that should help with this, and want to finish those first.
* Search Results UI design. Right now, it's JUST a bootstrap-formatted table with two columns.
* Import/Export decklists, or create them yourself. I don't want to replace or supplant existing deckbuilding tools, but being able to view multiple cards at once would be incredibly helpful, and this is probably the most natural implementation of that for a user.

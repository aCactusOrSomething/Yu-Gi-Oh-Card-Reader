# YU-GI-OH CARD READER

## About

This website displays cards from the game "Yu Gi Oh" with reformatted text for readability and accessibility.

The text reformatting is done as part of the server-side rendering process. The backend is a standard Ruby on Rails application with a Postgres database.

The card text itself is written by [Konami](https://www.yugioh-card.com/), and the database is seeded by referencing [YGOPRODeck's API](https://ygoprodeck.com/api-guide/).

## How To Use

[Visit the active deployment of the website here.](https://yugioh.hazelcactus.net) Cards can be searched for by name using the bar at the top.

## License

This project is licensed under the [Apache-2.0 License](https://github.com/aCactusOrSomething/Yu-Gi-Oh-Card-Reader/blob/main/LICENSE).

## Feedback

You can submit feedback for the website via [This Google Form](https://forms.gle/1KAHgsLxkK3tVMMP6).

### Far Future Goals

* Rewrite text processing algorithm entirely.
* Search Results UI design. Right now, it's JUST a bootstrap-formatted table with two columns. sorting by different fields would be nice.
* Import/Export decklists, or create them yourself. I don't want to replace or supplant existing deckbuilding tools, but being able to view multiple cards at once would be incredibly helpful, and this is probably the most natural implementation of that for a user.

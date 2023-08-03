# Pong In Taylor

Pong made in the [Taylor framework](https://github.com/HellRok/Taylor).
It features an AI that's, not so good being honest but its fun even so.
The motivation behind this project was to get my feet wet with taylor
and ruby for game development.

## Play it

You can get the latest release from [here](https://github.com/Chadowo/pong-taylor/releases)

## Development

First clone the source code:
`git clone https://github.com/Chadowo/pong-taylor.git`

and [download](https://taylor.oequacki.com/#downloads) Taylor for your
platform, once that's done you should move the taylor executable to the
directory where the source code is. With that it should be as easy as
running the taylor (or `$ rake run`)!

To export the game, run `$ rake export`, make sure you have [Docker](https://www.docker.com/)
installed and working.

## Code Structure

The main source code is under `src/`, later on `lib/` we have standalone files
that have specific and reusable functionality.

## Assets

Credits goes to [domsson](https://opengameart.org/users/domsson) on
opengameart for the pong graphics.

see [CREDITS.txt](assets/CREDITS.txt)

## License

[MIT](LICENSE)

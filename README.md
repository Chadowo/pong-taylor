# Pong In Taylor

![GitHub release (with filter)](https://img.shields.io/github/v/release/chadowo/pong-taylor)

Pong made in the [Taylor framework](https://github.com/HellRok/Taylor).
It features an AI that's, not so good being honest but its fun even so.
The motivation behind this project was to get my feet wet with taylor
and ruby for game development.

<p align="center">
  <img src="docs/media/in_game_screenshot.png" alt="In game screenshot"/>
</p>

## Play it

You can get the latest release from [here](https://github.com/Chadowo/pong-taylor/releases)

## Development

First clone the project:

`git clone https://github.com/Chadowo/pong-taylor.git`

and [download Taylor for your platform](https://taylor.oequacki.com/#downloads) (you can grab it from the [releases on github](https://github.com/HellRok/Taylor/releases))
too. Once that's done you should move the taylor executable to the directory where you cloned the project, 
With that it should be as easy as running the taylor (or `rake run` if you have rake)!

To export the game, run `./taylor export` (or `rake export`), make sure you have [Docker](https://www.docker.com/)
installed and working.

## Code Structure

The main source code is under `src/`, later on `lib/` we have standalone files
that have specific and reusable functionality. I should probably organize this better.

## Assets

Credits goes to [domsson](https://opengameart.org/users/domsson) on
opengameart for the pong graphics.

see [CREDITS.txt](assets/CREDITS.txt).

## License

This project is licensed under the [MIT](LICENSE) license.

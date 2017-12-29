# Twittrix
Twittrix is a client implementation for the arduino server software at
[ngrash/max7219-ticker](https://github.com/ngrash/max7219-ticker). It downloads
original tweets that contain the hashtag "#34c3" and sends them to a connected
arduino running the ticker software.

## Usage
Make sure to set both `TWITTER_CONSUMER_KEY` and `TWITTER_CONSUMER_SECRET`.
These can be retrieved from your twitter app.
In addition, you can configure a different hashtag in `config.exs`.
Then run `mix` and you're running.

## License
Twittrix is released under the [MIT License](https://opensource.org/licenses/MIT).


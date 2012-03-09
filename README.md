# Ruby rhyming headline generator

This automatically generates rhymes from a list of possible article headline sources. It uses the 'ruby_rhymes' gem to create rhyme couplets. You can add some RSS feed URLs into data/feeds.txt and a cron job is setup with the Whenever gem to run the get feeds file to pull in headlines into headlines.txt. These are ordered by their rhyme keys.

This is based on:
[Ruby Poetry](http://blog.andrewmcdonough.com/blog/2012/02/23/ruby-poetry/) by [Andrew McDonough](https://twitter.com/#!/andrewmcdonough).

## Steps

1. **get_feeds.rb**
	Extracts feed URLs from feeds.yaml, and writes these URLs to feeds.txt (could be skipped)

2. **get_headlines.rb**
	Downloads all feeds specified in feeds.txt, extracts the headlines of the articles in the feeds, and stores these headlines in headlines.txt.

3. **find.rb**
	Reads in the headlines from headlines.txt, generates couplets and prints it out.

## TODO

1.  Remove headline strings from the array they're stored in while get_headlines.rb is saving them to rhymes.txt if they don't have matching rhyme keys.
2.  Add tests. Whoops!
3.  Add some functionality to tweet_n_delete.rb
4.  Rack this baby up into a Sinatra app

## Changelog

- Removed generate_topical_rhyming_couplets.rb.
- Made 'syck' the YAML engine because some of the YAML code was either invalid or just wasn't being parsed properly.
- Added feedback for get_headlines job with incremental counter to see how far the download is.
- In headline fetching, remove anything after a pipe character with regex. Also remove known superfluous suffixes.
- Changed headlines.uniq! to headlines.uniq in get_headlines.rb
- Headlines.txt is emptied every time it fetches a batch of headlines
- Added ruby_rhymes gem
- Added the whenever gem to run the Ruby files in a cron job
- Added twitter gem
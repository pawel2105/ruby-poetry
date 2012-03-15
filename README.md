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

## Notes

In find.rb in the rhyme? method, all punctuation marks are stripped while headlines are being checked for rhymes.

    as = a.gsub /\W/,""
    bs = b.gsub /\W/,""

Rhymes also need to be tweet sized

    (as.length + bs.length < 140)

We reject all headlines whose last word ends in a word not in the rhyming dictionary otherwise it won't know how to rhyme it

    headlines.reject! { |h|  h.to_phrase.dict? == false }

We remove all headlines that end in the same word. We could go about deleting all but one, but this way was easier.

Every time new rhymes are searched for, we first empty the couplets text file before saving the new rhymes to it.

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
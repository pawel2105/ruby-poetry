# Ruby rhyming headline generator

This automatically generates rhymes from a list of possible article headline sources. It uses the 'ruby_rhymes' gem to create rhyme couplets.

This is based on:
[Ruby Poetry](http://blog.andrewmcdonough.com/blog/2012/02/23/ruby-poetry/) by [Andrew McDonough](https://twitter.com/#!/andrewmcdonough).

# Steps

1. **get_feeds.rb**
	Extracts feed URLs from feeds.yaml, and writes these URLs to feeds.txt (could be skipped)

2. **get_headlines.rb**
	Downloads all feeds specified in feeds.txt, extracts the headlines of the articles in the feeds, and stores these headlines in headlines.txt.

3. **find.rb**
	Reads in the headlines from headlines.txt, generates couplets and prints it out.

#TODO

- Remove "and more" suffix from headlines
- Add rhyming gem
- Add Twitter gem, post headlines every hour.
- Store couplets into file, delete couplet as it's tweeted.
- Add headline character limit.
- Style HTML page
- save HTML page somewhere?
- Cron job to fetch headlines once a day
- Host file online?
- Remove error-prone urls from feeds.txt in the get_headlines rescue block

# Changelog

- Removed generate_topical_rhyming_couplets.rb.
- Made 'syck' the YAML engine because some of the YAML code was either invalid or just wasn't being parsed properly.
- Added feedback for get_headlines job with incremental counter to see how far the download is.
- In headline fetching, remove anything after a pipe character with regex. Also remove known superfluous suffixes.
- Changed headlines.uniq! to headlines.uniq in get_headlines.rb
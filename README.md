# Ruby Poetry

Automatically generates couplets (rhymes) from article headlines.

Based on:
[Ruby Poetry](http://blog.andrewmcdonough.com/blog/2012/02/23/ruby-poetry/) by [Andrew McDonough](https://twitter.com/#!/andrewmcdonough).

1. **get_feeds.rb**
	Extracts feed URLs from feeds.yaml, and writes these URLs to feeds.txt (could be skipped)

2. **get_headlines.rb**
	Downloads all feeds specified in feeds.txt, extracts the headlines of the articles in the feeds, and stores these headlines in headlines.txt.

3. **find.rb**
	Reads in the headlines from headlines.txt and generates couplets.

# Done Pawel
- Removed generate_topical_rhyming_couplets.rb.
- Gemfile for dependency management would be nice.

#TODO Pawel

- Add feedback for get_headlines.rb so it prints out what it's getting, not just for when there's an error.
- In headline fetching, remove anything after a pipe character with regex
- Remove "and more" suffix from headlines
- Add rhyming gem
- Add Twitter gem, post headlines every hour.
- Store couplets into file, delete couplet as it's tweeted.
- Add headline character limit.
- Style HTML page
- save HTML page somewhere?
- Cron job to fetch headlines once a day
- Host file online?
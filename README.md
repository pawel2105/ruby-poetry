# Ruby Poetry

Based on:
[Ruby Poetry](http://blog.andrewmcdonough.com/blog/2012/02/23/ruby-poetry/) by [Andrew McDonough](https://twitter.com/#!/andrewmcdonough).

1. **get_feeds.rb**
	Reads in feeds.yaml, extracts Feed urls from that file, and writes these URLs to feeds.txt
(could be skipped)

2. **get_headlines.rb**
	Downloads all feeds specified in feeds.txt, extracts the headlines of the articles in the feeds, and stores these headlines in headlines.txt.

3. **find.rb**
	Reads in the headlines from headlines.txt and generates couplets out of them.

# TODO
- Not 100% sure what the purpose of generate_topical_rhyming_couplets.rb was, at it just seems to combine the code of the other 3 files. Maybe this could be removed.
- Gemfile for dependency management would be nice.

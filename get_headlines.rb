#!/usr/bin/env ruby

require 'open-uri'
require 'rss'
require 'pp'

require "./paths.rb"

open(HEADLINES, "w") do |f|
  begin
    f.truncate(0)
    puts "Emptied headlines file"
  rescue
    puts "Couldn't empty headlines file!"
  end
end

fh = open(FEEDS_TXT)
feeds = fh.read.split "\n"

headlines = []
feedcount = feeds.count
feedincrement = 0
feeds.each do |feed|
  begin
    file = open(feed)
    rss = RSS::Parser.parse(file.read)
    feed_headlines = rss.items.map(&:title)
    headlines += feed_headlines
    feedincrement += 1
    puts "Fetched headlines #{feedincrement}/#{feedcount} - from #{feed}"
  rescue
    puts "----------- \n Error with #{feed} \n-----------"
    feedincrement += 1
  end
end

# Remove duplicates and strip some prefixes and some suffixes
headlines = headlines.uniq
headlines = headlines.map {|h| h.gsub /^(AUDIO|VIDEO): /,""}
headlines = headlines.map {|h| h.gsub /|\s\w+$/,""} #anything after a pipe character
headlines = headlines.map {|h| h.gsub /(\(|\))/,""} #strip parenthesis
headlines = headlines.map {|h| h.gsub /video$/,""} 

open(HEADLINES, "w") do |fh|
  headlines.each do |h|
    fh.write "#{h}\n"
  end
end

fulldata = []
feeds.each do |feed|
  begin
    file = open(feed)
    rss = RSS::Parser.parse(file.read)
    datatitle = rss.items.map(&:title)
    datalink = rss.items.map(&:link)
    
    temp_array = []
    datatitle.count.times { temp_array << "" }
    fulldata += temp_array.zip(datatitle, datalink)
    #puts fulldata
    puts "#{wef}/ #{feeds.count}"
  rescue
    puts "----------- \n Error with #{feed} \n-----------"
  end
end

fulldata = fulldata.uniq

open(DATA, "w") do |data|
  fulldata.each do |datatitle|
    data.write "\"#{datatitle.join("\n")}\"" + "\n\n" 
  end
end
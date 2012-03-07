#!/usr/bin/env ruby

require 'open-uri'
require 'yaml'
require 'rss'

require "./paths.rb"

YAML::ENGINE.yamler = 'syck'
data = YAML.load(open(FEEDS_YAML))
feeds = data.collect {|source| source["feeds"] && source["feeds"].collect {|f| f["url"] } }.flatten

open(FEEDS_TXT, "w") do |fh|
  feeds.each do |feed|
    fh.write "#{feed}\n"
  end
end





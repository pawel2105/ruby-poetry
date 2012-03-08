#!/usr/bin/env ruby

require 'rubygems'
require "bundler/setup"

Bundler.require(:default)

require "pp"
require "./paths.rb"

# read in all headlines incl. links
blog_headlines = []
Dir.glob("./data/blog_headlines/*.json").each do |file|
   blog_headlines += JSON[open(file).read]
end

# create lookup map
blog_headlines_map = Hash[blog_headlines.map{|bh| [bh["content"],bh["href"]] }]

headlines = blog_headlines_map.keys

def couplet?(a,b)
  as = a.gsub /\W/,"" # Ignore punctuation
  bs = b.gsub /\W/,""
  as[-3,3] == bs[-3,3] &&
    !(as[-4,4] == bs[-4,4]) &&
    (as.length - bs.length).abs < 15 &&
    (as.length > 30 && as.length < 70) &&
    (bs.length > 30 && bs.length < 70)
end

headlines.reject! {|h| h.length < 10}
headlines.sort! {|a,b|  a[-3,3] <=> b[-3,3] }

couplets_html = open("./output/couplets.html","w")

couplets_html.puts '<!DOCTYPE html>'
couplets_html.puts '<html lang="en">'
couplets_html.puts '<head>'
couplets_html.puts '<meta http-equiv="content-type" content="text/html; charset=utf-8" /> <meta charset="utf-8">'
couplets_html.puts '</head>'
couplets_html.puts '<body>'

couplets_html.puts '<h1>Ruby-Poetry: Blog Post Couplets</h1>'

i = 0
while (i < headlines.length-1) do
  a = headlines[i]
  b = headlines[i+1]
  if couplet?(a,b)
    i += 1
    couplets_html.puts "<a href='#{blog_headlines_map[a]}'>#{a}</a> <br/>"
    couplets_html.puts "<a href='#{blog_headlines_map[b]}'>#{b}</a> <br/><br/>"
    couplets_html.puts "\n"
  end
  i += 1
end

couplets_html.puts '</body>'
couplets_html.puts '</html>'


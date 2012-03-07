#!/usr/bin/env ruby

require "./paths.rb"
require 'ruby_rhymes'

fh = open(HEADLINES)
headlines = fh.read.split("\n")

def rhyme?(a,b)
  as = a.gsub /\W/,"" # Ignore punctuation
  bs = b.gsub /\W/,""
  as.to_phrase.rhyme_keys == bs.to_phrase.rhyme_keys &&
    (as.length + bs.length < 141) #rhyme needs to be tweet sized
end

headlines.reject! {|h| h.length < 10 || h.length > 140 }
headlines.sort! {|a,b|  a[-3,3] <=> b[-3,3] }
headlines.reject! { |h|  h.to_phrase.dict? == false } #reject all headlines whose last word ends in a word not in the rhyming dictionary or it won't know how to rhyme it

#Empty the couplets text file before saving the new rhymes to it
open(RHYMES, "w") do |empty|
  begin
    empty.truncate(0)
    puts "Emptied couplets.txt file"
  rescue
    puts "Couldn't empty couplets file!"
  end
end

#open it again
c = open(RHYMES)
cl = c.read.split("\n")

begin
  i = 0
  puts "Adding new rhymes to rhymes.txt"
  while (i < headlines.length-1) do #looping through the headlines
    a = headlines[i]
    b = headlines[i+1]
    if rhyme?(a,b)
      i += 1
        open(RHYMES, "w") do |c|
          headlines.each do |a|
            c.write "#{a}\n" #write rhymes to couplets.txt
          end
        end
      end
    i += 1
  end
  puts "successfully saved rhymes"
rescue
  puts "couldn't save new rhymes"
end


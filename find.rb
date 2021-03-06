#!/usr/bin/env ruby

require "./paths.rb"
require 'ruby_rhymes'
require 'pp'

fh = open(HEADLINES)
headlines = fh.read.split("\n")

def rhyme?(a,b)
  as = a.gsub /\W/,""
  bs = b.gsub /\W/,""
  as.to_phrase.rhymes.flatten.join(", ").include?(bs.to_phrase.rhymes.flatten.join(", ")) &&
    (as.length + bs.length < 140)
end

headlines.reject! {|h| h.length < 10 || h.length > 140 }
headlines.reject! { |h| h.to_phrase.dict? == false } 
headlines = headlines.map{|i| i.split(" ")[-1]}.inject(Hash.new(0)){|i,c| i[c]+=1; i}.map{|k,v| headlines.grep(/\s#{k}$/).first if v==1}.compact

rhyme_map = Hash[headlines.map{|h| h.to_phrase.rhyme_key}.zip(headlines)]
rhyme_map.reject!{|k, v| v.size % 2 != 0 }
headlines_with_counterparts = rhyme_map.reject{|k, v| v.size <= 1 }.values
headlines.sort_by! { |h| h.to_phrase.rhyme_keys }

open(RHYMES, "w") do |empty|
  begin
    empty.truncate(0)
    puts "Emptied rhymes.txt file"
  rescue
    puts "Couldn't empty couplets file!"
  end
end

c = open(RHYMES, "w")
begin
  i = 0
  puts "Adding new rhymes to rhymes.txt"
  while (i < headlines.length-1) do
    a = headlines[i]
    b = headlines[i+1]
    if rhyme?(a,b)
      i += 1
        open(RHYMES, "w") do |c|
          headlines.each do |a|
            c.write "#{a}" + "\n"
          end
        end
      end
    i += 1
  end
  puts "successfully saved rhymes"
rescue
  puts "couldn't save new rhymes"
end
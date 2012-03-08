#!/usr/bin/env ruby

require "./paths.rb"
require 'ruby_rhymes'

fh = open(HEADLINES)
headlines = fh.read.split("\n")

def rhyme?(a,b)
  as = a.gsub /\W/,"" # Ignore punctuation
  bs = b.gsub /\W/,""
  as.to_phrase.rhymes.flatten.join(", ").include?(bs.to_phrase.rhymes.flatten.join(", ")) &&
    (as.length + bs.length < 140) #rhyme needs to be tweet sized
end

headlines.reject! {|h| h.length < 10 || h.length > 140 }
headlines.reject! { |h|  h.to_phrase.dict? == false } #reject all headlines whose last word ends in a word not in the rhyming dictionary or it won't know how to rhyme it

headlines = headlines.map{|i| i.split(" ")[-1]}.inject(Hash.new(0)){|i,c| i[c]+=1; i}.map{|k,v| headlines.grep(/\s#{k}$/).first if v==1}.compact
#removes any headlines that end in the same word

headlines.sort_by! { |h| h.to_phrase.rhyme_keys }

#need a way to remove all headlines whose rhyme_keys count is 1

#puts headlines.map{|i| i.to_phrase.rhyme_keys }


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
c = open(RHYMES, "w")
#cl = c.read.split("\n")

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
            c.write "#{a}" + "\n" #write rhymes to rhymes.txt
          end
        end
      end
    i += 1
  end
  puts "successfully saved rhymes"
rescue
  puts "couldn't save new rhymes"
end
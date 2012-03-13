require 'twitter'
require "./paths.rb"
require 'ruby_rhymes'
require './twitter.rb' #just my twitter credentials

def rhyme?(a,b)
  as = a.gsub /\W/,""
  bs = b.gsub /\W/,""
  as.to_phrase.rhymes.flatten.join(", ").include?(bs.to_phrase.rhymes.flatten.join(", ")) &&
    (as.length + bs.length < 140)
end

file = open(RHYMES)
potential = file.read.split "\n"  

# This works yet the one below doesn't?
#   1.times do
#     i = 0
#     a = potential[i]
#     b = potential[i+1]
#     if rhyme?(a,b)
#       twitter.update("#{a}. #{b}")
#       puts "Tweeted a headlines"
#     else
#       i += 1
#     end
#     #a.delete
#     #b.delete
#   end

begin
  i = 0
  puts "Trying to tweet a rhyming headline"
  while (i < potential.length-1) do
    a = headlines[i]
    b = headlines[i+1]
    if rhyme?(a,b)
        twitter.update("#{a}. #{b}")
        return
    end
    i += 1
  end
  puts "successfully tweeted"
rescue
  puts "couldn't tweet"
end

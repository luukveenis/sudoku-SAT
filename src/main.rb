#!/usr/bin/env ruby
require './puzzle'

def main
  input = File.open(ARGV[0]).reduce("") do |acc, line|
    acc = acc + line.chomp.gsub(/[.*?]/, "0")
  end

  Puzzle.new(input).solve
end

if __FILE__ == $0
  main
end

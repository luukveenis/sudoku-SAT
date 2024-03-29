#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "src/puzzle")

def main
  input = File.open(ARGV[0]).reduce("") do |acc, line|
    acc = acc + line.chomp.gsub(/[.*?0]/, "-")
  end

  use_extended = ARGV[1] == "-e"
  puzzle = Puzzle.new input, use_extended
  puzzle.print

  solution = puzzle.solve
  solution.print
end

if __FILE__ == $0
  main
end

require File.join(File.dirname(__FILE__), "solution")
require File.join(File.dirname(__FILE__), "sudoku")

class Puzzle < Sudoku
  INFILE = "SAT-input-temp.txt"
  OUTFILE = "SAT-output-temp.txt"

  def initialize input, use_extended
    @input = input
    @units = input.chars.count { |c| c != "-" }
    @use_extended = use_extended
  end

  def print
    puts "\nInput:"
    puts "(-'s are blank entries)"
    puts "====================="
    puts format @input.chars.each_slice(9).to_a
    puts "\nUsing extended encoding\n" if @use_extended
  end

  def solve
    generate
    `./minisat #{INFILE} #{OUTFILE}`
    response = File.open(OUTFILE, "r").map(&:chomp)
    Solution.new response
  end

  private

  def generate
    f = File.open(INFILE, "w")

    write_header f
    write_each_entry f
    write_each_row f
    write_each_column f
    write_sub_grids f
    write_extended f if @use_extended
    write_units f
    f.close
  end

  def write_header f
    if @use_extended
      f.puts "p cnf 729 #{11988 + @units}"
    else
      f.puts "p cnf 729 #{8829 + @units}"
    end
  end

  def write_each_entry f
    (1..9).each do |i|
      (1..9).each do |j|
        (1..9).each do |k|
          f.print to_entry(i,j,k) + " "
        end
        f.puts "0"
      end
    end
  end

  def write_each_row f
    (1..9).each do |j|
      (1..9).each do |k|
        (1..8).each do |i|
          ((i+1)..9).each do |r|
            f.print "#{to_entry(i,j,k,true)} #{to_entry(r,j,k,true)} "
            f.puts "0"
          end
        end
      end
    end
  end

  def write_each_column f
    (1..9).each do |i|
      (1..9).each do |k|
        (1..8).each do |j|
          ((j+1)..9).each do |r|
            f.print "#{to_entry(i,j,k,true)} #{to_entry(i,r,k,true)} "
            f.puts "0"
          end
        end
      end
    end
  end

  def write_sub_grids f
    (1..9).each do |k|
      (0..2).each do |r|
        (0..2).each do |s|
          (1..3).each do |i|
            (1..3).each do |j|
              ((j+1)..3).each do |t|
                f.print "#{to_entry(3*r + i, 3*s + j, k, true)} "
                f.print "#{to_entry(3*r + i, 3*s + t, k, true)} "
                f.puts "0"
              end
            end
          end
        end
      end
    end
    (1..9).each do |k|
      (0..2).each do |r|
        (0..2).each do |s|
          (1..3).each do |i|
            (1..3).each do |j|
              ((i+1)..3).each do |t|
                (1..3).each do |u|
                  f.print "#{to_entry(3*r + i, 3*s + j, k, true)} "
                  f.print "#{to_entry(3*r + t, 3*s + u, k,true)} "
                  f.puts "0"
                end
              end
            end
          end
        end
      end
    end
  end

  def write_extended f
    (1..9).each do |i|
      (1..9).each do |j|
        (1..8).each do |k|
          ((k+1)..9).each do |r|
            f.print "#{to_entry(i, j, k, true)} "
            f.print "#{to_entry(i, j, r, true)} "
            f.puts "0"
          end
        end
      end
    end
    (1..9).each do |j|
      (1..9).each do |k|
        (1..9).each do |i|
          f.print to_entry(i, j, k, true) + " "
        end
        f.puts "0"
      end
    end
    (1..9).each do |i|
      (1..9).each do |k|
        (1..9).each do |j|
          f.print to_entry(i, j, k, true) + " "
        end
        f.puts "0"
      end
    end
    (1..9).each do |k|
      (0..2).each do |r|
        (0..2).each do |s|
          (1..3).each do |i|
            (1..3).each do |j|
              f.print "#{to_entry(3*r + i, 3*s + j, k)} "
            end
          end
        f.puts "0"
        end
      end
    end
  end

  def write_units f
    i=1
    @input.chars.each_slice(9) do |row|
      row.each_with_index do |val, j|
        if val != "-"
          f.puts "#{to_entry(i,j+1,val.to_i)} 0"
        end
      end
      i = i + 1
    end
  end

  def to_entry i, j, k, negate = false
    if negate
      (-((81 * (i - 1)) + (9 * (j - 1)) + (k - 1) + 1)).to_s
    else
      ((81 * (i - 1)) + (9 * (j - 1)) + (k - 1) + 1).to_s
    end
  end
end

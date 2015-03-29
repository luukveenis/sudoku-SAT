class Puzzle
  INFILE = "SAT-input-temp.txt"
  OUTFILE = "SAT-output-temp.txt"

  def initialize(input)
    @input = input
  end

  def generate
    f = File.open(INFILE, "w")

    write_header f
    write_each_entry f
    write_each_row f
    write_each_column f
    write_sub_grids f
    write_units f
    f.close
  end

  private

  def write_header f
    f.puts "p cnf 729 8829"
  end

  def write_each_entry f
    (1..9).each do |i|
      (1..9).each do |j|
        (1..9).each do |k|
          f.print(to_entry(i,j,k) + " ")
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
            f.print("#{to_entry(i,j,k,true)} #{to_entry(r,j,k,true)} ")
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
            f.print("#{to_entry(i,j,k,true)} #{to_entry(i,r,k,true)} ")
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
                f.print("#{to_entry(3*r + i, 3*s + j, k, true)} ")
                f.print("#{to_entry(3*r + i, 3*s + t, k, true)} ")
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
                  f.print("#{to_entry(3*r + i, 3*s + j, k, true)} ")
                  f.print("#{to_entry(3*r + t, 3*s + u, k,true)} ")
                  f.puts "0"
                end
              end
            end
          end
        end
      end
    end
  end

  def write_units f
    i=1
    @input.chars.each_slice(9) do |row|
      row.each_with_index do |val, j|
        k = val.to_i
        if k != 0
          f.puts "#{to_entry(i,j+1,k)} 0"
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

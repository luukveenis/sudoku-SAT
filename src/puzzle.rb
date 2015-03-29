class Puzzle
  def initialize(input)
    @input = input
  end

  def generate
    f = File.open("../SAT-input.txt", "w")

    write_header f
    write_each_entry f
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

  def to_entry i, j, k
    ((81 * (i - 1)) + (9 * (j - 1)) + (k - 1) + 1).to_s
  end
end

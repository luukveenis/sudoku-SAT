class Solution
  def initialize response
    @satisfiable = response[0] == "SAT"
    @results = @satisfiable ? process(response[1]) : nil
  end

  def print
    if @satisfiable
      puts format_results
    else
      puts "Error: provided puzzle not satisfiable - no solution"
    end
  end

  private

  def process assignments
    results = Array.new(9) { Array.new(9) }
    assignments.split(" ").each do |val|
      val = val.to_i
      if val > 0
        i,j,k = table_entry(val)
        results[i-1][j-1] = k
      end
    end
    results
  end

  def table_entry val
    y = ((val - 1) % 81) / 9 + 1
    z = ((val - 1) % 9) + 1
    x = (val - 1 - z - (9*(y-1))) / 81 + 2
    [x, y, z]
  end

  def format_row row
    row.each_slice(3).to_a.map{ |e| e.join(" ") }.join(" | ")
  end

  def format_results
    sep = "\n---------------------\n"
    @results.each_slice(3).to_a.map do |slice|
      slice.map{ |row| format_row row }.join("\n")
    end.join(sep)
  end
end

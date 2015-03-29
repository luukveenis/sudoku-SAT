class Solution
  def initialize response
    @satisfiable = response[0] == "SAT"
    @results = @satisfiable ? process(response[1]) : nil
  end

  private

  def process assignments
    results = Array.new(9) { Array.new(9) }
    assignments.split(" ").each do |val|
      val = val.to_i
      if val > 0
        i,j,k = table_entry(val)
        results[i][j] = k
      end
    end
    results
  end

  def table_entry val
    y = ((val - 1) % 81) / 9 + 1
    z = ((val - 1) % 9) + 1
    x = (val - 1 - z - (9*(y-1))) / 81 + 1
    [x, y, z]
  end
end

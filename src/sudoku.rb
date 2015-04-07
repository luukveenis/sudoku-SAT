class Sudoku

  private

  def format_row row
    row.each_slice(3).to_a.map{ |e| e.join(" ") }.join(" | ")
  end

  def format puzzle
    sep = "\n---------------------\n"
    puzzle.each_slice(3).to_a.map do |slice|
      slice.map{ |row| format_row row }.join("\n")
    end.join(sep)
  end
end

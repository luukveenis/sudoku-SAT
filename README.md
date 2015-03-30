# CSC 320 - Sudoku SAT

This project converts partially solved sudoku puzzles into the standard
SAT-challenge (DIMACS) format that can be input to the miniSAT SAT solver.
If there is a solution to the puzzle, it is converted back and presented
to the user.

## Running the Code

This project was written in Ruby, so you will have to have Ruby installed.
Since UVic's Linux boxes only have Ruby 1.8.6 installed, the code has ensured
compatibility with this version and up.

You will need the compiled MiniSAT binary. The code assumes it is in the root
directory (same directory as main.rb), so please compile it and move the
`minisat` executable there.

Next, make main.rb executable as follows (you may need to sudo):
```
chmod 755 main.rb
```
Finally, simply pass the name of an input file containing a single sudoku
puzzle to main and the solution will be printed. Some sample puzzles are
provided in the `data` directory and can be used as shown:
```
./main.rb data/sample2.txt
```

## Authors

- Nikita Malhotra
- Luuk Veenis

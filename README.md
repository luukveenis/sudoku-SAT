# CSC 320 - Sudoku SAT

This is the final project for CSC 320 - Foundations of Computer Science. It was
completed by Nikita Malhotra and Luuk Veenis. This project converts partially
solved sudoku puzzles into the standard SAT-challenge (DIMACS) format that can
be input to the miniSAT SAT solver. If there is a solution to the puzzle, it is
converted back and presented to the user. The results of our experiments are
summarized in the project report submitted together with this code.

## What is included in this submission

We have included a PDF entitled ProjectSummaryReport.pdf that discusses our
implementation of the Sudoku solver and the results of our experiments with
different encodings and other solvers.

Our main program is contained in `main.rb` and the instructions for running it
are in the next section. The `src` directory contains some Ruby files with
utility classes used by our solver. You should not need to access these in order
to use our solver. The `data` directory contains some sample sudoku puzzles
that can be used to test our program. An example use of these is shown in the
next section.

## Running the Code

This project was written in Ruby, so you will have to have Ruby installed.
Since UVic's Linux boxes only have Ruby 1.8.6 installed, the code has ensured
compatibility with this version and up.

You will need the compiled MiniSAT binary. The code assumes it is in the root
directory (same directory as main.rb), so please compile MiniSAT and move the
`minisat` executable there.

Next, make main.rb executable as follows (you may need to sudo):
```
chmod 755 main.rb
```
Finally, simply pass the name of an input file containing a *single* sudoku
puzzle to main and the solution will be printed. Some sample puzzles are
provided in the `data` directory and can be used as shown:
```
./main.rb data/sample2.txt
```

## Other SAT Solvers

As outlined in the project summary provided, some other SAT solvers were
tested to compare performance against MiniSAT. Specifically, we tested RSat
which uses the same input format as MiniSAT. In order to test this, we simply
ran the solver once (which uses MiniSAT by default) which generates the
temporary file `SAT-input-temp.txt`. This file contains the puzzle's encoding,
so we simply ran RSat on this file after.

If you would like to test the extended encoding with a solver other than
MiniSAT, simply run main.rb with the -e flag once to run MiniSAT on the
extended encoding, and similarly the extended encoding of the puzzle will be in
the file `SAT-input-temp.txt`.

## Authors

- Nikita Malhotra
- Luuk Veenis

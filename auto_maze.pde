Dimension size = new Dimension(700, 700);

Button btnNew, btnSolve;

GenMazeAldous genMaze;
SolveMazeBackTrack solveMaze;
Maze maze;

void setup() {
  size(700, 700);
  
  btnNew = new Button("new", 0, 0, 100, 20) {
    public void onClick() {
      maze = genMaze.newMaze(20, 20, new Point(30, 30), new Dimension(size.w - 60, size.h - 60));
      solveMaze.rute = null;
    }
  };
  btnSolve = new Button("solve", 100, 0, 100, 20) {
    public void onClick() {
      if (genMaze.isGenerated()) solveMaze.solveMaze(maze);
    }
  };
  
  genMaze = new GenMazeAldous();
  solveMaze = new SolveMazeBackTrack();
  btnNew.onClick();
}

int skip = 20, frame = 0;
void draw() {
  // if (frame++ % skip != 0) return;
  background(0);
  genMaze.nextStep();
  if (genMaze.isGenerated()) {
    solveMaze.nextStep();
    solveMaze.draw();
  }
  maze.draw();
  btnNew.draw();
  btnSolve.draw();
}

void mouseClicked() {
  btnNew.mouseClicked();
  btnSolve.mouseClicked();
}

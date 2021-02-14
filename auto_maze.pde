Dimension screenS;
Button btnCreate, btnSolve, btnRunSolve;

MazeCreator mazeCreator;
MazeSolver mazeSolver;
Maze maze;
int delay = 5;

void setup() {
  size(700, 700);
  screenS = new Dimension(700, 700);
  btnCreate = new Button("new", 0, 0, 80, 20) {
    public void onClick() {
      maze = mazeCreator.newMaze(101);
      mazeSolver.maze = null;
      mazeSolver.solved = false;
    }
  };
  btnSolve = new Button("solve", 80, 0, 80, 20) {
    public void onClick() {
      mazeSolver.solve(maze);
    }
  };
  btnRunSolve = new Button("run solve", 160, 0, 80, 20) {
    public void onClick() {
      btnSolve.onClick();
      mazeSolver.running = true;
    }
  };
  
  mazeCreator = new MazeCreator();
  mazeSolver = new MazeSolver();
  btnCreate.onClick();
}

void draw() {
  delay = ++delay % 5;
  if (delay != 0) return;
  background(0);
  btnCreate.render();
  btnSolve.render();
  btnRunSolve.render();
  maze.render(20, 20, screenS.w - 40, screenS.h - 40);
  mazeSolver.render(20, 20, screenS.w - 40, screenS.h - 40);
}

void mouseClicked() {
  btnCreate.mouseClicked();
  btnSolve.mouseClicked();
  btnRunSolve.mouseClicked();
}

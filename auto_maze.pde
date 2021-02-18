Dimension screenSize;

Button btnNew, btnSolve;
DropdownList sizesList, speedsList;

GenMazeAldous genMaze;
SolveMazeBackTrack solveMaze;
Maze maze;

String[] speeds = {"slow", "medium", "fast", "faster"};
int speed;

int[] sizes = {5, 10, 20, 50};
int mazeSize;

void setup() {
  size(700, 700);
  screenSize = new Dimension(700, 700);
  
  btnNew = new Button("new", new Point(0, 0), new Dimension(100, 20)) {
    public void onClick() {
      mazeSize = sizes[sizesList.selection];
      maze = genMaze.newMaze(mazeSize, mazeSize, new Point(30, 30),
          new Dimension(screenSize.w - 60, screenSize.h - 60));
      solveMaze.rute = null;
    }
  };
  btnSolve = new Button("solve", new Point(100, 0), new Dimension(100, 20)) {
    public void onClick() {
      if (genMaze.isGenerated()) solveMaze.solveMaze(maze);
    }
  };
  String[] sizesTxt = new String[sizes.length];
  for (int i = sizes.length - 1; i >= 0; i--) {
    sizesTxt[i] = sizes[i] + " x " + sizes[i];
  }
  speedsList = new DropdownList(speeds,
    new Point(screenSize.w - 200, 0), new Dimension(100, 20));
  sizesList = new DropdownList(sizesTxt,
    new Point(screenSize.w - 100, 0), new Dimension(100, 20));
  
  genMaze = new GenMazeAldous();
  solveMaze = new SolveMazeBackTrack();
  btnNew.onClick();
}

int frame = 0;
void draw() {
  
  background(0);
  if (speed == 3) {
    for (int i = 0; i <= 25; i++) {
      genMaze.nextStep();
      solveMaze.nextStep();
    }
  } else {
    if (frame == 0) {
      genMaze.nextStep();
      solveMaze.nextStep();
    }
    if (speed == 0) frame = ++frame % 20;
    else if (speed == 1) frame = ++frame % 5;
    else frame = 0;
  }
  solveMaze.draw();
  maze.draw();
  btnNew.draw();
  btnSolve.draw();
  speedsList.draw();
  sizesList.draw();
}

void mouseClicked() {
  btnNew.mouseClicked();
  btnSolve.mouseClicked();
  if (speedsList.mouseClicked()) speed = speedsList.selection;
  sizesList.mouseClicked();
}

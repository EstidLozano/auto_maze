class SolveMazeBackTrack extends SolveMaze {

  byte[] dirs = {Maze.UP, Maze.RIGHT, Maze.DOWN, Maze.LEFT};
  Maze maze;
  byte[][] cells;
  boolean[][] visits;
  LinkedList<Point> rute;
  Point start, end, p, q;
  
  void solveMaze(Maze maze) {
    this.maze = maze;
    cells = maze.cells;
    visits = new boolean[cells.length][cells[0].length];
    rute = new LinkedList<Point>();
    for (int i = 0; i <= 3; i++) {
      int x = (i % 2) * (cells.length - 1),
          y = (i / 2) * (cells[0].length - 1);
      if (maze.canGoTo(x, y, Maze.START)) start = new Point(x, y);
      else if (maze.canGoTo(x, y, Maze.END)) end = new Point(x, y);
    }
    p = start;
    rute.addLast(p);
  }
  
  void nextStep() {
    if (rute == null || isSolved()) return;
    visits[p.x][p.y] = true;
    
    byte dir = (byte)(Math.random() * 4);
    for (int i = 0; i <= 3; i++) {
      q = maze.getNeighboor(p.x, p.y, dirs[dir]);
      if (q != null && !visits[q.x][q.y] && maze.canGoTo(p.x, p.y, dirs[dir])) {
        rute.addLast(q);
        p = q;
        return;
      }
      dir = (byte) (++dir % 4);
    }
    rute.removeLast();
    p = rute.getLast();
  }
  
  void draw() {
    if (rute == null) return;
    Dimension cS = maze.cellSize;
    for (int i = visits.length - 1; i >= 0; i--) {
      for (int j = visits[0].length - 1; j >= 0; j--) {
        if (visits[i][j]) {
          fill(150);
          strokeWeight(0);
          stroke(100);
          rect(maze.position.x + maze.cellSize.w * i,
              maze.position.y + maze.cellSize.h * j,
              maze.cellSize.w, maze.cellSize.h);
        }
      }
    }
    for (Point p : rute) {
      if (p.x == this.p.x && p.y == this.p.y) {
        drawCircle(p.x, p.y, (cS.w + cS.h) / 3, 0xffffff00);
      } else {
        drawCircle(p.x, p.y, (cS.w + cS.h) / 6, 255);
      }
    }
  }
  
  void drawCircle(int x, int y, float r, color col) {
    fill(col);
    strokeWeight(0);
    fill(col);
    circle(maze.position.x + maze.cellSize.w * (x + 0.5),
        maze.position.y + maze.cellSize.h * (y + 0.5), r);
  }
  
  boolean isSolved() {
    if (rute == null) return false;
    Point p = rute.getLast();
    return p.x == end.x && p.y == end.y;
  }
  
}

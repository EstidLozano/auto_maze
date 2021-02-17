class GenMazeAldous extends GenMaze {
  
  Maze maze;
  byte[][] cells;
  byte[][] visits;
  LinkedList<Point> neighs;
  byte[] directions = {Maze.UP, Maze.RIGHT, Maze.DOWN, Maze.LEFT};
  Point p, q;
  
  protected void genMaze(Maze maze) {
    this.maze = maze;
    cells = maze.cells;
    visits = new byte[cells.length][cells[0].length];
    neighs = new LinkedList<Point>();
    
    p = new Point((int) (Math.random() * cells.length),
        (int) (Math.random() * cells[0].length));
    q = null;
  }
  
  void nextStep() {
    if (isGenerated()) return;
    visits[p.x][p.y] = 2;
    for (byte dir : directions) {
      q = maze.getNeighboor(p.x, p.y, dir);
      if (q != null && visits[q.x][q.y] == 0) {
        neighs.addLast(q);
        visits[q.x][q.y]++;
      }
    }
    int neigh = (int)(Math.random() * neighs.size);
    p = neighs.get(neigh);
    for (int i = (int) (Math.random() * 4), c = 0; c <= 3; c++, i = ++i % 4) {
      q = maze.getNeighboor(p.x, p.y, directions[i]);
      if (q != null && visits[q.x][q.y] == 2) {
        maze.setWall(p.x, p.y, directions[i], true);
        neighs.remove(neigh);
        break;
      }
    }
  }
  
  boolean isGenerated() {
    return (neighs.size == 0 && q != null);
  }
  
}

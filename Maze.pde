class Maze {
  
  static final byte
      UP = 1,
      RIGHT = 2,
      DOWN = 4,
      LEFT = 8,
      START = 16,
      END = 32;

  byte[][] cells;
  
  Point position;
  Dimension cellSize;
  
  Maze(byte[][] cells, Point position, Dimension size) {
    this.cells = cells;
    this.position = position;
   
    this.cellSize = new Dimension(size.w / cells.length, size.h / cells[0].length);
  }
  
  boolean canGoTo(int x, int y, byte direction) {
    return (cells[x][y] & direction) == direction;
  }
  
  boolean isIsolated(int x, int y) {
    return cells[x][y] == 0;
  }
  
  boolean isOut(int x, int y) {
    return Math.min(Math.max(x, 0), cells.length - 1) != x ||
        Math.min(Math.max(y, 0), cells[0].length - 1) != y;
  }
  
  Point getNeighboor(int x, int y, byte direction) {
    x += (direction == LEFT ? -1 : (direction == RIGHT ? 1 : 0));
    y += (direction == UP ? -1 : (direction == DOWN ? 1 : 0));
    return isOut(x, y) ? null : new Point(x, y);
  }
  
  byte oppositeDirection(byte direction) {
    if (direction == UP) return DOWN;
    if (direction == RIGHT) return LEFT;
    if (direction == DOWN) return UP;
    return RIGHT;
  }
  
  void setWall(int x, int y, byte direction, boolean open) {
    if (isOut(x, y)) return;
    Point neigh = getNeighboor(x, y, direction);
    if (isOut((int) neigh.x, (int) neigh.y)) return;
    if (open) {
      cells[x][y] |= direction;
      cells[(int) neigh.x][(int) neigh.y] |= oppositeDirection(direction);
    } else {
      cells[x][y] -= cells[x][y] & direction;
      cells[(int) neigh.x][(int) neigh.y] -= cells[x][y] & oppositeDirection(direction);
    }
  }
  
  void draw() {
    for (int i = 0; i <= 3; i++) {
      int x = (i % 2) * (cells.length - 1),
       y = (i / 2) * (cells[0].length - 1);
      if (canGoTo(x, y, START)) drawRect(position.x + x * cellSize.w, position.y + y * cellSize.h, 0xff00ff00);
      else if (canGoTo(x, y, END)) drawRect(position.x + x * cellSize.w, position.y + y * cellSize.h, 0xff0000ff);
    }
    
    for (int i = cells.length - 1; i >= 0; i--) {
      for (int j = cells.length - 1; j >= 0; j--) {
        if (!canGoTo(i, j, UP)) {
          float x = position.x + i * cellSize.w, y = position.y + j * cellSize.h;
          drawLine(x, y, x + cellSize.w, y);
        }
        if (!canGoTo(i, j, RIGHT)) {
          float x = position.x + (i + 1) * cellSize.w, y = position.y + j * cellSize.h;
          drawLine(x, y, x, y + cellSize.h);
        }
        if (!canGoTo(i, j, DOWN)) {
          float x = position.x + i * cellSize.w, y = position.y + (j + 1) * cellSize.h;
          drawLine(x, y, x + cellSize.w, y);
        }
        if (!canGoTo(i, j, LEFT)) {
          float x = position.x + i * cellSize.w, y = position.y + j * cellSize.h;
          drawLine(x, y, x, y + cellSize.h);
        }
      }
    }
  }
  
  private void drawLine(float x1, float y1, float x2, float y2) {
    strokeWeight((cellSize.w + cellSize.h) / 20);
    stroke(255);
    line(x1, y1, x2, y2);
  }
  
  private void drawRect(float x, float y, color col) {
    fill(col);
    strokeWeight(0);
    stroke(col);
    rect(x, y, cellSize.w, cellSize.h);
  }
  
}

abstract class GenMaze {

  Maze newMaze(int w, int h, Point position, Dimension size) {
    byte[][] cells = new byte[w][h];
    int start = (int) (Math.random() * 4);
    int end = (int) (Math.random() * 3);
    if (end == start) end = 3;
    cells[(start % 2) * (w - 1)][(start / 2) * (h - 1)] |= Maze.START;
    cells[(end % 2) * (w - 1)][(end / 2) * (h - 1)] |= Maze.END;
    maze = new Maze(cells, position, size);
    genMaze(maze);
    return maze;
  }
  
  protected abstract void genMaze(Maze maze);
  
  protected abstract void nextStep();
  
  abstract boolean isGenerated();
  
}

abstract class SolveMaze {
  
  abstract void solveMaze(Maze maze);
  
  abstract void nextStep();
  
  abstract boolean isSolved();
  
}

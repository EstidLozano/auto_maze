class MazeSolver {
  
  Maze maze;
  int[][] solve;
  
  short[] rute;
  int ruteAdvance;
  boolean solved;
  boolean running;

  void solve(Maze maze) {
    running = false;
    ruteAdvance = 0;
    if (solved) return;
    this.maze = maze;
    solve = new int[maze.map.length][maze.map.length];
    for (int i = 0; i < solve.length; i++) {
      solve[0][i] = -1;
    }
    for (int i = 1; i < solve.length; i++) {
      solve[i] = solve[0].clone();
    }
    solveMaze(maze.start.x, maze.start.y, 0);
    getRute();
    solved = true;
  }
  
  private void solveMaze(int x, int y, int distance) {
    solve[x][y] = distance;
    for (int i = 0; i < 4; i++) {
      short xi = (short) ((i == 0 ? -1 : (i == 2 ? 1 : 0)) + x);
      short yi = (short) ((i == 1 ? -1 : (i == 3 ? 1 : 0)) + y);
      if (!maze.map[xi][yi] /*&& maze.start.x != xi && maze.start.y != yi*/
          && (solve[xi][yi] == -1 || solve[xi][yi] > distance)) {
        solveMaze(xi, yi, distance + 1);
      }
    }
  }

  private void getRute() {
    int i = maze.end.x, j = maze.end.y;
    rute = new short[solve[i][j]];
    for (int k = 0; k < solve[i][j]; /*k++*/) {
      if (solve[i][j - 1] == solve[i][j] - 1) {
        rute[solve[i][j] - 1] = 3;
        j--;
      } else if (solve[i][j + 1] == solve[i][j] - 1) {
        rute[solve[i][j] - 1] = 2;
        j++;
      } else if (solve[i - 1][j] == solve[i][j] - 1) {
        rute[solve[i][j] - 1] = 1;
        i--;
      } else if (solve[i + 1][j] == solve[i][j] - 1) {
        rute[solve[i][j] - 1] = 0;
        i++;
      }
    }
  }
  
  void render(float x, float y, float w, float h) {
    if (maze == null) return;
    w /= maze.realCellsX;
    h /= maze.realCellsY;
    if (running) {
      int xi = maze.start.x, yi = maze.start.y;
      for (int k = 0; k < ruteAdvance; k++) {
        xi += (short) (rute[k] == 0 ? -1 : rute[k] == 1 ? 1 : 0);
        yi += (short) (rute[k] == 2 ? -1 : rute[k] == 3 ? 1 : 0);
        float cX = x + w / 2 + xi * w, cY = y + h / 2 + yi * h;
        drawCell(cX, cY, w / 5, 0xffffffff);
      }
      int k = ruteAdvance;
      xi += (short) (rute[k] == 0 ? -1 : rute[k] == 1 ? 1 : 0);
      yi += (short) (rute[k] == 2 ? -1 : rute[k] == 3 ? 1 : 0);
      float cX = x + w / 2 + xi * w, cY = y + h / 2 + yi * h;
      drawCell(cX, cY, w / 3, 0xffff0000);
      if (ruteAdvance < rute.length - 1) ruteAdvance++;
    } else {
      for (int i = solve.length - 1; i >= 0; i--) {
        for (int j = solve.length - 1; j >= 0; j--) {
          float cX = x + i * w, cY = y + j * h;
          if (solve[i][j] != -1) {
            drawCell(cX, cY, w, h, String.valueOf(solve[i][j]));
          }
        }
      }
    }
  }
  
  private void drawCell(float x, float y, float w, float h, String txt) {
    x += w / 2;
    y += h / 2;
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(h * 0.7);
    text(txt, x, y);
  }
  
  private void drawCell(float x, float y, float r, int colour) {
    fill(colour);
    stroke(255);
    strokeWeight(2);
    ellipseMode(CENTER);
    circle(x, y, r);
  }

}

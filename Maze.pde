class Maze {
  
  boolean[][] map;
  static final int EMPTY = 0,
      WALL = 1,
      START = 2, 
      END = 3;
  Point start, end;
  
  int realCellsX, realCellsY, cellsX, cellsY;
      
  Maze(boolean[][] map, Point start, Point end) {
    this.map = map;
    this.start = start;
    this.end = end;
    realCellsX = map.length;
    realCellsY = map[0].length;
    cellsX = (cellsX - 3) / 2;
    cellsY = cellsX;
  }
  
  void render(float x, float y, float w, float h) {
    w /= realCellsX; 
    h /= realCellsY;
    for (int i = map.length - 1; i >= 0; i--) {
      for (int j = map.length - 1; j >= 0; j--) {
        float cX = x + i * w, cY = y + j * h;
        if (map[i][j]) drawCell(cX, cY, w, h, 0xff888888);
      }
    }
    drawCell(x + start.x * w, y + start.y * h, w, h, 0xff00ff00);
    drawCell(x + end.x * w, y + end.y * h, w, h, 0xff0000ff);
  }
  
  private void drawCell(float x, float y, float w, float h, int colour) {
    fill(colour);
    stroke(255);
    strokeWeight(w / 10);
    rect(x, y, w, h);
  }
  
}

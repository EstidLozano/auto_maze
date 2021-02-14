class MazeCreator {
  
  Maze newMaze(int size) {
      int newSize = size * 2 + 3;
      boolean[][] map = new boolean[newSize][newSize];
      //Body and corners
      for (int i = 0; i < newSize; i++) {
          map[0][i] = false; //Top corner
          map[1][i] = true; //First row
      }
      map[1][0] = false; //Left cell (to make the corner)
      map[1][newSize - 1] = false; //Right cell (to make the corner)
      for (int i = 2; i < newSize - 1; i++) {
          map[i] = map[1].clone(); //Second to final Rows
      }
      map[newSize - 1] = map[0].clone(); //Bottom corner
      //Start and goal
      Point start = new Point(size + 1, size + 1),
            end;
      short corner = (short) (Math.random() * 4);
      if (corner == 0) {
          end = new Point(2, 2);
      } else if (corner == 1) {
          end = new Point(newSize - 3, 2);
      } else if (corner == 2) {
          end = new Point(2, newSize - 3);
      } else { // (corner == 3)
          end = new Point(newSize - 3, newSize - 3);
      }
      map[start.x][start.y] = false;
      map[end.x][end.y] = false;
      Maze maze = new Maze(map, start, end);
      createMaze(maze, size + 1, size + 1);
      return maze;
  }

  void createMaze(Maze maze, int x, int y) {
      short num = (short) (Math.random() * 3 + 2); //Sides to look for
      short[] sides = {0, 1, 2, 3};
      //Unsorter
      for (int i = 0; i < sides.length; i++) {
          int j = i;
          while (j == i) {
              j = (int) (Math.random() * sides.length);
          }
          sides[i] = (short) (sides[j] - sides[i]);
          sides[j] = (short) (sides[j] - sides[i]);
          sides[i] = (short) (sides[j] + sides[i]);
      }
      for (int i = 0; i < sides.length; i++) {
          short xi = (short) (sides[i] == 0 ? -2 : sides[i] == 1 ? 2 : 0);
          short yi = (short) (sides[i] == 2 ? -2 : sides[i] == 3 ? 2 : 0);
          if (maze.map[x + xi][y + yi] == true && num > 0) {
              maze.map[x + xi][y + yi] = false;
              maze.map[x + xi / 2][y + yi / 2] = false;
              createMaze(maze, x + xi, y + yi);
              num--;
          } else if (maze.end.x == x + xi && maze.end.y == y + yi) {
              maze.map[x + xi / 2][y + yi / 2] = false;
              num--;
          }
      }
  }

}

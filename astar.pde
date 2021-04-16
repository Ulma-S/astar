import java.util.*;

int w = 5, h = 5;

Node Nodes[][];
ArrayList<Node> Root = new ArrayList<Node>();
Node currentNode;
Node goalNode;

void setup() {
  size(400, 400);

  //Initialization
  Nodes = new Node[w][h];

  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      Nodes[i][j] = new Node(i, j);
    }
  }

  //Set objectives
  Nodes[2][1].status = ENodeStatus.Wall;
  Nodes[2][2].status = ENodeStatus.Wall;
  Nodes[2][3].status = ENodeStatus.Wall;
  Nodes[1][3].status = ENodeStatus.Wall;
  Nodes[4][2].status = ENodeStatus.Wall;

  //Set start
  Root.add(Nodes[1][1]);
  Root.get(0).status = ENodeStatus.Open;
  currentNode = Root.get(0);

  //Set goal
  goalNode = Nodes[4][4];

  SearchRoot();
}

void draw() {
  background(255);

  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      if (Nodes[i][j] == goalNode) {
        fill(0, 255, 0);
      } else {
        switch(Nodes[i][j].status) {
        case None:
          fill(255);
          break;

        case Open:
          fill(255);
          fill(255, 0, 0);
          break;

        case Closed:
          fill(0, 0, 255);
          break;

        case Wall:
          fill(0);
          break;

        case Root:
          fill(0, 255, 0);
          break;
        }
      }
      rect(50 + i*60, 50+j*60, 60, 60);

      fill(0);
      text("c:" + Nodes[i][j].cost, 70 + i *60, 70 + j * 60);
      text("h:" + Nodes[i][j].hCost, 70 + i *60, 85 + j * 60);
      text("s:" + Nodes[i][j].score, 70 + i *60, 100 + j * 60);
    }
  }
}

void keyPressed() {
  if (keyCode == 'r' || keyCode == 'R') {
    ResetEnv();
  } else if (keyCode == ' ') {
    SearchRoot();
  }
}

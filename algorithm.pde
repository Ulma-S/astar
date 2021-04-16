enum ENodeStatus{
  None,
  Open,
  Closed,
  Wall,
  Root,
}


class Node{
  ENodeStatus status;
  Node parent;
  
  int cost;
  int hCost;
  int score;
  
  PVector coord;
  
  Node(int x, int y){
    status = ENodeStatus.None;
    parent = null;
    cost = 0;
    hCost = 0;
    score = 0;
    
    coord = new PVector(x, y);
  }
}

int loopCount = 0;
void SearchRoot(){
  //if current node is goal, finish searching
  if(currentNode == goalNode) return;
  
  //Check infinity loop
  if(loopCount > w * h) return;
  
  //if open node is none, return
  loop:
  for(int i=0; i<w; i++){
    for(int j=0; j<h; j++){
      if(Nodes[i][j].status == ENodeStatus.Open) break loop;
      if(i == w-1 && j == h-1) return;
    }
  }
  
  //Search minimum score node
  Node minNode = null;
  for(int i=0; i<w; i++){
    for(int j=0; j<h; j++){
      if(Nodes[i][j].status != ENodeStatus.Open) continue;
      if(minNode == null){
        minNode = Nodes[i][j];
      }else{
        if(minNode.score > Nodes[i][j].score) minNode = Nodes[i][j];
      }
    }
  }
  currentNode = minNode;
 
  
  Node nextNode = null;
  for(int i=-1; i<=1; i++){
    for(int j=-1; j<=1; j++){
      PVector nextCoord = new PVector(currentNode.coord.x + i, currentNode.coord.y + j); 
      //Check range
      if((int) nextCoord.x >= w || (int) nextCoord.x < 0
      || (int) nextCoord.y >= h || (int) nextCoord.y < 0){
        continue;
      }

      if(Nodes[(int) nextCoord.x][(int) nextCoord.y].status != ENodeStatus.None) continue;
      
      //Set next node
      nextNode = Nodes[(int) nextCoord.x][(int) nextCoord.y];
      nextNode.parent = currentNode;
      nextNode.status = ENodeStatus.Open;
      
      //Check goal status
      if(goalNode.status == ENodeStatus.Open){
        Node node = currentNode;
        while(true){
          node.status = ENodeStatus.Root;
          Root.add(node);
          node = node.parent;
          if(node == null) break;
        }
        goalNode.status = ENodeStatus.Root;
        return;
      }
      
      //Calc hCost
      float hX, hY;
      hX = abs(goalNode.coord.x - nextNode.coord.x);
      hY = abs(goalNode.coord.y - nextNode.coord.y);
  
      if(hX >= hY){
        nextNode.hCost = (int) hX;
      }else{
        nextNode.hCost = (int) hY;
      }
      
      //Calc cost
      nextNode.cost = currentNode.cost + 1;
      
      //Calc score
      nextNode.score = nextNode.cost + nextNode.hCost;
    }
  }
  
  currentNode.status = ENodeStatus.Closed;
  SearchRoot();
  loopCount ++;
}


void ResetEnv(){
  //Reset node status
  for(int i=0; i<w; i++){
    for(int j=0; j<h; j++){
      Nodes[i][j].status = ENodeStatus.None;
      Nodes[i][j].parent = null;
      Nodes[i][j].cost = 0;
      Nodes[i][j].hCost = 0;
      Nodes[i][j].score = 0;
    }
  }
  
  loopCount = 0;
  
  //Set wall
  int count = 0;
  while(count < 5){
    int x = (int) random(0, w);
    int y = (int) random(0, h);
    
    if(Nodes[x][y].status == ENodeStatus.Wall) continue;
    Nodes[x][y].status = ENodeStatus.Wall;
    count ++;
  }
  
  //Set start and goal
  while(true){
    int x = (int) random(0, w);
    int y = (int) random(0, h);
    
    if(Nodes[x][y].status != ENodeStatus.None) continue;
    Nodes[x][y].status = ENodeStatus.Open;
    break;
  }
  while(true){
    int x = (int) random(0, w);
    int y = (int) random(0, h);
    
    if(Nodes[x][y].status != ENodeStatus.None) continue;
    goalNode = Nodes[x][y];
    break;
  }
}

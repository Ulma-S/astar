enum ENodeStatus{
  None,
  Open,
  Closed,
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

void SearchRoot(){
  //if current node is goal, finish searching
  if(currentNode == goalNode) return;
  
  for(int i=-1; i<=1; i++){
    for(int j=-1; j<=1; j++){
      PVector nextCoord = currentNode.coord.add(new PVector(i, j)); 
      if((int) nextCoord.x >= w || (int) nextCoord.x <0
      || (int) nextCoord.y >= h || (int) nextCoord.y <0){
        continue;
      }
      
      if(Nodes[(int) nextCoord.y][(int) nextCoord.y].status 
      != ENodeStatus.Open) continue;
      
      currentNode = Nodes[(int) currentNode.coord.y + i][(int) currentNode.coord.x + j];
      
      
      //Calc hCost
      float hX, hY;
      hX = goalNode.coord.x - currentNode.coord.x;
      hY = goalNode.coord.y - currentNode.coord.y;
  
      if(hX >= hY){
        currentNode.hCost = (int) hX;
      }else{
        currentNode.hCost = (int) hY;
      }
    }
  }
}

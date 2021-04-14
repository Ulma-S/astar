int w = 5, h = 5;

Node Nodes[][];
ArrayList<Node> Root = new ArrayList<Node>();
Node currentNode;
Node goalNode;

void setup(){
  size(400, 400);
  
  //Initialization
  Nodes = new Node[w][h];
  
  for(int i=0; i<h; i++){
    for(int j=0; j<w; j++){
      Nodes[i][j] = new Node(j, i);
    }
  }
 
  //Set objectives
  Nodes[1][2].status = ENodeStatus.Closed;
  Nodes[2][2].status = ENodeStatus.Closed;
  Nodes[3][2].status = ENodeStatus.Closed;
  Nodes[3][1].status = ENodeStatus.Closed;
  
  //Set start
  Root.add(Nodes[1][1]);
  currentNode = Root.get(0);
  
  //Set goal
  goalNode = Nodes[4][4];
}

void draw(){
  background(255);
  
  for(int i=0; i<h; i++){
    for(int j=0; j<w; j++){
      switch(Nodes[i][j].status){
        case None:
        fill(255);
          break;
        
        case Open:
        fill(255);
          break;
          
        case Closed:
          fill(100);
          break;
      }
      rect(50 + j*60, 50+i*60, 60, 60);
    }
  }
}

int scl = 20;

ArrayList<PVector> snake;
ArrayList<PVector> foods;

PVector vel;

void setup() {
  
  frameRate(10);
  size(800, 600);
  
  snake = new ArrayList<PVector>();
  foods = new ArrayList<PVector>();
  
  for(int i = 0; i < 2; i ++){
    snake.add(new PVector(1*i, 1));
  }
  
  vel = new PVector(1, 0);
  
  spawnFood();
  
}

void draw() {
  clear();
  
  background(0);
  fill(255);
  
  // now for the movement
  snake.remove(0);
  PVector last_position = snake.get(snake.size()-1);
  PVector new_position = new PVector(last_position.x, last_position.y);
  
  new_position.add(vel);
  snake.add(snake.size(), new_position);
  
  PVector snake_head = snake.get(snake.size() - 1);
  for(int i = 0; i < foods.size(); i++){
    if(snake_head.dist(foods.get(i)) == 0) {
      foods.remove(i);
      snake.add(snake_head.copy().add(vel));
      spawnFood();
    }
  }
  
  // draw current snake
  for(int i =0; i < snake.size(); i++){
    rect(snake.get(i).x * scl, snake.get(i).y * scl, scl, scl);
  }
  
  for(int i = 0; i < foods.size(); i++){
    fill(0, 255, 0);
    rect(foods.get(i).x*scl, foods.get(i).y*scl, scl, scl);
  }
  
}

// this method spawns a new food item-
void spawnFood() {
  int foodX = floor(random(width/scl-1));
  int foodY = floor(random(height/scl-1));
  
  foods.add(new PVector( foodX, foodY ));
}

void keyPressed(){
  switch(keyCode) {
    case 40:
      vel = new PVector(0, 1);
    break;
    
    case 38:
      vel = new PVector(0, -1);
    break;
    
    case 37:
      vel = new PVector(-1, 0);
    break;
    
    case 39:
     vel = new PVector(1, 0);
    break; 
  }
}
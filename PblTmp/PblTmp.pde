
class LoadThread implements Runnable {

  void algo() {
    /** Algorithm Start **/

    for(int i=0;i<n;i++){
      a.value = i;
      L[a.value].value=i;
      blink();//insert delay if you need.
    }
    blink();
    insert(L, 3, 5);
    //blink();

    /** Algorithm End **/
  }

  /** Functions Start **/

  void insert(Item[] L, int index, int value){
    for(int i=n-1;i>index;i--){
      L[i].value=L[i-1].value;
      blink();
    }
    L[index].value=value;
  }   
  
  
  /** Functions End **/

  public synchronized void run() {
    algo();
  }


  synchronized void blink() {
    for (int j=0; j<n; j++) L[j].blink = L[j].changed();
    a.blink = a.changed();
    b.blink = b.changed();
    delay(1000);
  }
}

Item[] L;
int n=20;

Pointer a, b;

void setup() {
  size(600, 200);
  background(0);

  L = new Item[n];

  for (int i=0; i<n; i++) {
    L[i]=new Item();
    L[i].index=i;
    L[i].value=(int)random(1, 100);
  }

  a = new Pointer();
  a.index=0; 
  a.name="a";
  b = new Pointer();
  b.index=n; 
  b.name="b";

  new Thread(new LoadThread()).start();
}


void draw() {
  background(0);
  for (int i=0; i<n; i++) L[i].draw();
  a.draw();  
  b.draw();
}


class Item {
  int index, value=0;
  protected int w=30, old_value=0;
  protected boolean blink=false;
  void draw() {
    if (blink) fill(255, 200, 200); 
    else fill(255);
    ellipse(index*w+w/2, 100, w, w);
    text(index, index*w+w/2-5, 100-20);
    fill(0);
    text(value, index*w+w/2-5, 100+5);
  }
  boolean changed() {
    boolean result = (value!=old_value);
    old_value =  value; 
    return(result);
  }
}

class Pointer extends Item {
  String name;
  void draw() {
    if (blink) fill(255, 200, 200); 
    else fill(255);
    rect(value*w, 140, w, w);
    int x = value*w+w/2-5;
    text(name, x, 185);
    strokeWeight(3);
    stroke(255);
    line(x+5, 100+w/2+5, x+5, 140);
    fill(0);
    text(value, x, 160);
  }
}

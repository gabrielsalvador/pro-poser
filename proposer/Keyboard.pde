class Keyboard {

  ArrayList<Boundary> blocks =  new ArrayList<Boundary>();
  int _width = 20;

  public Keyboard(int _x, int _y, int _w, int _h) {
    for (int i = 0; i<12*4; i++) {


      if (i%2 == 0)
      {
        Boundary b = new Boundary(_x + i*_width, _y+i*5, _width, _width);
        b.pitch = i;
        b._color = color(0, 0, 0);
        blocks.add(b);
      } else {
        //b._color = color(255, 255, 255);
      }
    }
  }

  public void display() {
    for (Boundary b : blocks) {
      b.display();
    }
  }



  void chord(int root) {

    color chord[] = {
      color(0, 0, 0),
      color(255, 255, 255),
      color(255, 255, 255),
      color(0, 0, 0),
      color(255, 255, 255),
      color(255, 255, 255),
      color(255, 255, 255),
      color(0, 0, 0),
      color(255, 255, 255),
      color(255, 255, 255),
      color(0, 0, 0),
      color(255, 255, 255),
      color(0, 0, 0),
    };

    for (int i = 0; i<12*4; i++) {
      if (i+root<48) {
        Boundary b = blocks.get(i+root);
        b._color = color(255, 255, 255);
        b._color = chord[i%12];
      }
    }
  }
}

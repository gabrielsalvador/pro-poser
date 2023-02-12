
import controlP5.*;

ControlP5 cp5;

import themidibus.*; //Import the library

World _world ;

MidiBus myBus; // The MidiBus
// A reference to our box2d world


// An ArrayList of particles that will fall on the surface


void setup() {
  size(1200, 900);
  smooth();

  _world = new World(this);
  _world.setupWorld();
  //MIDI

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
 // myBus = new MidiBus(this, "Barramento 1", "Bus 2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  setupGUI();
}

void draw() {
  background(0);
  _world._draw();
}


public void keyPressed() {
  switch(key) {
  case 'n':
    cp5.getController("commandTextBox").setPosition(mouseX, mouseY);

    break;
  }
}

void stop() {
}




void mousePressed() {
}

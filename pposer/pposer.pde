// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of controlling an object with our own motion (by attaching a MouseJoint)
// Also demonstrates how to know which object was hit

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import themidibus.*; //Import the library



MidiBus myBus; // The MidiBus
// A reference to our box2d world
Box2DProcessing box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

Boundary wall;
Keyboard keyboard;

void setup() {
  size(1200, 900);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Create the empty list
  particles = new ArrayList<Particle>();


  keyboard = new Keyboard(0, height-40, width, 10);
  wall = new Boundary(width/2, height-5, width, 10);


  //MIDI

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "Barramento 1", "Bus 2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  background(255);

  if (random(1) < 0.1) {
  }


  // We must always step through time!
  box2d.step();

  // Look at all particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }

  wall.display();
  keyboard.display();
}


// Collision event functions!
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) {
    Particle p1 = (Particle) o1;
    //p1.delete();
    Particle p2 = (Particle) o2;
    //p2.delete();
  }

  if (o1.getClass() == Boundary.class) {
    Particle p = (Particle) o2;
    p.delete();
    Boundary b = (Boundary) o1;
    if (b._color == color(0, 0, 0)) {
      
      sendNote(b.pitch);
    }
  }
  if (o2.getClass() == Boundary.class) {
    Particle p = (Particle) o1;
    p.delete();
    Boundary b = (Boundary) o2;
    if (b._color == color(0, 0, 0)) {
      sendNote(b.pitch);
    }
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}


void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void sendNote(int pitch) {
  int channel = 0;
  int velocity = 127;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(2);
  //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}


void mouseDragged() {
  float sz = random(1, 2);
  particles.add(new Particle(mouseX, mouseY, sz));
}


void keyPressed(){
  int root = ((int)key - 49);
  keyboard.chord(root);
}

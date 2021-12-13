import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;



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
  } else {
    if (o1.getClass() == Boundary.class || o2.getClass() == Boundary.class) {
      Particle p = (Particle) o2;

      Boundary b = (Boundary) o1;
      if (b._color == color(0, 0, 0)) {
        sendNote(b.pitch);
      }
      p.delete();
    }
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}


class World {

  ArrayList<Particle> particles;
  Boundary wall;
  Keyboard keyboard;
  Box2DProcessing box2d ;

  World(PApplet ref) {
    // Initialize box2d physics and create the world
    box2d = new Box2DProcessing(ref);
    box2d.createWorld();

    // Turn on collision listening!
    box2d.listenForCollisions();

    
  }


  void setupWorld() {
    // Create the empty list
    //particles = new ArrayList<Particle>();

    //keyboard = new Keyboard(100, height-500, width, 1);
   // wall = new Boundary(width/2, height-5, width, 10);
  }
  
  
  public void _draw() {

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
    fill(255);
  }


  void mouseDragged() {
    for (int i = 0; i < 2; i++) {
      float sz = random(1, 2);
      particles.add(new Particle(mouseX, mouseY, sz));
    }
  }
}

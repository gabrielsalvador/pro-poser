void parse(String command) {
  hello.Hello.parse(command, new CustomHelloWalker());
}


public class CustomHelloWalker extends HelloBaseListener {
  public void enterR(HelloParser.RContext ctx ) {
    int times = Integer.parseInt(ctx.options().option().NUMBER(0).getText());
    for (int i = 0; i < times; i++) {
      float sz = random(1, 2);
      float x = random(0,500);
      float y = random(0,500);
      _world.particles.add(new Particle(x, y, sz));
    }
  }

  public void exitR(HelloParser.RContext ctx ) {
    System.out.println( "Exiting R" );
  }
}

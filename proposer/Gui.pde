
void setupGUI() {
  PFont font = createFont("arial", 20);

  cp5 = new ControlP5(this);

   cp5.addTextfield("commandTextBox")
    .setPosition(20, 100)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0))
    ;

  cp5.addBang("clear")
    .setPosition(240, 170)
    .setSize(80, 40)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;



  textFont(font);
}

public void clear() {
  cp5.get(Textfield.class, "commandTextBox").clear();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
      parse(theEvent.getStringValue());
  }
}


/*-------OSC Stuff----------*/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress vdmxReceiver;

String currentSample = "0";  
float input1, input2, input3, input4, input5, input6, input7, input8 = 0.0;

/*-------HYPE Stuff----------*/

import hype.*;
import hype.extended.layout.HGridLayout;

HDrawablePool pool;
float         r     = 0;

void setup() {
  size(640,640, P3D);

  oscP5 = new OscP5(this, 1818);
  vdmxReceiver = new NetAddress("127.0.0.1", 2020);


  H.init(this).background(#242424).use3D(true);

  pool = new HDrawablePool(125);
  pool.autoAddToStage()
    .add(new HBox().depth(25).width(25).height(25))
    .layout (new HGridLayout().startX(180).startY(180).startZ(-140).spacing(70, 70, 70).cols(5).rows(5))
    
    .requestAll()
  ;
}

void draw() {

  H.background((int)((1-input4)*255));
  lights();

  translate( width/2,  height/2);
  rotateY(input2);
  rotateX(input3);
  translate(-width/2, -height/2);
  r+=0.3;

  int i = 0;
  for (HDrawable d : pool) {
    float scale = 1;

    HBox b = (HBox) d;
    b.depth(25 * scale * input1)
     .width(25 * scale * input1)
     .height(25* scale * input1)
     .fill((int)(input4*i%255))
     .stroke((int)((1-input4)*i%255));
    i++;
  }

  H.drawStage();
}

void oscEvent(OscMessage m) {
  OscBundle vdmxBundle = new OscBundle();
  OscMessage msg = new OscMessage("/params");

  int i;
  for(i = 0; i < m.typetag().length(); ++i) {
    String name = m.get(i).stringValue();
    switch(name) {
      case "s":
        currentSample = m.get(i+1).stringValue();
        msg.clear();
        msg.setAddrPattern("/params/sample");
        msg.add(currentSample);
        vdmxBundle.add(msg);
        break;
      case "n1":
        input1 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n1");
        msg.add(input1);
        vdmxBundle.add(msg);
        break;      
      case "n2":
        input2 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n2");
        msg.add(input2);
        vdmxBundle.add(msg);
        break;
      case "n3":
        input3 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n3");
        msg.add(input3);
        vdmxBundle.add(msg);
        break;      
      case "n4":
        input4 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n4");
        msg.add(input4);
        vdmxBundle.add(msg);
        break;      
      case "n5":
        input5 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n5");
        msg.add(input5);
        vdmxBundle.add(msg);
        break;      
      case "n6":
        input6 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n6");
        msg.add(input6);
        vdmxBundle.add(msg);        
        break;
      case "n7":
        input7 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n7");
        msg.add(input7);
        vdmxBundle.add(msg); 
        break;      
      case "n8":
        input8 = m.get(i+1).floatValue();
        msg.clear();
        msg.setAddrPattern("/params/n8");
        msg.add(input8);
        vdmxBundle.add(msg); 
        break;
    }
    i++;
  }
  vdmxBundle.setTimetag(vdmxBundle.now() + 100);
  oscP5.send(vdmxBundle, vdmxReceiver);
}

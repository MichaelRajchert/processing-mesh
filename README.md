# processing-mesh
Moving mesh graphic built in Processing 3.4

```
//constraints
int pointDensity ---------------> How many points the mesh will have.
float maxSpeed -----------------> How fast the points will travel across the screen
int lineWeight -----------------> The line weight;

//mods (voluntary modifications to the mesh behaviour)
boolean mouseModSpeedEnabled ---> Holding left-mouse button will allow you to change the speed/
float   mouseModSpeedAmplifier -> Changes how much 'mouseModSpeedEnabled' affects the mesh.

boolean mouseModColourEnabled --> Holding left-mouse button will allow you to change the colour of the mesh live.
String  mouseModColourAction ---> Decide what colour set you want to modify "rg"(Red,Green),"rb"(Red,Blue),"gb"(Green,Blue)
boolean mouseModLineBloom ------> Clicking left-mouse button will instantly increase the line weight to 'mouseModLineBloomAmp'.
int     mouseModLineBloomAmp ---> Modify line weight.
float   mouseModLineBloomRev ---> The lower the number, the slower the bloom reduction
boolean screenshotsEnabled ----> Press any key to take a screenshot

boolean cycleColours -----------> Cycle colours over time, relys on 'mouseModColourAction' settings

//graphics
String pointEdgeAction --------> Change point-on-edge interaction, "bounce", "teleport", "random"
int[][] lineColourRange -------> {{minR,minG,minB},{maxR,maxG,maxB}}, line colours reduce in range when points are closer together.
```

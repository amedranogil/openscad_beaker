beaker_diameter = 60;
beaker_total_height=60;
spout_cord=40;
spout_height=30;
smooth=2;
wall=1.6;

function sagita(rad,arch) = rad - sqrt(pow(rad,2)-pow(arch/2,2));

/*
circle(d=beaker_diameter);
translate([beaker_diameter/2+spout_cord*sqrt(3)/12-sagita(beaker_diameter/2,spout_cord),0,0])circle(d=spout_cord/sqrt(3),$fn=3);
*/


module spout(spout_cord,spout_height,smooth){
    r=spout_cord-smooth;
    translate([0,0,spout_height])
    mirror([0,0,1])
    linear_extrude(height = spout_height, convexity = 10, scale=0.01)
     translate([r*sqrt(3)/12+smooth,0,0])
    offset(r=smooth)
    circle(d=r/sqrt(3),$fn=3);
}

//spout(spout_cord,spout_height,smooth,$fn=20);

module basic_shape(beaker_diameter,beaker_total_height,spout_cord,spout_height){
    cylinder(d=beaker_diameter,h=beaker_total_height);
    intersection(){
    translate(
        [beaker_diameter/2-sagita(beaker_diameter/2,spout_cord),
         0,
          beaker_total_height-spout_height])
    spout(spout_cord,spout_height,0);
    cylinder(d=beaker_diameter+spout_cord,h=beaker_total_height);
    }
}

difference(){
minkowski()
{
    basic_shape(beaker_diameter-smooth,beaker_total_height,spout_cord,spout_height);
    sphere(d=smooth);
}
translate([0,0,wall])
minkowski()
{
    basic_shape(beaker_diameter-smooth-wall,beaker_total_height,spout_cord,spout_height);
    sphere(d=smooth);
}
}
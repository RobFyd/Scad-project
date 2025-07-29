$fn = 200;

name_text = "Alicja";
font_size = 10;
font_name = "a Area Stencil";  // Testuj różne!

module cut_name() {
    linear_extrude(height = 80, center = true)
        offset(delta = 0.5)
        text(name_text, size = font_size, font = font_name,
             halign = "center", valign = "center");
}

translate([0, 0, 40])
    rotate([90, 0, 0])
    color("red") cut_name();



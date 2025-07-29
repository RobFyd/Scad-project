$fn = 200;

// ==== PARAMETRY KLOSZA ====
radius_outer = 40;
wall_thickness = 2;
height_total = 80;
top_thickness = 3.5;

// ==== PARAMETRY TEKSTU ====
name_text = "Alicja";
font_size = 10;
font_name = "Sirin Stencil";  // Upewnij się, że masz ją zainstalowaną
text_depth = radius_outer * 2; // wystarczająco, by przeciąć cały cylinder

// ==== MODUŁ: WYCIĘCIE TEKSTU ====
module cut_name() {
    linear_extrude(height = text_depth, center = true)
        offset(delta = 0.5)
        text(name_text, size = font_size, font = font_name,
             halign = "center", valign = "center");
}

// ==== MODUŁ: KLOSZ ====
module lamp_with_cutout() {
    difference() {
        // Klosz z zamkniętą górą i otwartym dołem
        cylinder(h = height_total, r = radius_outer, center = false);
        translate([0, 0, 0])
            cylinder(h = height_total - top_thickness, r = radius_outer - wall_thickness, center = false);

        // Tekst wycięty NA WYLOT przez cały cylinder
        translate([0, 0, height_total/2])
            rotate([90, 0, 0])
            cut_name();
    }
}

lamp_with_cutout();








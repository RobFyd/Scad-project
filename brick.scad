// Parameters for brick dimensions and customization
// Length in studs
brickLength = 3; // (1-48)
// Width in studs
brickWidth = 2;  // (1-48)
// Height in LEGO units (1 = plate, 3 = standard brick)
brickHeight = 3; 

// Toggle features for studs
// Enable studs on top [yes, no]
withStuds = "yes"; // [yes, no]

// Advanced settings for tolerance and resolution
tolerance = 0.00; 
numberFragments = 50; 
$fn = numberFragments;

// LEGO dimensions and adjustments [ADVANCED]
UNIT_LENGTH = 8; 
PLATE_HEIGHT = 3.2; 
ROOF_THICKNESS = 1; 
WALL_THICKNESS = 1.5; 
STUD_DIAMETER = 4.8; 
STUD_HEIGHT = 1.8; 
UNDERTUBE_OUTER_DIAMETER = 6.41; 
UNDERTUBE_INNER_DIAMETER = 4.8; 
UNDERSTUD_DIAMETER = 1.6; 
PLAY = 0.2; 

// Main structure of the brick
module createBrick(length, width, height) {
    createBrickBase(length, width, height);
    if (withStuds == "yes") createStudsOnTop(length, width, height);
    if (width > 1 && length > 1) createUnderTubes(length, width, height);
}

// Create the main rectangular brick body
module createBrickBase(length, width, height) {
    translate([PLAY / 2 + tolerance, PLAY / 2 + tolerance, 0]) {
        difference() {
            cube([length * UNIT_LENGTH - PLAY - 2 * tolerance, width * UNIT_LENGTH - PLAY - 2 * tolerance, height * PLATE_HEIGHT]);
            translate([WALL_THICKNESS - 2 * tolerance, WALL_THICKNESS - 2 * tolerance, -ROOF_THICKNESS]) {
                cube([length * UNIT_LENGTH - 2 * WALL_THICKNESS - PLAY + 2 * tolerance, width * UNIT_LENGTH - 2 * WALL_THICKNESS - PLAY + 2 * tolerance, height * PLATE_HEIGHT]);
            }
        }
    }
}

// Add studs on top of the brick
module createStudsOnTop(length, width, height) {
    translate([0, 0, height * PLATE_HEIGHT - 0.00001]) {
        for (y = [0 : width - 1]) {
            for (x = [0 : length - 1]) {
                translate([(x + 0.5) * UNIT_LENGTH, (y + 0.5) * UNIT_LENGTH, 0]) {
                    cylinder(h = STUD_HEIGHT, d = STUD_DIAMETER - 2 * tolerance);
                }
            }
        }
    }
}

// Create under-tubes for bricks larger than 1x1
module createUnderTubes(length, width, height) {
    for (y = [1 : width - 1]) {
        for (x = [1 : length - 1]) {
            difference() {
                translate([x * UNIT_LENGTH, y * UNIT_LENGTH, 0]) {
                    cylinder(h = height * PLATE_HEIGHT - ROOF_THICKNESS + 0.01, d = UNDERTUBE_OUTER_DIAMETER - 2 * tolerance);
                }
                translate([x * UNIT_LENGTH, y * UNIT_LENGTH, -0.01]) {
                    cylinder(h = height * PLATE_HEIGHT - ROOF_THICKNESS + 0.01, d = UNDERTUBE_INNER_DIAMETER + 2 * tolerance);
                }
            }
        }
    }
}

// Render the brick
translate([-brickLength / 2 * UNIT_LENGTH, -brickWidth / 2 * UNIT_LENGTH, 0]) {
    createBrick(brickLength, brickWidth, brickHeight);
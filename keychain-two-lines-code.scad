// Robi

/* [- BASIC PARAMETERS -] */
Text_Name = "♡Alicja♡";
Text_Size = 10; // [4:1:40]
Letter_Spacing = 1; // [0.5:0.05:1.25] 

/* [- FONT SELECTION -] */
Use_Recomended_List = true;
aux1 = Use_Recomended_List;
Recomended_List = "DynaPuff";  // ["Zeyada","ZCOOL KuaiLe","Fascinate","Smythe","Press Start 2P","Honk","Amaranth","Balsamiq Sans","Chela One","Delicious Handrawn","DynaPuff","Chewy","Lobster"];
aux2 = Recomended_List;
List = "DynaPuff:style=Bold";  // font
aux3 = List;
Font_Choice = aux1 ? aux2 : aux3;        

/* [- ADVANCED PARAMETERS -] */ 
Text_Thickness = 1; // [0.5:0.5:10]
Base_Thickness = 2; // [0.5:0.5:10]
Base_Size = 1.5; // [0:0.5:5]
Ring_Horizontal = -30; // [-50:0.5:50]
Ring_Vertical = 0; // [-10:0.2:10]
Text_Color = "Gold"; // ["red","green","blue","yellow","cyan","magenta","orange","pink","purple","brown","white","black","grey","gold","lightblue"]
Base_Color = "Black"; // ["red","green","blue","yellow","cyan","magenta","orange","pink","purple","brown","white","black","grey","gold","lightblue"]

// - MODULES -

// Fonts
Fonts = [
["Zeyada","ZCOOL KuaiLe","Fascinate","Smythe","Press Start 2P","Honk","Aladin","Amaranth","Artifika","Balsamiq Sans","Chela One","Delicious Handrawn","DynaPuff","Chewy","Lobster"]
];

module text_name() {
    translate([0, 0, Base_Thickness])
        linear_extrude(height = Text_Thickness)
            text(Text_Name, size = Text_Size, font = Font_Choice, spacing = Letter_Spacing, halign="center", valign="center");
}

module base() {
    linear_extrude(height = Base_Thickness)
        offset(delta = Base_Size)
            text(Text_Name, size = Text_Size, font = Font_Choice, spacing = Letter_Spacing, halign="center", valign="center");
}

module keychain_ring() {
    difference() {
        cylinder(h = 2, r = 4, center=true, $fn=32);
        cylinder(h = 2 + 0.1, r = 2, center=true, $fn=32);
    }
}

// - MAIN CALLS -

color(Base_Color)
    base();

color(Base_Color)
    translate([Ring_Horizontal, Ring_Vertical, Base_Thickness/2])
        keychain_ring();

color(Text_Color)
    text_name();

// template_offset = (8.5 - 6) / 2;
template_offset = 0;

thickness = 8;

module template_poly(diff = false, r = 1) {
    if (diff) 
    {
        difference() {
            children();
            offset(r = -r) children();
        }
    }
    else
    {
        offset(r = -r) children();
    }
}

module template_full(file="panel_base_500.dxf") {
    height = thickness;
    %translate([0, 400])
        linear_extrude(height = height, center = true, convexity = 10)
            text(file, 50, halign="center", valign="center");

    linear_extrude(height = height, center = true, convexity = 10)
        template_poly(diff = false, r = template_offset) 
            import (file);
}


module extract(enable_file, enable_n, file, n, quadrant_x_n, quadrant_y_n, quadrant_size_x, quadrant_size_y, resize_x = 0, resize_y = 0) {
    sqx = quadrant_x_n != 0 ? quadrant_x_n / abs(quadrant_x_n) : 0;
    sqy = quadrant_y_n != 0 ? quadrant_y_n / abs(quadrant_y_n) : 0;
    
    translate([quadrant_x_n * quadrant_size_x - 0.5 * resize_x * sqx, 
            quadrant_y_n * quadrant_size_y - 0.5 * resize_y * sqy, 0])
    color([1, 0, 0, 0.3])
    %cube([quadrant_size_x + resize_x, quadrant_size_y + resize_y, 30], center= true);

    if (enable_file == "all" || (enable_file == file && (enable_n == n || enable_n == 0))) {
        difference() {
            intersection() {
        
                translate([quadrant_x_n * quadrant_size_x - 0.5 * resize_x * sqx, 
                        quadrant_y_n * quadrant_size_y - 0.5 * resize_y * sqy, 0])
                color([1, 0, 0, 0.3])
                cube([quadrant_size_x + resize_x, quadrant_size_y + resize_y, 30], center= true);
                
                template_full(file);
            }
        
        trot = (sqx != 0 && sqy == 0) ? 90 : 0;
        translate([quadrant_x_n * quadrant_size_x - 1 * resize_x * sqx - 0.5* sqx * quadrant_size_x / 2 + 1 * sqy * 5, 
                quadrant_y_n * quadrant_size_y - 1 * resize_y * sqy - sqy * quadrant_size_y / 2 + 1 * sqy * 5, 1])
        rotate([0, 0, trot])
            linear_extrude(1) text(file, 5, font="ubuntu", halign = "center", valign = "center" );
        }
    }
}

if (false) {
    for (x = [-2:2]) {
        for (y = [-2:2]) {
            extract(x, y, 140, 140);
        }
    }
}


module select(sf, sn) // AUTO_MAKE_STL["panel_base_500.dxf", "panel_door_500.dxf","panel_lid_back_500.dxf","panel_lid_front_500.dxf","panel_lid_side_500.dxf","panel_lid_top_500.dxf","panel_side_left_500.dxf","panel_electronics_plain_500.dxf"][1:5]
{
    translate ([-1000, 0])
    {
        //extract("panel_base_500.dxf", -2, -2, 140, 140, -30, -20);
        //extract("panel_base_500.dxf", -2,  2, 140, 140, -40, -30);
        extract(sf, sn, "panel_base_500.dxf", 1, 2, -2, 140, 140, -30, -20);
        extract(sf, sn, "panel_base_500.dxf", 2, 2,  2, 140, 140, -40, -30);
        extract(sf, sn, "panel_base_500.dxf", 3, 0,  2, 140, 140,  30, -30);
        extract(sf, sn, "panel_base_500.dxf", 4, 0, -2, 100, 140, -10, -80);
        extract(sf, sn, "panel_base_500.dxf", 5, 2, 0,  140, 140, -80, -80);

        %template_full("panel_base_500.dxf");
    }
    
    translate ([-1000, -1000])
    {
        extract(sf, sn, "panel_door_500.dxf", 1, -1, -2, 140, 150,  10,  30);
        extract(sf, sn, "panel_door_500.dxf", 2,  1, -2, 140, 150, -50, -50);
        extract(sf, sn, "panel_door_500.dxf", 3,  1,  0, 140, 150, -50, 0);

        %template_full("panel_door_500.dxf");
    }

    translate ([0, -1000])
    {
        extract(sf, sn, "panel_lid_back_500.dxf", 1, -2, -1, 150, 140, 20, 40);
        extract(sf, sn, "panel_lid_back_500.dxf", 2, -2,  1, 150, 140, 20, 40);
        extract(sf, sn, "panel_lid_back_500.dxf", 3,  2,  0, 150, 140, -80, 40);

        %template_full("panel_lid_back_500.dxf");
    }

    translate ([1000, -1000]) 
    { 
        extract(sf, sn, "panel_lid_front_500.dxf", 1, -2, -1, 150, 140, -60, -10);
        extract(sf, sn, "panel_lid_front_500.dxf", 2, -2,  1, 150, 140, 10, 50);
        extract(sf, sn, "panel_lid_front_500.dxf", 3,  0, -1, 150, 140, 10, 0);

        %template_full("panel_lid_front_500.dxf");
    }


    translate ([1000, 0]) 
    {
        extract(sf, sn, "panel_lid_side_500.dxf", 1, -2, -1, 160, 110, -20, 50);
        extract(sf, sn, "panel_lid_side_500.dxf", 2, -2,  1, 160, 110, -70, -50);
        extract(sf, sn, "panel_lid_side_500.dxf", 3,  2, -1, 160, 110, -90, -20);

        %template_full("panel_lid_side_500.dxf");
    }


    translate ([1000, 1000]) 
    {
        extract(sf, sn, "panel_lid_top_500.dxf", 1, -2, -2, 145, 150, 10, 0);
        extract(sf, sn, "panel_lid_top_500.dxf", 2, -2,  2, 145, 150, 30, -0);
        extract(sf, sn, "panel_lid_top_500.dxf", 3,  0,  2, 145, 150, -30, -70);

        %template_full("panel_lid_top_500.dxf");
    }

    translate ([0, 0]) 
    {
        extract(sf, sn, "panel_side_left_500.dxf", 1, -2, -2, 160, 150, -10, 60);
        extract(sf, sn, "panel_side_left_500.dxf", 2,  2, -2, 160, 150, -10, -0);

        %template_full("panel_side_left_500.dxf");
    }

    translate ([0, 1000]) 
    {
        extract(sf, sn, "panel_electronics_plain_500.dxf", 1, -2, -2, 150, 150, -40, 80);
        extract(sf, sn, "panel_electronics_plain_500.dxf", 2, -1, -2, 150, 150, -0, -30);

        %template_full("panel_electronics_plain_500.dxf");
    }
    
}

select("all", 0);
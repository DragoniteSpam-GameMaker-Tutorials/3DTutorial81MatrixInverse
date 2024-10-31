function import_obj(filename, vertex_format) {
    var buffer = buffer_load(filename);
    var content_string = buffer_read(buffer, buffer_text);
    buffer_delete(buffer);
    
    var lines = string_split(content_string, "\n");
    
    var vb = vertex_create_buffer();
    vertex_begin(vb, vertex_format);
    
    var positions = [];
    var texcoords = [];
    var normals = [];
    
    for (var i = 0; i < array_length(lines); i++) {
        var this_line = lines[i];
        if (this_line == "") continue;
        
        var tokens = string_split(this_line, " ");
        
        switch (tokens[0]) {
            case "v":
                var vx = real(tokens[1]);
                var vy = real(tokens[2]);
                var vz = real(tokens[3]);
                array_push(positions, {
                    x: vx, y: vz, z: vy
                });
                break;
            case "vt":
                var tx = real(tokens[1]);
                var ty = real(tokens[2]);
                array_push(texcoords, {
                    x: tx, y: 1 - ty
                });
                break;
            case "vn":
                var nx = real(tokens[1]);
                var ny = real(tokens[2]);
                var nz = real(tokens[3]);
                array_push(normals, {
                    x: nx, y: nz, z: ny
                });
                break;
            case "f":
                for (var j = 2; j < array_length(tokens); j++) {
                    var v1 = tokens[1];
                    var v2 = tokens[j - 1];
                    var v3 = tokens[j];
                    
                    var v1_tokens = string_split(v1, "/");
                    var v2_tokens = string_split(v2, "/");
                    var v3_tokens = string_split(v3, "/");
                    
                    var v1_position = { x: 0, y: 0, z: 0 };
                    var v1_texcoord = { x: 0, y: 0 };
                    var v1_normal =   { x: 0, y: 0, z: 0 };
                    var v2_position = { x: 0, y: 0, z: 0 };
                    var v2_texcoord = { x: 0, y: 0 };
                    var v2_normal =   { x: 0, y: 0, z: 0 };
                    var v3_position = { x: 0, y: 0, z: 0 };
                    var v3_texcoord = { x: 0, y: 0 };
                    var v3_normal =   { x: 0, y: 0, z: 0 };
                    
                    switch (array_length(v1_tokens)) {
                        case 1:
                            v1_position = positions[real(v1_tokens[0]) - 1];
                            break;
                        case 2:
                            v1_position = positions[real(v1_tokens[0]) - 1];
                            v1_texcoord = texcoords[real(v1_tokens[1]) - 1];
                            break;
                        case 3:
                            v1_position = positions[real(v1_tokens[0]) - 1];
                            if (v1_tokens[1] != "") {
                                v1_texcoord = texcoords[real(v1_tokens[1]) - 1];
                            }
                            v1_normal =   normals[real(v1_tokens[2]) - 1];
                            break;
                    }
                    switch (array_length(v2_tokens)) {
                        case 1:
                            v2_position = positions[real(v2_tokens[0]) - 1];
                            break;
                        case 2:
                            v2_position = positions[real(v2_tokens[0]) - 1];
                            v2_texcoord = texcoords[real(v2_tokens[1]) - 1];
                            break;
                        case 3:
                            v2_position = positions[real(v2_tokens[0]) - 1];
                            if (v2_tokens[1] != "") {
                                v2_texcoord = texcoords[real(v2_tokens[1]) - 1];
                            }
                            v2_normal =   normals[real(v2_tokens[2]) - 1];
                            break;
                    }
                    switch (array_length(v3_tokens)) {
                        case 1:
                            v3_position = positions[real(v3_tokens[0]) - 1];
                            break;
                        case 2:
                            v3_position = positions[real(v3_tokens[0]) - 1];
                            v3_texcoord = texcoords[real(v3_tokens[1]) - 1];
                            break;
                        case 3:
                            v3_position = positions[real(v3_tokens[0]) - 1];
                            if (v3_tokens[1] != "") {
                                v3_texcoord = texcoords[real(v3_tokens[1]) - 1];
                            }
                            v3_normal =   normals[real(v3_tokens[2]) - 1];
                            break;
                    }
                    
                    vertex_position_3d(vb, v1_position.x, v1_position.y, v1_position.z);
                    vertex_normal(vb, v1_normal.x, v1_normal.y, v1_normal.z);
                    vertex_texcoord(vb, v1_texcoord.x, v1_texcoord.y);
                    vertex_colour(vb, c_white, 1);
                    
                    vertex_position_3d(vb, v2_position.x, v2_position.y, v2_position.z);
                    vertex_normal(vb, v2_normal.x, v2_normal.y, v2_normal.z);
                    vertex_texcoord(vb, v2_texcoord.x, v2_texcoord.y);
                    vertex_colour(vb, c_white, 1);
                    
                    vertex_position_3d(vb, v3_position.x, v3_position.y, v3_position.z);
                    vertex_normal(vb, v3_normal.x, v3_normal.y, v3_normal.z);
                    vertex_texcoord(vb, v3_texcoord.x, v3_texcoord.y);
                    vertex_colour(vb, c_white, 1);
                }
                break;
        }
    }
    
    vertex_end(vb);
    vertex_freeze(vb);
    
    return vb;
}
/// @description Draw the 3D world

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
draw_clear(c_black);
gpu_set_texrepeat(true);

// 3D projections require a view and projection matrix
var camera = camera_get_active();

var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z + 120;
var xto = xfrom - dcos(Player.look_dir) * dcos(Player.look_pitch);
var yto = yfrom + dsin(Player.look_dir) * dcos(Player.look_pitch);
var zto = zfrom + dsin(Player.look_pitch);

var view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
var proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 10_000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

shader_set(shd_diffuse);

vertex_submit(vb_ground, pr_trianglelist, sprite_get_texture(spr_ground, 0));

matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 32, 32, 32));
vertex_submit(vb_chest, pr_trianglelist, sprite_get_texture(spr_xenoblade, 0));

matrix_set(matrix_world, matrix_build_identity());
shader_reset();
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);
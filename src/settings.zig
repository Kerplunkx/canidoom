pub const fps = 60;
pub const frame_delay: u32 = 1000 / fps;
pub const screen_width = 640.0;
pub const screen_height = 480.0;
pub const render_delay = 30;
pub const player_fov = 60.0;
pub const player_x = 2.0;
pub const player_y = 2.0;
pub const player_movement = 0.5;
pub const player_rotation = 5.0;
pub const raycasting_precision = 64;
pub const player_angle = 90.0;
pub const increment_angle = player_fov / screen_width;
pub const map = [10][10]u8{
    [10]u8{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    [10]u8{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 1, 1, 0, 1, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 1, 0, 1, 1, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    [10]u8{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    [10]u8{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
};

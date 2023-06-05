const std = @import("std");
const math = std.math;
const sdl = @import("sdl2");
const settings = @import("settings.zig");
const p = @import("player.zig");

pub const Ray = struct {
    x: f32 = undefined,
    y: f32 = undefined,

    /// rayCasting function on reference
    pub fn casting(self: *Ray, render: sdl.Renderer, player: *p.Player) !void {
        var angle: f32 = player.angle - player.fov / 2.0;
        player.update();
        for (0..@floatToInt(usize, settings.screen_width)) |count| {
            self.x = player.x;
            self.y = player.y;

            var cos = math.cos(math.degreesToRadians(f32, angle)) / settings.raycasting_precision;
            var sin = math.sin(math.degreesToRadians(f32, angle)) / settings.raycasting_precision;

            // Wall checking
            var wall: i32 = 0;
            while (wall == 0) {
                self.x += cos;
                self.y += sin;
                wall = settings.map[@floatToInt(usize, math.floor(self.y))][@floatToInt(usize, math.floor(self.x))];
            }

            // Pythagoras theorem
            var distance = math.sqrt(math.pow(f32, player.x - self.x, 2) + math.pow(f32, player.y - self.y, 2));

            // Fisheye fix
            distance = distance * math.cos(math.degreesToRadians(f32, angle - player.angle));

            // Wall height
            var wall_height: f32 = math.floor((settings.screen_height / 2) / distance);

            // Drawing
            // Ceiling
            try render.setColor(sdl.Color.cyan);
            try render.drawLineF(@intToFloat(f32, count), 0, @intToFloat(f32, count), (settings.screen_height / 2) - wall_height);
            // Walls
            try render.setColor(sdl.Color.red);
            try render.drawLineF(@intToFloat(f32, count), (settings.screen_height / 2) - wall_height, @intToFloat(f32, count), (settings.screen_height / 2) + wall_height);
            // Floor
            try render.setColor(sdl.Color.green);
            try render.drawLineF(@intToFloat(f32, count), (settings.screen_height / 2) + wall_height, @intToFloat(f32, count), settings.screen_height);

            angle += settings.increment_angle;
        }
    }
};

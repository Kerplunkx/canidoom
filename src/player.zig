const std = @import("std");
const math = std.math;
const sdl = @import("sdl2");
const settings = @import("settings.zig");

pub const Player = struct {
    x: f32 = settings.player_x,
    y: f32 = settings.player_y,
    angle: f32 = settings.player_angle,
    fov: f32 = settings.player_fov,
    movement: f32 = settings.player_movement,
    rotation: f32 = settings.player_rotation,

    pub fn update(self: *Player) void {
        const key_states = sdl.getKeyboardState();
        if (key_states.isPressed(sdl.Scancode.w)) {
            const cos = math.cos(math.degreesToRadians(f32, self.angle)) * self.movement * 0.1;
            const sin = math.sin(math.degreesToRadians(f32, self.angle)) * self.movement * 0.1;
            var new_x = self.x + cos;
            var new_y = self.y + sin;

            // Collision test
            if (settings.map[@floatToInt(usize, math.floor(new_y))][@floatToInt(usize, math.floor(new_x))] == 0) {
                self.x = new_x;
                self.y = new_y;
            }
        } else if (key_states.isPressed(sdl.Scancode.s)) {
            const cos = math.cos(math.degreesToRadians(f32, self.angle)) * self.movement * 0.1;
            const sin = math.sin(math.degreesToRadians(f32, self.angle)) * self.movement * 0.1;
            var new_x = self.x - cos;
            var new_y = self.y - sin;

            // Collision test
            if (settings.map[@floatToInt(usize, math.floor(new_y))][@floatToInt(usize, math.floor(new_x))] == 0) {
                self.x = new_x;
                self.y = new_y;
            }
        } else if (key_states.isPressed(sdl.Scancode.d)) {
            self.angle += self.rotation;
        } else if (key_states.isPressed(sdl.Scancode.a)) {
            self.angle -= self.rotation;
        } else {}
    }
};

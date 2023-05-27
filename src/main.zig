const std = @import("std");
const sdl = @import("sdl2");
const settings = @import("settings.zig");
const ray = @import("ray.zig");
const p = @import("player.zig");

pub fn main() !void {
    sdl.init(.{ .video = true, .events = true }) catch {
        std.log.err("SDL2 failed to initialize.", .{});
        return;
    };
    defer sdl.quit();

    const window = sdl.createWindow("DEMO", .{ .centered = {} }, .{ .centered = {} }, settings.screen_width, settings.screen_height, .{ .vis = .shown }) catch {
        std.log.err("SDL couldn't create the window.", .{});
        return;
    };
    defer window.destroy();
    const render = sdl.createRenderer(window, null, .{ .accelerated = true }) catch {
        std.log.err("SDL couldn't create renderer.", .{});
        return;
    };
    defer render.destroy();

    var r = ray.Ray{};
    var player = p.Player{};

    mainLoop: while (true) {
        while (sdl.pollEvent()) |event| {
            switch (event) {
                .quit => break :mainLoop,
                else => {},
            }
        }
        try render.setColorRGB(0x19, 0x19, 0x19);
        try render.clear();
        try r.casting(render, &player);
        render.present();
    }
}

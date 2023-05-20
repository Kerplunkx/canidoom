const std = @import("std");
const sdl = @import("sdl2");

pub fn main() !void {
    std.debug.print("Can I {s}\n", .{"DOOM?"});
    sdl.init(.{ .video = true, .events = true }) catch {
        std.log.err("SDL2 failed to initialize.", .{});
        return;
    };
    defer sdl.quit();

    const window = sdl.createWindow("DEMO", .{ .centered = {} }, .{ .centered = {} }, 800, 600, .{ .vis = .shown }) catch {
        std.log.err("SDL couldn't create the window.", .{});
        return;
    };
    defer window.destroy();

    mainLoop: while (true) {
        while (sdl.pollEvent()) |event| {
            switch (event) {
                .quit => break :mainLoop,
                else => {},
            }
        }
    }
}
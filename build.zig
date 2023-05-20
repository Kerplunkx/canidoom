const std = @import("std");
const Sdk = @import("libs/SDL.zig/Sdk.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});
    const sdk = Sdk.init(b, null);

    const exe = b.addExecutable(.{
        .name = "canidoom",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);
    sdk.link(exe, .dynamic);
    exe.addModule("sdl2", sdk.getWrapperModule());

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}

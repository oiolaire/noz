const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "noz",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("secp256k1");

    const nostr = b.dependency("zigNostr", .{
        .target = target,
        .optimize = optimize,
    });
    exe.addModule("nostr", nostr.module("zig-nostr"));

    b.installArtifact(exe);
}

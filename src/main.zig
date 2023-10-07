const std = @import("std");
const nostr = @import("nostr");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var input: [32]u8 = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32 };

    var skBytes: [32]u8 = undefined;
    std.crypto.hash.sha2.Sha256.hash(&input, &skBytes, .{});
    std.debug.print("private key: {s}\n", .{std.fmt.fmtSliceHexLower(&skBytes)});

    const sk = try nostr.parseKey(&skBytes);
    var pk: [32]u8 = undefined;
    sk.serializedPublicKey(&pk);
    std.debug.print("public key: {s}\n", .{std.fmt.fmtSliceHexLower(&pk)});
}

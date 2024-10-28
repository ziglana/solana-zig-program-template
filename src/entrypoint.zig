const solana = @import("solana-program-sdk");
const process = @import("process.zig");

export fn entrypoint(_: [*]u8) callconv(.C) u64 {
    solana.print("Hello world!", .{});
    return 0;
}

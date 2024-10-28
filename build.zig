const std = @import("std");
const solana = @import("solana-program-sdk");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
    // Choose the on-chain target (bpf, sbf v1, sbf v2, etc)
    // Many targets exist in the package, including `bpf_target`,
    // `sbf_target`, and `sbfv2_target`.
    // See `build.zig` for more info.
    const target = b.resolveTargetQuery(solana.sbf_target);
    // Choose the optimization. `.ReleaseSmall` gives a good balance of
    // optimized CU usage and smaller size of compiled binary
    const optimize = .ReleaseSmall;
    // Define your program as a shared library
    const program = b.addSharedLibrary(.{
        .name = "program_name",
        // Give the root of your program, where the entrypoint is defined
        .root_source_file = .{ .path = "src/entrypoint.zig" },
        .optimize = optimize,
        .target = target,
    });
    // Use the `buildProgram` helper to create the solana-sdk module, add all
    // of its required dependencies, link the program properly, and generate
    // a keypair in `zig-out/lib` along with the compiled program.
    const solana_mod = solana.buildProgram(b, program, target, optimize);

    // Optional, but if you define unit tests in your program files, you can run
    // them with `zig build test` with this step included
    const test_step = b.step("test", "Run unit tests");
    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/entrypoint.zig" },
    });
    lib_unit_tests.root_module.addImport("solana-program-sdk", solana_mod);
    const run_unit_tests = b.addRunArtifact(lib_unit_tests);
    test_step.dependOn(&run_unit_tests.step);
}

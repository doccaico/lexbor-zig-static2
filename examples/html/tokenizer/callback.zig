const std = @import("std");
const exit = std.process.exit;
const print = std.debug.print;

const core = @import("lexbor").core;
const html = @import("lexbor").html;
const tag = @import("lexbor").tag;

pub fn main() void {
    var status: core.Status = undefined;
    const data = "<div><span>test</span></div>";

    print("HTML:\n{s}\n\n", .{data});
    print("Result:\n", .{});

    const tkz = html.tokenizer.create();
    defer _ = html.tokenizer.destroy(tkz);

    status = html.tokenizer.init(tkz);
    if (status != .ok) failed("Failed to create tokenizer object", .{});

    // Set callback for token
    html.tokenizer.callbackTokenDoneSet(tkz, tokenCallback, null);

    status = html.tokenizer.begin(tkz);
    if (status != .ok) failed("Failed to prepare tokenizer object for parsing", .{});

    status = html.tokenizer.chunk(tkz, data, data.len);
    if (status != .ok) failed("Failed to parse the html data", .{});

    status = html.tokenizer.end(tkz);
    if (status != .ok) failed("Failed to ending of parsing the html data", .{});
}

fn tokenCallback(tkz: ?*html.Tokenizer, token: ?*html.Token, ctx: ?*anyopaque) callconv(.C) ?*html.Token {
    _ = tkz;
    _ = ctx;

    const name = tag.nameById(@enumFromInt(token.?.tag_id), null) orelse failed("Failed to get token name", .{});

    const bool_str = if ((token.?.type & @intFromEnum(html.token.Type.close)) == 1) "true" else "false";

    print("Tag name: {s}; Tag id: {any}; Is close: {s}\n", .{ name, token.?.tag_id, bool_str });

    return token;
}

pub fn failed(comptime fmt: []const u8, args: anytype) noreturn {
    print(fmt, args);
    exit(1);
}

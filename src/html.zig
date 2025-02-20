pub const document = @import("html/document.zig");
pub const parser = @import("html/parser.zig");
pub const tag = @import("html/tag.zig");
pub const serialize = @import("html/serialize.zig");

const html_ext = @import("html_ext.zig");
pub const Document = html_ext.lxb_html_document_t;

// const std = @import("std");
// const sliceTo = std.mem.sliceTo;

// pub const core = @import("../core_ext.zig");
// pub const html = @import("../html_ext.zig");
pub const dom = @import("../dom_ext.zig");

// pub const HtmlDocument = @import("../html.zig").Document;

// pub const errors = @import("../errors.zig");

// const Document = @This();

// dom_element: *dom.lxb_dom_element_t,

const Error = error{
    FailedToDomCreateElement,
    FailedToDomCreateTextNode,
};

// pub fn createElement(document: ?*dom.lxb_dom_document_t, local_name: ?*const core.lxb_char_t, lname_len: usize, reserved_for_opt: ?*anyopaque) Error!Document {

// pub fn createElement(document: ?*dom.lxb_dom_document_t, local_name: []const u8, lname_len: usize, reserved_for_opt: ?*anyopaque) Error!Document {
pub fn createElement(dom_document: *dom.lxb_dom_document, local_name: []const u8, lname_len: usize, reserved_for_opt: ?*anyopaque) Error!*dom.lxb_dom_element_t {
    const dom_element = dom.lxb_dom_document_create_element(dom_document, @ptrCast(local_name.ptr), lname_len, reserved_for_opt) orelse return error.FailedToDomCreateElement;
    return dom_element;
}

pub fn createTextNode(dom_document: *dom.lxb_dom_document, data: []const u8, len: usize) Error!*dom.lxb_dom_text_t {
    const text_node = dom.lxb_dom_document_create_text_node(dom_document, @ptrCast(data.ptr), len) orelse return error.FailedToDomCreateTextNode;
    return text_node;
}

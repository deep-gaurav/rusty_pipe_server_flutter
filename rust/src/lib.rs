use rusty_pipe_server;
use std::ffi::{CStr, CString};
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn rust_greeting(to: *const c_char) -> *mut c_char {
    let c_str = unsafe { CStr::from_ptr(to) };
    let recipient = match c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };

    CString::new("Hello ".to_owned() + recipient)
        .unwrap()
        .into_raw()
}

#[no_mangle]
pub extern "C" fn run_server(to: *const c_char) {
    let c_str = unsafe { CStr::from_ptr(to) };
    let rstr = String::from(c_str.to_str().unwrap());
    let splits = rstr.trim().split(":").collect::<Vec<_>>();
    let port = splits.get(1).unwrap_or(&"49000").parse().unwrap_or(49000);
    let ips = splits
        .get(0)
        .unwrap_or(&"127.0.0.1")
        .trim()
        .split(".")
        .collect::<Vec<_>>();
    let ip1 = ips.get(0).unwrap_or(&"127").parse().unwrap_or(127);
    let ip2 = ips.get(0).unwrap_or(&"0").parse().unwrap_or(0);
    let ip3 = ips.get(0).unwrap_or(&"0").parse().unwrap_or(0);
    let ip4 = ips.get(0).unwrap_or(&"1").parse().unwrap_or(1);
    let rt = tokio::runtime::Runtime::new();
    if let Ok(mut rt) = rt {
        rt.block_on(rusty_pipe_server::run_server_async(
            [ip1, ip2, ip3, ip4],
            port,
        ))
    }
}

#[no_mangle]
pub extern "C" fn rust_cstr_free(s: *mut c_char) {
    unsafe {
        if s.is_null() {
            return;
        }
        CString::from_raw(s)
    };
}

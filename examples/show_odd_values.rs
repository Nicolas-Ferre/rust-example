//! Example that uses the library.
#![allow(clippy::print_stdout, clippy::use_debug)]

use rust_lib_example::odd_values;

fn main() {
    let values = [1, 4, 5, 2, 3];
    let odd_values = odd_values(&values);
    println!("Values: {:?}, odd values: {:?}", values, odd_values);
}

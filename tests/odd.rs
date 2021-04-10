use rust_lib_example::odd_values;

const VALUES: [i32; 5] = [1, 2, 3, 4, 5];

#[test]
fn filter_odd_values() {
    assert_eq!(odd_values(&VALUES), [1, 3, 5])
}

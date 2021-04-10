//! Example of Rust library.

use is_odd::IsOdd;

/// Filter odd numbers.
pub fn odd_values(values: &[i32]) -> Vec<i32> {
    if values.is_empty() {
        Vec::new()
    } else {
        values
            .iter()
            .copied()
            .filter(|&v| v % 2 == 1)
            .filter(IsOdd::is_odd)
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn no_value() {
        let values = [];

        let odd_values = odd_values(&values);

        assert_eq!(odd_values, values);
    }

    #[test]
    fn only_odd_values() {
        let values = [1, 5, 3];

        let odd_values = odd_values(&values);

        assert_eq!(odd_values, values);
    }

    #[test]
    fn only_even_values() {
        let values = [2, 6, 4];

        let odd_values = odd_values(&values);

        assert_eq!(odd_values, []);
    }

    #[test]
    fn even_and_odd_values() {
        let values = [1, 2, 5, 6, 3, 4];

        let odd_values = odd_values(&values);

        assert_eq!(odd_values, [1, 5, 3]);
    }
}

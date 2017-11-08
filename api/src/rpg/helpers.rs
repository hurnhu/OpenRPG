/// # Function Name: remove_ele
/// ---
///
/// This function simple removes the specified element
/// spaw_remove is o(1), but will
/// >Removes an element from anywhere in the vector and return it, replacing it with the last
/// element.

pub fn remove_ele(v: &mut Vec<&str>, p: usize){
    v.swap_remove(p);
}

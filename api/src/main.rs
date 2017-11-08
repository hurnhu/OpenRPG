#![feature(plugin)]
#![plugin(rocket_codegen)]

//extern crate for rock framework && json
extern crate rocket;
#[macro_use]
extern crate rocket_contrib;
extern crate serde_json;

//imports for spawnning processes and sending html reponse
use rocket::response::content;

mod rpg;

/// # Function Name: not_found
/// ---
///
/// This will trigger if the path requested is not found.
/// It displays a simple error message, with suggestions.

#[error(404)]
fn not_found(req: &rocket::Request) -> content::Html<String> {
    content::Html(format!(
        "<h1>404 path '{}' not found!</h1>
    <p>Try visiting /roll?-h instead.</p>
    <p>or visit /name?-h instead. </p>",
        req.uri()
    ))
}


/// # Function Name: main
/// ---
///
/// Main funciton

fn main() {
    rocket::ignite()
        .mount("/", routes![rpg::dice::roll, rpg::person::name])
        .catch(errors![not_found])
        .launch();
}

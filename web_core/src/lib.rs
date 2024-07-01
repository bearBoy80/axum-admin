use serde::{Deserialize, Serialize};

mod utils;
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct User {
    pub user_id: i64,
    pub username: String,
    pub email: String,
}
#[allow(unused)]
impl User {
    fn new(uid: i64, username: &str, email: &str) -> Self {
        User {
            user_id: uid,
            username: username.to_string(),
            email: email.to_string(),
        }
    }
}

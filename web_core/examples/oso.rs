use oso::{Oso, PolarClass};

#[derive(Clone, PolarClass)]
struct User {
    #[polar(attribute)]
    pub username: String,
}

impl User {
    fn superuser() -> Vec<String> {
        vec!["alice".to_string(), "charlie".to_string()]
    }
}

fn main() -> anyhow::Result<()> {
    let mut oso = Oso::new();

    oso.register_class(
        User::get_polar_class_builder()
            .add_class_method("superusers", User::superuser)
            .build(),
    )?;

    oso.load_str(
        r#"allow(actor: User, _action, _resource) if
                        actor.username.ends_with("example.com");"#,
    )?;

    let user = User {
        username: "alice@example.com".to_owned(),
    };

    assert!(oso.is_allowed(user, "foo", "bar")?);
    Ok(())
}

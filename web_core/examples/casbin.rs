use sqlx_adapter::{
    casbin::{CoreApi, DefaultModel, Enforcer},
    SqlxAdapter,
};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    let m = DefaultModel::from_file("./rbac_model.conf").await?;
    let a = SqlxAdapter::new("postgres://chat01:postgres@127.0.0.1:5432/chat01", 8).await?;
    let mut enforcer = Enforcer::new(m, a).await?;
    enforcer.load_policy().await?;
    Ok(())
}

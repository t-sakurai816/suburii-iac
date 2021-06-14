# suburii-iac

下記のようなコマンドでインスタンスを立てることができる。
VPC, サブネット(a, c, d), インターネットゲートウェイ, ルートテーブル, セキュリティグループ, EC2(t3a.micro), EBS(standard 15GB), EIPが生成されます

```
terraform apply -var 'instance_name=TEST-instance'
```
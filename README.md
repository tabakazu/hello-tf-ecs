## 事前準備

##### ECR のレポジトリ作成

```
$ aws ecr create-repository --repository-name taba
```

##### Docker イメージの用意  

Dockerfile からイメージビルド
```
$ docker build -t taba .
```
[イメージのプッシュ - Amazon ECR](https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/docker-push-ecr-image.html)

## プロビジョニング
```
$ terraform init
$ terraform plan

$ terraform apply
```
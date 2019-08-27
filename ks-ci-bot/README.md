## 更新配置

1. 更新 config.yaml
```
kubectl create configmap config \
--from-file=config.yaml=config.yaml --dry-run -o yaml \
| kubectl replace configmap config -f -
```

2. 更新 plugins.yaml
```
kubectl create configmap plugins \
  --from-file=plugins.yaml=plugins.yaml --dry-run -o yaml \
  | kubectl replace configmap plugins -f -
```

3. 更新 labels.yaml
```
kubectl create configmap label-config \
 --from-file=labels.yaml=labels.yaml --dry-run -o yaml \
 | kubectl replace configmap config -f -
```

## 新增仓库支持

### 1 仓库给 `ks-ci-bot` admin 权限，`ks-ci-bot` 同意

### 2 Github 仓库 setting -> webhooks 处增加 webhook
可以通过命令行新增 webhook，也可以在 Github 手动配置 webhook

#### 2.1 Payload URL: http://prow.kubesphere.io:8080/webhook

#### 2.2. Content type: application/json

#### 2.3 secret: 填 prow 服务端存放的 hmac
```
kubectl get secret hmac-token -o=jsonpath='{.data.hmac}' | base64 -d
```

#### 2.4 选择 send me everything

## 命令行新增 webhook
```
go get -u k8s.io/test-infra/experiment/add-hook
cp $GOPATH/bin/add-hook /usr/local/bin
```

```
add-hook  --hmac-path=h-mac --github-token-path=oauth -hook-url http://prow.kubesphere.io:8080/hook -repo kubesphere-test/prow-tutorial -confirm=true
```

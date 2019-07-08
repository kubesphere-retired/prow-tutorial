# Prow使用指南
![prow_logo](logo_horizontal_solid.png)

## 简介

**Prow**是k8s使用的CI/CD系统(<https://github.com/kubernetes/test-infra/tree/master/prow>)，用于管理k8s的issue和pr。如果你经常去k8s社区查看pr或者提交过一些Pr后，就会经常看到一个叫**k8s-ci-bot**的机器人在各个Pr中回复，并且还能合并pr。在k8s-ci-bot中背后工作的就是Prow。Prow是为了弥补github上一些功能上的缺陷，它也是Jenkins-X的一部分，它具备这些功能：

1. 执行各种Job，包括测试，批处理和制品发布等，能够基于github webhook配置job执行的时间和内容。
2. 一个可插拔的机器人功能（**Tide**），能够接受`/foo`这种样式的指令。
3. 自动合并Pr
4. 自带一个网页，能够查看当前任务的执行情况以及Pr的状况，也包括一些帮助信息
5. 基于OWNER文件在同一个repo里配置模块的负责人
6. 能够同时处理很多repo的很多pr
7. 能够导出Prometheus指标


## 安装指南

> 官方repo提供了一个基于GKE快速安装指南，本文将基于青云的[QKE](https://github.com/QingCloudAppcenter/QKE])(QingCloud Kubernetes Engine)搭建Prow环境。不用担心，其中大部分步骤都是平台无关的，整个安装过程能够很方便的在其他平台上使用。

### 一、 准备一个kubernetes集群

在青云控制台上点击左侧的容器平台，选择其中的QKE，简单设置一些参数之后，就可以很快创建一个kubernetes集群。

### 二、 准备一个github机器人账号
> 如果没有机器人账号，用个人账号也可以。机器人账号便于区分哪些Prow的行为，所以正式使用时应该用机器人账号。

1. 在想要用prow管理的仓库中将机器人账号设置为管理员。
2. 在账号设置中添加一个[personal access token][1]，此token需要有以下权限：
   
   + **必须**：`public_repo` 和 `repo:status`
   + **可选**：`repo`假如需要用于一些私有repo
   + **可选**：`admin_org:hook` 如果想要用于一个组织
3. 将此Token保存在文件中，比如${HOME}/secrets/oauth
4. 用`openssl rand -hex 20`生成一个随机字符串用于验证webhook。将此字符串保存在本地，比如${HOME}/secrets/h-mac

### 三、 配置k8s集群
> 这里使用的default命名空间配置prow，如果需要配置在其他命名空间，需要在相关`kubectl`的命令中配置`-n`参数，并且在部署的yaml中配置命名空间。
> 
1. 将上一步中创建token和hmac保存在k8s集群中
```bash
# openssl rand -hex 20 > ${HOME}/secrets/h-mac
kubectl create secret generic hmac-token --from-file=hmac=
kubectl create secret generic oauth-token --from-file=oauth=${HOME}/secrets/oauth
```
2. 部署Prow。由于Prow官方yaml中使用了grc.io镜像，这个镜像在中国大陆无法访问，所以我们将相应的repo搬到了dockerhub上，并提供了一份替换相关镜像名称的[yaml](prow.yaml)



[1]: https://github.com/settings/tokens
[2]: /prow/jobs.md#How-to-configure-new-jobs
[3]: https://github.com/jetstack/cert-manager
[4]: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
[5]: /prow/cmd/mkbuild-cluster/
[6]: /prow/cmd/tide/README.md
[7]: /prow/cmd/tide/config.md
[8]: https://github.com/kubernetes/test-infra/blob/master/prow/scaling.md#working-around-githubs-limited-acls
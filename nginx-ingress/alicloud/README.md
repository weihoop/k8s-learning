## template 目录说明 

### 文件用途

- convert-ingress-controller-template.sh
  - 使用ingress-controller-template.yml.j2，生成ingress-controller.yml文件
  - 生成的yml用于部署ingress controller
- convert-ingress-alibaba-log-template.sh
  - 使用ingress-alibaba-log-template.yml.j2，生成ingress-alibaba-log.yml文件
  - 生成的yml用于部署ingress controller阿里云日志服务

### 参考文档

- [如何在ACK集群中部署多个Ingress Controller](https://help.aliyun.com/document_detail/151524.html?spm=5176.11065259.1996646101.searchclickresult.30ec6a496GRSig)
- [如何在阿里云Kubernetes集群中部署多个Ingress Controller](https://www.colabug.com/2018/0927/4711897/) 

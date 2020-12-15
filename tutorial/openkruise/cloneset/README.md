## CloneSet蓝绿/灰度发布

- blue_green: 演示CloneSet使用Ingress做蓝绿发布
- gray_release_ingress: 演示CloneSet使用Ingress做灰度发布
- gray_release_partition: 演示CloneSet使用partition做灰度发布

### blue_green

本教程演示使用CloneSet做蓝绿发布

依次使用 kubectl 执行4个文件:
- 1.cloneset_blue_v1.yaml
- 2.cloneset_blue_ingress.yaml  
- 3.cloneset_green_v2.yaml
- 4.cloneset_green_ingress.yaml

### gray_release_ingress

本教程演示使用CloneSet控制器,通过Ingress做灰度发布.

依次使用 kubectl 执行6个文件:
- 1.cloneset_v1.yaml          
- 2.cloneset_ingress_v1.yaml  
- 3.cloneset_v2.yaml                    
- 4.cloneset_ingress_v2_10percent.yaml  
- 5.cloneset_ingress_v2_50percent.yaml
- 6.cloneset_ingress_v2_100percent.yaml


### gray_release_partition

本教程演示使用CloneSet控制器的，通过partition功能做灰度发布.

依次使用 kubectl 执行5个文件:
- 1.cloneset_v1.yaml    
- 2.cloneset_ingress.yaml
- 3.cloneset_gray_v2_partition4.yaml   
- 4.cloneset_gray_v2_partition2.yaml
- 5.cloneset_gray_v2_partition0.yaml

### 测试方法

创建测试脚本

```
cat > curl_nginx_demo.sh <<EOF
#!/bin/bash
url=http://nginx-demo.myapp.com:30809
#url=http://nginx-demo-gray.myapp.com:30809

> curl_result.txt

for count in \$(seq 1 100);do
  curl -s \$url >> curl_result.txt
done

sort curl_result.txt | uniq -c
EOF
```

> 注意: 根据不同的测试项目，切换url变量

使用测试脚本

```
sh curl_nginx_demo.sh
```

脚本会curl访问100次url，并将访问结果排序去重计数，得出的计数结果，可以获取访问的效果。

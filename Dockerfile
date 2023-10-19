FROM ubuntu:18.04

# 更新软件源
RUN apt-get update 

# 安装nginx
RUN apt-get -y install nginx

# 定义暴露端口
EXPOSE 80

# 设置容器启动命令
CMD ["nginx", "-g", "daemon off;"]

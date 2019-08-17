# aria2-web

# 使用方式
```sh
#这里单独新建了一个目录来存放数据
#download用来存放aria2文件下载数据,appdata用来存放aria2 session会话数据和filebrowser配置数据,ariacache存放aria2缓存数据
mkdir -p /aria2-data/{download,appdata,ariacache}

#运行
docker run --name aria2-web \
	-p 6800:6800 -p 8680:8680 \
	-v /aria2-data/download:/data -v /aria2-data/appdata:/appdata -v /aria2-data/ariacache:/root/.cache \
	lunnlew/aria2-web:latest
```
# 访问方式

访问链接`http://127.0.0.1:8680`，端口`8680`提供ui服务，默认为aria2下载界面

`http://127.0.0.1:8680/files/`为文件管理服务，默认用户admin，密码admin

具体IP使用你自己的环境IP
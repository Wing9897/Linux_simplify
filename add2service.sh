#!/bin/bash

echo "Your service name:"
read SERVICE_NAME

echo "service description:"
read SERVICE_DESCRIPTION

echo "app path (/usr/bin/python3 or /usr/local/bin/node):"
read APP_PATH

echo "app command or document path:"
read APP_COMMAND

# 创建Systemd服务配置文件
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

echo "[Unit]
Description=${SERVICE_DESCRIPTION}
After=network.target

[Service]
ExecStart=${APP_PATH}/${APP_COMMAND}
WorkingDirectory=${APP_PATH}
Restart=always


[Install]
WantedBy=multi-user.target
" | sudo tee ${SERVICE_FILE}

# 重新加载Systemd配置
sudo systemctl daemon-reload

# 启动和管理服务
sudo systemctl start ${SERVICE_NAME}  # 启动服务
sudo systemctl enable ${SERVICE_NAME} # 设置开机自启
sudo systemctl status ${SERVICE_NAME} # 查看服务状态

#manually Part 
#chmod +x deploy.sh
#./deploy.sh
#sudo systemctl start my-node-app  # 启动服务
#sudo systemctl stop my-node-app   # 停止服务
#sudo systemctl restart my-node-app    # 重启服务
#sudo systemctl status my-node-app # 查看服务状态
#!/bin/bash

# 設置UTF-8編碼
export LANG=zh_TW.UTF-8

# 檢查 .git 目錄是否存在
if [ ! -d ".git" ]; then
    echo "正在初始化 Git 倉庫..."
    git init
else
    echo "Git 倉庫已初始化。"
fi

# 獲取當前時間戳，格式為 YYYY-MM-DD_HH-MM-SS
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# 將所有文件添加到暫存區
echo "正在添加所有文件..."
git add .

# 使用時間戳作為提交信息進行提交
echo "正在提交更改..."
git commit -m "更新 $timestamp"

# 顯示提交歷史
echo "正在顯示提交歷史..."
git log --oneline -10

echo "備份完成！"
#!/bin/bash

# 注意：date 和 time 格式因系統語言不同可能會有差異，這是一個常見格式的範例
COMMIT_MSG=$(date +"%Y-%m-%d_%H-%M-%S")_update

echo "使用提交訊息：$COMMIT_MSG"

# 固定遠端名稱
REMOTE_NAME=origin

# 取得當前分支名稱
BRANCH_NAME=$(git branch --show-current)
echo "當前分支名稱：$BRANCH_NAME"

echo "添加所有變更..."
git add .

echo "提交變更..."
git commit -m "$COMMIT_MSG"

echo "推送到遠端 $REMOTE_NAME 的 $BRANCH_NAME 分支..."
git push $REMOTE_NAME $BRANCH_NAME

echo "完成！"

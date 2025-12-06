#!/bin/bash
# AutoDL Git 模型下载脚本
# 用法: ./download_model_git.sh <仓库地址> <保存目录>

REPO_URL=$1
SAVE_DIR=${2:-/root/autodl-tmp/models}

if [ -z "$REPO_URL" ]; then
    echo "⚠️ 请提供模型仓库地址，例如 https://huggingface.co/bert-base-uncased"
    exit 1
fi

# 确保目录存在
mkdir -p $SAVE_DIR
cd $SAVE_DIR

echo "🔽 开始下载模型仓库: $REPO_URL"
git lfs install
git clone $REPO_URL

echo "✅ 下载完成，模型保存在: $SAVE_DIR"
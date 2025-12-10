#!/bin/bash
# 一键清理 pip/conda/HF 缓存和日志，释放空间

echo "开始清理缓存和日志..."

# 清理 pip 缓存（全局）
echo "清理 pip 缓存..."
pip cache purge

# 清理 conda 缓存（全局）
echo "清理 conda 缓存..."
conda clean -a -y

# 清理 HuggingFace 缓存
echo "清理 HuggingFace 缓存..."
rm -rf ~/.cache/huggingface
rm -rf ~/.cache/torch
rm -rf ~/.cache/pip

# 如果你设置了缓存目录到数据盘，也清理它们
echo "清理数据盘缓存目录..."
rm -rf /root/autodl-tmp/huggingface/*
rm -rf /root/autodl-tmp/transformers/*
rm -rf /root/autodl-tmp/pip_cache/*
rm -rf /root/autodl-tmp/tmp/*

# 清理系统日志
echo "清理系统日志..."
rm -rf /var/log/*

# 显示剩余空间
echo "清理完成，当前磁盘使用情况："
df -h | grep -E "/$|/root/autodl-tmp"

echo "✅ 清理完成，可以继续安装 xinference[all]"
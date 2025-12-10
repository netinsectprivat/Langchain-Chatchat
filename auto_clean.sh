#!/bin/bash
# 自动检测磁盘空间并清理缓存和日志

# 设置阈值
THRESHOLD=80

# 获取系统盘和数据盘使用率
SYS_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
DATA_USAGE=$(df -h /root/autodl-tmp | awk 'NR==2 {print $5}' | sed 's/%//')

echo "系统盘使用率: $SYS_USAGE%"
echo "数据盘使用率: $DATA_USAGE%"

# 定义清理函数
clean_all() {
  echo "⚠️ 空间超过阈值，开始清理..."

  # 清理 pip 缓存
  echo "清理 pip 缓存..."
  pip cache purge

  # 清理 conda 缓存
  echo "清理 conda 缓存..."
  conda clean -a -y

  # 清理 HuggingFace/Transformers 缓存
  echo "清理 HuggingFace 缓存..."
  rm -rf ~/.cache/huggingface ~/.cache/torch ~/.cache/pip

  echo "清理数据盘缓存目录..."
  rm -rf /root/autodl-tmp/huggingface/* \
         /root/autodl-tmp/transformers/* \
         /root/autodl-tmp/pip_cache/* \
         /root/autodl-tmp/tmp/*

  # 清理系统日志
  echo "清理系统日志..."
  rm -rf /var/log/*

  echo "✅ 清理完成"
}

# 判断是否需要清理
if [ "$SYS_USAGE" -ge "$THRESHOLD" ] || [ "$DATA_USAGE" -ge "$THRESHOLD" ]; then
  clean_all
else
  echo "✅ 空间充足，无需清理"
fi

# 显示清理后的磁盘情况
echo "当前磁盘使用情况："
df -h | grep -E "/$|/root/autodl-tmp"
**使用方法

保存为 1.**auto_clean.sh**：

2.chmod +x auto_clean.sh

3.执行脚本

./auto_clean.sh

**

1 pip install  xinference[sglang]  -i https://pypi.tuna.tsinghua.edu.cn/simple

2 XINFERENCE_HOME=/root/autodl-tmp/xinference XINFERENCE_MODEL_SRC=modelscope xinference-local --host 0.0.0.0  --port 9997

3 xinference launch --model-engine vllm  --model-name  glm4-chat --size-in-billions 9 --model-format pytorch --quantization  none

4.xinference list

5.XINFERENCE_HOME=/root/autodl-tmp/xinference XINFERENCE_MODEL_SRC=modelscope xinference-local --host 0.0.0.0 --port 9997

6.xinference launch --model-name bge-large-zh-v1  --model-type embedding


***1.先从github上将新版本的项目拉取下来，指令如下***

git clone https://github.com/chatchat-space/Langchain-Chatchat.git

**2.新建一个虚拟环境**

conda create -n glm4_text python==3.11

**3.对于一个全新的机子来说新建完虚拟环境无法做到直接激活，重新加载你的shell配置
输入以下指令,**

source ~/.bashrc

conda init

4.开始激活新建好的环境

  conda activate glm4_text

5.安装 Langchain-Chatchat，从 0.3.0 版本起，Langchain-Chatchat 提供以 Python 库形式的安装方式，具体安装请执行：

pip install langchain-chatchat -U  -i https://pypi.tuna.tsinghua.edu.cn/simple

6.因模型部署框架 Xinference 接入 Langchain-Chatchat 时需要额外安装对应的 Python 依赖库，因此如需搭配 Xinference 框架使用时，建议使用如下安装方式：

pip install langchain-chatchat[xinference] -U  -i https://pypi.tuna.tsinghua.edu.cn/simple

三.使用Xinference，进行框架部署与大模型加载，embidding模型加载
1.从 0.3.0 版本起，Langchain-Chatchat 不再根据用户输入的本地模型路径直接进行模型加载，涉及到的模型种类包括 LLM、Embedding、Reranker 及后续会提供支持的多模态模型等，均改为支持市面常见的各大模型推理框架接入，如 Xinference、Ollama、LocalAI、FastChat、One API 等。因此，请确认在启动 Langchain-Chatchat 项目前，首先进行模型推理框架的运行，并加载所需使用的模型。

2.再次新建一个虚拟环境
conda create -n llm_tl python==3.11

3.开始激活新建好的环境

conda activate llm_tl

4.Xinference 在 Linux, Windows, MacOS 上都可以通过 `<span>pip</span>` 来安装。如果需要使用 Xinference 进行模型推理，可以根据不同的模型指定不同的引擎。

pip install "xinference[all]"  -i https://pypi.tuna.tsinghua.edu.cn/simple

5.PyTorch(transformers) 引擎支持几乎有所的最新模型，这是 Pytorch 模型默认使用的引擎：

pip install "xinference[transformers]"  -i https://pypi.tuna.tsinghua.edu.cn/simple

6.安装 xinference 和 vLLM：

pip install "xinference[vllm]"

7.Xinference 通过 `<span>llama-cpp-python</span>` 支持 `<span>gguf</span>` 和 `<span>ggml</span>` 格式的模型。建议根据当前使用的硬件手动安装依赖，从而获得最佳的加速效果。初始步骤

pip install xinference  -i https://pypi.tuna.tsinghua.edu.cn/simple

8.安装英伟达显卡：

CMAKE_ARGS="-DLLAMA_CUBLAS=on" pip install llama-cpp-python  -i https://pypi.tuna.tsinghua.edu.cn/simple

9.SGLang 具有基于 RadixAttention 的高性能推理运行时。它通过在多个调用之间自动重用KV缓存，显著加速了复杂 LLM 程序的执行。它还支持其他常见推理技术，如连续批处理和张量并行处理。

pip install 'xinference[sglang]'  -i https://pypi.tuna.tsinghua.edu.cn/simple

10.本地运行Xinference，让我们以一个经典的大语言模型 glm4-9b-chat 来展示如何在本地用 Xinference 运行大模型,我这里自定义了一个存储日志文件和大模型，embidding模型的路径，如果不自定义一个路径将会下载到默认的一个路径下，这样很容易将我们的系统盘给撑爆，以魔塔社区下载模型为例。

XINFERENCE_HOME=/root/autodl-tmp/xinference XINFERENCE_MODEL_SRC=modelscope xinference-local --host 0.0.0.0 --port 9997

xinference launch --model-engine vllm --model-name glm4-chat --size-in-billions 9 --model-format pytorch --quantization none

11.以使用 `<span>--model-uid</span>` 或者 `<span>-u</span>` 参数指定模型的 UID，如果没有指定，Xinference 会随机生成一个 ID，下面的命令就是手动指定了 ID 为glm4-chat :

xinference list

12.大模型下载好之后，我们开始下载embidding模型，官方地址如下[bge-large-zh-v1.5 — Xinference](https://inference.readthedocs.io/zh-cn/latest/models/builtin/embedding/bge-large-zh-v1.5.html "bge-large-zh-v1.5 — Xinference")这里我选择的是bge-large-zh-v1.5

XINFERENCE_HOME=/root/autodl-tmp/xinference XINFERENCE_MODEL_SRC=modelscope xinference-local --host 0.0.0.0 --port 9997

xinference launch --model-name bge-large-zh-v1.5 --model-type embedding

#### 四.启动项目

1.切换成我们最开始新建的虚拟环境，在启动项目之前确保首先进行模型推理框架的运行，并加载所需使用的模型，查看与修改 Langchain-Chatchat 配置

chatchat-config --help

这时会得到返回：

Usage: chatchat-config [OPTIONS] COMMAND [ARGS]...

  指令 ` chatchat-config` 工作空间配置

Options:
  --help  Show this message and exit.

Commands:
  basic   基础配置
  kb      知识库配置
  model   模型配置
  server  服务配置

2.可根据上述配置命令选择需要查看或修改的配置类型，以 `<span>基础配置</span>`为例，想要进行 `<span>基础配置</span>`查看或修改时可以输入以下命令获取帮助信息：

chatchat-config basic --help

这个时候会返回以下信息:

Usage: chatchat-config basic [OPTIONS]

  基础配置

Options:
  --verbose [true|false]  是否开启详细日志
  --data TEXT             初始化数据存放路径，注意：目录会清空重建
  --format TEXT           日志格式
  --clear                 清除配置
  --show                  显示配置
  --help                  Show this message and exit.

3.使用 chatchat-config 查看对应配置参数以 `<span>基础配置</span>`为例，可根据上述命令帮助内容确认，需要查看 `<span>基础配置</span>`的配置参数，可直接输入：

chatchat-config basic --show

在未进行配置项修改时，可得到默认配置内容如下：

{
    "log_verbose": false,
    "CHATCHAT_ROOT": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat",
    "DATA_PATH": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/data",
    "IMG_DIR": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/img",
    "NLTK_DATA_PATH": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/data/nltk_data",
    "LOG_FORMAT": "%(asctime)s - %(filename)s[line:%(lineno)d] - %(levelname)s: %(message)s",
    "LOG_PATH": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/data/logs",
    "MEDIA_PATH": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/data/media",
    "BASE_TEMP_DIR": "/root/anaconda3/envs/chatchat/lib/python3.11/site-packages/chatchat/data/temp",
    "class_name": "ConfigBasic"
}

4.使用 chatchat-config 修改对应配置参数，以修改 `<span>模型配置</span>`中 `<span>默认llm模型</span>`为例，可以执行以下命令行查看配置项名称

chatchat-config model --help

这时会得到

Usage: chatchat-config model [OPTIONS]

  模型配置

Options:
  --default_llm_model TEXT        默认llm模型
  --default_embedding_model TEXT  默认embedding模型
  --agent_model TEXT              agent模型
  --history_len INTEGER           历史长度
  --max_tokens INTEGER            最大tokens
  --temperature FLOAT             温度
  --support_agent_models TEXT     支持的agent模型
  --set_model_platforms TEXT      模型平台配置 as a JSON string.
  --set_tool_config TEXT          工具配置项  as a JSON string.
  --clear                         清除配置
  --show                          显示配置
  --help                          Show this message and exit.

5.可首先查看当前 `<span>模型配置</span>`的配置项：

chatchat-config model --show

这时会得到:

{
    "DEFAULT_LLM_MODEL": "glm4-chat",
    "DEFAULT_EMBEDDING_MODEL": "bge-large-zh-v1.5",
    "Agent_MODEL": null,
    "HISTORY_LEN": 3,
    "MAX_TOKENS": null,
    "TEMPERATURE": 0.7,
    ...
    "class_name": "ConfigModel"
}

6.需要修改 `<span>默认llm模型</span>`为 `<span>qwen2-instruct</span>`时，可执行：

chatchat-config model --default_llm_model qwen2-instruct

7.初始化知识库

chatchat-kb -r

8.初始化知识库最常见的报错信息是

Traceback (most recent call last):
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/init_database.py", line 156, in main
    folder2db(kb_names=args.kb_name, mode="recreate_vs", embed_model=args.embed_model)
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/server/knowledge_base/migrate.py", line 130, in folder2db
    kb.create_kb()
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/server/knowledge_base/kb_service/base.py", line 80, in create_kb
    self.do_create_kb()
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/server/knowledge_base/kb_service/faiss_kb_service.py", line 51, in do_create_kb
    self.load_vector_store()
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/server/knowledge_base/kb_service/faiss_kb_service.py", line 28, in load_vector_store
    return kb_faiss_pool.load_vector_store(kb_name=self.kb_name,
  File "/Users/hkk/Amap/ai/Langchain-Chatchat/myenv/lib/python3.8/site-packages/chatchat/server/knowledge_base/kb_cache/faiss_cache.py", line 132, in load_vector_store
    raise RuntimeError(f"向量库 {kb_name} 加载失败。")
RuntimeError: 向量库 samples 加载失败。

9.遇到类似加载向量库失败的报错，缺少一个faiss这个包，这个时候需要再安装一个faiss的包

pip install faiss-cpu==1.7.4

pip install rank_bm25 -i https://mirrors.aliyun.com/pypi/simple

10.出现以下日志即为成功:

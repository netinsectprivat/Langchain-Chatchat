from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

model_path = "/root/autodl-tmp/models/qwen3-8b-instruct"  # 修改为你自己的路径

tokenizer = AutoTokenizer.from_pretrained(model_path, trust_remote_code=True)

model = AutoModelForCausalLM.from_pretrained(
    model_path,
    device_map="auto",
    torch_dtype=torch.bfloat16,  # RTX 5090 支持 bfloat16，速度和显存都更好
    trust_remote_code=True
)

prompt = "介绍一下你是谁？"

inputs = tokenizer(prompt, return_tensors="pt").to(model.device)

outputs = model.generate(**inputs, max_new_tokens=200)

print(tokenizer.decode(outputs[0], skip_special_tokens=True))

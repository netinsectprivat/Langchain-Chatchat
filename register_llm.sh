#!/bin/bash
# 注册 GLM-4-9B-Chat 模型
# 注意：修改 model_uri 为你的实际模型路径

curl 'http://127.0.0.1:9997/v1/model_registrations/LLM' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "model": "{
      \"version\": 1,
      \"model_name\": \"autodl-tmp-glm-4-9b-chat\",
      \"model_description\": \"GLM-4-9B Chat Model\",
      \"context_length\": 2048,
      \"model_lang\": [\"en\", \"zh\"],
      \"model_ability\": [\"generate\", \"chat\"],
      \"model_family\": \"glm4-chat\",
      \"model_specs\": [{
        \"model_uri\": \"/root/autodl-tmp/glm-4-9b-chat\",
        \"model_size_in_billions\": 9,
        \"model_format\": \"pytorch\",
        \"quantizations\": [\"none\"]
      }],
      \"prompt_style\": {
        \"style_name\": \"CHATGLM3\",
        \"system_prompt\": \"\",
        \"roles\": [\"user\", \"assistant\"],
        \"intra_message_sep\": \"\",
        \"inter_message_sep\": \"\",
        \"stop\": [\"<|endoftext|>\", \"<|user|>\", \"<|observation|>\"],
        \"stop_token_ids\": [151329, 151336, 151338]
      }
    }",
    "persist": true
  }'

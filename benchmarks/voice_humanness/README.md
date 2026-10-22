# Voice humanness benchmarks

本目录集中管理用于评估语音“拟人度”的公开 benchmark。仓库只保存清单、配置和安装脚本；上游项目通过脚本按需拉取，避免复制其数据和许可证受限的音频。

## 推荐组合

- **单段 TTS 音频**：HEAR + TTS-PRISM/ExpressiveSpeech 评分协议。
- **多个语音模型横向比较**：Vapi Humanness Index。
- **语音 Agent 互动拟人度**：HumDial-FDBench + Voice Agent Evals。

## 项目

| 项目 | 用途 | 上游 |
| --- | --- | --- |
| Vapi Humanness Index | 同一音色盲测、真人基线、Elo 拟人度排名 | https://github.com/VapiAI/humanness-index |
| HEAR | acoustic reasoning、Humanlike-100 和诊断维度 | https://github.com/HEAR-6/HEAR |
| NVV-SuperBench | 自然度、非语言表达和 LLM-as-judge | https://github.com/lmxue/NVV-SuperBench |
| ExpressiveSpeech | 人工听评的人类真实性/表现力协议 | https://github.com/FreedomIntelligence/ExpressiveSpeech |
| TTS-PRISM | 中文 TTS 的 12 维评分标准 | https://github.com/xiaomi-research/tts-prism |
| HumDial-FDBench | 打断、重叠、backchannel 和全双工互动 | https://github.com/ASLP-lab/HumDial-FDBench |
| Voice Agent Evals | 语音 Agent 的自然表达、同理心和连贯性 | https://github.com/srajdev/voice_agent_evals |

## 配置环境

在仓库根目录运行：

```bash
bash scripts/setup_voice_humanness.sh
```

脚本会把上游代码放到 `third_party/voice_humanness/`，创建 `.venv-voice/`，并安装 HEAR 的基础复现依赖。首次运行需要能够访问 GitHub 和 PyPI。

只安装目录、不装 Python 依赖：

```bash
SKIP_PYTHON_DEPS=1 bash scripts/setup_voice_humanness.sh
```

HEAR 的已保存结果可以直接复现：

```bash
source .venv-voice/bin/activate
python third_party/voice_humanness/hear/reproducibility/humanlike100/recompute.py
```

完整的实时/人工听评仍需按照各上游仓库的许可证、数据下载说明和 API 配置执行。Humanness Index 的源音频不在代码仓库中，HumDial-FDBench 的测试数据从其 Hugging Face 页面获取。

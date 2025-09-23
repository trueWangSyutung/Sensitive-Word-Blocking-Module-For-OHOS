
## 🧪 敏感词数据 / Sensitive Word Data

本项目使用的敏感词数据来源于 [konsheng/Sensitive-lexicon](https://github.com/konsheng/Sensitive-lexicon) 仓库，包含各类敏感词超过20000个，涵盖以下类型：

### 获取和处理敏感词数据 / Acquiring and Processing Sensitive Word Data

由于国内 Git 平台的敏感词审查机制，本项目采用处理 Python 脚本的形式实现敏感词数据的获取和处理。您需要先从 GitHub 下载敏感词仓库，再使用提供的 Python 脚本进行处理。

#### 步骤 1: 克隆敏感词仓库 / Step 1: Clone the Sensitive Word Repository

```bash
git clone https://github.com/konsheng/Sensitive-lexicon.git
```
#### 步骤 2: 使用 Python 脚本处理数据 / Step 2: Process Data with Python Script

项目中提供了 [process.py](file:///Users/wxd2zrx/DevEcoStudioProjects/SensitiveWordBlockingDemo/sensitiveinput/src/main/resources/rawfile/process.py) 脚本，用于将敏感词库中的分类词汇文件处理为本组件所需的 JSON 格式：

```bash
python sensitiveinput/src/main/resources/rawfile/process.py
```
脚本会将敏感词库处理为两个 JSON 文件：
1. `vocabulary.json` - 包含所有敏感词分类及词汇的完整数据
2. `types.json` - 包含所有敏感词分类名称的列表

注意：您需要根据实际的敏感词库路径修改 `process.py` 脚本中的 `vocabulary_folder` 变量。


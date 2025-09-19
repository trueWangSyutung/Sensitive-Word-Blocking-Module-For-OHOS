# 敏感词检测输入框组件

一个专为鸿蒙OS Next研发的敏感词检测输入框组件。A sensitive word detection TextInput component developed specifically for HarmonyOS Next.

[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-0052CC?style=flat-square&logo=harmony&logoColor=white)](https://www.harmonyos.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ 特性 / Features

- 🚀 **实时检测** - 在用户输入时实时检测敏感词
- 🎯 **自动替换** - 自动将敏感词替换为星号(*)显示
- 🛠️ **灵活配置** - 支持自定义提示文本、字体大小等属性
- 🌍 **多类型支持** - 支持多种类型的敏感词检测
- 📱 **HarmonyOS优化** - 专为鸿蒙OS Next设计，完美适配ArkTS
- 🔧 **易于使用** - 简单的API设计，支持链式调用
- 📦 **轻量级** - 无外部依赖，包体积小
- 📏 **自动扩展** - 支持自动扩展大小的多行文本输入框
- 🔄 **多种替换模式** - 支持符号、拼音、自定义字符串等多种替换模式

## 📦 安装 / Installation

在项目中添加依赖：

```json
   {
   "dependencies": {
       "@syutung/sensitiveinput": "@syutung/sensitiveinput:last"
   }
}
```
然后运行：
```bash
ohpm install
```
## 🚀 快速开始 / Quick Start

### 基础用法 / Basic Usage

```typescript
import { SensitiveTextInput, SensitiveWordMode, ReplaceMode } from "sensitiveinput"

SensitiveTextInput({
option:{
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.SYMBOLS, // 敏感词替换模式
placeholderValue: '请输入文本，系统将自动检测敏感词...',
textValue: this.inputText,
multlineValue:false,
autoValue : false, // 当且仅当 multilineValue为true时生效
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
console.log(this.inputText);
},
onFocusFunction: () => {
console.log('输入框获得焦点');
},
onBlurFunction: () => {},
fontSizeValue: 16,
}
}).width('80%')
```
### 多行文本输入框 / Multi-line Text Input

```typescript
import { SensitiveTextInput, SensitiveWordMode, ReplaceMode } from "sensitiveinput"

SensitiveTextInput({
option:{
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.SYMBOLS,
placeholderValue: '请输入文本，系统将自动检测敏感词...',
textValue: this.inputText,
multlineValue:true,
autoValue : true,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
console.log(this.inputText);
},
onFocusFunction: () => {
console.log('输入框获得焦点');
},
onBlurFunction: () => {},
fontSizeValue: 16,
}
}).width('80%')
```
### 文本输入框 / Text Input With Customize sensitive words

```typescript
import { SensitiveTextInput, SensitiveWordMode, ReplaceMode } from "sensitiveinput"
import words from "../../resources/rawfile/words.json"
import types from "../../resources/rawfile/types.json"
// 加载自定义敏感词，放在 rawfile 文件夹中

SensitiveTextInput({
option:{
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.SYMBOLS,
placeholderValue: '请输入文本，系统将自动检测敏感词...',
textValue: this.inputText,
multlineValue:true,
autoValue : true,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
console.log(this.inputText);
},
onFocusFunction: () => {
console.log('输入框获得焦点');
},
onBlurFunction: () => {},
fontSizeValue: 16,
customize: {
types: types,
sensitives: words
}
}
}).width('80%')
```
## 🔧 API 文档 / API Documentation

### SensitiveTextInput 组件

#### 构造函数参数 / Constructor Parameters

```typescript
interface SensitiveCustomize {
types: string[],
sensitives: Vocabulary[],
}

interface SensitiveTextInputOption{
modeValue: SensitiveWordMode        // 敏感词检测模式
replaceMode: ReplaceMode            // 敏感词替换模式
replaceStr?: string                 // 自定义替换字符串（仅在ReplaceMode.CUSTOM时生效）
placeholderValue: string            // 输入框提示文本
textValue: string                   // 输入框初始文本
fontSizeValue: number               // 字体大小
multlineValue: boolean              // 是否为多行文本输入框
warningValue: string                // 警告文本
autoValue?: boolean                 // 是否启用自动扩展大小（仅在multilineValue为true时生效）
onSensitiveChangeCallback: (value: string) => void  // 文本变化回调函数
onFocusFunction?: () => void        // 获得焦点回调函数
onBlurFunction?: () => void         // 失去焦点回调函数
customize?: SensitiveCustomize      // 自定义敏感词配置
}
```
#### 敏感词检测模式 / Sensitive Word Detection Modes
- 只在未启用自定义敏感词的模式下生效

```typescript
enum SensitiveWordMode {
   DEFAULT,  // 默认模式 - 检测暴力、色情、广告等核心敏感词
   MEDIUM,   // 中等模式 - 检测更多类型的敏感词
   STRICT    // 严格模式 - 检测所有类型的敏感词
}
```
各模式对应的敏感词类型：

1. **DEFAULT 模式**:
   - `"gun"` (枪支)
   - `"sex"` (色情)
   - `"ads"` (广告)
   - `"reactionary"` (反动)
   - `"violent"` (暴力)

2. **MEDIUM 模式**:
   - `"livelihood"` (民生)
   - `"gun"` (枪支)
   - `"sex"` (色情)
   - `"ads"` (广告)
   - `"reactionary"` (反动)
   - `"violent"` (暴力)
   - `"policy"` (政策)
   - `"more"` (其他)
   - `"url"` (网址)
   - `"covid"` (疫情)

3. **STRICT 模式**:
   - `"livelihood"` (民生)
   - `"gun"` (枪支)
   - `"sex"` (色情)
   - `"ads"` (广告)
   - `"reactionary"` (反动)
   - `"violent"` (暴力)
   - `"policy"` (政策)
   - `"more"` (其他)
   - `"url"` (网址)
   - `"covid"` (疫情)

#### 敏感词替换模式 / Sensitive Word Replacement Modes

```typescript
enum ReplaceMode {
   SYMBOLS,   // 符号替换模式 - 用符号替换敏感词（默认为*）
   PINYIN,    // 拼音替换模式 - 用拼音替换敏感词
}
```
### 在HarmonyOS应用中使用 / Usage in HarmonyOS App
详情请见 example

## 📝 使用示例 / Usage Examples

### 1. 不同检测模式 / Different Detection Modes

```typescript
// 默认模式 - 适用于一般场景
SensitiveTextInput({
   option: {
      modeValue: SensitiveWordMode.DEFAULT,
      replaceMode: ReplaceMode.SYMBOLS,
      placeholderValue: '默认模式...',
      textValue: this.inputText,
      multlineValue: false,
      autoValue: false,
      warningValue: "发现敏感词",
      onSensitiveChangeCallback: (value: string) => {
      this.inputText = value;
      },
      onFocusFunction: () => {},
      onBlurFunction: () => {},
      fontSizeValue: 16,
   }
}).width('80%')

// 严格模式 - 适用于严格审核场景
SensitiveTextInput({
   option: {
      modeValue: SensitiveWordMode.STRICT,
      replaceMode: ReplaceMode.SYMBOLS,
      placeholderValue: '严格模式...',
      textValue: this.inputText,
      multlineValue: false,
      autoValue: false,
      warningValue: "发现敏感词",
      onSensitiveChangeCallback: (value: string) => {
      this.inputText = value;
      },
      onFocusFunction: () => {},
      onBlurFunction: () => {},
      fontSizeValue: 16,
   }
}).width('80%')
```
### 2. 不同替换模式 / Different Replacement Modes

```typescript
// 符号替换模式（默认）
SensitiveTextInput({
option: {
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.SYMBOLS,
placeholderValue: '符号替换模式...',
textValue: this.inputText,
multlineValue: true,
autoValue: true,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusFunction: () => {},
onBlurFunction: () => {},
fontSizeValue: 16,
}
}).width('80%')

// 拼音替换模式
SensitiveTextInput({
option: {
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.PINYIN,
placeholderValue: '拼音替换模式...',
textValue: this.inputText,
multlineValue: true,
autoValue: true,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusFunction: () => {},
onBlurFunction: () => {},
fontSizeValue: 16,
}
}).width('80%')

// 自定义字符串替换模式
SensitiveTextInput({
option: {
modeValue: SensitiveWordMode.DEFAULT,
replaceMode: ReplaceMode.SYMBOLS,
replaceStr: "(敏感词)",
placeholderValue: '自定义字符串替换模式...',
textValue: this.inputText,
multlineValue: true,
autoValue: true,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusFunction: () => {},
onBlurFunction: () => {},
fontSizeValue: 16,
}
}).width('80%')
```
### 3. 自定义样式 / Custom Styling

```typescript
SensitiveTextInput({
option: {
modeValue: SensitiveWordMode.MEDIUM,
replaceMode: ReplaceMode.SYMBOLS,
placeholderValue: '请输入文本...',
textValue: this.inputText,
multlineValue: false,
autoValue: false,
warningValue: "发现敏感词",
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusFunction: () => {},
onBlurFunction: () => {},
fontSizeValue: 16,
}
})
.width(300)
.height(50)
.fontSize(18)
.border({
width: 2,
color: '#409EFF',
radius: 8
})
```
### 4. 敏感词处理 / Sensitive Word Processing

当用户输入包含敏感词的文本时，组件会自动：
1. 检测到敏感词
2. 根据设置的替换模式替换敏感词
3. 在输入框下方显示敏感词提示

例如：
- 输入：`这是一段包含打人内容的文本`
- 显示（符号替换）：`这是一段包含**内容的文本`
- 显示（拼音替换）：`这是一段包含DR内容的文本`
- 显示（符号替换）：`这是一段包含(敏感词)内容的文本`
- 提示：`发现敏感词: 打人`

## 🧪 敏感词数据 / Sensitive Word Data

本项目使用的敏感词数据来源于 [konsheng/Sensitive-lexicon](https://github.com/konsheng/Sensitive-lexicon) 仓库，包含各类敏感词超过20000个，涵盖以下类型：

### 敏感词类型
- 民生类 (livelihood)
- 枪支类 (gun)
- 色情类 (sex)
- 广告类 (ads)
- 反动类 (reactionary)
- 暴力类 (violent)
- 政策类 (policy)
- 其他类 (more)
- 网址类 (url)
- 疫情类 (covid)

敏感词数据持续更新，确保覆盖最新的敏感内容。

## 🎯 高级配置 / Advanced Configuration

### 自动扩展大小功能 / Auto-expanding Feature

`SensitiveTextInput` 组件支持 `autoValue` 参数来启用自动扩展大小功能：

- 当 `autoValue: true` 且 `multlineValue: true` 时，输入框会根据内容自动调整高度
- 当 `autoValue: false` 或 `multlineValue: false` 时，输入框保持固定高度，内容可滚动

### 自定义敏感词 / Customize sensitive words
`SensitiveTextInput` 组件支持 `customize` 参数来自定义敏感词：
自定义敏感词 通常 位于 [resources/rawfile/*.json](file:///Users/wxd2zrx/DevEcoStudioProjects/SensitiveWordBlockingDemo/entry/src/main/resources/rawfile/types.json) 文件中,
*.json 文件格式为：
```json
[
   {
      "type": "typeName1",
      "words": [
         "word1", "word2", "...", "wordN"
      ]
   },
   {
      "type": "typeName2",
      "words": [
         "word1", "word2", "...", "wordN"
      ]
   }
]
```
同时需要一个 types 文件，用于指定敏感词类型，格式为：
```json
[
"typeName1", "typeName2"
]
```
这个可以直接放在 [resources/rawfile/types.json](file:///Users/wxd2zrx/DevEcoStudioProjects/SensitiveWordBlockingDemo/entry/src/main/resources/rawfile/types.json) 文件中，也可以直接传入 string 数组。

### 多种替换模式 / Multiple Replacement Modes

组件支持三种敏感词替换模式：

1. **符号替换模式 (SYMBOLS)** - 将敏感词替换为指定符号（默认为*）
2. **拼音替换模式 (PINYIN)** - 将敏感词替换为拼音
3. **自定义替换模式 (CUSTOM)** - 将敏感词替换为自定义字符串

## 🤝 贡献 / Contributing

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建特性分支: `git checkout -b feature/AmazingFeature`
3. 提交更改: `git commit -m 'Add some AmazingFeature'`
4. 推送到分支: `git push origin feature/AmazingFeature`
5. 提交 Pull Request

## 📄 许可证 / License

本项目基于 [MIT LICENSE](LICENSE) 开源协议。

敏感词数据来源于 [konsheng/Sensitive-lexicon](https://github.com/konsheng/Sensitive-lexicon)，遵循其相应的许可协议。

## 🔗 相关链接 / Links

- [HarmonyOS 官网](https://www.harmonyos.com/)
- [ArkTS 开发指南](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/arkts-get-started-0000001504769321-V3)
- [TypeScript 官网](https://www.typescriptlang.org/)
- [Sensitive Lexicon 仓库](https://github.com/konsheng/Sensitive-lexicon)

## ⭐ 支持项目 / Support

如果这个项目对您有帮助，请给它一个星标⭐！

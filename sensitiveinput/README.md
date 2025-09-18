```markdown
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
- 🎨 **TypeScript** - 完整的类型支持，开发体验更佳

## 📦 安装 / Installation

在项目中添加依赖：

```
json
{
"dependencies": {
"@syutung/sensitiveinput": "@syutung/sensitiveinput:last"
}
}
```
然后运行：
```
bash
ohpm install
```
## 🚀 快速开始 / Quick Start

### 基础用法 / Basic Usage

```
typescript
import { SensitiveTextInput, SensitiveWordMode } from "sensitiveinput"

@Entry
@Component
struct Example {
@State inputText: string = '';

build() {
Column() {
SensitiveTextInput({
mode: SensitiveWordMode.DEFAULT,
placeholder: '请输入文本...',
text: this.inputText,
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusCallback: () => {
console.log('输入框获得焦点');
},
onBlurCallback: () => {
console.log('输入框失去焦点');
},
fontSize: 16,
})
.width('80%')
.height(40)
}
}
}
```
## 🔧 API 文档 / API Documentation

### SensitiveTextInput 组件

#### 构造函数参数 / Constructor Parameters

```
typescript
interface SensitiveTextInputOption {
mode: SensitiveWordMode;          // 敏感词检测模式
placeholder: string;              // 输入框提示文本
text: string;                     // 输入框初始文本
fontSize: number;                 // 字体大小
onSensitiveChangeCallback: (value: string) => void;  // 文本变化回调函数
onFocusCallback: () => void;      // 获得焦点回调函数
onBlurCallback: () => void;       // 失去焦点回调函数
}
```
#### 敏感词检测模式 / Sensitive Word Detection Modes

```
typescript
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
   - `"other"` (其他)
   - `"covid"` (疫情)
   - `"corruption"` (腐败)

3. **STRICT 模式**:
   - `"livelihood"` (民生)
   - `"tencent"` (腾讯敏感词相关)
   - `"gun"` (枪支)
   - `"sex"` (色情)
   - `"ads"` (广告)
   - `"reactionary"` (反动)
   - `"violent"` (暴力)
   - `"policy"` (政策)
   - `"more"` (其他)
   - `"url"` (网址)
   - `"other"` (其他)
   - `"covid"` (疫情)
   - `"corruption"` (腐败)
   - `"net"` (网易敏感词相关)

#### 链式方法 / Chainable Methods

```
typescript
// 设置宽度
width(value: string | number): SensitiveTextInput

// 设置高度
height(value: string | number): SensitiveTextInput

// 设置字体大小
fontSize(value: number): SensitiveTextInput

// 设置边框
border(options: { width?: number, color?: string, radius?: number }): SensitiveTextInput
```
### 在HarmonyOS应用中使用 / Usage in HarmonyOS App

```
typescript
// 在ArkTS文件中使用
import { SensitiveTextInput, SensitiveWordMode } from "sensitiveinput"

@Entry
@Component
struct HomePage {
@State inputText: string = '';
@State message: string = '敏感词检测输入框演示';

build() {
Column() {
Text(this.message)
.fontSize(24)
.fontWeight(FontWeight.Bold)
.margin({ top: 50, bottom: 30 })

      SensitiveTextInput({
        mode: SensitiveWordMode.STRICT,
        placeholder: '请输入文本，系统将自动检测敏感词...',
        text: this.inputText,
        onSensitiveChangeCallback: (value: string) => {
          this.inputText = value;
          console.log('输入文本:', value);
        },
        onFocusCallback: () => {
          console.log('输入框获得焦点');
        },
        onBlurCallback: () => {
          console.log('输入框失去焦点');
        },
        fontSize: 16,
      })
      .width('80%')
      .height(40)
      .border({ width: 1, color: '#ccc', radius: 4 })
    }
    .height('100%')
    .width('100%')
}
}
```
## 📝 使用示例 / Usage Examples

### 1. 不同检测模式 / Different Detection Modes

```
typescript
// 默认模式 - 适用于一般场景
SensitiveTextInput({
mode: SensitiveWordMode.DEFAULT,
placeholder: '默认模式...',
text: this.inputText,
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusCallback: () => {},
onBlurCallback: () => {},
fontSize: 16,
})

// 严格模式 - 适用于严格审核场景
SensitiveTextInput({
mode: SensitiveWordMode.STRICT,
placeholder: '严格模式...',
text: this.inputText,
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusCallback: () => {},
onBlurCallback: () => {},
fontSize: 16,
})
```
### 2. 自定义样式 / Custom Styling

```
typescript
SensitiveTextInput({
mode: SensitiveWordMode.MEDIUM,
placeholder: '请输入文本...',
text: this.inputText,
onSensitiveChangeCallback: (value: string) => {
this.inputText = value;
},
onFocusCallback: () => {},
onBlurCallback: () => {},
fontSize: 16,
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
### 3. 敏感词处理 / Sensitive Word Processing

当用户输入包含敏感词的文本时，组件会自动：
1. 检测到敏感词
2. 将敏感词替换为星号(*)显示
3. 在输入框下方显示敏感词提示

例如：
- 输入：`这是一段包含打人内容的文本`
- 显示：`这是一段包含**内容的文本`
- 提示：`发现敏感词: 打人`

## 🧪 敏感词数据 / Sensitive Word Data

本项目使用的敏感词数据来源于 [konsheng/Sensitive-lexicon](https://github.com/konsheng/Sensitive-lexicon) 仓库，包含各类敏感词超过20000个，涵盖以下类型：

### 敏感词类型
- 民生类 (livelihood)
- 腾讯敏感词相关 (tencent)
- 枪支类 (gun)
- 色情类 (sex)
- 广告类 (ads)
- 反动类 (reactionary)
- 暴力类 (violent)
- 政策类 (policy)
- 其他类 (more)
- 网址类 (url)
- 其他 (other)
- 疫情类 (covid)
- 腐败类 (corruption)
- 网易敏感词相关 (net)

敏感词数据持续更新，确保覆盖最新的敏感内容。

## 🎯 高级配置 / Advanced Configuration

### 性能优化建议

```
typescript
// 对于复杂页面，建议将敏感词检测组件单独封装
@Component
struct MySensitiveInput {
@State private text: string = '';
@State private mode: SensitiveWordMode = SensitiveWordMode.MEDIUM;

build() {
SensitiveTextInput({
mode: this.mode,
placeholder: '请输入...',
text: this.text,
onSensitiveChangeCallback: (value: string) => {
this.text = value;
},
onFocusCallback: () => {},
onBlurCallback: () => {},
fontSize: 16,
})
}
}
```
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

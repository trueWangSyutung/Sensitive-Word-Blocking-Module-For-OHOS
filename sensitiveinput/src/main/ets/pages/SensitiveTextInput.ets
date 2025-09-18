import { SensitiveWordMode } from '../enmu/type';
import { SensitiveWordChecker } from '../module/SensitiveWordChecker'

interface SensitiveTextInputOption{
  mode: SensitiveWordMode
  placeholder : string,
  text : string,
  fontSize : number,
  onSensitiveChangeCallback : (value: string) => void,
  onFocusCallback : () => void,
  onBlurCallback : () => void
}

@Component
export struct SensitiveTextInput {
  @State private displayText: string = '';
  @State private originalText: string = '';
  @State private hasSensitiveWords: boolean = false;
  @State private isProcessingChange: boolean = false;
  private mode : SensitiveWordMode = SensitiveWordMode.DEFAULT;
  private placeholderValue: string = '';
  private fontSizeValue: number = 16;
  private onSensitiveChangeCallback?: (value: string) => void;
  private onFocusCallback?: () => void;
  private onBlurCallback?: () => void;

  private checker: SensitiveWordChecker | null = null;

  constructor(option : SensitiveTextInputOption) {
    super();
    this.placeholderValue = option.placeholder;
    this.originalText = option.text;
    this.displayText = option.text;

    this.fontSizeValue = option.fontSize;
    this.onSensitiveChangeCallback = option.onSensitiveChangeCallback;
    this.onFocusCallback = option.onFocusCallback;
    this.onBlurCallback = option.onBlurCallback;
    this.mode = option.mode;

  }

  aboutToAppear(): void {
    // 初始化时检查敏感词
    this.checker = new SensitiveWordChecker(this.mode);

    this.checkSensitiveWords(this.originalText);
  }

  /**
   * 检测敏感词
   * @param value 输入文本
   */
  private checkSensitiveWords(value: string): void {
    this.originalText = value;

    if (this.checker) {
      console.log("checkSensitiveWords", value);
      this.hasSensitiveWords = this.checker.checkSensitiveWords(value);
    }

    // 设置显示文本（如果有敏感词则替换为星号）
    if (this.hasSensitiveWords) {
      if (this.checker) {
        this.displayText = this.checker?.replaceSensitiveWords(
          value,
          '*'
        );
      } else {
        this.displayText = "*" . repeat(
          value.length
        );
      }

    } else {
      this.displayText = value;
    }

    // 触发onChange回调
    if (this.onSensitiveChangeCallback) {
      this.onSensitiveChangeCallback(this.originalText);
    }
  }

  build() {
    Column() {
      TextInput({
        placeholder: this.placeholderValue,
        text: this.displayText
      })
        .width('100%')
        .height('100%')
        .fontSize(this.fontSizeValue)
        .onChange((value: string) => {
          // 避免因替换显示文本而触发的重复处理
          if (value !== this.displayText && !this.isProcessingChange) {
            this.isProcessingChange = true;
            this.checkSensitiveWords(value);
            // 使用setTimeout确保状态更新完成后再重置标志
            setTimeout(() => {
              this.isProcessingChange = false;
            }, 0);
          }
        })
        .onFocus(() => {
          if (this.onFocusCallback) {
            this.onFocusCallback();
          }
        })
        .onBlur(() => {
          if (this.onBlurCallback) {
            this.onBlurCallback();
          }
        })

      if (this.hasSensitiveWords) {
        Row() {
          Text(`发现敏感词！已经替换`)
            .fontSize(12)
            .fontColor('#ff0000')
            .margin({ right: 5 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .padding({ top: 3 })
      }
    }
  }
}

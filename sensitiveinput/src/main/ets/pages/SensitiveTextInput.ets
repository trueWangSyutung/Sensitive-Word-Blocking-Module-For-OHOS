import { ReplaceMode, SensitiveWordMode } from '../enmu/type';
import { SensitiveWordChecker, Vocabulary } from '../module/SensitiveWordChecker'
interface SensitiveCustomize {
  types : string[] ,
  sensitives : Vocabulary[],
}
interface SensitiveTextInputOption{
  modeValue: SensitiveWordMode,
  replaceMode:ReplaceMode,
  replaceStr ?: string,
  placeholderValue : string,
  textValue : string,
  fontSizeValue : number,
  multlineValue : boolean,
  warningValue: string,
  autoValue ?:boolean,
  onSensitiveChangeCallback : (value: string) => void,
  onFocusFunction ?: () => void,
  onBlurFunction ?: () => void,
  customize ?: SensitiveCustomize ,
}

@Component
export struct SensitiveTextInput {
  @State private displayText: string | null =  null;
  @State private originalText: string | null =  null;
  @State private hasSensitiveWords: boolean = false;
  @State private isProcessingChange: boolean = false;
  @State private auto: boolean = false;
  @State private multiline: boolean = false;
  @State private warning : string = '存在敏感词！';
  @State private replaceModel : ReplaceMode = ReplaceMode.SYMBOLS;
  @State private replaceStr: string = '*';
  @State  public  option : SensitiveTextInputOption = {
    modeValue: SensitiveWordMode.DEFAULT,
    placeholderValue: '',
    replaceMode: ReplaceMode.SYMBOLS,
    replaceStr: '*',
    textValue: '',
    fontSizeValue: 16,
    multlineValue: false,
    warningValue: '存在敏感词！',
    autoValue: false,
    onSensitiveChangeCallback: (value: string) => {
    },
    onFocusFunction: () => {
    },
    onBlurFunction: () => {
    },
  };



  private mode : SensitiveWordMode = SensitiveWordMode.DEFAULT;
  private placeholderStr: string = '';
  private fontSizeNum: number = 16;
  private onChangeCallback?: (value: string) => void;

  private onFocusCallback?: () => void;
  private onBlurCallback?: () => void;

  private checker: SensitiveWordChecker | null = null;

  constructor() {
    super();
  }
  initUI(){
    console.log("SensitiveTextInput initUI", JSON.stringify(this.option));

    this.placeholderStr = this.option.placeholderValue;
    this.originalText = this.option.textValue;
    this.displayText = this.option.textValue;
    if (this.option.autoValue) {
      this.auto = this.option.autoValue;
    }
    this.fontSizeNum = this.option.fontSizeValue;
    this.onChangeCallback = this.option.onSensitiveChangeCallback;
    this.onFocusCallback = this.option.onFocusFunction;
    this.onBlurCallback = this.option.onBlurFunction;
    this.mode = this.option.modeValue;

    this.multiline = this.option.multlineValue;
    this.warning = this.option.warningValue;

    this.replaceModel = this.option.replaceMode;
    if (this.option.replaceStr){
      this.replaceStr = this.option.replaceStr;
    }

    // 检查敏感词
    if (this.option.customize){
      if (this.checker){
        this.checker.loadVocabularyByPath(this.option.customize.sensitives)
        this.checker.loadTypesByPath(this.option.customize.types)
      }
    }

  }


  aboutToAppear(): void {
    // 初始化时检查敏感词
    this.checker = new SensitiveWordChecker(this.mode);
    this.initUI()
    if (this.originalText) {
      this.checkSensitiveWords(this.originalText);
    }

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
        let res = this.checker?.replaceSensitiveWords(
          value,
          this.replaceStr,
          this.replaceModel
        );
        this.displayText = res.content;

      } else {
        this.displayText = "*" . repeat(
          value.length
        );
      }

    } else {
      this.displayText = value;
    }

    // 触发onChange回调
    if (this.onChangeCallback) {
      this.onChangeCallback(this.originalText);
    }
  }



  build() {
    Column() {
      if (this.multiline) {
        if (this.auto) {
          TextArea({
            placeholder: this.placeholderStr,
            text: this.displayText
          })
            .width('100%')
            .textOverflow(TextOverflow.Clip)
            .fontSize(this.fontSizeNum)
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
            }).onCopy( (value: string) => {
            return this.displayText;
          }).onCut( (value: string) => {
            return this.displayText;
          })
            .onBlur(() => {
              if (this.onBlurCallback) {
                this.onBlurCallback();
              }
            })
        }
        else{
          TextArea({
            placeholder: this.placeholderStr,
            text: this.displayText
          })
            .width('100%')
            .textOverflow(TextOverflow.Clip)
            .fontSize(this.fontSizeNum)
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
            }).onCopy( (value: string) => {
            return this.displayText;
          }).onCut( (value: string) => {
            return this.displayText;
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
            }).height('100%')
        }
      }else{
        TextInput({
          placeholder: this.placeholderStr,
          text: this.displayText
        })
          .width('100%')
          .textOverflow(TextOverflow.Clip)
          .fontSize(this.fontSizeNum)
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
          }).onCopy( (value: string) => {
            return this.displayText;
        }).onCut( (value: string) => {
          return this.displayText;
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
      }

      if (this.hasSensitiveWords) {
        Row() {
          Text(this.warning)
            .fontSize(12)
            .fontColor('#ff0000')
            .margin({ right: 5 })
        }
        .width('100%').height('auto')
        .justifyContent(FlexAlign.Start)
        .padding({ top: 3 , bottom: 10})
      }
    }.width('100%')
    .justifyContent(FlexAlign.Start)

  }
}

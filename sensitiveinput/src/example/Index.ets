import { SensitiveTextInput, SensitiveWordMode} from "@syutung/sensitiveinput"
import words from "../../resources/rawfile/words.json"
import types from "../../resources/rawfile/types.json"

@Entry
@Component
struct Index {
  @State message: string = '敏感词检测输入框演示';
  @State inputText: string = '';

  build() {
    RelativeContainer() {
      Column(){
        Text(this.message)
          .id('title')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .margin({ top: 50 })
          .onClick(() => {
            this.message = 'Welcome';
          })

        Text('单行文本输入框')
        SensitiveTextInput({
          option:{
            modeValue: SensitiveWordMode.DEFAULT,
            placeholderValue: '请输入文本，系统将自动检测敏感词...',
            textValue: this.inputText,
            multlineValue:false,
            autoValue : false,
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

        Text('多行文本输入框')
        SensitiveTextInput({
          option:{
            modeValue: SensitiveWordMode.DEFAULT,
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

        Text('多行文本输入框·自定义敏感词')
        SensitiveTextInput({
          option:{
            modeValue: SensitiveWordMode.DEFAULT,
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
            customize:{
              types:types,
              sensitives:words
            }
          }
        }).width('80%')


      }.height('100%')
      .width('100%')

    }
    .height('100%')
    .width('100%')
  }
}


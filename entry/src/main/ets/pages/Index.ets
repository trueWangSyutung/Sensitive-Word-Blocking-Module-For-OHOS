import {SensitiveTextInput, SensitiveWordMode} from "@syutung/sensitiveinput"

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

      // 共产党是家人
        SensitiveTextInput({
          mode: SensitiveWordMode.DEFAULT,
          placeholder: '请输入文本，系统将自动检测敏感词...',
          text: this.inputText,
          onSensitiveChangeCallback: (value: string) => {
            this.inputText = value;
            console.log(this.inputText);

          },
          onFocusCallback: () => {
            console.log('输入框获得焦点');
          },
          onBlurCallback: () => {},
          fontSize: 16,
        }).width('80%').height(40)




      }.height('100%')
      .width('100%')

    }
    .height('100%')
    .width('100%')
  }
}


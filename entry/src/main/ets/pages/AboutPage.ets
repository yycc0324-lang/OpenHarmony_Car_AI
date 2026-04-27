import router from '@ohos.router'

@Entry
@Component
struct AboutPage {
  build() {

    Column() {
      Image($r('app.media.login_backgroundbage'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .zIndex(-1)

      Text('关于我们')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin(20)

      Text('版本：v1.0.0')
        .fontSize(16)
        .margin(10)

      Text('版权所有 © 2025 SIAS University')
        .fontSize(14)
        .margin(10)
        .fontColor(Color.Gray)

      // ✅ 返回按钮
      Button('返回')
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#1677ff')
        .margin({ top: 40 })
        .padding(12)
        .width('100%')
        .onClick(() => router.back())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
  }
}



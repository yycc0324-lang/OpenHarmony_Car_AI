import router from '@ohos.router'

@Entry
@Component
struct SecurityPage {
  build() {
    Column() {
      // ✅ 顶部黑体居中标题
      Text('账户与安全')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      // 内容卡片
      Column() {
        // ✅ 修改后的绑定信息区域
        Text('账号绑定信息')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 15, bottom: 5, left: 20 })

        Text('已绑定车辆信息')
          .fontSize(14)
          .margin({ bottom: 20, left: 20 })

        Divider().height(1).backgroundColor('#e0e0e0').margin({ left: 20, right: 20 })

        Text('数据安全等级')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 5, left: 20 })

        Text('车辆级别安全加密已开启')
          .fontSize(14)
          .fontColor(Color.Green)
          .margin({ bottom: 20, left: 20 })

        Divider().height(1).backgroundColor('#e0e0e0').margin({ left: 20, right: 20 })

        Text('账号保护建议')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 5, left: 20 })

        Text('建议定期修改密码，确保个人信息安全。')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ bottom: 20, left: 20 })

        Text('本应用符合国家车载数据保护标准')
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 10, bottom: 10, left: 20 })
      }
      .backgroundColor(Color.White)
      .borderRadius(10)
      .margin({ left: 15, right: 15, top: 20 })
      .shadow({ radius: 2, offsetX: 0, offsetY: 2, color: '#bbbbbb' })

      // ✅ 底部返回按钮
      Button('返回')
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#1677ff')
        .padding(12)
        .margin({ top: 30 })
        .width('100%')
        .onClick(() => router.back())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f2f2f2')
  }
}





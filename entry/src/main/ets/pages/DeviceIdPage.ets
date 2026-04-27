import router from '@ohos.router'
import { model } from '../globalState' // ✅ 从共享实例中导入
import DeviceBean from '../common/bean/DeviceBean'

@Entry
@Component
struct DeviceIdPage {
  private deviceBean: DeviceBean = new DeviceBean(0, '', 0, 0, 0)
  private timerId: number = -1

  aboutToAppear() {
    this.updateData()
    this.timerId = setInterval(() => {this.updateData()}, 3000)
  }

  aboutToDisappear() {
    if (this.timerId !== -1) clearInterval(this.timerId)
  }

  updateData() {
    this.deviceBean = model.getDeviceData(1) // ✅ 使用共享实例 model
  }

  build() {
    Column() {
      Text('设备ID')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Blue)
        .margin(20)

      Text(`${this.deviceBean.deviceId}`)
        .fontSize(22)
        .margin({ top: 20, bottom: 30 })

      Button('返回')
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#1677ff')
        .margin({ top: 20 })
        .padding(12)
        .width('80%')
        .onClick(() => router.back())
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#f5f7fa')
  }
}

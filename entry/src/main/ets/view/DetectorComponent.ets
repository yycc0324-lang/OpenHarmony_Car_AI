import router from '@system.router'
import DeviceBean from '../common/bean/DeviceBean'
import { model } from '../globalState'
import prompt from '@system.prompt'
@Entry
@Component
export default struct DetectorComponent {
  @State deviceBean: DeviceBean = new DeviceBean(1, 'Jerry设备', 64, 98, 36.5)
  @State connectionStatus: string = 'connecting' // 'connecting' or 'connected'
  private timerId: number = 0
  private connectionTimerId: number = 0

  build() {
    Column() {
      // 背景图 - 强制拉伸填充全屏
      Image($r('app.media.background'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)
        .position({ top: 0, left: 2 })
        .zIndex(-1)


      }
    }

}




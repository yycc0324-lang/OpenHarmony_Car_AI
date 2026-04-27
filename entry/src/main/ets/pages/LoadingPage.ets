import router from '@ohos.router'

@Entry
@Component
struct LoadingPage {
  videoController: VideoController | undefined
  @State private progressVal: number = 0
  private timerId: number = -1

  aboutToAppear() {
    this.timerId = setInterval(() => {
      this.progressVal = Math.min(this.progressVal + 4, 100)
      if (this.progressVal === 100) {
        clearInterval(this.timerId)
        router.replaceUrl({ url: 'pages/MainPage' })
      }
    }, 120)
  }

  aboutToDisappear() {
    if (this.timerId !== -1) clearInterval(this.timerId)
  }

  build() {
    Stack() {
      Video({
        src: $rawfile('demo.mp4'),
        controller: this.videoController
      })
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .autoPlay(true)
        .loop(true)
        .muted(true)
        .controls(false)
        .onStart(() => {
          console.info('视频开始播放');
        })
        .onError(() => {
          console.error('视频播放失败');
        });

      Column() {
        Image($r('app.media.car_logo'))
          .width(120).height(120)
          .objectFit(ImageFit.Contain)

        Text('智能座舱健康监测系统')
          .fontSize(28).fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ top: 16 })

        Progress({ value: this.progressVal, total: 100, type: ProgressType.Linear })
          .width('60%').height(10)
          .color('#00d1ff')
          .backgroundColor('rgba(255,255,255,0.2)')
          .margin({ top: 40 })

        Text(`正在加载 ${this.progressVal}%`)
          .fontSize(20).fontColor('#cfd6e6')
          .margin({ top: 12 })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%').height('100%')
    }
  }
}

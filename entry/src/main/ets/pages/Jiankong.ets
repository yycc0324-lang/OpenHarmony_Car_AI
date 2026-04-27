// MainAbility/pages/Index.ets
@Entry
@Component
struct Index {
  // 创建 WebController 用于控制 Web 组件（可选）
  webController: WebController = new WebController();
  build() {
    Column() {
      // Web 组件用于加载网页
      Web({ src: 'http://192.168.179.192/', controller: this.webController })
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
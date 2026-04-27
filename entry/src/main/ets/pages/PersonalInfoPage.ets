import router from '@system.router'
import preferences from '@ohos.data.preferences'
@Entry
@Component
export default struct MineComponent {
  @State avatarName: string = 'touxiang1'   // 默认头像
  @State username: string = 'Jerry'         // 默认用户名

  // 页面首次加载时读取头像和用户名
  async aboutToAppear() {
    await this.loadUserInfo()
  }

  // 页面返回时也刷新头像和用户名
  async onPageShow() {
    await this.loadUserInfo()
  }

  // 读取头像与用户名
  private async loadUserInfo() {
    const ctx = getContext(this)
    const store = await preferences.getPreferences(ctx, 'users')

    const savedAvatar = await store.get('avatar', '') as string
    if (savedAvatar) {
      this.avatarName = savedAvatar
    }

    const savedUsername = await store.get('lastLoginUsername', '') as string
    if (savedUsername) {
      this.username = savedUsername
    }
  }

  // 映射头像名到资源
  getAvatarResource(name: string): Resource {
    switch (name) {
      case 'touxiang1': return $r('app.media.touxiang1')
      case 'touxiang2': return $r('app.media.touxiang2')
      case 'touxiang3': return $r('app.media.touxiang3')
      case 'touxiang4': return $r('app.media.touxiang4')
      default: return $r('app.media.touxiang1')
    }
  }

  build() {
    Column() {
      // 显示头像 + 点击跳转选择页
      Image(this.getAvatarResource(this.avatarName))
        .width(120)
        .height(120)
        .borderRadius(60)
        .objectFit(ImageFit.Cover)
        .margin({ bottom: 24 })
        .onClick(() => {
          router.push({ uri: 'pages/AvatarPickerPage' })
        })

      // 显示用户名（同步登录名）
      Text(this.username)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 6 })

      Text('身体是革命的本钱！')
        .fontSize(14)
        .margin({ bottom: 20 })

      // 菜单按钮区
      Button('个人资料')
        .width('70%')
        .margin({ bottom: 10 })
        .onClick(() => router.push({ uri: 'pages/PersonalInfoPage' }))

      Button('我的报告')
        .width('70%')
        .margin({ bottom: 10 })
        .onClick(() => router.push({ uri: 'pages/ReportPage' }))

      Button('账户与安全')
        .width('70%')
        .margin({ bottom: 10 })
        .onClick(() => router.push({ uri: 'pages/SecurityPage' }))

      Button('检查更新')
        .width('70%')
        .margin({ bottom: 10 })
        .onClick(() => router.push({ uri: 'pages/UpdatePage' }))

      Button('关于')
        .width('70%')
        .margin({ bottom: 10 })
        .onClick(() => router.push({ uri: 'pages/AboutPage' }))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 30 })
  }
}

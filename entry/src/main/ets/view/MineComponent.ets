import router from '@system.router'
import preferences from '@ohos.data.preferences'

@Entry
@Component
export default struct MineComponent {
  @State avatarName: string = 'touxiang1'  //
  @State username: string = ''

  async aboutToAppear() {
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

  async onPageShow() {
    this.aboutToAppear()
  }

  getAvatarResource(name: string): Resource {
    switch (name) {
      case 'touxiang1': return $r('app.media.touxiang1')
      case 'touxiang2': return $r('app.media.touxiang2')
      case 'touxiang3': return $r('app.media.touxiang3')
      case 'touxiang4': return $r('app.media.touxiang4')
      default: return $r('app.media.touxiang1')
    }
  }


  private funcData: Array<FunctionGroup> = [
    {
      title: '核心服务',
      items: [
        { icon: 'app.media.zhaq', label: '账号安全', page: 'pages/SecurityPage' },
        { icon: 'app.media.rjgx', label: '软件更新', page: 'pages/UpdatePage' },
        { icon: 'app.media.fhzy', label: '返回主页', page: 'pages/MainPage' },
        { icon: 'app.media.tuihuizhuye', label: '退出登录', page: 'pages/Index' },

      ]
    }
  ]

  @Builder
  UserHeader() {
    Row() {
      Image($r(`app.media.${this.avatarName}`))
        .width(60)
        .height(60)
        .borderRadius(40)
        .border({ width: 2, color: 0xFFFFFFFF })
        .shadow({ radius: 8, color: 0x40000000 })
        .onClick(() => {
          router.push({ uri: 'pages/AvatarPickerPage' })
        })

      Column() {
        Text("欢迎 " + this.username)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 10, top: 10 })
      }
    }
    .width('100%')
    .padding({ top: 10, left: 20 })
    .backgroundColor('#ADD8E6')
  }

  @Builder
  ServiceList(group: FunctionGroup) {
    Column() {
      Text(group.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 16, bottom: 8 })

      Column() {
        ForEach(group.items, (item: FunctionItem) => {
          Row() {
            Image($r(item.icon))
              .width(40)
              .height(40)
              .margin({ right: 16 })
            Text(item.label)
              .fontSize(16)
              .fontColor(0x333333)
              .width('80%')
            Image($r('app.media.right'))
              .width(16)
              .height(16)
              .margin({ left: 8 })
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor(0xFFFFFFFF)
          .onClick(() => {
            console.info("跳转页面:", item.page)
            router.push({ uri: item.page })
          })
        })
      }
      .backgroundColor(0xFFFFFFFF)
      .borderRadius(12)
    }
    .width('100%')
    .margin({ bottom: 16 })
  }

  build() {
    Column() {
      this.UserHeader()

      Scroll() {
        Column() {
          this.ServiceList(this.funcData[0])
        }
        .padding(16)
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xF5F7FA)
  }
}

interface FunctionItem {
  icon: string
  label: string
  page: string
}

interface FunctionGroup {
  title: string
  items: FunctionItem[]
}
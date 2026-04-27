import router from '@system.router'
import preferences from '@ohos.data.preferences'

@Entry
@Component
struct AvatarPickerPage {
  avatarList: string[] = ['touxiang1', 'touxiang2', 'touxiang3', 'touxiang4']

  getAvatarResource(name: string): Resource {
    switch (name) {
      case 'touxiang1': return $r('app.media.touxiang1')
      case 'touxiang2': return $r('app.media.touxiang2')
      case 'touxiang3': return $r('app.media.touxiang3')
      case 'touxiang4': return $r('app.media.touxiang4')
      default: return $r('app.media.touxiang1')
    }
  }

  async saveAvatar(name: string) {
    const ctx = getContext(this)
    const store = await preferences.getPreferences(ctx, 'users')
    await store.put('avatar', name)
    await store.flush()
  }

  build() {
    Column() {
      Text('选择头像')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30, bottom: 20 })

      // ✅ 用 Flex 模拟两列头像布局
      ForEach(this.chunkArray(this.avatarList, 2), (row: string[], rowIndex: number) => {
        Flex({ justifyContent: FlexAlign.SpaceEvenly }) {
          ForEach(row, (item: string) => {
            Column() {
              Image(this.getAvatarResource(item))
                .width(100)
                .height(100)
                .borderRadius(50)
                .objectFit(ImageFit.Cover)
                .onClick(async () => {
                  await this.saveAvatar(item)
                  router.back()
                })

              Text(item)
                .fontSize(14)
                .margin({ top: 8 })
            }.alignItems(HorizontalAlign.Center)
          })
        }.margin({ bottom: 20 })
      })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 20 })
    .alignItems(HorizontalAlign.Center)
  }

  private chunkArray(arr: string[], size: number): string[][] {
    const result: string[][] = []
    for (let i = 0; i < arr.length; i += size) {
      result.push(arr.slice(i, i + size))
    }
    return result
  }
}

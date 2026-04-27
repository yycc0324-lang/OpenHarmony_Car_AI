import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import preferences from '@ohos.data.preferences';

@Entry
@Component
struct Index {
  @State mercedesId: string = '';
  @State password: string = '';
  @State errorMsg: string = '';
  @State agreeTerms: boolean = false;
  @State pageOpacity: number = 0;
  @State titleScale: number = 0.8;
  @State idFocused: boolean = false;
  @State passwordFocused: boolean = false;
  @State continueBtnPressed: boolean = false;

  private videoController: VideoController = new VideoController();

  private userDatabase: Record<string, string> = {};

  async aboutToAppear() {
    const ctx = getContext(this);
    const store = await preferences.getPreferences(ctx, 'users');
    const raw = await store.get('userDatabase', '{}') as string;
    try {
      this.userDatabase = JSON.parse(raw);
    } catch (_) {
      this.userDatabase = {};
    }

    animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
      this.pageOpacity = 1;
      this.titleScale = 1;
    });
  }

  async saveUserMap() {
    const ctx = getContext(this);
    const store = await preferences.getPreferences(ctx, 'users');
    await store.put('userDatabase', JSON.stringify(this.userDatabase));
    await store.flush();
  }

  build() {
    Stack() {
      // 背景视频
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

      // 深色半透明遮罩层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(10, 10, 10, 0.6)');

      Column() {
        // 顶部品牌标题区域
        Column({ space: 12 }) {
          Image($r('app.media.Benz'))
            .width('70%')
            .objectFit(ImageFit.Contain)

            .scale({ x: this.titleScale, y: this.titleScale })
            .animation({
              duration: 800,
              curve: Curve.Friction,
              playMode: PlayMode.Normal
            });

          Text('现在登录或注册')
            .fontSize(16)
            .fontWeight(300)
            .fontColor('#A0A0A0')
            .textAlign(TextAlign.Center)
            .margin({ top: 8 });
        }
        .width('100%')
        .margin({ top: 50 });

        Blank();

        // 底部输入区域
        Column({ space: 12 }) {
          // Mercedes me ID 输入框
          Column({ space: 6 }) {
            Text('Mercedes me ID')
              .fontSize(14)
              .fontWeight(400)
              .fontColor('#A0A0A0')
              .width('88%')
              .textAlign(TextAlign.Start);

            TextInput({
              placeholder: '请输入您的 Mercedes me ID',
              text: this.mercedesId
            })
              .width('88%')
              .height(52)
              .backgroundColor('rgba(31, 31, 31, 0.85)')
              .borderRadius(8)
              .fontSize(16)
              .fontColor('#FFFFFF')
              .placeholderColor('#505050')
              .padding({ left: 16, right: 16 })
              .border({
                width: this.idFocused ? 1.5 : 1,
                color: this.idFocused ? '#00ADEF' : '#2A2A2A'
              })
              .backdropBlur(10)
              .animation({ duration: 300, curve: Curve.EaseInOut })
              .onFocus(() => {
                animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
                  this.idFocused = true;
                });
              })
              .onBlur(() => {
                animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
                  this.idFocused = false;
                });
              })
              .onChange((value: string) => {
                this.mercedesId = value;
              });
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center);

          // Mercedes me Password 输入框
          Column({ space: 6 }) {
            Text('Mercedes me Password')
              .fontSize(14)
              .fontWeight(400)
              .fontColor('#A0A0A0')
              .width('88%')
              .textAlign(TextAlign.Start);

            TextInput({
              placeholder: '请输入您的密码',
              text: this.password
            })
              .width('88%')
              .height(52)
              .backgroundColor('rgba(31, 31, 31, 0.85)')
              .borderRadius(8)
              .fontSize(16)
              .fontColor('#FFFFFF')
              .placeholderColor('#505050')
              .type(InputType.Password)
              .padding({ left: 16, right: 16 })
              .border({
                width: this.passwordFocused ? 1.5 : 1,
                color: this.passwordFocused ? '#00ADEF' : '#2A2A2A'
              })
              .backdropBlur(10)
              .animation({ duration: 300, curve: Curve.EaseInOut })
              .onFocus(() => {
                animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
                  this.passwordFocused = true;
                });
              })
              .onBlur(() => {
                animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
                  this.passwordFocused = false;
                });
              })
              .onChange((value: string) => {
                this.password = value;
              });
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center);

          // 错误提示
          if (this.errorMsg !== '') {
            Text(this.errorMsg)
              .fontSize(13)
              .fontColor('#FF4444')
              .width('88%')
              .textAlign(TextAlign.Start)
              .padding({ left: 4 });
          }

          // 复选框 - EULA 条款
          Row({ space: 10 }) {
            Checkbox()
              .select(this.agreeTerms)
              .onChange((val: boolean) => {
                this.agreeTerms = val;
              })
              .selectedColor('#00ADEF')
              .scale({ x: 0.85, y: 0.85 });

            Text('我通过点击确认,接受梅赛德斯-奔驰应用最终用户许可协议 (EULA)。我已知悉数据保护注意事项。')
              .fontSize(12)
              .fontColor('#808080')
              .lineHeight(18)
              .maxLines(3)
              .layoutWeight(1);
          }
          .width('88%')
          .alignItems(VerticalAlign.Top)
          .margin({ top: 4 });

          // 继续按钮
          Button('继续')
            .width('88%')
            .height(52)
            .fontSize(16)
            .fontWeight(500)
            .fontColor('#000000')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ top: 12 })
            .scale({
              x: this.continueBtnPressed ? 0.97 : 1,
              y: this.continueBtnPressed ? 0.97 : 1
            })
            .animation({ duration: 200, curve: Curve.EaseOut })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Down) {
                animateTo({ duration: 100, curve: Curve.Sharp }, () => {
                  this.continueBtnPressed = true;
                });
              } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
                animateTo({ duration: 200, curve: Curve.Friction }, () => {
                  this.continueBtnPressed = false;
                });
              }
            })
            .onClick(async () => {
              if (!this.agreeTerms) {
                this.errorMsg = '请先勾选同意条款';
                return;
              }

              if (this.mercedesId.trim() === '' || this.password.trim() === '') {
                this.errorMsg = 'Mercedes me ID 和密码不能为空';
                return;
              }

              // 检查是否为注册（用户不存在）或登录
              const saved = this.userDatabase[this.mercedesId];

              if (!saved) {
                // 注册新用户
                if (this.password.length < 6 || this.password.length > 20) {
                  this.errorMsg = '密码长度需在6-20位之间';
                  return;
                }
                this.userDatabase[this.mercedesId] = this.password;
                await this.saveUserMap();
                this.errorMsg = '';
                promptAction.showToast({ message: '注册成功，正在登录...' });

                const ctx = getContext(this);
                const store = await preferences.getPreferences(ctx, 'users');
                await store.put('lastLoginUsername', this.mercedesId);
                await store.flush();

                router.pushUrl({ url: 'pages/LoadingPage' });
              } else {
                // 登录现有用户
                if (saved !== this.password) {
                  this.errorMsg = 'Mercedes me ID 或密码错误';
                  return;
                }
                this.errorMsg = '';

                const ctx = getContext(this);
                const store = await preferences.getPreferences(ctx, 'users');
                await store.put('lastLoginUsername', this.mercedesId);
                await store.flush();

                promptAction.showToast({ message: '登录成功' });
                router.pushUrl({ url: 'pages/LoadingPage' });
              }
            });

          // 法律信息链接
          Text('法律信息')
            .fontSize(13)
            .fontWeight(400)
            .fontColor('#00ADEF')
            .textAlign(TextAlign.Center)
            .margin({ top: 20, bottom: 40 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/AgreementPage' });
            });
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center);
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .opacity(this.pageOpacity)
      .animation({ duration: 800, curve: Curve.EaseOut });
    }
    .width('100%')
    .height('100%');
  }
}

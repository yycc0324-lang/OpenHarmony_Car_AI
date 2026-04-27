import { DeepSeekService, ChatMessage } from '../common/DeepSeekService'
import axios, { AxiosRequestConfig, AxiosError } from '@ohos/axios'
import getToken from "../model/getToken"
import ApiData from "../model/DeviceData"
import { promptAction } from '@kit.ArkUI'

let Token: string = ""
let timestamp: number = new Date().getTime();
let now = Date.now();

function formatTime(timestamp: number): string {
  let date = new Date(timestamp);
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}:${String(date.getSeconds()).padStart(2, '0')}`;
}


async function switchLight(on: boolean): Promise<void> {
  const projectId = '8d9fa8e28d8847398364bdd2a49bfb84';
  const deviceId = '68515a5032771f177b430acd_nnssb';
  const endpoint = '591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com';
  const url = `https://${endpoint}/v5/iot/${projectId}/devices/${deviceId}/commands`;

  // ✅ 显式标注类型
  const body: DeviceCommandBody = {
    service_id: 'smart_cart',
    command_name: 'light_control',
    paras: { onoff: on ? 'ON' : 'OFF' }
  };

  const cfg: AxiosRequestConfig = {
    headers: {
      'Content-Type': 'application/json',
      'X-Auth-Token': Token,
    }
  };

  try {
    await axios.post(url, body, cfg);
    promptAction.showToast({ message: on ? '灯光已开启' : '灯光已关闭', duration: 1500 });
  } catch (err) {
    console.error('switchLight error', JSON.stringify(err));
    promptAction.showToast({ message: '控制失败，请重试', duration: 1500 });
  }
}
 async function switchMotor(on: boolean): Promise<void> {
  const projectId = '8d9fa8e28d8847398364bdd2a49bfb84';
  const deviceId = '68515a5032771f177b430acd_nnssb';
  const endpoint = '591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com';
  const url = `https://${endpoint}/v5/iot/${projectId}/devices/${deviceId}/commands`;
  const body: GeneratedObjectLiteralInterface_2 = {
    service_id: 'smart_cart',
    command_name: 'motor_control',
    paras: ({ onoff: on ? 'ON' : 'OFF' })
  };

  const cfg: AxiosRequestConfig = {
    headers: {
      'Content-Type': 'application/json',
      'X-Auth-Token': Token,

    }
  };

   try {
     await axios.post(url, body, cfg);
     promptAction.showToast({ message: on ? '灯光已开启' : '灯光已关闭', duration: 1500 });
   } catch (err) {
     console.error('switchLight error', JSON.stringify(err));
     promptAction.showToast({ message: '控制失败，请重试', duration: 1500 });
   }

}
// 设备控制命令的通用参数
interface DeviceCommandParas {
  onoff: string;
}

// 完整的设备控制命令体
interface DeviceCommandBody {
  service_id: string;
  command_name: string;
  paras: DeviceCommandParas;
}
interface GeneratedObjectLiteralInterface_2{
  service_id: string;
  command_name: string;
  paras: DeviceCommandParas;
}

@Entry
@Component
export struct AIComponent {
  @State inputText: string = ''
  @State thinkingText: string = ''
  @State outputText: string = '等待提问...'
  @State displayText: string = ''

  @State illumination: string = "--"
  @State temperature: string = "--"
  @State humidity: string = "--"

  private deepSeek: DeepSeekService = new DeepSeekService('sk-b44d494756a446f89d58b7bb441e9bdb')
  private timerId: number = -1

  GetHeart(Token: string) {
    const project_id = "8d9fa8e28d8847398364bdd2a49bfb84"
    const deviceid = "68515a5032771f177b430acd_nnssb"
    const endpoint = "591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com"
    const config: AxiosRequestConfig = {
      headers: {
        "Content-Type": "application/json",
        "Instance-Id": "8923986f-8463-4910-bf2d-4bbadba4b06c",
        "X-Auth-Token": Token
      }
    };
    axios.get(`https://${endpoint}/v5/iot/${project_id}/devices/${deviceid}/shadow`, config)
      .then((res: ApiData) => {
        this.illumination = res.data.shadow[0].reported.properties.illumination ?? "--"
        this.temperature = res.data.shadow[0].reported.properties.temperature ?? "--"
        this.humidity = res.data.shadow[0].reported.properties.humidity ?? "--"
      })
      .catch((error: AxiosError) => {
        console.error("获取设备数据失败:", JSON.stringify(error.response))
      })
  }

  async aboutToAppear() {
    Token = await getToken()
    this.GetHeart(Token)
    this.timerId = setInterval(async () => {
      Token = await getToken()
      this.GetHeart(Token)
    }, 2000)
  }

  aboutToDisappear() {
    if (this.timerId !== -1) clearInterval(this.timerId)
  }


  async findKeyWord(text: string) {
    if (!text.trim()) {
      this.outputText = '请输入您的问题。'
      this.displayText = ''
      await this.animateText(this.outputText)
      return
    }


    this.inputText = ''

    const lowerText = text.toLowerCase()
    let isControl = false
    let replyMessage = ''
    let controlTask: Promise<void> | null = null


    if (lowerText.includes('开灯') || lowerText.includes('打开灯') || lowerText.includes('开 灯')) {
      isControl = true
      replyMessage = '已为您开启灯光。'
      controlTask = switchLight(true)
    } else if (lowerText.includes('关灯') || lowerText.includes('关闭灯') || lowerText.includes('关 灯')) {
      isControl = true
      replyMessage = '已为您关闭灯光。'
      controlTask = switchLight(false)
    } else if (lowerText.includes('打开风扇') || lowerText.includes('开风扇') || lowerText.includes('启动风扇')) {
      isControl = true
      replyMessage = '已为您开启风扇。'
      controlTask = switchMotor(true)
    } else if (lowerText.includes('关闭风扇') || lowerText.includes('关风扇') || lowerText.includes('停止风扇')) {
      isControl = true
      replyMessage = '已为您关闭风扇。'
      controlTask = switchMotor(false)
    }

    // ✅ 如果是控制指令，走拟人化流程
    if (isControl && controlTask) {
      this.thinkingText = 'AI 分析中，请稍候...'
      this.displayText = ''
      this.outputText = ''

      try {
        await controlTask
        this.outputText = replyMessage
      } catch (e) {
        this.outputText = '抱歉，操作失败，请稍后重试。'
      }

      this.thinkingText = ''
      await this.animateText(this.outputText)
      return
    }

    // ✅ 其他问题走 AI 流程
    this.thinkingText = 'AI 分析中，请稍候...'
    this.displayText = ''
    this.outputText = ''

    const systemPrompt = `
你是一位智慧车载助手，请根据以下车辆当前环境数据回答用户问题：
- 车内光照强度：${this.illumination} lux
- 车内温度：${this.temperature} ℃
- 空气湿度：${this.humidity} %

请结合这些实时数据，给出专业、安全、实用的驾驶或用车建议。如果用户问题与环境无关，可忽略上述数据。
`.trim();

    try {
      const systemMsg: ChatMessage = { role: 'system', content: systemPrompt }
      const userMsg: ChatMessage = { role: 'user', content: text }
      const reply = await this.deepSeek.sendMessage([systemMsg, userMsg])
      this.outputText = reply
    } catch (e) {
      this.outputText = '网络异常，请稍后重试。'
    }

    this.thinkingText = ''
    await this.animateText(this.outputText)
  }

  async animateText(text: string) {
    this.displayText = ''
    for (let i = 0; i < text.length; i++) {
      this.displayText += text[i]
      await this.delay(30 + Math.random() * 20)
    }
  }

  delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  @Builder
  QuickPhraseMenu() {
    Menu() {
      ForEach([
        '规划从郑州到安阳的路线',
        '对比moudleY和Su7',
        '车轮压力是否正常',
        '电车有什么优点',
        '请结合我车室内的光照强度给我一些开车建议',
        '请结合当前车内温度给我一些建议',
        '请根据空气湿度给我一些用车提示',
        // ✅ 新增控制快捷指令
        '帮我开灯',
        '帮我关灯',
        '帮我打开风扇',
        '帮我关闭风扇'
      ], (phrase: string) => {
        MenuItem({ content: phrase })
          .onClick(() => {
            this.findKeyWord(phrase); // 走统一入口
          });
      });
    }
  }

  @Builder
  build() {
    Column() {
      Text('智慧车载')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ bottom: 10 })

      Row() {
        Image($r('app.media.AI_Doctor'))
          .width(60)
          .height(60)
          .borderRadius(15)
          .margin({ right: 10 })
        Column() {
          Text('专业级车载AI为您服务')
            .fontSize(16)
            .padding(10)
            .backgroundColor('#eeeeee')
            .borderRadius(10)
            .width('100%')
        }
        .width('70%')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 20, bottom: 20 })

      Scroll() {
        Column() {
          if (this.thinkingText !== '') {
            Row() {
              LoadingProgress()
                .color(Color.Blue)
                .layoutWeight(1)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .height(40)
          } else {
            if (this.displayText === '' && this.outputText === '等待提问...') {
              Text(this.outputText)
                .fontSize(18)
                .fontColor('#888888')
                .width('90%')
                .textAlign(TextAlign.Center)
                .opacity(0.8)
            } else {
              Text(this.displayText)
                .fontSize(18)
                .fontColor('#333333')
                .width('90%')
                .textAlign(TextAlign.Center)
                .lineHeight(24)
                .maxLines(50)
            }
          }
        }
      }
      .width('100%')
      .height(440)
      .scrollBarWidth(4)
      .scrollBarColor('#cccccc')
      .padding(20)
      .backgroundColor('#f6f6f6')
      .borderRadius(12)

      Column() {
        TextInput({ placeholder: '例如：帮我开灯、规划路线、当前温度建议...' })
          .width('100%')
          .textAlign(TextAlign.Center)
          .onChange((v: string) => { this.inputText = v })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Row() {
        Button('+')
          .layoutWeight(1)
          .width(20)
          .height(30)
          .fontSize(20)
          .margin({ top: 16 })
          .backgroundColor('#007AFF')
          .fontColor('#fff')
          .borderRadius(25)
          .bindMenu(this.QuickPhraseMenu)

        Button('提交')
          .layoutWeight(2)
          .margin({ top: 16 })
          .width(120)
          .onClick(() => {
            this.findKeyWord(this.inputText)
          })
      }

      Divider().margin({ top: 20, bottom: 10 }).width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}



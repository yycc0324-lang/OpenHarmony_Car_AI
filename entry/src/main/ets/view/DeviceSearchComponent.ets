import axios, { AxiosResponse, AxiosRequestConfig, AxiosError, isAxiosError } from '@ohos/axios'
import getToken from "../model/getToken"
import { promptAction } from '@kit.ArkUI'
import ApiData from "../model/DeviceData"

import router from '@ohos.router';

let Token: string = "" //let接收token，容器


interface GeneratedObjectLiteralInterface_1 {
  onoff: string;
}

interface GeneratedObjectLiteralInterface_2 {
  service_id: string;
  command_name: string;
  paras: GeneratedObjectLiteralInterface_1;
}

interface GeneratedTypeLiteralInterface_1 {
  command_id: string;
}

interface GeneratedTypeLiteralInterface_2 {
  command_id: string;
}
interface CommandResp {
  command_id: string
}
interface ErrorResp {
  error_code?: string
  error_desc?: string
}
interface LightCtrlParas {
  onoff: string           // 或者 brightness/level，完全照模型
}
interface LightCmdBody {
  service_id: string
  command_name: string
  paras: LightCtrlParas
}
@Entry




@Component

export struct DeviceSearchComponent {
  @State motorStatus: string = ""
  @State lightStatus: string = ""
  @State autoState:string = ""



  private timerId: number = -1

  GetHeart(Token: string) {

    let project_id = "8d9fa8e28d8847398364bdd2a49bfb84" //项目ID
    let deviceid = "68515a5032771f177b430acd_nnssb" //设备ID
    let endpoint = "591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com" //不需要动的节点
    // console.info("请求传入的token",Token)


    //请求头！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    const config: AxiosRequestConfig = {
      headers: {

        "Content-Type": "application/json",
        // "X-Security-Token": Token,
        "Instance-Id": "8923986f-8463-4910-bf2d-4bbadba4b06c",
        "X-Auth-Token": Token

      }
    };
    //！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！


    //get方法请求参数 www.baidu.com?token=1


    //使用axios获取云端的下发数据，
    axios.get(`https://${endpoint}/v5/iot/${project_id}/devices/${deviceid}/shadow`, config)
      .then((res: ApiData) => { //在自己写的数据结构中暴露一个ApiData类型供这个页面获取数据

        this.motorStatus = res.data.shadow[0].reported.properties.motorStatus
        this.lightStatus = res.data.shadow[0].reported.properties.lightStatus
        this.autoState = res.data.shadow[0].reported.properties.autoStatus


        //  })

      }).catch((error: AxiosError) => {
      console.info("请求axios" + JSON.stringify(error.response))
    })
  }


  private async switchLight(on: boolean): Promise<void> {
    const projectId = '8d9fa8e28d8847398364bdd2a49bfb84';
    const deviceId = '68515a5032771f177b430acd_nnssb';
    const endpoint = '591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com';

    const url = `https://${endpoint}/v5/iot/${projectId}/devices/${deviceId}/commands`;
    const body: GeneratedObjectLiteralInterface_2 = {
      service_id: 'smart_cart',
      command_name: 'light_control',
      paras: ({ onoff: on ? 'ON' : 'OFF' } as GeneratedObjectLiteralInterface_1)
    };

    const cfg: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': Token,

      }
    };

    try {
      this.lightStatus = on ? 'ON' : 'OFF'

      const res: AxiosResponse<CommandResp> =
        await axios.post<CommandResp, AxiosResponse<CommandResp>>(url, body, cfg)

      console.info('HTTPS', res.status, res.data)

      promptAction.showToast({ message: on ? '已开机' : '已关机', duration: 1500 })
    } catch (err) {
      console.error('switchMotor error', JSON.stringify(err))
      if (isAxiosError(err) && err.response ) {

        const code: string = err.response.data.error_code ?? 'UNKNOWN'
        const desc: string = err.response.data.error_desc ?? 'no description'
        console.error('400 detail', code, desc)
      } else {
        const msg: string = (err as Error).message
        console.error('Exception', msg)
      }
    }
  }
  private async switchMotor(on: boolean): Promise<void> {
    const projectId = '8d9fa8e28d8847398364bdd2a49bfb84';
    const deviceId = '68515a5032771f177b430acd_nnssb';
    const endpoint = '591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com';

    const url = `https://${endpoint}/v5/iot/${projectId}/devices/${deviceId}/commands`;
    const body: GeneratedObjectLiteralInterface_2 = {
      service_id: 'smart_cart',
      command_name: 'motor_control',
      paras: ({ onoff: on ? 'ON' : 'OFF' } as GeneratedObjectLiteralInterface_1)
    };

    const cfg: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': Token,

      }
    };

    try {
      this.motorStatus = on ? 'ON' : 'OFF'

      const res: AxiosResponse<CommandResp> =
        await axios.post<CommandResp, AxiosResponse<CommandResp>>(url, body, cfg)

      console.info('HTTPS', res.status, res.data)// 应看到 201

      promptAction.showToast({ message: on ? '已开机' : '已关机', duration: 1500 })
    } catch (err) {
      console.error('switchMotor error', JSON.stringify(err))
      if (isAxiosError(err) && err.response ) {

        const code: string = err.response.data.error_code ?? 'UNKNOWN'
        const desc: string = err.response.data.error_desc ?? 'no description'
        console.error('400 detail', code, desc)
      } else {
        const msg: string = (err as Error).message
        console.error('Exception', msg)
      }
    }
  }


  private async switchauto(on: boolean): Promise<void> {
    const projectId = '8d9fa8e28d8847398364bdd2a49bfb84';
    const deviceId = '68515a5032771f177b430acd_nnssb';
    const endpoint = '591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com';

    const url = `https://${endpoint}/v5/iot/${projectId}/devices/${deviceId}/commands`;
    const body: GeneratedObjectLiteralInterface_2 = {
      service_id: 'smart_cart',
      command_name: 'auto_control',
      paras: ({ onoff: on ? 'ON' : 'OFF' } as GeneratedObjectLiteralInterface_1)
    };

    const cfg: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': Token,

      }
    };

    try {
      this.motorStatus = on ? 'ON' : 'OFF'
      const res: AxiosResponse<CommandResp> =
        await axios.post<CommandResp, AxiosResponse<CommandResp>>(url, body, cfg)

      console.info('HTTPS', res.status, res.data)// 应看到 201

      promptAction.showToast({ message: on ? '开发中' : '开发中', duration: 1500 })
    } catch (err) {
      console.error('switchMotor error', JSON.stringify(err))
      if (isAxiosError(err) && err.response ) {

        const code: string = err.response.data.error_code ?? 'UNKNOWN'
        const desc: string = err.response.data.error_desc ?? 'no description'
        console.error('400 detail', code, desc)
      } else {
        const msg: string = (err as Error).message
        console.error('Exception', msg)
      }
    }
  }



  async aboutToAppear() {

    Token = await getToken()
    this.timerId = setInterval(async () => {
      //获取token
      getToken().then((res) => {
        Token = res
      });

      this.GetHeart(Token)
    }, 1000)
  }

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
    }
  }



  build() {


    Column() {

      Column({ space: 10 }) {
        Text('驾控云视')
          .fontSize(30)
          .padding({ right: 200, top: 0 })
          .fontWeight(FontWeight.Bold)


        Row() {
          Image($r('app.media.car'))
            .width(350)
        }
        .padding({ right: 230, top: 70 })
      }




      Column() {
        Text('车辆控制')
          .fontSize(20)
          .fontColor(0xcccccc)
          .width('100%')
          .padding({left:130})

        Row({ space: 10 }) {
          Text('灯光')
            .fontSize(12)
            .fontColor(0xcccccc)
            .width('30%')


          Flex({ justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
            Toggle({ type: ToggleType.Switch, isOn: false })
              .onClick(() => {
                console.info('Button pressed')                     // A: 点击反馈
                this.switchLight(this.lightStatus !== 'ON')
              })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn);
              })
          }
          .width('100%')

        }

        Row({ space: 10 }) {
          Text('扇叶状态')
            .fontSize(12)
            .fontColor(0xcccccc)
            .width('30%')


          Flex({ justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
            Toggle({ type: ToggleType.Switch, isOn: false })
              .onClick(() => {
                console.info('Button pressed')                     // A: 点击反馈
                this.switchMotor(this.motorStatus !== 'ON')
              })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn);
              })
          }
          .width('100%')

        }

        Row({ space: 10 }) {
          Text('自动状态')
            .fontSize(12)
            .fontColor(0xcccccc)
            .width('30%')


          Flex({ justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
            Toggle({ type: ToggleType.Switch, isOn: false })
              .onClick(() => {
                console.info('Button pressed')                     // A: 点击反馈
                this.switchauto(this.autoState !== 'ON')
              })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn);
              })
          }
          .width('100%')

        }

        Row({ space: 10 }) {
          Text('监控画面')
            .fontSize(12)
            .fontColor(0xcccccc)
            .width('30%')
          Flex({ justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
            Toggle({ type: ToggleType.Switch, isOn: false })
              .onClick(() => {
                router.pushUrl({ url: 'pages/Jiankong' })

              })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
          }
          .width('100%')
        }
      }. shadow({radius:20,
        offsetY:25,
        offsetX:25,
        color:"#bfbfbf"})
      .backgroundColor(0xf5f5f5)
      .borderRadius(10)
      .width('100%')
      .padding(10) // 可选：整体内边距
    }


  }
}
import axios, { AxiosResponse, AxiosRequestConfig, AxiosError, isAxiosError } from '@ohos/axios'
import getToken from "../model/getToken"
import ApiData from "../model/DeviceData"
import { TabID, TabItemList } from '../model/TabItem'
import { DeviceSearchComponent } from '../view/DeviceSearchComponent'
import { AIComponent } from './AIComponent'
import DeviceData from '../model/DeviceData' //在没有使用自己定义的数据结构时需要使用DeviceData（大概吧？？）
import { ItemRestriction, router, SegmentButton, SegmentButtonOptions, SegmentButtonTextItem } from '@kit.ArkUI'
import MineComponent from '../view/MineComponent'


let Token: string = "" //let接收token，容器
let timestamp: number = new Date().getTime();
let now = Date.now();
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
function formatTime(timestamp: number): string {
  let date = new Date(timestamp);
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}:${String(date.getSeconds()).padStart(2, '0')}`;
}

@Entry
@Component
struct Gauge7 {
  @State pageIndex: number = 0
  @State subTabIndex: number[] = [0]
  @State noneValueOne: number = 40;
  @State illumination: string = "" //声明变量
  @State temperature: string = "" //声明变量
  @State humidity: string = ""
  @State motorStatus: string = ""
  @State autoState: string = ""
  @State subTabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttons: [
      { text: '车辆光照' },
      { text: '车辆温度' },
      { text: '空气湿度' }
    ],

    textPadding: {
      top: 10,
      right: 10,
      bottom: 10,
      left: 10
    }
  })
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
        "Instance-Id": "8923986f-8463-4910-bf2d-4bbadba4b06c",
        "X-Auth-Token": Token

      }
    };
    //！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！


    //get方法请求参数 www.baidu.com?token=1


    //使用axios获取云端的下发数据，
    axios.get(`https://${endpoint}/v5/iot/${project_id}/devices/${deviceid}/shadow`, config)
      .then((res: ApiData) => { //在自己写的数据结构中暴露一个ApiData类型供这个页面获取数据
        this.illumination = res.data.shadow[0].reported.properties.illumination
        this.temperature = res.data.shadow[0].reported.properties.temperature
        this.humidity = res.data.shadow[0].reported.properties.humidity
        this.motorStatus = res.data.shadow[0].reported.properties.motorStatus
        this.autoState = res.data.shadow[0].reported.properties.autoStatus


        console.info("请求数据为" + this.illumination)
      }).catch((error: AxiosError) => {
      console.info("请求axios" + JSON.stringify(error.response))
    })
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


    Tabs({ barPosition: BarPosition.End }) {

      TabContent() {
        Column() {
          if (this.subTabIndex[0] === 0) {
            Row(){
              Text('Aegix Rover')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .width('85%')

              Text('                              ')
              Image($r('app.media.erweima'))
                .width(30)
                .onClick(()=>{
                  router.pushUrl({ url: 'pages/LoadingPage' });
                })
            }
            .padding({ right: 140, top:5 })

              .backgroundColor(0xf5f5f5)
              .borderRadius(10)


            Column() {
              Text(`车辆数据更新于：${formatTime(now)}`)
                .fontSize(15)
                .fontColor(0xCCCCCC)
                .width('100%')

                .padding({ right: 140, top: 5 })

                .backgroundColor(0xf5f5f5)
                .borderRadius(10)

              Row() {
                Slider({
                  value: this.noneValueOne,
                  min: 0,
                  max: 100,
                  style: SliderStyle.NONE
                })

                  .blockColor('#191970')
                  .trackColor('#ADD8E6')
                  .selectedColor('#4169E1')
                  .padding({ right: 120 })
                  .showTips(true)
                  .width('100%')
                  .onChange((value: number, mode: SliderChangeMode) => {
                    this.noneValueOne = value;
                  })
              }
            }

            .width('100%')
            Column() {
              Text('里程数')
                .fontSize(26)
                .fontWeight(FontWeight.Medium)
                .fontColor('#666666')
                .fontFamily('HarmonyOS Sans')

              Text('0.3km')
                .fontSize(58)
                .height(80)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Red)
                .fontFamily('HarmonyOS Sans')
            }
            .width('100%')
            .borderRadius(12)
            .alignItems(HorizontalAlign.Center)



            Row() {
              Image($r('app.media.car'))
                .width(600)
                .padding({ right: 230, top: 0 })
            }

            Row() {
              SegmentButton({ options: this.subTabOptions, selectedIndexes: $subTabIndex })
                .width('100%').padding({ top: 10, bottom: 10 })
              Divider()
            }

            Row() {
              Text(this.illumination!!)
                .fontSize(24)
                .fontColor(0xcccccc)
                .width("100%")
                .textAlign(TextAlign.Center)
            }
            .width("90%")
            .margin({ top: 20, left: "5%", right: "5%" })
            .height("25%")
            .shadow({
              radius: 20,
              offsetY: 25,
              offsetX: 25,
              color: "#bfbfbf"
            })
            .backgroundColor(0xf5f5f5)
            .borderRadius(10)

          } else if (this.subTabIndex[0] === 1) {
            Row(){
              Text('Aegix Rover')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .width('85%')

              Text('                              ')
              Image($r('app.media.erweima'))
                .width(30)
                .onClick(()=>{
                  router.pushUrl({ url: 'pages/LoadingPage' });
                })
            }
            .padding({ right: 140, top:5 })

            .backgroundColor(0xf5f5f5)
            .borderRadius(10)


            Column() {
              Text(`车辆数据更新于：${formatTime(now)}`)
                .fontSize(15)
                .fontColor(0xCCCCCC)
                .width('100%')

                .padding({ right: 140, top: 5 })
                .backgroundColor(0xf5f5f5)
                .borderRadius(10)

              Row() {
                Slider({
                  value: this.noneValueOne,
                  min: 0,
                  max: 100,
                  style: SliderStyle.NONE
                })

                  .blockColor('#191970')
                  .trackColor('#ADD8E6')
                  .selectedColor('#4169E1')
                  .padding({ right: 120 })
                  .showTips(true)
                  .width('100%')
                  .onChange((value: number, mode: SliderChangeMode) => {
                    this.noneValueOne = value;
                  })
              }
            }

            .width('100%')
            Column() {
              Text('里程数')
                .fontSize(26)
                .fontWeight(FontWeight.Medium)
                .fontColor('#666666')
                .fontFamily('HarmonyOS Sans')

              Text('0.3km')
                .fontSize(58)
                .height(80)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Red)
                .fontFamily('HarmonyOS Sans')
            }
            .width('100%')
            .borderRadius(12)
            .alignItems(HorizontalAlign.Center)



            Row() {
              Image($r('app.media.car'))
                .width(600)
                .padding({ right: 230, top: 0 })
            }
            Row() {
              SegmentButton({ options: this.subTabOptions, selectedIndexes: $subTabIndex })
                .width('100%').padding({ top: 10, bottom: 10 })
              Divider()
            }

            Row() {
              Text(this.temperature!!)
                .fontSize(24)
                .fontColor(0xcccccc)
                .width("100%")
                .textAlign(TextAlign.Center)
            }
            .width("90%")
            .margin({ top: 20, left: "5%", right: "5%" })
            .height("25%")
            .shadow({
              radius: 20,
              offsetY: 25,
              offsetX: 25,
              color: "#bfbfbf"
            })
            .backgroundColor(0xf5f5f5)
            .borderRadius(10)
          } else if (this.subTabIndex[0] === 2) {
            Row(){
              Text('Aegix Rover')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .width('85%')

              Text('                              ')
              Image($r('app.media.erweima'))
                .width(30)
                .onClick(()=>{
                  router.pushUrl({ url: 'pages/LoadingPage' });
                })
            }
            .padding({ right: 140, top:5 })

            .backgroundColor(0xf5f5f5)
            .borderRadius(10)


            Column() {
              Text(`车辆数据更新于：${formatTime(now)}`)
                .fontSize(15)
                .fontColor(0xCCCCCC)
                .width('100%')

                .padding({ right: 140, top: 5 })
                .backgroundColor(0xf5f5f5)
                .borderRadius(10)

              Row() {
                Slider({
                  value: this.noneValueOne,
                  min: 0,
                  max: 100,
                  style: SliderStyle.NONE
                })

                  .blockColor('#191970')
                  .trackColor('#ADD8E6')
                  .selectedColor('#4169E1')
                  .padding({ right: 120 })
                  .showTips(true)
                  .width('100%')
                  .onChange((value: number, mode: SliderChangeMode) => {
                    this.noneValueOne = value;
                  })
              }
            }

            .width('100%')
            Column() {
              Text('里程数')
                .fontSize(26)
                .fontWeight(FontWeight.Medium)
                .fontColor('#666666')
                .fontFamily('HarmonyOS Sans')

              Text('0.3km')
                .fontSize(58)
                .height(80)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Red)
                .fontFamily('HarmonyOS Sans')
            }
            .width('100%')
            .borderRadius(12)
            .alignItems(HorizontalAlign.Center)



            Row() {
              Image($r('app.media.car'))
                .width(600)
                .padding({ right: 230, top: 0 })
            }

            Row() {
              SegmentButton({ options: this.subTabOptions, selectedIndexes: $subTabIndex })
                .width('100%').padding({ top: 10, bottom: 10 })
              Divider()
            }

            Row() {
              Text(this.humidity!!)
                .fontSize(24)
                .fontColor(0xcccccc)
                .width("100%")
                .textAlign(TextAlign.Center)
            }
            .width("90%")
            .margin({ top: 20, left: "5%", right: "5%" })
            .height("25%")
            .shadow({
              radius: 20,
              offsetY: 25,
              offsetX: 25,
              color: "#bfbfbf"
            })
            .backgroundColor(0xf5f5f5)
            .borderRadius(10)
          }
        }.width('100%').height('100%')
      }.tabBar(this.MyTabBuilder(TabID.DETECTOR))


      TabContent() {
        DeviceSearchComponent()
      }.tabBar(this.MyTabBuilder(TabID.SEARCH))

      TabContent() {
        AIComponent()
      }.tabBar(this.MyTabBuilder(TabID.SEARCH_AI))

      TabContent() {
        MineComponent()
      }.tabBar(this.MyTabBuilder(TabID.MINE))

    }
    .vertical(false)
    .scrollable(true)
    .barWidth('100%')
    .barMode(BarMode.Fixed)
    .width('100%')
    .height('100%')
    .onChange((index) => {
      this.pageIndex = index
    })


  }

  @Builder
  MyTabBuilder(idx: number) {
    Column() {
      Image(idx === this.pageIndex ? TabItemList[idx].icon_selected : TabItemList[idx].icon).width(32).height(32)
      Text(TabItemList[idx].title)
        .fontSize(14).fontWeight(FontWeight.Bold)
        .fontColor(this.pageIndex === idx ? '#006eee' : '#888')
    }

  }
}

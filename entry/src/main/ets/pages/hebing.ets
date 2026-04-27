import DeviceData from '../model/DeviceData'
import axios,{AxiosResponse,AxiosRequestConfig} from '@ohos/axios'
import {
  ItemRestriction,
  SegmentButton,
  SegmentButtonOptions,
  SegmentButtonTextItem
} from '@kit.ArkUI';
let xueyang:number=0;
let shadowDvice:DeviceData;
let Token:string = ""
async function  GetToken (){
  //配置请求头
  const config:AxiosRequestConfig  = {
    headers:{
      "Content-Type": "application/json",

    }
  };


  try {
    let res:AxiosResponse= await axios.post(`https://iam.cn-north-4.myhuaweicloud.com/v3/auth/tokens`, {
      "auth": {
        "identity": {
          "methods": [
            "password"
          ],
          "password": {
            "user": {
              "name": "test001",
              "password": "A&_%ujXExjz",
              "domain": {
                "name": "hw058740476"
              }
            }
          }
        },
      }
    },config)
    console.info("请求的内容为",JSON.stringify(res.headers))
    Token=res.headers['x-subject-token']
    GetHeart(Token)
  }catch (error) {
    console.error("请求失败token", error)
    return;
  }
}
async  function GetHeart(Token:string){
  let project_id="8d9fa8e28d8847398364bdd2a49bfb84"
  let deviceid="6804bb6d84adf27cda50c19f_shshshsadada"
  let endpoint="591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com"

  const config:AxiosRequestConfig  = {
    headers:{

      "Content-Type": "application/json",
      "X-Auth-Token": Token,
      "Instance-Id": "8923986f-8463-4910-bf2d-4bbadba4b06c"
    }
  };

  try {

    let res: AxiosResponse = await axios.get(`https://${endpoint}/v5/iot/${project_id}/devices/${deviceid}/shadow`, config)

    xueyang=res.data.shadow[0].reported.properties.血氧

  }catch (error) {
    console.error("请求失败", error)
    return;
  }
}


@Component
struct Gauge7 {

  @State deviceblood: number = 0
  private timerId: number = -1

  aboutToAppear() {
    this.timerId = setInterval(() => { GetToken(); this.updateData() }, 3000)
  }

  aboutToDisappear() {
    if (this.timerId !== -1) clearInterval(this.timerId)
  }

  updateData() {
    this.deviceblood = xueyang
  }

  build() {
    Column() {
      Gauge({ value: this.deviceblood, min: 90, max: 100 }) {
        Column() {
          Text(`${this.deviceblood}`)
            .maxFontSize('60sp')
            .minFontSize('30.0vp')
            .fontWeight(FontWeight.Medium)
            .fontColor("#ff182431")
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ top: '35%' })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
          Text('血氧')
            .maxFontSize('20sp')
            .minFontSize("10.0vp")
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))
            .fontWeight(FontWeight.Regular)
            .width('100%')
            .height('10%')
            .textAlign(TextAlign.Center)
        }.width('100%').height('100%')
      }
      .startAngle(360)
      .endAngle(0)
      .colors(Color.Red)
      .width('80%')
      .height('80%')
      .indicator(null)
      .strokeWidth(18)
      .trackShadow({ radius: 7, offsetX: 7, offsetY: 7 })
      .padding(18)
    }.margin({ top: 40 }).width('100%').height('100%')
  }
}

@Component
struct DiscoveryPage {
  build() {
    Column() {
      Text("这是发现页面内容")
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height('100%')
    }
  }
}

@Component
struct ProfilePage {
  build() {
    Column() {
      Text("这是我的页面内容")
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height('100%')
    }
  }
}

// 主组件
@Entry
@Component
struct Index {

  @State tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttons: [{ text: '页签按钮1' }, { text: '页签按钮2' }, { text: '页签按钮3' }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundColor: 'rgb(213,213,213)',
    selectedBackgroundColor: 'rgb(112,112,112)',
    textPadding: {
      top: 10,
      right: 10,
      bottom: 10,
      left: 10
    },
  })

  @State tabSelectedIndexes: number[] = [0]

  build() {
    Column() {
      Image($r('app.media.backgroundbage'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .zIndex(-1)
      // 顶部导航栏
      SegmentButton({ options: this.tabOptions, selectedIndexes: $tabSelectedIndexes })
        .width('100%')
        .padding({ top: 10, bottom: 10 })

      // 分割线
      Divider()

      // 根据选中索引显示不同页面
      if (this.tabSelectedIndexes[0] === 0) {
        Gauge7()
      } else if (this.tabSelectedIndexes[0] === 1) {
        DiscoveryPage()
      } else if (this.tabSelectedIndexes[0] === 2) {
        ProfilePage()
      }
    }
    .width('100%')
    .height('100%')
  }
}

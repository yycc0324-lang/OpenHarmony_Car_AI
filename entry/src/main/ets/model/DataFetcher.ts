// model/DataFetcher.ts
import http from '@ohos.net.http'
import { MainViewModel } from './MainViewModel'
import { GlobalState } from '../globalState'  // 引入全局状态类

export class DataFetcher {
  private model: MainViewModel;
  private projectId: string = '8d9fa8e28d8847398364bdd2a49bfb84';
  private deviceId: string = '68515a5032771f177b430acd_nnssb'

  constructor(model: MainViewModel) {
    this.model = model;
  }

  public async startFetching() {
    await this.fetchToken();
    this.schedulePolling();
  }

  // 获取 token
  private async fetchToken() {
    try {
      const httpRequest = http.createHttp()
      const response = await httpRequest.request(
        'https://iam.cn-north-4.myhuaweicloud.com/v3/auth/tokens',
        {
          method: http.RequestMethod.POST,
          header: {
            'Content-Type': 'application/json'
          },
          extraData: JSON.stringify({
            auth: {
              identity: {
                methods: ['password'],
                password: {
                  user: {
                    name: 'car', // IAM 子账号名
                    password: 'ILblFsy7V&E8y', // 你提供的密码
                    domain: { name: 'hw058740476' } // 华为云账号名
                  }
                }
              },
              scope: {
                domain: {
                  name: 'hw058740476'
                }
              }
            }
          }),
          expectDataType: http.HttpDataType.STRING
        }
      )

      const token = response.header['x-subject-token']
      if (token) {
        // 将 token 存储到全局状态中
        GlobalState.setToken(token);
        console.info('✅ 成功获取 token');
      } else {
        console.error('❌ 获取 token 失败，响应中无 token 字段');
      }
    } catch (err) {
      console.error('❌ 请求 token 异常:', JSON.stringify(err));
    }
  }

  // 定时拉取设备数据
  private schedulePolling() {
    setInterval(async () => {
      try {
        // 从全局状态获取 token
        const token = GlobalState.getToken();
        if (!token) {
          console.error('❌ Token 未获取，无法继续请求');
          return; // 如果没有 token，则中断
        }

        const httpRequest = http.createHttp();
        const response = await httpRequest.request(
          `https://591bc7bfc8.st1.iotda-app.cn-north-4.myhuaweicloud.com/v5/iot/8d9fa8e28d8847398364bdd2a49bfb84/devices/68515a5032771f177b430acd_nnssb/shadow`,
          {
            method: http.RequestMethod.GET,
            header: {
              'Content-Type': 'application/json',
              'X-Auth-Token': token  // 使用全局 token
            },
            expectDataType: http.HttpDataType.STRING
          }
        )

        // 输出原始数据，帮助我们分析数据是否正常
        console.log('设备数据响应:', response.result);

        const result = typeof response.result === 'string' ? JSON.parse(response.result) : response.result;

        // 确认返回数据中是否有 shadow 和 reported 数据
        if (!result.shadow || !result.shadow[0] || !result.shadow[0].reported || !result.shadow[0].reported.properties) {
          console.error('❌ 数据格式错误，返回数据中没有正确的设备属性');
          return; // 如果数据格式不正确，终止后续操作
        }

        const props = result.shadow[0].reported.properties;

        // 输出设备数据
        console.log('设备属性:', props);

        // 如果获取到设备数据，更新到模型中
        this.model.updateDeviceData(1, {
          illumination: props.illumination,
          temperature: props.temperature,
          humidity: props.humidity,
          ecgData: props.ecgData
        })

        console.info('✅ 设备数据更新成功:', props)
      } catch (err) {
        console.error('❌ 获取设备数据失败:', JSON.stringify(err))
      }
    }, 1000); // 每1秒拉取一次数据
  }
}

import DeviceBean from '../common/bean/DeviceBean';

export class MainViewModel {
  private deviceMap: Map<number, DeviceBean> = new Map<number, DeviceBean>();

  // ✅ 心电图数据缓存（最多保留1000个点）
  private ecgData: number[] = [];

  constructor() {
    // 初始化一个设备（可根据真实数据更新）
    this.deviceMap.set(1, new DeviceBean(1, '设备1', 0, 0, 0));
  }

  public getDeviceData(deviceId: number): DeviceBean {
    return this.deviceMap.get(deviceId) ?? new DeviceBean(deviceId, '', 0, 0, 0);
  }

  public updateDeviceData(deviceId: number, data: {
    illumination?: number;
    temperature?: number;
    humidity?: number;
    ecgData?: number[]; // ✅ 如果硬件返回了 ecgData 数组，也支持更新
  }) {
    let device = this.deviceMap.get(deviceId);
    if (!device) {
      device = new DeviceBean(deviceId, `设备${deviceId}`, 0, 0, 0);
    }

    if (data.illumination !== undefined) {
      device.illumination = data.illumination;
    }

    if (data.temperature !== undefined) {
      device.temperature = data.temperature;
    }

    if (data.humidity !== undefined) {
      device.humidity = data.humidity;
    }

    if (data.ecgData && Array.isArray(data.ecgData)) {
      this.appendEcgData(data.ecgData);
    }

    this.deviceMap.set(deviceId, device);
  }

  // ✅ 心电图数据追加缓存（最多保留1000点）
  public appendEcgData(samples: number[]) {
    this.ecgData.push(...samples);
    if (this.ecgData.length > 1000) {
      this.ecgData.splice(0, this.ecgData.length - 1000);
    }
  }

  public getEcgData(): number[] {
    return this.ecgData;
  }
}

export default new MainViewModel();

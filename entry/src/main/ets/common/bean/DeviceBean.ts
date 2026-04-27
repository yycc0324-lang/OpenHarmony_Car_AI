export default class DeviceBean {
  deviceId: number;           // 设备id
  name: string;               // 设备名
  illumination: number;          // 心率heartRate = 照明
  temperature: number;        // 血氧bloodOxygen = 温度
  humidity: number;    // 体温bodyTemperature = 湿热
  ecgData: number[];          // ✅ 新增：心电图数据数组

  constructor(deviceId: number, name: string,  illumination: number,
    temperature: number, humidity: number,
    ecgData: number[] = []) {                      // ✅ 支持第6个参数，默认空数组
    this.deviceId = deviceId;
    this.name = name;
    this.illumination = illumination;
    this.temperature = temperature;
    this.humidity = humidity;
    this.ecgData = ecgData;
  }
}

import { DataFetcher } from './model/DataFetcher';
import { MainViewModel } from './model/MainViewModel';

// 创建 MainViewModel 实例
export const model = new MainViewModel();

// 创建数据拉取器，注入模型
export const fetcher = new DataFetcher(model);

// 启动拉取流程
export function startDataFetching() {
  fetcher.startFetching();
}

// GlobalState 类管理全局状态，包括 token
export class GlobalState {
  private static token: string = '';

  public static getToken(): string {
    return this.token;
  }

  public static setToken(token: string): void {
    this.token = token;
  }

  public static clearToken(): void {
    this.token = '';
  }

  public static getDeviceData(deviceId: number) {
    return model.getDeviceData(deviceId);
  }

  public static updateDeviceData(deviceId: number, data: any) {
    model.updateDeviceData(deviceId, data);
  }
}

// 移除默认导出，使用命名导出

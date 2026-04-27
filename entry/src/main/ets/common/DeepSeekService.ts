import http from '@ohos.net.http';
import type { BusinessError } from '@ohos.base';
// 关键修复：显式导出接口
export interface ChatMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}
// 为 choices 数组中的对象单独定义接口
interface ChatChoice {
  message: ChatMessage;
}
// 最终 API 响应类型
interface ApiResponse {
  choices: ChatChoice[];
}
export class DeepSeekService {
  private baseUrl: string = 'https://api.deepseek.com';
  private apiKey: string;
  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }
  async sendMessage(messages: ChatMessage[], model: string = 'deepseek-chat'): Promise<string> {
    const httpRequest = http.createHttp();
    try {
      // 显式声明请求选项类型
      const options: http.HttpRequestOptions = {
        method: http.RequestMethod.POST,

        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.apiKey}`
        },
        extraData: JSON.stringify({ messages, model })
      };
      // 明确指定响应类型
      const response: http.HttpResponse = await httpRequest.request(`${this.baseUrl}/v1/chat/completions`, options);
      // 使用正确的状态码属性
      if (response.responseCode === 200) {
        // 处理响应数据
        const result = response.result as string | object;
        const responseText = typeof result === 'string' ? result : JSON.stringify(result);
        const data: ApiResponse = JSON.parse(responseText);
        return data.choices[0].message.content;
      }
      else {
        throw new Error(`API请求失败，状态码: ${response.responseCode}`);
      }
    }
    catch (error) {
      const err = error as BusinessError;
      console.error('调用DeepSeek API出错:', err.message);
      throw new Error(err.message); // 确保抛出Error类型
    }
    finally {
      httpRequest.destroy();
    }
  }
}

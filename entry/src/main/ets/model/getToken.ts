// getToken.ts

import axios from '@ohos/axios';

// 配置请求体的类型声明
interface AuthData {
  auth: {
    identity: {
      methods: string[];
      password: {
        user: {
          domain: {
            name: string;
          };
          name: string;
          password: string;
        };
      };
    };
  };
}

// 配置请求体
const data: AuthData = {
  auth: {
    identity: {
      methods: ['password'],
      password: {
        user: {
          domain: {
            name: 'hw058740476'  // 替换为你的华为云账号名
          },
          name: 'car',  // 替换为你的IAM用户名
          password: 'ILblFsy7V&E8y'  // 替换为你的IAM密码
        }
      }
    }
  }
};

// 配置请求头
const config = {
  headers: {
    'Content-Type': 'application/json;charset=UTF-8',

  }
};

// 发送 POST 请求获取 Token
async function getToken() :Promise<string>{
  try {
    let res= await axios.post('https://iam.cn-north-4.myhuaweicloud.com/v3/auth/tokens', data, config)
    let token:string = res.headers['x-subject-token'];
    // console.info("获取数据为"+token)
    return token;

  } catch(err){
    return err

  }


}



export default getToken


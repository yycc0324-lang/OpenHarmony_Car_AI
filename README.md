OpenHarmony_Car_AI · 北向鸿蒙车载

> 基于 **HarmonyOS / OpenHarmony** 打造的**车载智能助手**，融合 **DeepSeek 大模型 AI 能力** 与 **华为云 IoT 设备实时数据监测**，面向车机与座舱场景提供智能交互、设备物联与健康/环境数据可视化。


---

## 📌 项目简介

`基于 **Stage 应用模型** 与 **ArkUI 声明式 UI** 构建的鸿蒙应用，定位为「北向鸿蒙车载」智能终端应用
-  **AI 智能助手**：通过 DeepSeek 大模型进行多轮对话，提供问答、推理等智能服务。
-  **实时设备监测**：连接华为云 IoT 设备影子，实时获取车载/座舱设备上报的**光照、温度、湿度** 等数据。
-  **设备与账户管理**：设备信息、个人资料证码登录模态等。

---

## 🧩 功能特性

| 能力 | 说明 |
| --- | --- |
| AI 多轮对话 | 封装 DeepSeek API（`deepseek-chat`），支持 `system / user / assistant` 角色上下文 |
| 实时设备监控 | 每秒轮询 IoTDA 设备影子，展示光照 / 温度 / 湿度 / 心电数据 |
| 全屏登录模态 | `bindContentCover` + `@Builder` 实现全屏模态登录，`transition` 转场 |
| 个人中心 | 头像选择、设备 ID / 名称、协议、关于、安全设置、资料编辑 |
| 权限管理 | 申请 `ohos.permission.INTERNET`，用于访问 DeepSeek 与华为云服务 |

---

## 🛠 技术栈

- **语言 / UI**：ArkTS / TypeScript，ArkUI 声明式 UI
- **应用模型**：Stage 模型（`UIAbility` + `module.json5` + `app.json5`）
- **运行版本**：`compatibleSdkVersion 5.0.1(13)`，`runtimeOS: HarmonyOS`
- **构建工具**：hvigor（`hvigorfile.ts`、`hvigorw`）
- **第三方依赖**：
  - `@ohos/axios` — HTTP 客户端
  - `@ohos/hypium` — 单元测试框架
  - `mqtt` — MQTT 客户端（`package.json` 中声明，用于实时通道扩展）
  - `@ohos/arkui` / `@ohos/arkui-components`
- **内置能力**：`@ohos.net.http`、`@ohos.hilog`、`@ohos.window`、`@ohos.app.ability.UIAbility`
- **云服务**：
  - DeepSeek：`https://api.deepseek.com/v1/chat/completions`
  - 华为云 IAM：`https://iam.cn-north-4.myhuaweicloud.com/v3/auth/tokens`
  - 华为云 IoTDA：`https://<endpoint>.iotda-app.cn-north-4.myhuaweicloud.com/v5/iot/<projectId>/devices/<deviceId>/shadow`

---

## 📁 目录结构

```
OpenHarmony_Car_AI
├── AppScope
│   ├── app.json5                      # 包名 / 版本 / 图标等应用级配置
│   └── resources/base
├── entry                              # 主模块（entry 类型）
│   └── src/main
│       ├── ets
│       │   ├── entryability/EntryAbility.ts    # 应用入口，启动数据拉取
│       │   ├── globalState.ts                  # 全局状态 + token 管理
│       │   ├── common
│       │   │   ├── DeepSeekService.ts          # DeepSeek AI 调用封装
│       │   │   ├── StorageKeys.ts              # 本地存储键
│       │   │   └── bean/DeviceBean.ts          # 设备数据模型
│       │   ├── model
│       │   │   ├── DataFetcher.ts              # 华为云 token + 设备轮询
│       │   │   ├── MainViewModel.ts            # 设备 / ECG 状态管理
│       │   │   ├── DeviceData.ts
│       │   │   ├── TabItem.ets · MineItemList.ets
│       │   │   └── getToken.ts                 # 用 axios 取华为云 token
│       │   ├── pages                           # 业务页面
│       │   │   ├── Index.ets · LoadingPage.ets · MainPage.ets
│       │   │   ├── Jiankong.ets                # 设备监控（核心）
│       │   │   ├── PersonalInfoPage.ets · SecurityPage.ets · AboutPage.ets
│       │   │   ├── DeviceIdPage.ets · DeviceNamePage.ets
│       │   │   └── AvatarPickerPage.ets · AgreementPage.ets · hebing.ets
│       │   └── view                            # 视图组件
│       │       ├── AIComponent.ets · DetectorComponent.ets
│       │       └── DeviceSearchComponent.ets · MineComponent.ets
│       └── resources                           # 多语言与资源（base / zh_CN / en_US / rawfile）
│       ├── module.json5 · agconnect-services.json · config.json
│       ├── build-profile.json5 · oh-package.json5 · hvigorfile.ts
├── casesfeature/modalwindow          # HAR 功能模块：全屏登录模态
│   └── src/main/ets
│       ├── model/DefaultLogin.ets · OtherWaysToLogin.ets
│       └── ModalWindow.ets
├── build-profile.json5               # 应用级构建（模块 = entry + modalwindow）
├── oh-package.json5 · oh-package-lock.json5
├── package.json · package-lock.json
├── hvigorfile.ts · hvigorw · hvigorw.bat
└── .gitignore
```

---

## 🚀 快速开始

### 环境要求
- **DevEco Studio** 5.0.1 及以上（HarmonyOS API 13）
- **Node.js**（hvigor 运行依赖）
- HarmonyOS 真机或模拟器（`deviceTypes`: `phone`, `tablet`）

### 构建与运行
1. 用 DevEco Studio 打开项目根目录，等待 hvigor 自动同步（首次执行 `ohpm install`）。
2. 在 `build-profile.json5` 中配置 `signingConfig`（签名）。
3. 选择设备后点击 **Run** 运行。
4. 模块关系：主模块 `entry` 通过 `file:../casesfeature/modalwindow` 依赖 HAR 模块 `modalwindow`。

### 命令行构建
```bash
ohpm install
./hvigorw assembleHap
```

---

## 🔑 核心实现

### 1. DeepSeek AI 助手（`common/DeepSeekService.ts`）
> 使用 ArkTS 内置 `@ohos.net.http`，无需额外引入第三方库；`model` 默认 `deepseek-chat`。
### 2. 华为云设备数据拉取（`model/DataFetcher.ts`）
- 入口：`EntryAbility.onCreate` → `startDataFetching()`。
- ① 先向 **IAM** 请求 `x-subject-token` 并写入全局状态。
- ② 通过 `setInterval(..., 1000)` 每秒轮询 **IoTDA 设备影子**。
- ③ 解析 `shadow[0].reported.properties`，将 `illumination / temperature / humidity / ecgData` 写入 `MainViewModel`。
- ④ `MainViewModel` 对 ECG 采样点做**滑动窗口缓存**（上限 1000 点）。
### 3. 全屏登录模态（`casesfeature/modalwindow`）

## ⚙️ 配置说明

> **安全提示**：当前代码中 **DeepSeek API Key** 与 **华为云 IAM 子账号密码** 均为硬编码，公开仓库前务必改为环境变量或 UI 输入注入。

| 配置项 | 位置 | 说明 |
| --- | --- | --- |
| DeepSeek BaseURL / API Key | `DeepSeekService.ts` | `https://api.deepseek.com` |
| 华为云 IAM 账号 | `DataFetcher.ts` / `getToken.ts` | 账号 `hw058740476`，子账号 `car` |
| IoTDA 项目 / 设备 ID | `DataFetcher.ts` | `projectId` / `deviceId` 常量 |
| 网络权限 | `module.json5` | `ohos.permission.INTERNET` |
| 包名 / 应用名 | `AppScope/app.json5`、`string.json` | 建议将 `medicalapp` / `MyApplication` 改为车载相关命名 |

---

## 📄 页面清单

启动流程：`Index` → `LoadingPage` → `MainPage` → `Jiankong`（监控）/ `AIComponent`（AI）/ `MineComponent`（我的）。

其它页面：`PersonalInfoPage`、`SecurityPage`、`AboutPage`、`DeviceIdPage`、`DeviceNamePage`、`AvatarPickerPage`、`AgreementPage`、`hebing`。

---


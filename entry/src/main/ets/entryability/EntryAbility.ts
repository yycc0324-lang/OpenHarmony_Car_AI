import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { startDataFetching } from '../globalState'; // 确保路径正确

export default class EntryAbility extends UIAbility {
  onCreate(_want, _launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate')

    // ✅ 启动 HTTPS 实时数据拉取（推荐）
    startDataFetching()
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate')

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load content: %{public}s', JSON.stringify(err) ?? '')
        return
      }
      hilog.info(0x0000, 'testTag', 'Load success: %{public}s', JSON.stringify(data) ?? '')
    })
  }

  onWindowStageDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy')
  }

  onForeground() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground')
  }

  onBackground() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground')
  }
}


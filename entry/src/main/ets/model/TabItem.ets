export interface TabItem {
  icon: Resource;          // 图标（未选中）
  icon_selected: Resource; // 图标（选中）
  title: string;           // 标签文字
  id: number;              // TabID 枚举值
}

export enum TabID {
  DETECTOR,     // 主页
  SEARCH,       // 发现
  SEARCH_AI,
  JIANKONG = 3,// AI 医生
  MINE = 4       // 我的

}

export const TabItemList: TabItem[] = [
  {
    icon: $r('app.media.zhuye0'),
    icon_selected: $r('app.media.zhuye1'),
    title: '车载',
    id: TabID.DETECTOR
  },
  {
    icon: $r('app.media.faxian0'),
    icon_selected: $r('app.media.faxian1'),
    title: '控制',
    id: TabID.SEARCH
  },
  {
    icon: $r('app.media.AI0'),
    icon_selected: $r('app.media.AI1'),
    title: '车载AI',
    id: TabID.SEARCH_AI
  },
  {
    icon: $r('app.media.peo0'),
    icon_selected: $r('app.media.peo1'),
    title: '我的',
    id: TabID.MINE
  },
  {
    icon: $r('app.media.peo0'),
    icon_selected: $r('app.media.peo1'),
    title: '我的',
    id: TabID.MINE
  }
]

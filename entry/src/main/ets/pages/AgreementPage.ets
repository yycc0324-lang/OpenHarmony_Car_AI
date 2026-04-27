import router from '@system.router'

@Entry
@Component
export default struct AgreementPage {
  @State showAgreement: boolean = true
  @State showPrivacyPolicy: boolean = true

  build() {
    Column() {

      Text('《车载服务协议》')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .margin({ top: 20 })

      Button(this.showAgreement ? '收起' : '展开')
        .fontSize(14)
        .fontColor('#1677ff')
        .backgroundColor('transparent')
        .onClick(() => {
          this.showAgreement = !this.showAgreement
        })
        .margin({ top: 10, bottom: 10 })

      if (this.showAgreement) {
        Scroll() {
          Column({ space: 10 }) {
            Text('欢迎使用我们的智能车载服务。在使用本平台提供的任何功能前，请您仔细阅读以下《车载服务协议》（以下简称“本协议”）。本协议适用于所有使用本平台车载互联、远程控制与数据服务的用户。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })

            Text('1. 服务内容\n   本平台为您提供车辆远程控制、实时车况监测、导航与 OTA 升级、故障诊断、车联网娱乐等相关服务。我们将努力保证信息的准确性与及时性，但您应结合实际使用环境自行判断。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })

            Text('2. 用户责任\n   使用服务时，您需确保所绑定车辆信息真实、合法，并对所有操作行为及其结果负责。请勿利用平台进行任何可能影响车辆安全或违反法律法规的行为。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('3. 隐私保护\n   我们承诺严格保护您的车辆及个人数据，未经您同意不会向第三方披露，除非法律法规另有规定或为履行本协议之必要。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('4. 服务费用\n   部分高级功能（如高级导航包、增值远程控制服务等）可能收取费用。平台将在您使用前明确告知，只有在您确认并支付后方可使用。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('5. 免责声明\n   本平台提供的车辆数据和诊断信息仅供参考，不能替代专业维保意见。因依赖平台信息而导致的车辆损坏或其他后果，平台不承担任何责任。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('6. 协议变更\n   若本协议内容调整，我们将在平台发布更新并通知用户。您继续使用服务即视为接受变更内容。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('7. 联系我们\n   如对服务有任何疑问或建议，请通过平台提供的客服渠道与我们联系。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('本协议自发布之日起生效。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })
          }
        }
        .height('40%')
      }


      Text('《数据隐私保护政策》')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .margin({ top: 40 })

      Button(this.showPrivacyPolicy ? '收起' : '展开')
        .fontSize(14)
        .fontColor('#1677ff')
        .backgroundColor('transparent')
        .onClick(() => {
          this.showPrivacyPolicy = !this.showPrivacyPolicy
        })
        .margin({ top: 10, bottom: 10 })

      if (this.showPrivacyPolicy) {
        Scroll() {
          Column({ space: 10 }) {
            Text('本隐私政策（以下简称“政策”）适用于我们提供的所有车载互联服务，旨在阐述我们如何收集、使用、存储、保护与分享车辆及个人数据。请在使用服务前仔细阅读。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })

            Text('1. 数据收集\n   我们收集的个人及车辆数据包括但不限于：车辆识别信息（VIN）、行驶及里程数据、位置与导航记录、驾驶行为数据、账号联系方式等。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })

            Text('2. 数据使用\n   收集的数据将用于实现远程控制、车况诊断、路线规划、驾驶行为分析、提升用户体验及服务改进等用途。我们不会将您的数据用于未经授权的目的。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('3. 数据存储与保护\n   我们采用加密传输与存储，配合访问控制等安全技术防护措施，确保数据不被未经授权访问、泄露或篡改。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('4. 数据共享\n   除符合法律法规或经您明确授权的场景外，我们不会向第三方披露您的个人与车辆数据。如需与授权服务商共享数据，我们将遵循最小必要原则。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('5. 数据访问与删除\n   您可随时通过平台查看、导出或删除您的车辆与个人数据。如您需要帮助，可联系在线客服。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('6. 数据保留\n   我们仅在实现服务目的所必需的期限内保留数据，超期后将进行删除或匿名化处理。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('7. 政策变更\n   如本政策有重要变更，我们将通过平台公告或推送通知方式告知您。继续使用服务即表示您同意更新后的政策。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('8. 联系我们\n   若您对隐私保护有任何疑问，请通过平台客服渠道与我们联系。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 10, left: 20, right: 20 })

            Text('本隐私政策自发布之日起生效。')
              .fontSize(14).fontColor('#888888').textAlign(TextAlign.Start)
              .margin({ top: 20, left: 20, right: 20 })
          }
        }
        .height('40%')
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}

Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE578D512
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIG9-0002J9-7f; Wed, 30 Aug 2023 06:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1qbIG5-0002Ir-Cw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:17:09 -0400
Received: from mail-am7eur03on2115.outbound.protection.outlook.com
 ([40.107.105.115] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1qbIG1-0000fb-Qh
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:17:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPsJKmpA2LBQB/iutqBjHx7O+LahIj9oDIsBnq0jXqYJ0n+a6HODuyMt31AIzhzBWoPRg9of4So8Gh90YkeM6qTMRcZ67YeJslWqt32izSJlmjiZ3sWJh/pR6y5eDiIBeut91YIfH5klQAikQkNGoDkvRaRgNw/kKb2n8FwJkZGcgFghRp4NJuS71tkaDrjh85rHaR4Pf+LvzWucke9EFp8HA4phYTVjldmiQ2TtIajNoC0uqVzHgsImXPh0Sghe9tO8ZEH6GoauA2U5mDFh87BQ/BzzhtRuphtVyylftEis/5K1vO9luP+heHRyXabdljvXtT/VnKPzEmuexLlMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzmiQnZ3NSAsttJbiBAcs/hdNqFE5RqaDm3LbdpxJkE=;
 b=OKJ5uak0ejghhUDk+Zi/KA6gPZnWvH89TQ7kWnI2Q2MXNC0gGqs4F6S9u8XEC/4tQuK6Z43Zfyg5ISRku2b1xkpBC44wCy7np3BhQZgx0/wvPFHTuDtsI6GjkoB51LKEO8vRw9VW5yVMjZw5dF+YfW4Ymmqsk3h7KOVEwUxfz8PLXqWvvqSDFSpR42WYVmynE609/hspL7wg61FojpekB+yFS0w4FgCSwxpkrqGrQ69wGo+XcAGaRBd/YzdZqnLLDCPz/RfO6MqCoxcgvYEKUKBvI5lZ0yRRlBi+cL5c1c0DUoTKl6wyfxWqT6TDJFfxttePDOacr+wc37BnNJGooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com; 
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzmiQnZ3NSAsttJbiBAcs/hdNqFE5RqaDm3LbdpxJkE=;
 b=K9c/gdoTHZGfPwOzHmHvQ6pV0jZHE2V8STS/9laYGJ73EuTmveHoJ7qU7hVxZOQiU7AbmvAN2kz2JP4lAXCnSUUcDhS63qnshb2AxUA+9ogpSVlccJ46p6w7MKYvRySmBrRoviwduxsc7s4w43+dmn6c7HNlfWU8pq1kFo4Q8EQ=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PAXP189MB1648.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:11:59 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 10:11:59 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang
 <jasowang@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH 1/2] igb: Add a VF reset handler
Thread-Topic: [PATCH 1/2] igb: Add a VF reset handler
Thread-Index: AQHZ2lf/XK/MsYmlAk6JVv21epvecbACoAsA
Date: Wed, 30 Aug 2023 10:11:58 +0000
Message-ID: <DBBP189MB14333B3A5BDDE8C7C4E7074D95E6A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-2-clg@kaod.org>
In-Reply-To: <20230829090529.184438-2-clg@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PAXP189MB1648:EE_
x-ms-office365-filtering-correlation-id: b18009f5-31f9-4d1a-3f31-08dba9418bfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2aeNCUE0OGd7bg5a2OMVBQwnvV5fNM21NcHPBTnLl//PwYoaE/T4SUQ5RBLu5+3j0lDgydNE9JLjeexfnMeeYMMUnFeP1i6oUUG3jlQH3FTvL0z4DYecW9oo9lrI4XQCzoWzIAEMmBNRydaOKNtJTDygAwf6rhk9kWorLc/Z0W5NLMqMkpv6SuVQ0B+u1FSBxgMQA+uxoZzOyl8ejI8AQ02DR80psKbiLk7xEz+TX98ZRVZxn1e/slzqmw2+Ibw5oaCx87SG0DE5nu9blfHe3kdNRo8pLub+0bJQEhe/swq4LQU0NIL3AapMJv46hgO0/ji4eAP1tWbyV2ZDpPpT6ih3ocVQ08DVli/qY2OUv5mB98uKpLzv1OYvLZuDmkhHsl8w4hISN3s7weSEhA+TImaOIUWOny42tC4yOUl2tda1fQgsjqFPEdf0y2MRNr0b9sxwAYWwVzZNhJD0ulXwbaCj+wogj6kQTdItp4cF4Pw9LSG1/VeUK0K1r9/aJAbrsA/jBJr+OdUfkxXQBmVQPuH0r+q87oj5GhnxiOmEqxqLTb13igZZ0ThJBRqziD+xWmaENroqg3U4pCTU/o3JDF5TrhXZQ2+JTRh9fHuC9HfPXgohR1JVeS/+yypJlov
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39830400003)(376002)(451199024)(1800799009)(186009)(33656002)(55016003)(83380400001)(52536014)(86362001)(44832011)(41300700001)(5660300002)(53546011)(4326008)(8676002)(8936002)(6506007)(7696005)(26005)(71200400001)(9686003)(478600001)(76116006)(110136005)(4744005)(2906002)(38100700002)(38070700005)(122000001)(66556008)(66446008)(54906003)(66476007)(66946007)(64756008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhaWFdFT0w2U0lsd3l2REJPYWdpcXdWQTNBVEZ3OVEyZXd2SFQvQ3ZCY0di?=
 =?utf-8?B?emVycDNCdlJFUUdLTzZwOVhGaDU3VXJBaGJLc00xLytGY0JNWi8xU01DWml0?=
 =?utf-8?B?VC9WUDFMVnpzczNuQk05YXRxM2tybEZ2SGR4ak9ibDJCbzJlR1NaeHN2eUJU?=
 =?utf-8?B?OVBSYjNXOEp1dEhnQ0pIV0R0L0JXNjZWTUU0YnFVZTAxdC92SlJVQSsra2xt?=
 =?utf-8?B?eDROTm96QUNIZmJWbkJtZTdkamRYenVoME84YVljTGlSUHRXQzlLdS9HVG5D?=
 =?utf-8?B?Q2tITVFKRXFUbHpMSVFNSGI5cm9hNS93TFhKdWd2SVRVRTNtZHZyR241TUV6?=
 =?utf-8?B?cFhzKytHL3loMS85akZxb0pkUXJzNTBXbFU2NHN4OHRuQU92cUNvSjJBd3Ft?=
 =?utf-8?B?UXhaZkpBU2YxNlZtZ09YWEVBZ1hhKzJ1YnNFbWZzZHN1VncvV2RGRm50RnBF?=
 =?utf-8?B?UWFzOS9WdUNxejhXN09WRjBFaHZPZG9hMUwrRTFKQy9KVndobytxUVNIbnhq?=
 =?utf-8?B?TG15YXYrUytjMUNRb1pMeDJYNW5OSDVHem9uYWZJLzVjR1djRHZJUjJPVkxV?=
 =?utf-8?B?WGE1amdZSGhSRytNckRnTTZBUVdOZ3V1dDNGeG5wVllLdkJxcW1OSXNZbGQ5?=
 =?utf-8?B?em1DR1hvbjd2UXJoS3F6cUIwMzE2SE1ZQmVtUko1OHptOWxzbmZ0Mzhhb0pa?=
 =?utf-8?B?blErSDdhMDZrVzdBVm9meEIrM0RsQ0luRERVMnN0RFZjQXlwMks0emNDRXpj?=
 =?utf-8?B?OWZJek5YOTR0enJ2WTFzTlRmOStIeUlMWS9KWmc4ZUJzbnhSdVd6UVpTT3Rm?=
 =?utf-8?B?bTg3UlJRT1Q1U0dXL1RUQ01hbkRGd0FHcGgrRVNGN3M3c0lHaDQxRDJ4Y2or?=
 =?utf-8?B?WHNNZXBOck1oZWRRM0QrclpjdStzZTJnN3NJZ0ZjeFo4b2Q2WUJCODVzUGla?=
 =?utf-8?B?cDNIQTVqSVFRZkcwbGRUNUhvZVJYL0xWVjZkTmxtWTdtZzRRZDN1YTRXQWhj?=
 =?utf-8?B?L2ZTUnI4RFhtWlh3aUx0MnRzSUhIOTNOSlJVbFFveS9wdlc1ZDNQWFhndkhW?=
 =?utf-8?B?UWszZVdaZTU4V3VCdmdxa3dBZU10anpoeFM3b21Zc1o5ZmpkNDgzODMzMlhE?=
 =?utf-8?B?K1E4QkZESnZuelA4enU4enFnZjIzKzloZ05JakxnM2FRM1NEajFwVUtRczNt?=
 =?utf-8?B?a3lhSFQzNGExa2Rvc0FIS3pYSndma1hkT1UybEoxQkZxZEMybzVLY3FwM0h3?=
 =?utf-8?B?N0thbWt0TGRLbVVraXluaWxwM1ZRNC9RcGtXTVM1eTV6MkdOVGVsVzE3akc0?=
 =?utf-8?B?L1lIeXpEeVdKY1FKdjZOT2Q0eHMvSE5jOFNoeHQrRk1rU1dxRDlzWXpQTjVT?=
 =?utf-8?B?L2JkL1dydEduYnE2UHNza1ExdWVKM09WZngxcEo3OVlkQ1RGNzUvUEQ3dWdu?=
 =?utf-8?B?NlRiOFlKNDdBMmIxUUFkSlRvTFNCWlhGQXBRRTFNQkZLUzhJVnZ4YXlpZkVx?=
 =?utf-8?B?UTJMWXdJY1d3OG5yd0YwbzJZV1BnYWtUTVN5dmlkeEV2bTlIemo2UzBnYk1S?=
 =?utf-8?B?RmF3SGFVVkdYTGdXTll1NWN6K0tmRHpNVFkxQldYTTQ3L0tkN2Job05Ia1h0?=
 =?utf-8?B?YmVmM1lnbW0yT1RBcm52NDg2R285bW15OFNQYUlQd3EzUHBIOWUzYndkSVp2?=
 =?utf-8?B?NExaL0IxU1g3LzRLVmlMVUVFdm55U2FsVVFoYjNmWVdsWjl0cUtCODJncnBG?=
 =?utf-8?B?elRNSGZmQ1JyZmRNS3ZaVDRSMVhFUWtVMEdxd1RqV0FMaXpYai9QQlJRbGVS?=
 =?utf-8?B?eGhxS09tR3gxYW5ydzRMSzZzV3BMMDMvZ2ZCQW81UEM4ZXZMVHkxMDdXSEEw?=
 =?utf-8?B?dnVvc0xiLzN5N25TOStWVHA3KzVoQnN5S0RnbzhjOXQvV282WjBtWVYyWVlx?=
 =?utf-8?B?SDF0ZWFGcHRVdXR5N0JSOXp6YktZL08welp2U0NoVWJlVE52ajJRQ0RHVkV1?=
 =?utf-8?B?eWdhWUVEMWdveUJpQ3ZQRU9vUm50eUdzem1ZTUhXcnpFVTlPWElaOUhQWTdH?=
 =?utf-8?B?N1Jkd0NhbHRRMVFwaVkxZlhmOTZGMXo2M3ZtMTZJTVhFdWhWOXY1eUdKekdm?=
 =?utf-8?Q?aI2Rbqhn/aNXmY8Us4koLqboj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b18009f5-31f9-4d1a-3f31-08dba9418bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 10:11:58.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8v6GE/j/MN02H/AYu2CdqYLvURSgaoBnF0X0pbMPq8GzVTovKQezm7Ladn2gOtwxodOhRFDu4qAISnaQssmW3SIQfuLqQByu2w7p+z9OLuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1648
Received-SPF: pass client-ip=40.107.105.115;
 envelope-from=sriram.yagnaraman@est.tech;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAyOSBBdWd1c3QgMjAyMyAxMTowNQ0KPiBU
bzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9k
YWtpQGRheW5peC5jb20+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXN0LnRlY2g+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgQ8OpZHJpYw0KPiBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBpZ2I6IEFk
ZCBhIFZGIHJlc2V0IGhhbmRsZXINCj4gDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCj4gDQo+IEV4cG9ydCB0aGUgaWdiX3ZmX3Jlc2V0KCkgaGVscGVyIHJvdXRp
bmUgZnJvbSB0aGUgUEYgbW9kZWwgdG8gbGV0IHRoZSBJR0JWRg0KPiBtb2RlbCBpbXBsZW1lbnQg
aXRzIG93biBkZXZpY2UgcmVzZXQuDQo+IA0KPiBDYzogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPg0KPiBTdWdnZXN0ZWQtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmly
YW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L25ldC9pZ2JfY29tbW9uLmggfCAgMSAr
DQo+ICBody9uZXQvaWdiX2NvcmUuaCAgIHwgIDMgKysrDQo+ICBody9uZXQvaWdiLmMgICAgICAg
IHwgIDYgKysrKysrDQo+ICBody9uZXQvaWdiX2NvcmUuYyAgIHwgIDYgKysrKy0tDQo+ICBody9u
ZXQvaWdidmYuYyAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgaHcvbmV0L3RyYWNlLWV2ZW50cyB8
ICAxICsNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQoNClJldmlld2VkLWJ5OiBTcmlyYW0gWWFnbmFyYW1hbiA8c3JpcmFtLnlhZ25hcmFt
YW5AZXN0LnRlY2g+DQo=


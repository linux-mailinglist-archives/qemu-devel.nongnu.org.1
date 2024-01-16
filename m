Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91582E7D4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 03:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPYmZ-0001CW-Ey; Mon, 15 Jan 2024 21:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rPYmW-0001CK-R7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:02:24 -0500
Received: from mail-dm6nam04on2095.outbound.protection.outlook.com
 ([40.107.102.95] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rPYmU-0007Gw-O0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:02:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZX41D4CHNp25by/QAcZTNzonV20Mw7iqzlK7h+3MylunTMNP4jxGMlzOCrzkKqg9xMwQChkbsKxVvlcOAHAwcx0SJ+wBZdMzh/VQ3jWGXFEC7xO5gFhIP6sDwxlCRzs4sITqFw2WBiJsP4lOExlHkwxNIG3tn1WJ1jany6/2YJzlCcJY5ABPYS+foRoOZSiWQCP1CTQf02p6cm8OkSPYyth/4hILQYDK9DyieYV2PfeAPao5b5ktDqE2UbmpGdCxzhRX/4+fMMVh1oNKCihMQJEP1pZEoa2dCAYhEpqe486TspYUo+QyJjOY+YiRukB402KoHMwJXjgyGluD9ecZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t79Q/Q8FmY/hfyhMANQ7yCasi0Xm4CCTqDeCVTIxpRE=;
 b=dBuXvxEJUmfCdRg+7VRxUD0tqBJ0AH7sD2OEhN6f02u3ZAlvvMlXxGnnsE8wZDs0Sa4n6wDwsp9J/E/QhLUzkI6p6Iz+oe9XSrKwLfjd1qIw+KOyJk7y183IGKRPCD+NOwkdX/dypaFsVbG+Zh7q/KzSu0oI+NG79cCfmISnNywaXE5joAOGJcnesHSMsZZi+j7yjHJpCxQPKtgzKlA5AIYRglCqEqiEbtGCQUI3u0tOOmCHJvF+QEZOD9oqja1u1A2+1QJ/jTdxOgKT3eiQNzzkLzZ/ZxEIyxlrELpzZYyixGwPvlTCrrx8im62BgwJ+EnohYoicVnFujv7r+OtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t79Q/Q8FmY/hfyhMANQ7yCasi0Xm4CCTqDeCVTIxpRE=;
 b=tYvjXjN/VanaS7dpaj965yh9wuCaZJ3tRwK/fhxxdcTl7w/UZIpzEdnUWteon06NV3azcVQEi13kYVfXHpsHKLwk0ovWVbgskx84wCOCKD3Wba/nwRaWTJpfHYjxRQ2Ix3znsML0XfUSDCwY1dNiovVSZbLbN8plABo3Vg00Mo8w5e82NOpm5bfhwXu5m+5nAchbWqso0Xi/Ja6/ghpNNycUL+xLeVN1H19kBgUispzUMLnLPWAEJ6o+zWmhW0ut5sgwkw5sO6l18KXjWSX93DJ4lnmZ7jXLLOoTcqBeKMGRk5/3dRx8z8L3aUzDiG0pwSQzw4xSAFLpnI31/Mrxdw==
Received: from SN4PR13MB5727.namprd13.prod.outlook.com (2603:10b6:806:213::12)
 by MN2PR13MB3902.namprd13.prod.outlook.com (2603:10b6:208:1e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 01:57:17 +0000
Received: from SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350]) by SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350%4]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 01:57:16 +0000
From: Wentao Jia <wentao.jia@nephogine.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, Rick Zhong <zhaoyong.zhong@nephogine.com>
Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Topic: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8ygAfvHuzAAhk7OgAA1l2oA
Date: Tue, 16 Jan 2024 01:57:16 +0000
Message-ID: <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
In-Reply-To: <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR13MB5727:EE_|MN2PR13MB3902:EE_
x-ms-office365-filtering-correlation-id: a9d926b9-468f-422f-77bb-08dc16367783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8r4uybdOQuqya7311RIKSxW3Py1dIiEibNu3fRfbcqzbSEEo2PyNMtRk90arNVe2D4j3eCFvAxu7JNKP4Q66xiaBCFf2+H2FHO9sj51iSS3zjk8W8qMBw9zZfknQNBObUjj7I3vKDuyvMhQvB5tZ3Oc10FCmiATEGwdbbsIjfXC1TeljoMPcZYcnNTTfF7BZfZBJGIpxdPevCOtFqdWMZ/ydSbL42qdLYI06haCfekZ4JsJn9K66OE9VhajTpVxSU9hz0LCzp7KCOfevurEoaw3k2fmdmm3GL/3L3Pk60FDVyecWfBI6uoq3U5Uy/fG3K/ydfj5h4G9l8Qc9vjpZpESU+65bhrikgaABuYFsUiyPo/PaMFl75q1PNeXj6022NUDSOlEIqG36t7t2X7nChJWdZzlZYloDsNjXng1zCawSxgY76akCmHq8V7VB7lrfE+86Ed0vKPz4q551gzVL1Qqp0o0inmrbBEqnQ9GTKx52TCQLeSk2jLXncILeRbFOwlaXKcJVI0c4DEPfg7CnlvTmsZNDIhDoSOt798jLk37n4DpMdj5NaSo1kuxB6amK2yZLGtAsFuV50SCFU//RtTDcpkqVXNTlVbxYJjTCSMPJB6M3wTvd/Y3MXGikuisI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR13MB5727.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39840400004)(366004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(55016003)(107886003)(83380400001)(53546011)(71200400001)(7696005)(6506007)(86362001)(38100700002)(33656002)(38070700009)(122000001)(5660300002)(41300700001)(4326008)(44832011)(9686003)(66946007)(76116006)(66556008)(66476007)(54906003)(316002)(6916009)(64756008)(52536014)(66446008)(2906002)(8936002)(8676002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRaRzFmeTNFTTlGNzcveW5ac0laYTZKdWxLQ1J5WUlvSzBIZ05NaW1TVHFy?=
 =?utf-8?B?ZnUzcWt6dENxaWJjY3ZKTlYwWW5uY2hsdjBIOWNsejZPOFJkd25HeE5wa0xM?=
 =?utf-8?B?eWYvTVJicE1zZ2pZMytZSWtZV3hRT1NERUw3QzY2Um5JSGNuaC9wQ0FIWWM1?=
 =?utf-8?B?MjBUaVp3VGlqVVVLVnhIQUFzTDAwU3ZCdUlraTVVUFdPU1BvZzJxL0lxMVk2?=
 =?utf-8?B?dlZuVUZNZk8wMFl3MEF4SXRxdk9CZDhWNDA3TXhNWks2ZlhPUGJ3QklnTjJa?=
 =?utf-8?B?OCswUENrZVlveHZIbWdseWk1N2YxbS9QamdHUlVmaktxMTdRcDhENWFuL0pI?=
 =?utf-8?B?L1pvcGd0QzM0Z0dzM3M3V21rSjhPeS96V1FTUXpqSFpvd2tUcXJtb1BaS1ps?=
 =?utf-8?B?dGtmblA1YWlNaUx0MTZSRDdmUEIvR3lic1ArZGd0M1JZSDVETzhrZHZkNFZL?=
 =?utf-8?B?YW4rYU85TWJZMk95Uk54WXRBN1dFT3BTQ1lCaDFRNHYwWjZuRDhkaWtFNjV1?=
 =?utf-8?B?QUhNUmdMbTREbUFjKy9wZXI0QTZSS2xtM3l5WFlwa0VKQW90M2dHT1NaTTI5?=
 =?utf-8?B?bEdSMkJyL2ZSM3Y3dFMva3ZDdFo1akh5bWxXNVBGRjNTakdBU0lJRjhNRzY0?=
 =?utf-8?B?WEJrcjJtek9SMVV2WFZnckk0dXpZMzNlMURyU3lkUEliY01DNXY5NHlGQ0FB?=
 =?utf-8?B?NUNlSUwwTTlpSkcrakpPT1k2TWhwK0VVb3VhUUJuLytBWDBkd2M3Q1J4dWVz?=
 =?utf-8?B?UDBFRzF6ZndHUzJ4YndZQk83a3FGS25HcFNGNlExbkRLQm5ZTk9jemxYbkl5?=
 =?utf-8?B?NDFUdzlZN2hqeW1WcFpzeFVXRFBhT0VEbUJMNDNneXJkL3BrTDNTbi9USW9G?=
 =?utf-8?B?TXhpQjVYVkxGMWt5RHZ6aUZYNmVxTVV5UVNtMFEvRXI2M2lTK2o3ZE9NQWIv?=
 =?utf-8?B?cURpRlc5RTVlOVROVHhZRjVIV2QyWVBKR3NhVStYeFduMXJyVDdjZVdMRUdZ?=
 =?utf-8?B?cUpMT0lYTE5VUjRHYi8yenlLYWVRSjdEVjBhWkxKZFUzNnlMeGRHOGpnRzdI?=
 =?utf-8?B?a3V2UHRtL25UVTNaR0ZnSjRDTTlqVENRK1RTd2VaTnBId3VLSlV4Wk1vUGNt?=
 =?utf-8?B?SGdxUC9qckQvVDFtb0JDS3JrL3RRVThLb2Z4WGhOa1hGbDB5M0xYMG5XT0RU?=
 =?utf-8?B?SS9jcjU0aVNkYWZlN2gwRHIxUU1ON05WOGZqMGpkZG9VWHFPc1VRVUhraExo?=
 =?utf-8?B?MVhQUkhhUzkxYzRGR2l6WDl5TC9iT25WazUxSmNtdlByV0NTbnVXNE9xQmY4?=
 =?utf-8?B?S1VTNHR0TC9DZHhkSjlyWEZHYTBPK1pWZE5NUk5NMEs2TVp0ZSs5ODl3bld2?=
 =?utf-8?B?OEdEbFR6R2RLN3FJOHhScngxTk8xWTVmckdkaEdDOWY1bCtOZFREWmdhMVE5?=
 =?utf-8?B?RW15MGo2bUR1cG41aTN3MWNRVTBUNXprVXBHZVdOZTJBVGJVRWZPN0d4OGVL?=
 =?utf-8?B?R09nSWFJNlR5eDcrSTNOWkw2SU9kdythOEZnSmVlZGNmeGJnOWp0cnV6MnRV?=
 =?utf-8?B?Tlg1aGt2a2ZlbUV6WkZQSDNteDN0M1Z3RG1TS3pjL2V0blBXcENtRUlwMkJp?=
 =?utf-8?B?RkNHSWVQWmhlTjlXZnJNQ3RKU1A3anoxT0RvRGhwYUtMcTVNRE5jL2grVjNv?=
 =?utf-8?B?WnN1WCtGZ3k5Rkt3bkpvYVY2azhCU2RPak1aWTY3ekdWdUNYc0lTUHQ0blQ4?=
 =?utf-8?B?U2VVekhWWDFMWXlBaDlnUHEvQjZGZnJRdUJwTnZTZ0pkajc4ZDBXWXA3aWY1?=
 =?utf-8?B?UVMvV1IrMmUyVnRTOHladTdoWHlySzBPMVBCamZyNTlZZmQvVVgyQng2Vks4?=
 =?utf-8?B?Q0Rrb2VsOXdXWHNGTFhBQU4rMk5WakxyYTBWL1pMc3R1RkFMdEltenNTNFZk?=
 =?utf-8?B?dG9TTnc1T3hnNTByZUE1RUpsZS9WaDdpdTRWY3RCWktCTFRhSklEdlZFN1hv?=
 =?utf-8?B?NXhwQ0hvS3hjREcvT1JFa1JPVUVsMDdPbXhHZ211NjcvYy9MMGV2M0tFb051?=
 =?utf-8?B?WjNyMXAwUlJUbFhQbkFLN1luL1RJWjJwV3ppb2QvZDgrL2ZmRVNnQlYvY2Ir?=
 =?utf-8?Q?4ePo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR13MB5727.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d926b9-468f-422f-77bb-08dc16367783
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 01:57:16.8617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAZikFMUCO/wDuzUj1/ANxVU8VXRF1qAW0KG47U7CHl6v6QxOgQR3jGJ0YXnVkMBYS1OsYC1CNY1HDWdHpDG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3902
Received-SPF: pass client-ip=40.107.102.95;
 envelope-from=wentao.jia@nephogine.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGksIEphc29uDQoNCkkganVzdCBhZGQgdHdvIGZlYXR1cmVzIGluIHZob3N0IHVzZXIgZmVhdHVy
ZSBiaXRzLCBUaGUgcGF0Y2ggd2FzIHRlc3RlZCBpbiBteSBlbnZpcm9ubWVudA0KSSBkbyBub3Qg
a25vdyB3aGF0IHRoZSBjb21wYXRpYmlsaXR5IG1lYW4NCg0KV2VudGFvDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiAN
ClNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNSwgMjAyNCA4OjE4IEFNDQpUbzogV2VudGFvIEppYSA8
d2VudGFvLmppYUBuZXBob2dpbmUuY29tPg0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgbXN0
QHJlZGhhdC5jb207IFJpY2sgWmhvbmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQpT
dWJqZWN0OiBSZTogRlc6IFtQQVRDSF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJT19GX0lOX09SREVS
IGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlDQoNCk9uIEZyaSwgSmFuIDEy
LCAyMDI0IGF0IDQ6MTjigK9QTSBXZW50YW8gSmlhIDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+
IHdyb3RlOg0KPg0KPiBIaSwgTWljaGFlbCBhbmQgSmFzb24NCj4NCj4gRG8geW91IGhhdmUgYW55
IG90aGVyIGNvbW1lbnRzPw0KPiBJcyB0aGVyZSBhIHNjaGVkdWxlIGZvciBtZXJnZSB0aGUgcGF0
Y2ggaW50byB0aGUgY29tbXVuaXR5Pw0KPiBUaGFuayB5b3UNCg0KSSB0aGluayBhcyBkaXNjdXNz
ZWQsIHdlIG5lZWQgdG8gYWRkIGNvbXBhdGliaWxpdHkgc3VwcG9ydCBmb3IgdGhvc2UgZmVhdHVy
ZXMuDQoNClRoYW5rcw0KDQo+DQo+IFdlbnRhbw0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBXZW50YW8gSmlhDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMiwgMjAy
NCAxOjU3IFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6ICdtc3RAcmVkaGF0
LmNvbScgPG1zdEByZWRoYXQuY29tPjsgUmljayBaaG9uZyANCj4gPHpoYW95b25nLnpob25nQG5l
cGhvZ2luZS5jb20+OyAnSmFzb24gV2FuZycgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBGVzogW1BBVENIXSB2aG9zdC11c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5k
IA0KPiBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlDQo+DQo+DQo+IC0tLQ0KPiAg
aHcvbmV0L3Zob3N0X25ldC5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3Zob3N0X25ldC5jIGIvaHcvbmV0L3Zob3N0
X25ldC5jIGluZGV4IA0KPiBlOGUxNjYxNjQ2Li4yMTFjYTg1OWE2IDEwMDY0NA0KPiAtLS0gYS9o
dy9uZXQvdmhvc3RfbmV0LmMNCj4gKysrIGIvaHcvbmV0L3Zob3N0X25ldC5jDQo+IEBAIC03Niw2
ICs3Niw4IEBAIHN0YXRpYyBjb25zdCBpbnQgdXNlcl9mZWF0dXJlX2JpdHNbXSA9IHsNCj4gICAg
ICBWSVJUSU9fRl9JT01NVV9QTEFURk9STSwNCj4gICAgICBWSVJUSU9fRl9SSU5HX1BBQ0tFRCwN
Cj4gICAgICBWSVJUSU9fRl9SSU5HX1JFU0VULA0KPiArICAgIFZJUlRJT19GX0lOX09SREVSLA0K
PiArICAgIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBLA0KPiAgICAgIFZJUlRJT19ORVRfRl9S
U1MsDQo+ICAgICAgVklSVElPX05FVF9GX0hBU0hfUkVQT1JULA0KPiAgICAgIFZJUlRJT19ORVRf
Rl9HVUVTVF9VU080LA0KPiAtLQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBXZW50YW8gSmlhDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMiwgMjAyNCAxOjM4IFBN
DQo+IFRvOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBDYzogbXN0QHJlZGhh
dC5jb207IFJpY2sgWmhvbmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQo+IFN1Ympl
Y3Q6IFJFOiBGVzogW1BBVENIXSB2aG9zdC11c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5k
IA0KPiBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlDQo+DQo+IEhpLCBKYXNvbg0K
Pg0KPiBJdCBpcyBnb29kIGp1c3QgY2hhbmdlIGZlYXR1cmUgYml0cywgSSB3aWxsIGNvbW1pdCBh
IG5ldyBwYXRjaCwgdGhhbmtzDQo+DQo+IFdlbnRhbyBKaWENCj4NCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4g
U2VudDogVHVlc2RheSwgSmFudWFyeSAyLCAyMDI0IDExOjI0IEFNDQo+IFRvOiBXZW50YW8gSmlh
IDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgUmljayBa
aG9uZyA8emhhb3lvbmcuemhvbmdAbmVwaG9naW5lLmNvbT4NCj4gU3ViamVjdDogUmU6IEZXOiBb
UEFUQ0hdIHZob3N0LXVzZXI6IGFkZCBWSVJUSU9fRl9JTl9PUkRFUiBhbmQgDQo+IFZJUlRJT19G
X05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUNCj4NCj4gT24gVHVlLCBKYW4gMiwgMjAyNCBhdCAx
MDoyNuKAr0FNIFdlbnRhbyBKaWEgPHdlbnRhby5qaWFAbmVwaG9naW5lLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBIaSwgTWljaGFlbCAgYW5kIEphc29uDQo+ID4NCj4gPg0KPiA+DQo+ID4gcGxlYXNl
IHJldmlldyB0aGUgcGF0Y2ggYXQgeW91ciBjb252ZW5pZW5jZSwgdGhhbmsgeW91DQo+ID4NCj4g
PiB2aG9zdC11c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNB
VElPTl9EQVRBIA0KPiA+IGZlYXR1cmUgLSBQYXRjaHdvcmsgKGtlcm5lbC5vcmcpDQo+ID4NCj4g
Pg0KPiA+DQo+ID4gV2VudGFvIEppYQ0KPiA+DQo+ID4NCj4gPg0KPiA+IEZyb206IFdlbnRhbyBK
aWENCj4gPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDEsIDIwMjMgNjoxMSBQTQ0KPiA+IFRvOiBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIHZob3N0LXVzZXI6IGFk
ZCBWSVJUSU9fRl9JTl9PUkRFUiBhbmQgDQo+ID4gVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEg
ZmVhdHVyZQ0KPiA+DQo+ID4NCj4gPg0KPiA+IFZJUlRJT19GX0lOX09SREVSIGFuZCBWSVJUSU9f
Rl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlIGFyZSANCj4gPiBpbXBvcnRhbnQgZmVhdHVyZQ0K
PiA+DQo+ID4gZm9yIGRwZGsgdmRwYSBwYWNrZXRzIHRyYW5zbWl0dGluZyBwZXJmb3JtYW5jZSwg
YWRkIHRoZSAyIGZlYXR1cmVzIA0KPiA+IGF0IHZob3N0LXVzZXINCj4gPg0KPiA+IGZyb250LWVu
ZCB0byBuZWdvdGlhdGlvbiB3aXRoIGJhY2tlbmQuDQo+ID4NCj4gPg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogS3lsZSBYdSB6aGVuYmluZy54dUBjb3JpZ2luZS5jb20NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFdlbnRhbyBKaWEgd2VudGFvLmppYUBjb3JpZ2luZS5jb20NCj4gPg0KPiA+IFJl
dmlld2VkLWJ5OiAgIFhpbnlpbmcgWXUgeGlueWluZy55dUBjb3JpZ2luZS5jb20NCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiAgIFNodWppbmcgRG9uZyBzaHVqaW5nLmRvbmdAY29yaWdpbmUuY29tDQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogICBSaWNrIFpob25nIHpoYW95b25nLnpob25nQGNvcmlnaW5l
LmNvbQ0KPiA+DQo+ID4gLS0tDQo+ID4NCj4gPiBody9uZXQvdmhvc3RfbmV0LmMgICAgICAgICB8
IDIgKysNCj4gPg0KPiA+IGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIHwgNCArKysrDQo+ID4N
Cj4gPiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4NCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9ody9uZXQvdmhvc3RfbmV0LmMgYi9ody9uZXQvdmhvc3RfbmV0LmMNCj4g
Pg0KPiA+IGluZGV4IGU4ZTE2NjE2NDYuLjIxMWNhODU5YTYgMTAwNjQ0DQo+ID4NCj4gPiAtLS0g
YS9ody9uZXQvdmhvc3RfbmV0LmMNCj4gPg0KPiA+ICsrKyBiL2h3L25ldC92aG9zdF9uZXQuYw0K
PiA+DQo+ID4gQEAgLTc2LDYgKzc2LDggQEAgc3RhdGljIGNvbnN0IGludCB1c2VyX2ZlYXR1cmVf
Yml0c1tdID0gew0KPiA+DQo+ID4gICAgICBWSVJUSU9fRl9JT01NVV9QTEFURk9STSwNCj4gPg0K
PiA+ICAgICAgVklSVElPX0ZfUklOR19QQUNLRUQsDQo+ID4NCj4gPiAgICAgIFZJUlRJT19GX1JJ
TkdfUkVTRVQsDQo+ID4NCj4gPiArICAgIFZJUlRJT19GX0lOX09SREVSLA0KPiA+DQo+ID4gKyAg
ICBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSwNCj4gPg0KPiA+ICAgICAgVklSVElPX05FVF9G
X1JTUywNCj4gPg0KPiA+ICAgICAgVklSVElPX05FVF9GX0hBU0hfUkVQT1JULA0KPiA+DQo+ID4g
ICAgICBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNCwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3ZpcnRpby92aXJ0aW8uaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oDQo+ID4N
Cj4gPiBpbmRleCBjOGY3Mjg1MGJjLi4zODgwYjY3NjRjIDEwMDY0NA0KPiA+DQo+ID4gLS0tIGEv
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmgNCj4gPg0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvdmly
dGlvL3ZpcnRpby5oDQo+ID4NCj4gPiBAQCAtMzY5LDYgKzM2OSwxMCBAQCB0eXBlZGVmIHN0cnVj
dCBWaXJ0SU9STkdDb25mIFZpcnRJT1JOR0NvbmY7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELCBmYWxzZSksIFwNCj4gPg0KPiA+ICAgICAgREVG
SU5FX1BST1BfQklUNjQoInF1ZXVlX3Jlc2V0IiwgX3N0YXRlLCBfZmllbGQsIFwNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfUklOR19SRVNFVCwgdHJ1ZSkNCj4gPg0K
PiA+ICsgICAgREVGSU5FX1BST1BfQklUNjQoIm5vdGlmaWNhdGlvbl9kYXRhIiwgX3N0YXRlLCBf
ZmllbGQsIFwNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfTk9USUZJ
Q0FUSU9OX0RBVEEsIHRydWUpLCBcDQo+ID4NCj4gPiArICAgIERFRklORV9QUk9QX0JJVDY0KCJp
bl9vcmRlciIsIF9zdGF0ZSwgX2ZpZWxkLCBcDQo+ID4NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19GX0lOX09SREVSLCB0cnVlKQ0KPg0KPiBEbyB3ZSB3YW50IGNvbXBhdGliaWxp
dHkgc3VwcG9ydCBmb3IgdGhvc2U/DQo+DQo+IFRoYW5rcw0KPg0KPiA+DQo+ID4NCj4gPg0KPiA+
IGh3YWRkciB2aXJ0aW9fcXVldWVfZ2V0X2Rlc2NfYWRkcihWaXJ0SU9EZXZpY2UgKnZkZXYsIGlu
dCBuKTsNCj4gPg0KPiA+IGJvb2wgdmlydGlvX3F1ZXVlX2VuYWJsZWRfbGVnYWN5KFZpcnRJT0Rl
dmljZSAqdmRldiwgaW50IG4pOw0KPiA+DQo+ID4gLS0NCj4NCg0K


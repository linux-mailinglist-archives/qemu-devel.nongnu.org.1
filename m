Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781BE82D52E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 09:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPIXg-0006RI-PL; Mon, 15 Jan 2024 03:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <troy_lee@aspeedtech.com>)
 id 1rPIXc-0006Qx-6B
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:41:56 -0500
Received: from mail-psaapc01on2121.outbound.protection.outlook.com
 ([40.107.255.121] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <troy_lee@aspeedtech.com>)
 id 1rPIXZ-0005gp-4S
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:41:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNXtwNoeZYw0wE1UxiA2t4mH96tmAcN/M6a6FNI5n8DarnVrhfKelwIpFkdKDAuW7wvN5Fq9+qZ+lrzdNr44GAfEPcmrISapIkGZpSMC04V4Y3O5OPZ6G9qxqgw0yn0yPvIraax9pSG4tU2vF/VXs5P/8dqArgdjXe4ECiQZVIp/U0gJy9lZArIOaEON8ktueielbJw3oORz9/omvYPT4w9Coercn7oTVeCWWnLQ9lr91P25Qhap87Hqx5V5xFZbunu11ACZXdI1aCwjWRHJ9nEUHtINfkBadRzqCzEkXDDuKxjv8bxv1islJnPBxGTJjOcXwzpr5g/WG1vOkeFQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt1tyZeskVs3FIZ2zsnwmmhEZvelUDbotOWdSxGlgTs=;
 b=VXyxVYAuRoGH/1buAWitDXOJ9JVls1YJVKcmFXduylNDz5O8sqpOcotFwX5ubQUChDc5xU3ytGrwkAmp1M1GaJ2+KfwYTnYyW4X9bRTbL5e2NmAPDra7sg8TaWAHCZS5HHgusk+Gc/6RjYakdnOppMMzXtRWqD9RNi+4HikCj9FkmcJ4+kbkJREpNrSQ1xFdMgT84yd/G+AAHyy5IkJfFP9cTPmDZ01EyanVy0UFMVtZ3RdydIL6Qqq6DaMifO9eb3l0/tp30/nCJfVobiDqD0LjQVEOQT7B4rUXbTB2JTxXA2Y3iBrLaJqFh6PNOh9lOV/qEWUgF8kXipsqOGr1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt1tyZeskVs3FIZ2zsnwmmhEZvelUDbotOWdSxGlgTs=;
 b=pqQqvXiixQH+plLsCfVV2Cjo617a77QF17x+Q5pQ26lnPom3XNI8ekSlQsTgi6u/IDlmfkOoOmLhTXct2VPOEZyYF3Gf3vltLVR5rpUcfXa9GQxa+7g59Zp/xJr+FvaKiz3PEr+EIkZh1+zQ1d9hy+dcZ9uhqzs1NDapiBTdrW5Yb2LG68uKraYsG5rhzzRZ5Of8Ol72vGIrbht5H5477qkAlCAmJezSN6JvNdROV3cZDmMtnwmBNnYb52uy51DRIlwN/dgTekc10qMGMTx4ziIT689UQh8jGu+Ux9Qa8NR9MOMmIP5sywt8Y0rPGlb5OhMHQzsbHoq8fapMkHmh6w==
Received: from TYUPR06MB6100.apcprd06.prod.outlook.com (2603:1096:400:357::10)
 by JH0PR06MB7013.apcprd06.prod.outlook.com (2603:1096:990:70::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 08:36:42 +0000
Received: from TYUPR06MB6100.apcprd06.prod.outlook.com
 ([fe80::4292:8629:68b6:6f7d]) by TYUPR06MB6100.apcprd06.prod.outlook.com
 ([fe80::4292:8629:68b6:6f7d%6]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 08:36:41 +0000
From: Troy Lee <troy_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Stephen Longfield
 <slongfield@google.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: RE: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
Thread-Topic: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
Thread-Index: AQHaRLUv8MiMcTqDikaM8Q822PjFQ7DWYLAAgAQv4zA=
Date: Mon, 15 Jan 2024 08:36:41 +0000
Message-ID: <TYUPR06MB6100E421E040739C5A9B67FB8A6C2@TYUPR06MB6100.apcprd06.prod.outlook.com>
References: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
 <484ebf77-6b62-418c-8319-d69ccaf90c17@kaod.org>
In-Reply-To: <484ebf77-6b62-418c-8319-d69ccaf90c17@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6100:EE_|JH0PR06MB7013:EE_
x-ms-office365-filtering-correlation-id: 504cd845-227d-4de3-d2d0-08dc15a51958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGfgn7JqHb3BJaMA9KhZ6GnJwa+2AoCEA48MbFxWDEungFywOS2Q6D63Km8GhCBVsa8L2M2r7W5QopiE0bo1cltX62bOcd79r2w2kshzEzUrpWOkYZiISvLv2fcTnsFQj6fuHXZMVCBcexKKhjAkL6A8wIGp/Y3dbrNXsuS732EbR0z4ZtbcCmmN3FzqxkITsmuxAwLmGPSf4RNlr49hdZiGj1V1ggZiv3Pyf1XDGEQhB9BVooxr0PHFiMGdwMAM5wmpGj703m2pHpwMqyVlc0WzaFioQAKoE1pgycZBPSlLrolHRBo0lh6XEZGD09nj0CyZEdEQM/kfWla56gV/Jokq4qjkKPyaZPLAMO2+E2rqaWk1eGQngc2CLLLb0siCK+nfHtGCMIzwF3Ab4IbLrXY7OTaVS+k1f8LZA8GHDGndPJXwew6yqJYQHABJPwBFcivM8/tf2JtLlqZpOks+fKiyACsdLHtVC2huHWQyD309LKdMHUuu5qncN04P/MSgvE1wTGGVu+5JyxHszqNtBNLhzA7sgrx8O1XtU+ezsS0OTBs6tBXNddY3GhKPSxHSt/TjP08lUsRmH73MJyY85SyQS8Nz3ZgrVcKnjiKLhL4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYUPR06MB6100.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39850400004)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(38070700009)(55016003)(33656002)(110136005)(8936002)(54906003)(66476007)(8676002)(66446008)(83380400001)(66556008)(966005)(41300700001)(478600001)(52536014)(53546011)(4326008)(66946007)(76116006)(64756008)(6506007)(7696005)(71200400001)(316002)(86362001)(5660300002)(107886003)(2906002)(9686003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVyc3pJR2cxamduSnRtMktjdWQzMkZVbFd4UUwwaHNFNEkwcmZMak54ZU9U?=
 =?utf-8?B?eFFaNGRNc0I3SnZDZVg1RUR3enZTY1BKTTk1NlNGSk1EQzMzY0pGbWdvTVA1?=
 =?utf-8?B?Vmt2UkJ4UTZTa1Y5Yk00NVVKTm5MN0ZldnFESWsrbVBYMXNxT3p5aWxzeE5n?=
 =?utf-8?B?VUI2Z0pEbjVuc1pBS0h6Z0E1VEppNXRqeVl6TitwZm9KY2c5anNSUDg4M3hN?=
 =?utf-8?B?Q0t3SjN3TEkzYVdDa3FXV1V4K2c1Q3p6bnVjM0JkWTRxOVZ6YlAyZFZkdmlh?=
 =?utf-8?B?L2N0Q3NXVXl0RnJLa2h5V1NxbUx3K2NPbFJ6a0t1MkVpU0VnTVNKamJnOXZ2?=
 =?utf-8?B?MG9oTmozcjBnQlJiZnZkUUlmTjE3UTBJb3ZuKzhGeG0zUUhRVUNoTDE1R2Q1?=
 =?utf-8?B?eE9GWXFQeXlSSXlGRklEMTFHdzVEYTNGVGRuNzFDeUZYelBjZUtlQ0JJS2NO?=
 =?utf-8?B?YUNQdlZMSTd6Z0ZjS3ZzK3Rxcys1WXRkZXhGT0I0ZkNPUlJBMDdvclJpTHox?=
 =?utf-8?B?TVNIRmIxOGQxOGNRRWNKaHlMWmJQSGRXajdKR0tPUzZmRG9GUk9KRjVMWWI0?=
 =?utf-8?B?UTBHNS8zcTZYdDBvMlZWNWJTZkdNbEhqNGx1eUplMHJqbnRURFRHL1hTa3pr?=
 =?utf-8?B?UGhmVkxHekh0ZG5UeElrVmFBSVhUbkQ2L2oxcDIyeFhpQlBDTDRlYkxoT0Fs?=
 =?utf-8?B?bGVxMEE1VnVhUlBReFhZOXczZEV5ZDcrK0pVMkJLNFZ5cTNsNTZjRnZYZ2NE?=
 =?utf-8?B?ZFJNUmtYVW5ZTXNJRllxWVdNZzU1SFpkQ2dGYWFxOXFrZmlaT3NqajBIbk1W?=
 =?utf-8?B?Z2x3OVlncnhNVjNaWEFkVzNzNkZEU3RGczVxNW1JNXQwRkJDL2JETUlkMnhD?=
 =?utf-8?B?MnBuTTgxY2Zydmx5YW5jZTFNUVZhczZkQlRXTW82Zyt5MElZUzY1SDhaRmNB?=
 =?utf-8?B?eHRVQ05tQmZmM1ZzeE5Gd3V1TXRGdWltQXpBVmk0WTdXUk4ydFl2ZFBFREVR?=
 =?utf-8?B?Y29JOFliY21OTUtlT1pVVTRzWUZFWHlMczd3REFKckxZNWR3ZXQrUHQxcG1m?=
 =?utf-8?B?MU5mcTRiMCtXRi9acCtrV0lqbFBRSjRlQ3VhSmZBb2JqSEUvS1M5Sk9JTVhT?=
 =?utf-8?B?MHQ4Vmh2SFcxN284WGdnOTh1L2pPdUVLM3pCSjYvSXhMZUsybjhWeEpjQWZE?=
 =?utf-8?B?eWNqYjg3aVhURlRVdG0rVG51a0QwbVJjYi9DQVk2QVYwUHk0OVB0OVR1L1R3?=
 =?utf-8?B?bk5WYml3WWVZeDBJSW1RUDE2cG9YOE5CMnhycUdQU0RPdVllVStVTGZvaVpo?=
 =?utf-8?B?RFJKMEdzY2lmZEt4djVLWXEvSGU0V3lybE9HcTlJVCsvMFVIY3pwVGV0OVRU?=
 =?utf-8?B?WXBTL0tiYmplTlZqS0oxSXp0ZmU0V0RJaUtFRGNTRmFxc0lYMjJMb0Y5WExk?=
 =?utf-8?B?djRybjZZMkxYTFJXOVoxQWRSL1dxaXYvTE5NYmJCaWtFY3JlMnhDNXpZa1Z4?=
 =?utf-8?B?U0x3Um1vb0drMk1kKzBMMGluQko3Uk41VVBDWXMybDBlUGUzN1BTRFN1YTA5?=
 =?utf-8?B?ekJHTTR6UUNpdU11aHlNdzM1bWd6QVhhV2JtMnYvbTJPcGI1WTc2Yk9wZHhD?=
 =?utf-8?B?UGhGUXdXUVVsaVFqc0ZDYkNyVS9sWVkydFJ5UWtpbXBicXhMUkgvbTgzWjdH?=
 =?utf-8?B?dkJTd0c2KzU0WS9BN3dLdkhIcW85REQzbkYvYkNXdHZmbFZmeTI3K0V2NEsy?=
 =?utf-8?B?cmRZOHpvQndUZm5DYXFOTEJ3SDhhb0pBYy9KMlNpQUVtQUtmK2oxKzhDSm56?=
 =?utf-8?B?RVY4Wk1QR0p0VUYrd2c5cFhUa3JSYXM2eXZqSVg0RXJDNkpwaFp1dTZRaTAx?=
 =?utf-8?B?R0hSUFRsUkw5Wmt6VXNqbDU2aTdoUmtnanppOTV4REdWbEhyWTMybDBHNUFU?=
 =?utf-8?B?ekY4Y0dNZy9hODJBRi8wcGtsbHcyVUhUakJaaUIvOEhPUlNSZ2g4SWkwU3Fm?=
 =?utf-8?B?R25aVVArOWlsNnFiY0lobE1XVFhGdWJlRU1FUkhKMXpBQUlZMEk2WlFjUXd4?=
 =?utf-8?B?a2VCV1hhd0tZZ2ZKdGdQdVhPWEtaZFVCZ2tFZlR2YndKMktxSVNYWCt2SmdY?=
 =?utf-8?Q?UhrEYfOQe3wi1mmP25tioQ38c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6100.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504cd845-227d-4de3-d2d0-08dc15a51958
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:36:41.8350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJzXZcsaPfLCfDSahkRVIUG6Bga/xXooZEVVphsgSzD5zIhgf+7dXnjRvMIegow0tI1+/O2LKTLynsMV/LsaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7013
Received-SPF: pass client-ip=40.107.255.121;
 envelope-from=troy_lee@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgU3RlcGhlbiBhbmQgQ2VkcmljLA0KDQpUaGlzIGlzc3VlIGhhdmVuJ3QgYmVlbiBmb3VuZCBp
biByZWFsIHBsYXRmb3JtIGJ1dCBzb21ldGltZSBoYXBwZW5zIGluDQplbXVsYXRvciwgZS5nLiBT
aW1pYy4gDQoNCj4gQWRkaW5nIEFzcGVlZCBFbmdpbmVlcnMuIFRoaXMgcmVtaW5kcyBtZSBvZiBh
IGRpc2N1c3Npb24gYSB3aGlsZSBhZ28uDQo+IA0KPiBPbiAxLzExLzI0IDE4OjM4LCBTdGVwaGVu
IExvbmdmaWVsZCB3cm90ZToNCj4gPiBXZeKAmXZlIG5vdGljZWQgaW5jb25zaXN0ZW50IGJlaGF2
aW9yIHdoZW4gcnVubmluZyBhIGxhcmdlIG51bWJlciBvZiBhc3BlZWQNCj4gYXN0MjYwMCBleGVj
dXRpb25zLCB0aGF0IHNlZW1zIHRvIGJlIHRpZWQgdG8gYSByYWNlIGNvbmRpdGlvbiBpbiB0aGUg
c21wIGJvb3QNCj4gd2hlbiBleGVjdXRpbmcgb24gVENHLVFFTVUsIGFuZCB3ZXJlIHdvbmRlcmlu
ZyB3aGF0IGEgZ29vZCBtZWRpYXRpb24NCj4gc3RyYXRlZ3kgbWlnaHQgYmUuDQo+ID4NCj4gPiBU
aGUgcHJvYmxlbSBmaXJzdCBzaG93cyB1cCBhcyBwYXJ0IG9mIFNNUCBib290LiBPbiBhIHJ1biB0
aGF04oCZcyBsaWtlbHkgdG8NCj4gbGF0ZXIgcnVuIGludG8gaXNzdWVzLCB3ZeKAmWxsIHNlZSBz
b21ldGhpbmcgbGlrZToNCj4gPg0KPiA+IGBgYA0KPiA+IFsgwqAgwqAwLjAwODM1MF0gc21wOiBC
cmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NCj4gPiBbIMKgIMKgMS4xNjg1ODRdIENQVTE6
IGZhaWxlZCB0byBjb21lIG9ubGluZSBbIMKgIMKgMS4xODcyNzddIHNtcDogQnJvdWdodA0KPiA+
IHVwIDEgbm9kZSwgMSBDUFUgYGBgDQo+ID4NCj4gPiBDb21wYXJlZCB0byB0aGUgbW9yZSBsaWtl
bHkgdG8gc3VjY2VlZDoNCj4gPg0KPiA+IGBgYA0KPiA+IFsgwqAgwqAwLjA4MDMxM10gc21wOiBC
cmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NCj4gPiBbIMKgIMKgMC4wOTMxNjZdIHNtcDog
QnJvdWdodCB1cCAxIG5vZGUsIDIgQ1BVcyBbIMKgIMKgMC4wOTMzNDVdIFNNUDoNCj4gPiBUb3Rh
bCBvZiAyIHByb2Nlc3NvcnMgYWN0aXZhdGVkICg0ODAwLjAwIEJvZ29NSVBTKS4NCj4gPiBgYGAN
Cj4gPg0KPiA+IEl04oCZcyBzb21ld2hhdCByZWxpYWJseSByZXByb2R1Y2libGUgYnkgcnVubmlu
ZyB0aGUgYXN0MjYwMC1ldmIgd2l0aCBhbg0KPiBPcGVuQk1DIGltYWdlLCB1c2luZyDigJgtaWNv
dW50IGF1dG/igJkgdG8gc2xvdyBleGVjdXRpb24gYW5kIG1ha2UgdGhlIHJhY2UNCj4gY29uZGl0
aW9uIG1vcmUgZnJlcXVlbnQgKGl0IGhhcHBlbnMgd2l0aG91dCB0aGlzLCBqdXN0IGVhc2llciB0
byBkZWJ1ZyBpZiB3ZQ0KPiBjYW4gcmVwcm9kdWNlKToNCj4gPg0KPiA+DQo+ID4gYGBgDQo+ID4g
Li9hYXJjaDY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbWFjaGluZSBhc3QyNjAwLWV2
YiAtDQo+IG5vZ3JhcGhpYw0KPiA+IC1kcml2ZQ0KPiA+IGZpbGU9fi9ibWMtYmluL2ltYWdlLW9i
bWMtYXN0MjYwMCxpZj1tdGQsYnVzPTAsdW5pdD0wLHNuYXBzaG90PW9uIC1uaWMNCj4gPiB1c2Vy
IC1pY291bnQgYXV0byBgYGANCg0KSGF2ZSB5b3UgdHJ5IHRvIHJ1biBxZW11IHdpdGggIi1zbXAg
MiI/DQoNCj4gPg0KPiA+IE91ciBjdXJyZW50IGh5cG90aGVzaXMgaXMgdGhhdCB0aGUgcHJvYmxl
bSBjb21lcyB1cCBpbiB0aGUgcGxhdGZvcm0NCj4gdWJvb3QuwqAgQXMgcGFydCBvZiB0aGUgYm9v
dCwgdGhlIHNlY29uZGFyeSBjb3JlIHdhaXRzIGZvciB0aGUgc21wIG1haWxib3ggdG8NCj4gZ2V0
IGEgbWFnaWMgbnVtYmVyIHdyaXR0ZW4gYnkgdGhlIHByaW1hcnkgY29yZToNCj4gPg0KPiA+IGh0
dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy91LWJvb3QvYmxvYi9hc3BlZWQtbWFzdGVy
LQ0KPiB2MjAxOS4wNC9hDQo+ID4gcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNjAwL3BsYXRmb3Jt
LlMjTDE2OA0KPiA+IDxodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvdS1ib290L2Js
b2IvYXNwZWVkLW1hc3Rlci0NCj4gdjIwMTkuMDQvDQo+ID4gYXJjaC9hcm0vbWFjaC1hc3BlZWQv
YXN0MjYwMC9wbGF0Zm9ybS5TI0wxNjg+DQo+ID4NCj4gPiBIb3dldmVyLCB0aGlzIG1lbW9yeSBh
ZGRyZXNzIGlzIGNsZWFyZWQgb24gYm9vdDoNCj4gPg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9B
c3BlZWRUZWNoLUJNQy91LWJvb3QvYmxvYi9hc3BlZWQtbWFzdGVyLQ0KPiB2MjAxOS4wNC9hDQo+
ID4gcmNoL2FybS9tYWNoLWFzcGVlZC9hc3QyNjAwL3BsYXRmb3JtLlMjTDE0Ng0KPiA+IDxodHRw
czovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvdS1ib290L2Jsb2IvYXNwZWVkLW1hc3Rlci0N
Cj4gdjIwMTkuMDQvDQo+ID4gYXJjaC9hcm0vbWFjaC1hc3BlZWQvYXN0MjYwMC9wbGF0Zm9ybS5T
I0wxNDY+DQo+ID4NCj4gPiBUaGUgcmFjZSBjb25kaXRpb24gb2NjdXJzIGlmIHRoZSBwcmltYXJ5
IGNvcmUgcnVucyBmYXIgYWhlYWQgb2YgdGhlIHNlY29uZGFyeQ0KPiBjb3JlOiBpZiB0aGUgcHJp
bWFyeSBjb3JlIGdldHMgdG8gdGhlIHBvaW50IHdoZXJlIGl0IHNpZ25hbHMgdGhlIHNlY29uZGFy
eSBjb3Jl4oCZcw0KPiBtYWlsYm94IGJlZm9yZSB0aGUgc2Vjb25kYXJ5IGNvcmUgZ2V0cyBwYXN0
IHRoZSBwb2ludCB3aGVyZSBpdCBkb2VzIHRoZSBpbml0aWFsDQo+IHJlc2V0IGFuZCBzdGFydHMg
d2FpdGluZywgdGhlIHJlc2V0IHdpbGwgY2xlYXIgdGhlIHNpZ25hbCwgYW5kIHRoZW4gdGhlIHNl
Y29uZGFyeQ0KPiBjb3JlIHdpbGwgbmV2ZXIgZ2V0IHBhc3QgdGhlIHBvaW50IHdoZXJlIGl04oCZ
cyBsb29waW5nIGluDQo+IGBwb2xsX3NtcF9tYm94X3JlYWR5YC4NCj4gPg0KPiA+IFdl4oCZdmUg
b2JzZXJ2ZWQgdGhpcyByYWNlIGhhcHBlbmluZyBieSBkdW1waW5nIGFsbCBTQ1UgcmVhZHMgYW5k
IHdyaXRlcywNCj4gYW5kIHZhbGlkYXRlZCB0aGF0IHRoaXMgaXMgdGhlIHByb2JsZW0gYnkgdXNp
bmcgYSBtb2RpZmllZCBgcGxhdGZvcm0uU2AgdGhhdA0KPiBkb2VzbuKAmXQgY2xlYXIgdGhlID1T
Q1VfU01QX1JFQURZIG1haWxib3ggb24gcmVzZXQsIGJ1dCB3b3VsZCByYXRoZXIgbm90DQo+IGhh
dmUgdG8gdXNlIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiBTTVAgYm9vdCBqdXN0IGZvciBRRU1VLVRD
RyBleGVjdXRpb24uDQoNClRvIHByZXZlbnQgdGhlIHJhY2UgY29uZGl0aW9uIGRlc2NyaWJlZCwg
U0NVMTg4IHplcm9pemF0aW9uIGlzIGNvbmR1Y3RlZA0KYXMgZWFybHkgYXMgcG9zc2libGUgYnkg
Ym90aCBDUFUjMCBhbmQgQ1BVIzEuIEFmdGVyIHRoYXQsIHRoZXJlIGFyZSBhdCANCmxlYXN0IDEw
MCBpbnN0cnVjdGlvbnMgZm9yIENQVSMwIHRvIGV4ZWN1dGUgYmVmb3JlIGl0IGdldCB0aGUgY2hh
bmNlIHRvDQpzZXQgU0NVMTg4IHRvIDB4YmFiZWNhZmUuIEZvciByZWFsLCBwYXJhbGxlbCBIVywg
aXQgaXMgdW51c3VhbCB0aGF0IENQVSMxDQp3aWxsIGJlIHNsb3dlciB0aGFuIENQVSMwIGJ5IDEw
MCBpbnN0cnVjdGlvbiBjeWNsZXMuDQoNCj4gDQo+IHlvdSBjb3VsZCB1c2UgJy10cmFjZSBhc3Bl
ZWRfc2N1KicgdG8gY29sbGVjdCB0aGUgTU1JTyBhY2Nlc3NlcyBvbiB0aGUgU0NVDQo+IHVuaXQu
IEEgVENHIHBsdWdpbiBhbHNvLg0KPiANCj4gPiBJcyB0aGVyZSBhIHdheSB0byBoYXZlIFFFTVUg
aW5zZXJ0IGEgYmFycmllciBzeW5jaHJvbml6YXRpb24gYXQgc29tZSBwb2ludA0KPiBpbiB0aGUg
Ym9vdGxvYWRlcj/CoCBJIHRoaW5rIGdldHRpbmcgYm90aCBjb3JlcyBwYXN0IHRoZSA9U0NVX1NN
UF9SRUFEWSByZXNldA0KPiB3b3VsZCBnZXQgcmlkIG9mIHRoaXMgcmFjZSwgYnV0IEnigJltIG5v
dCBhd2FyZSBvZiBhIHdheSB0byBkbyB0aGF0IGtpbmQgb2YgdGhpbmcNCj4gaW4gUUVNVS1UQ0cu
DQo+ID4NCj4gPiBUaGFua3MgZm9yIGFueSBpbnNpZ2h0cyENCj4gDQo+IENvdWxkIHdlIGNoYW5n
ZSB0aGUgZGVmYXVsdCB2YWx1ZSB0byByZWdpc3RlcnMgMHgxODAgLi4uIDB4MThDIGluDQo+IGh3
L21pc2MvYXNwZWVkX3NjdS5jIHRvIG1ha2Ugc3VyZSB0aGUgU01QIHJlZ3MgYXJlIGltbXVuZSB0
byB0aGUgcmFjZSA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpUaGFua3MsDQpUcm95IExl
ZQ0K


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 626417EAC42
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 09:58:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2pDZ-0006sB-6z; Tue, 14 Nov 2023 03:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r2pDP-0006rN-19; Tue, 14 Nov 2023 03:56:11 -0500
Received: from mail-sgaapc01on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:feab::61e]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r2pDL-0000Zv-D1; Tue, 14 Nov 2023 03:56:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjtfRcbN/v8BltbILqsEuuYeFnp8H77nc1SM/0bl6dHWnlE/t5HFIh5/xMGgaMESYeakOLJ8ct1I2O8TgTzCR7sdpPcJLFY/bKRRlYM05j9mHFFpB0wu6mZfi+4qsoxNbqb9OJdMUcfakK1GJoAUobAGY7bzptDprl5cVhaj1jVs8UV6CHcOH1YQSIvnMx6toTPifDAL5v38850mhA67QyaTWznJ5he3cTtY0yDUF3cVa8wXY3t9b6AevXSHu/HCv9IoR+bFz0ZepQgjbbhtGa4apCgr4VcNF+pfl9V6bwu/3mbaQ9TlkjdqTYoJQUQet36DU8z2wZ3k4+eDo0oJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytZ41SayBzMdp2mcaw/Hp35KOaUE8ovXV6AyKTViPcg=;
 b=VfGwk4QsvGZTjzcYulPKyYv/Gm2Iz1hEdrctC+LIXLTTelMWEAlPpyqX0XIjEawF83fZtCdgt83yz/NUWm93cvPGKWSJk6uiwMaDp95m5rLGxIitWP3QjrW2Fk69leqYUadyR+qpucbXxf8cY5K3fQLB/Jlc7ClHhT7vnnCRZvRr9y/Zakb+OH7UI0i45zdKCg6GHp+J6MorAR06y0jF3Dv5D9VWljc2UeCjLX8fTDjqNm58E2B1jkPLGLP4VEnTpv0YzY0EvgLDlH3CluQQGIP3BsvD6RLDjME2oAOd6K5mfstUSp5K3DrkGCX+049ZzKOIxKZ4ONhaEbrOvG5YaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytZ41SayBzMdp2mcaw/Hp35KOaUE8ovXV6AyKTViPcg=;
 b=R1KbWSyz4F5nqNQLC60LvA5lGaC+h2/lQK4No69CYiMFEMNMVp83ZOGss7qCtPtmWECqDGjFAKls7qzl8fHDIX1E+RhnucrvMCR9SWPfrqTlBl8FxsdA5B5RG8eRYn/E8hEdb1W7uBvOw87tNC6s3VUWYTU5uzeZMyN5nFaGka4=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by SEYPR03MB6815.apcprd03.prod.outlook.com (2603:1096:101:8e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:55:55 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b%5]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 08:55:55 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Nabih Estefan <nabihestefan@google.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH v5 05/11] hw/arm: Add GMAC devices to NPCM7XX SoC
Thread-Topic: [PATCH v5 05/11] hw/arm: Add GMAC devices to NPCM7XX SoC
Thread-Index: AQHaCP7QEHed2NHT+EKUt7mel/DCFrB5nlCQ
Date: Tue, 14 Nov 2023 08:55:55 +0000
Message-ID: <KL1PR03MB77442E6CFFD4D9288A9AB671DBB2A@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-6-nabihestefan@google.com>
In-Reply-To: <20231027175532.3601297-6-nabihestefan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|SEYPR03MB6815:EE_
x-ms-office365-filtering-correlation-id: 311b0e93-87af-4fd9-2e27-08dbe4ef8361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnCL9p2YsR8ZeO2POoE58LphJgFD/QuOrfbYN3L0wvimD88cdsizMgiYIMm9Wwu9jTx9k2/p5ETUy5HztRs/q8SWhExL2H6LOpOhfl3E0qIvIWVtpLT14UQUejsUU/p8YAs+86GdYQa14OXR0eC3X6fL6PQayPFrUczP4Iaamnf7IVU7mxW++/Cw/9oJ1uK/azxJ5pZv/crqgjGpScmEC7Y2PvXBs/8tjX45ygniXwEoO/P4S963mLIGqt6OnUUyoi6kR8WMqdbWRjJ+TthnVcZSiUCiBS4+Dj+gkimsiU9Rfbwtenyfe5o4c6z57ieuIbLfzjIpozsMLdxSQAmRG0y1CtKYP78G9zKRm0W+FCtBmv3ba9xGrKroi9KNLx9Qj3P03tGH12iX3YriSliRDo2HyJV1ZO1DBFiZLFRe4gasPGoQITGEKZAvosTtxc5zOTIAGTgLU96eOPRFWYWzm8o733Ch4dLkAHNf9BjmIGTGICrPKNYZoripvLSbQwON32Fvsthw0uUXAnVKjT5O4uDMEOhhEBLYuFm5T5IkD6heT69/B2HcTb0Z39a4KxzLF9wAjvko0QexNtalkM/+aBM7J3NnDbzgrU6Yrw8KagZcieLLODtdywbep/G14KwZIvjRkHqF4yO7F4Sc3oOqkRZXuDjKT81dZhx3hklGjso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(19627235002)(8676002)(38100700002)(478600001)(55016003)(4326008)(71200400001)(7696005)(6506007)(53546011)(8936002)(52536014)(26005)(5660300002)(107886003)(110136005)(54906003)(64756008)(66476007)(66556008)(76116006)(316002)(66446008)(66946007)(83380400001)(2906002)(41300700001)(122000001)(38070700009)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEY0VUZ1c01EcnVleERLSWc4L2RPMmIveHlaUTZ0T0pLWFBvb0NZMElmVVNE?=
 =?utf-8?B?S1Jha21DNXpWTDhSNExBRElEcWZET3ViU2g0d3hIZ2taS04vY2dHeUEvWjVl?=
 =?utf-8?B?Q3hLelA0Ky92OUdVOElvaGpMTzRiZWI4eTVxRThDWW5LU0N1ZHlBT013eUI5?=
 =?utf-8?B?SHVodWdEMkh0ODlVZXJCK1FHRkFLK2drOFoxWnVvc0s1UkRjTmxWNkxlbE00?=
 =?utf-8?B?N0V0eEpPa1ArMEt0N2M1WEpjcms0Zytid1c4R2pvTWJJQ1NwUHR5ZlRUc0JC?=
 =?utf-8?B?N2VGbHQ3VHV4akpBcmFTektEeGhCY2l3bzZUM2FLZTdobjNUcUlwQ3k2Nnhn?=
 =?utf-8?B?VUUzSlBoTksvMkNjSVMrV1VSb1l3SU1jRDI1emNKSDJ5aGJwd3BkL3N5VWJ4?=
 =?utf-8?B?ZVNQaDdVQ1NyNjZwZXJ1c1dXUTlkb2lXSCtmVnZsa3VNczEybXVmRWJZeERW?=
 =?utf-8?B?ZjFIbDN6U0FtbE5DY1A5YkRtYzcvZGEvL1NYdmFJTUg5Uy80c1FBYVpxYWhk?=
 =?utf-8?B?dDRadUF0OHlSUGJmOWx0WDlUbzBBdWlTNFNFeHI4eDVTUTRSM3ZVSGtpRWpu?=
 =?utf-8?B?VU9GQVVQc2gySDYxaE5LN2tMbXczQ05waUFXVHJaRnV1Nk9HdVVvTTd5S0kw?=
 =?utf-8?B?RXdlTnMxRkJnNTZxeGVMZnV2UC91T0NZR3dhUC9tNHZrdXZ4enovL2Q1MVdn?=
 =?utf-8?B?aUlOUnF2NFdsc3N5bCthNEdKSWdiMWdDbWo2Uk5adm0wNzN5SnNJRkhpYWhP?=
 =?utf-8?B?SDZZWDA1Q1JkS3NqVEk1Z2JWRXk3V0pabGFkNi9ScnlIdzFDTkk1aTl3eFNx?=
 =?utf-8?B?a2xIVVRJdUpWMzZONDZIU08zNlNHbWxtcldicXhsdTZMZHFZR0NJTFI3S2VJ?=
 =?utf-8?B?SFBVNnNsZjE3My9oei9CWVVCdEsra3RKTXFuWFlWNjltazZoNHBvT3NRMHd0?=
 =?utf-8?B?Zyt1RW5SYXpWTTE5WW1XQ01aN25ROTRmTzlmcllPNFZDZ2FRSVhGTktLZ2VC?=
 =?utf-8?B?cWo1WTZMTWJqRVRTTHVNYWxkcURCTTMxaWVicy9kUjZqRkYxbnBhUkUyVk1h?=
 =?utf-8?B?REFyVXRnZ0pYRE8xNm5EVWd2dkl6NThkTis5OEFDVFJSTU1VWkQ0NnIzMWJm?=
 =?utf-8?B?T3ZGS3h6V01xTWdMckl6TEkwdm4ydXlkUmNmYmp1ZGRza1d4ZFdoM3ZDeFND?=
 =?utf-8?B?cGt0WEt0VFlQdERUWmxySWlQV09CaDZSaUc0SXE1TFpMajhJUS9DMXBoc0Rj?=
 =?utf-8?B?dU5Id1ZIZ3RkNTIwRytBMExHajZrZ0FNb1ZjbFRoeTBvUHhBTGZsYU1MdkJv?=
 =?utf-8?B?b3F2RjV4bXljY0FCbTNIVnJKWFVhRmszU3Vma2dRQjd0ZGh2cGI1RGZHWHJi?=
 =?utf-8?B?dGRQc3lZYWZoUUQwZllCc1BlT2dpR3VZWHF0V2RMQ1FnNnZEaTVnbnFNRklN?=
 =?utf-8?B?U3ZTem8xdUJoVHIxV3hpNU10RCtoRDdSQytmbXUvT2gya2ZzWnVYTzRTT0N6?=
 =?utf-8?B?Q21aMExwZFRzbmdCcHRIVGRnVUNrRmk4NTl6cG1wZFMzWE1xMHZqR2svWVEr?=
 =?utf-8?B?R21xdjdMVlhMdFJjNXVDRytBNHFzOTlzb0VaMnBnWFZQNkg0TGJZa3dzcys3?=
 =?utf-8?B?WEtMYTIzRUlJVkFrM0FyNks1dVpEaUpjZ1Q1aHVtSTZHZEducUVDSkdiT0ds?=
 =?utf-8?B?QTQ5c0xzdi9JK1o4TUJGWkE2WnZkaTdqUHFzUjB6cU96RnpOSnpBdjNuNHA0?=
 =?utf-8?B?eVNnQk5KOUV0QlRVSWEzYURlMkdtdlhtM0tHdXFSVHM3VmwwNStaY0twSmRy?=
 =?utf-8?B?RVo5eUdvRGVjekV1ZWNvZGJmK2dQQmptbmY2cmNkMkY5YmlCVHNsL0hMTlpu?=
 =?utf-8?B?eXYzanNUQU4vM0pIdW1ZOFZiTWlQVCtQWitpZ2hkcUQxWlZCVEYxOWR6aGYw?=
 =?utf-8?B?ZmdNdTJucm5PMVliQ1ZpV3RrbjYvM0ZNQ0x2ZXg0enQ1SkVHWDZnUllxSFhV?=
 =?utf-8?B?djlMTTluVUZKMWQyZkpwOCswckZnR1hFQlphc1BuWnRmUi92blFCZ2xjWGFv?=
 =?utf-8?B?NHphRTBnM1BNL0dYRWRKVVZURmlmQW5WZjZyM2hKWUl5Z1hLNjhjaXdtVjBB?=
 =?utf-8?Q?AY30XmHhSvd/YlvdVDNWXgkBm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b0e93-87af-4fd9-2e27-08dbe4ef8361
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 08:55:55.5506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgIm1FvVoq6Nwfx+4G/s/rK/5BV2YS6VjDem3tZf+9QKZSgBdHru5UAphILA2oc69eYEsvMZGh/7lH/LYociKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6815
Received-SPF: pass client-ip=2a01:111:f400:feab::61e;
 envelope-from=KFTING@nuvoton.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBOYWJpaCBFc3RlZmFuIDxuYWJp
aGVzdGVmYW5AZ29vZ2xlLmNvbT4NClNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI4LCAyMDIzIDE6
NTUgQU0NClRvOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmcNCkNjOiBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IENTMjAgS0ZUaW5nIDxLRlRJTkdAbnV2b3Rvbi5j
b20+OyB3dWhhb3RzaEBnb29nbGUuY29tOyBqYXNvbndhbmdAcmVkaGF0LmNvbTsgSVMyMCBBdmkg
RmlzaG1hbiA8QXZpLkZpc2htYW5AbnV2b3Rvbi5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNv
bTsgQ1MyMCBLV0xpdSA8S1dMSVVAbnV2b3Rvbi5jb20+OyBJUzIwIFRvbWVyIE1haW1vbiA8dG9t
ZXIubWFpbW9uQG51dm90b24uY29tPjsgSU4yMCBIaWxhIE1pcmFuZGEtS3V6aSA8SGlsYS5NaXJh
bmRhLUt1emlAbnV2b3Rvbi5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjUgMDUvMTFdIGh3L2FybTog
QWRkIEdNQUMgZGV2aWNlcyB0byBOUENNN1hYIFNvQw0KDQpGcm9tOiBIYW8gV3UgPHd1aGFvdHNo
QGdvb2dsZS5jb20+DQoNCkNoYW5nZS1JZDogSWJiYjFkNzIyMWJiMTRlNzUxNzNiZjA1MTI3MWU3
NThkNjQwZjQwYzgNClNpZ25lZC1vZmYtYnk6IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0K
LS0tDQogaHcvYXJtL25wY203eHguYyAgICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQogaW5jbHVkZS9ody9hcm0vbnBjbTd4eC5oIHwgIDIgKysNCiAyIGZp
bGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9ody9hcm0vbnBjbTd4eC5jIGIvaHcvYXJtL25wY203eHguYyBpbmRleCBjOWU4NzE2MmNi
Li4xMmUxMTI1MGUxIDEwMDY0NA0KLS0tIGEvaHcvYXJtL25wY203eHguYw0KKysrIGIvaHcvYXJt
L25wY203eHguYw0KQEAgLTkxLDYgKzkxLDcgQEAgZW51bSBOUENNN3h4SW50ZXJydXB0IHsNCiAg
ICAgTlBDTTdYWF9HTUFDMV9JUlEgICAgICAgICAgID0gMTQsDQogICAgIE5QQ003WFhfRU1DMVJY
X0lSUSAgICAgICAgICA9IDE1LA0KICAgICBOUENNN1hYX0VNQzFUWF9JUlEsDQorICAgIE5QQ003
WFhfR01BQzJfSVJRLA0KICAgICBOUENNN1hYX01NQ19JUlEgICAgICAgICAgICAgPSAyNiwNCiAg
ICAgTlBDTTdYWF9QU1BJMl9JUlEgICAgICAgICAgID0gMjgsDQogICAgIE5QQ003WFhfUFNQSTFf
SVJRICAgICAgICAgICA9IDMxLA0KQEAgLTIzNCw2ICsyMzUsMTIgQEAgc3RhdGljIGNvbnN0IGh3
YWRkciBucGNtN3h4X3BzcGlfYWRkcltdID0gew0KICAgICAweGYwMjAxMDAwLA0KIH07DQoNCisv
KiBSZWdpc3RlciBiYXNlIGFkZHJlc3MgZm9yIGVhY2ggR01BQyBNb2R1bGUgKi8gc3RhdGljIGNv
bnN0IGh3YWRkcg0KK25wY203eHhfZ21hY19hZGRyW10gPSB7DQorICAgIDB4ZjA4MDIwMDAsDQor
ICAgIDB4ZjA4MDQwMDAsDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCiAgICAgaHdh
ZGRyIHJlZ3NfYWRkcjsNCiAgICAgdWludDMyX3QgdW5jb25uZWN0ZWRfcGluczsNCkBAIC00NjIs
NiArNDY5LDEwIEBAIHN0YXRpYyB2b2lkIG5wY203eHhfaW5pdChPYmplY3QgKm9iaikNCiAgICAg
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBzcGlbKl0iLCAmcy0+cHNwaVtpXSwg
VFlQRV9OUENNX1BTUEkpOw0KICAgICB9DQoNCisgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUocy0+Z21hYyk7IGkrKykgew0KKyAgICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2Jq
LCAiZ21hY1sqXSIsICZzLT5nbWFjW2ldLCBUWVBFX05QQ01fR01BQyk7DQorICAgIH0NCisNCiAg
ICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAicGNpLW1ib3giLCAmcy0+cGNpX21ib3gs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfTlBDTTdYWF9QQ0lfTUJPWCk7DQog
ICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgIm1tYyIsICZzLT5tbWMsIFRZUEVfTlBD
TTdYWF9TREhDSSk7IEBAIC02OTUsNiArNzA2LDI5IEBAIHN0YXRpYyB2b2lkIG5wY203eHhfcmVh
bGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICBzeXNidXNfY29u
bmVjdF9pcnEoc2JkLCAxLCBucGNtN3h4X2lycShzLCByeF9pcnEpKTsNCiAgICAgfQ0KDQorICAg
IC8qDQorICAgICAqIEdNQUMgTW9kdWxlcy4gQ2Fubm90IGZhaWwuDQorICAgICAqLw0KKyAgICBR
RU1VX0JVSUxEX0JVR19PTihBUlJBWV9TSVpFKG5wY203eHhfZ21hY19hZGRyKSAhPSBBUlJBWV9T
SVpFKHMtPmdtYWMpKTsNCisgICAgUUVNVV9CVUlMRF9CVUdfT04oQVJSQVlfU0laRShzLT5nbWFj
KSAhPSAyKTsNCisgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocy0+Z21hYyk7IGkrKykg
ew0KKyAgICAgICAgU3lzQnVzRGV2aWNlICpzYmQgPSBTWVNfQlVTX0RFVklDRSgmcy0+Z21hY1tp
XSk7DQorDQorICAgICAgICAvKg0KKyAgICAgICAgICogVGhlIGRldmljZSBleGlzdHMgcmVnYXJk
bGVzcyBvZiB3aGV0aGVyIGl0J3MgY29ubmVjdGVkIHRvIGEgUUVNVQ0KKyAgICAgICAgICogbmV0
ZGV2IGJhY2tlbmQuIFNvIGFsd2F5cyBpbnN0YW50aWF0ZSBpdCBldmVuIGlmIHRoZXJlIGlzIG5v
DQorICAgICAgICAgKiBiYWNrZW5kLg0KKyAgICAgICAgICovDQorICAgICAgICBzeXNidXNfcmVh
bGl6ZShzYmQsICZlcnJvcl9hYm9ydCk7DQorICAgICAgICBzeXNidXNfbW1pb19tYXAoc2JkLCAw
LCBucGNtN3h4X2dtYWNfYWRkcltpXSk7DQorICAgICAgICBpbnQgaXJxID0gaSA9PSAwID8gTlBD
TTdYWF9HTUFDMV9JUlEgOiBOUENNN1hYX0dNQUMyX0lSUTsNCisgICAgICAgIC8qDQorICAgICAg
ICAgKiBOLkIuIFRoZSB2YWx1ZXMgZm9yIHRoZSBzZWNvbmQgYXJndW1lbnQgc3lzYnVzX2Nvbm5l
Y3RfaXJxIGFyZQ0KKyAgICAgICAgICogY2hvc2VuIHRvIG1hdGNoIHRoZSByZWdpc3RyYXRpb24g
b3JkZXIgaW4gbnBjbTd4eF9lbWNfcmVhbGl6ZS4NCisgICAgICAgICAqLw0KKyAgICAgICAgc3lz
YnVzX2Nvbm5lY3RfaXJxKHNiZCwgMCwgbnBjbTd4eF9pcnEocywgaXJxKSk7DQorICAgIH0NCisN
CiAgICAgLyoNCiAgICAgICogRmxhc2ggSW50ZXJmYWNlIFVuaXQgKEZJVSkuIENhbiBmYWlsIGlm
IGluY29ycmVjdCBudW1iZXIgb2YgY2hpcCBzZWxlY3RzDQogICAgICAqIHNwZWNpZmllZCwgYnV0
IHRoaXMgaXMgYSBwcm9ncmFtbWluZyBlcnJvci4NCkBAIC03NjUsOCArNzk5LDYgQEAgc3RhdGlj
IHZvaWQgbnBjbTd4eF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCiAg
ICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJucGNtN3h4LnNpb3hbMl0iLCAgICAgIDB4
ZjAxMDIwMDAsICAgNCAqIEtpQik7DQogICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgi
bnBjbTd4eC5haGJwY2kiLCAgICAgICAweGYwNDAwMDAwLCAgIDEgKiBNaUIpOw0KICAgICBjcmVh
dGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoIm5wY203eHgubWNwaHkiLCAgICAgICAgMHhmMDVmMDAw
MCwgIDY0ICogS2lCKTsNCi0gICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCJucGNtN3h4
LmdtYWMxIiwgICAgICAgIDB4ZjA4MDIwMDAsICAgOCAqIEtpQik7DQotICAgIGNyZWF0ZV91bmlt
cGxlbWVudGVkX2RldmljZSgibnBjbTd4eC5nbWFjMiIsICAgICAgICAweGYwODA0MDAwLCAgIDgg
KiBLaUIpOw0KICAgICBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoIm5wY203eHgudmNkIiwg
ICAgICAgICAgMHhmMDgxMDAwMCwgIDY0ICogS2lCKTsNCiAgICAgY3JlYXRlX3VuaW1wbGVtZW50
ZWRfZGV2aWNlKCJucGNtN3h4LmVjZSIsICAgICAgICAgIDB4ZjA4MjAwMDAsICAgOCAqIEtpQik7
DQogICAgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgibnBjbTd4eC52ZG1hIiwgICAgICAg
ICAweGYwODIyMDAwLCAgIDggKiBLaUIpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL25w
Y203eHguaCBiL2luY2x1ZGUvaHcvYXJtL25wY203eHguaCBpbmRleCBjZWMzNzkyYTJlLi45ZTVj
ZjYzOWEyIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9hcm0vbnBjbTd4eC5oDQorKysgYi9pbmNs
dWRlL2h3L2FybS9ucGNtN3h4LmgNCkBAIC0zMCw2ICszMCw3IEBADQogI2luY2x1ZGUgImh3L21p
c2MvbnBjbTd4eF9wd20uaCINCiAjaW5jbHVkZSAiaHcvbWlzYy9ucGNtN3h4X3JuZy5oIg0KICNp
bmNsdWRlICJody9uZXQvbnBjbTd4eF9lbWMuaCINCisjaW5jbHVkZSAiaHcvbmV0L25wY21fZ21h
Yy5oIg0KICNpbmNsdWRlICJody9udnJhbS9ucGNtN3h4X290cC5oIg0KICNpbmNsdWRlICJody90
aW1lci9ucGNtN3h4X3RpbWVyLmgiDQogI2luY2x1ZGUgImh3L3NzaS9ucGNtN3h4X2ZpdS5oIg0K
QEAgLTEwNSw2ICsxMDYsNyBAQCBzdHJ1Y3QgTlBDTTd4eFN0YXRlIHsNCiAgICAgT0hDSVN5c0J1
c1N0YXRlICAgICBvaGNpOw0KICAgICBOUENNN3h4RklVU3RhdGUgICAgIGZpdVsyXTsNCiAgICAg
TlBDTTd4eEVNQ1N0YXRlICAgICBlbWNbMl07DQorICAgIE5QQ01HTUFDU3RhdGUgICAgICAgZ21h
Y1syXTsNCiAgICAgTlBDTTd4eFBDSU1Cb3hTdGF0ZSBwY2lfbWJveDsNCiAgICAgTlBDTTd4eFNE
SENJU3RhdGUgICBtbWM7DQogICAgIE5QQ01QU1BJU3RhdGUgICAgICAgcHNwaVsyXTsNCi0tDQoy
LjQyLjAuODIwLmc4M2E3MjFhMTM3LWdvb2cNCg0KU2lnbmVkLW9mZi1ieTogVHlyb25lIFRpbmcg
PGtmdGluZ0BudXZvdG9uLmNvbT4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRoZSBwcml2aWxlZ2VkIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlbWFpbCBpcyBpbnRlbmRlZCBmb3Ig
dXNlIG9ubHkgYnkgdGhlIGFkZHJlc3NlZXMgYXMgaW5kaWNhdGVkIGJ5IHRoZSBvcmlnaW5hbCBz
ZW5kZXIgb2YgdGhpcyBlbWFpbC4gSWYgeW91IGFyZSBub3QgdGhlIGFkZHJlc3NlZSBpbmRpY2F0
ZWQgaW4gdGhpcyBlbWFpbCBvciBhcmUgbm90IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyeSBvZiB0
aGUgZW1haWwgdG8gc3VjaCBhIHBlcnNvbiwgcGxlYXNlIGtpbmRseSByZXBseSB0byB0aGUgc2Vu
ZGVyIGluZGljYXRpbmcgdGhpcyBmYWN0IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiBpdCBmcm9t
IHlvdXIgY29tcHV0ZXIgYW5kIG5ldHdvcmsgc2VydmVyIGltbWVkaWF0ZWx5LiBZb3VyIGNvb3Bl
cmF0aW9uIGlzIGhpZ2hseSBhcHByZWNpYXRlZC4gSXQgaXMgYWR2aXNlZCB0aGF0IGFueSB1bmF1
dGhvcml6ZWQgdXNlIG9mIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBvZiBOdXZvdG9uIGlzIHN0
cmljdGx5IHByb2hpYml0ZWQ7IGFuZCBhbnkgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBpcnJl
bGV2YW50IHRvIHRoZSBvZmZpY2lhbCBidXNpbmVzcyBvZiBOdXZvdG9uIHNoYWxsIGJlIGRlZW1l
ZCBhcyBuZWl0aGVyIGdpdmVuIG5vciBlbmRvcnNlZCBieSBOdXZvdG9uLg0K


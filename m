Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA007E9EF4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:40:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Y62-0006Km-P9; Mon, 13 Nov 2023 09:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r2NwT-00056y-Ev; Sun, 12 Nov 2023 22:48:54 -0500
Received: from mail-sgaapc01on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:feab::61a]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r2NwQ-0007vf-4W; Sun, 12 Nov 2023 22:48:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZawOu2ZnSVHMt48aqgekhSjEdsfQlTgwOlT1DfkCo4OEFUr8zosRQHssHwjkNHsdYYV/xZ7+SW5hxsjnjeFinK05jBk9q3EDuS04jHch77m1GlRpnrp5KMkY7tlzMK5kshB2J7UMVqddCb7OeMmXF7l9XusqbsCBWgIiXX8eYWVWlIbgKpf9QVevUJICtPN9MdnHltaB+7/lIq5Cr3alGiItc9BXmY1KWHaEoKdmS9QRm5WrpzJuTei4xDr/wjRF2uZWGnaR4ctHZkjSLvGulVsWBpMgnHIqoyMhaiQSn4tVnHxP7SUeugRlc6xw9sER382/3Cl9433vmZoINHsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaCuJk9wL4/USF021a2oslnHwFdLCQVEU8syKwlpHOA=;
 b=X87fWCVq0zH1S/rX99juyso+267SbqUHvpdF3GGF6Fkmt/2I0ewtaa0qRtypTz8ipBAqEpVHwVa21AzjvjvkF8fqJr86wElyqHQ+fHjzDDu6ifSO9BwVA6kkeDA2vH1CgnbjaEHZuQ6NRB/Augm6XV/8+py84FNbxl4aEDPVS4Ec/l+IGUInT3GvPLs0G2aHnUgCSv4Uj+PLP+W27dZckx168DqbMn8jPyrdI1DVs/xvMIAt7HZKHJqO00FaiBDvh/8o3/5I8OhhBqg+6m/ye5MsVJ660oH1MB93IW+WOasszhexnapgR7mzJf3FRa9qn2gSHU8WwnKXLUhimQbcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaCuJk9wL4/USF021a2oslnHwFdLCQVEU8syKwlpHOA=;
 b=UH90D++pQAXCKTo4TCBpp7NRnQlRRd6LzE635O+8Rf8jhIvMyqCd6KU27LX9WOwU5CxZyDK/y5GgQggiRKvZIvxApse8FSVKZjuUwDetnBGgfgWejWZI4sS8wnudEpUYNkCvzNyjV+MceABvTsHQCfKJtX4WTBKjXVFCViiDinM=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by TYZPR03MB7896.apcprd03.prod.outlook.com (2603:1096:400:45f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:48:41 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b%5]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 03:48:41 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Nabih Estefan <nabihestefan@google.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH v5 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
Thread-Topic: [PATCH v5 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
Thread-Index: AQHaCP7OEIIn+RaAbkGYKqaTRccfUrB3tl4A
Date: Mon, 13 Nov 2023 03:48:41 +0000
Message-ID: <KL1PR03MB7744EF7DCA386E8E8E79C645DBB3A@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-3-nabihestefan@google.com>
In-Reply-To: <20231027175532.3601297-3-nabihestefan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|TYZPR03MB7896:EE_
x-ms-office365-filtering-correlation-id: 123307c4-b5c3-4f66-f096-08dbe3fb6d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em0+Ubh3nz+XqEOCu5VcQ6rOYAIeub5qTTsNhyqp73THgIlOI1logunmF6PM3PP8xoZDrZT52HTuXt+bL/lxY35iy+BNggWrzMvVDIzvvNJJlMIoa26owqUA0Ka2BdRPx3KacofR0x+a6t8MrPPsAuvO5nNmMnwZuk3g9te292hSwLeX630NSU2rVpO4XuLkW/adNAdlENTmULg2B/0WcFtHA2ytZAfJRAVtaljCk9PDeVJyz0sJjW4GQzqXJ/E9C5Nag5kPFPzTXaq641wBc0X9Dl+bnGOVMqKJT60eHZ5Czrs9ei63S2Smysuip0rDerL90C9jlEl+iBH/7SuO+rPpY+waxQbaxe3/efKSryMIB6PO3mfGGYHBFd0BLTwDGYOR7ckvB9L8HHfYBpr4lYb2YTnA+SidWDOmH2SirN+MXMa/6PhRgxFOhH0Cikq5Q8G51+ZoXoOE86L0VUk6eY5qv2sRzm/4iJcZcBjrcWsZCfeECt3uJ0I/mUcM62AlUjWKC+2Fh61gZ2/7mXnsWJzQiHzomnv+F4tXCAWyv4piu/HxWlR0w3Ye8sLD8z4Ptzuw6KbRaUHVEafLAa9DHzf8vEVvk8d+Qx4O8lHnMXrhUO2gh+lk6ETO50hNgee3/gMt1o7V4BlCmX560cgHuI/f8zdeuXb/+41GPGQZwpB5OIchv/Xc6SIGBWAagFWlrXx0L3hQI54ZlVnCKvqQbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799009)(107886003)(26005)(6506007)(7696005)(53546011)(71200400001)(9686003)(83380400001)(5660300002)(4326008)(8936002)(8676002)(52536014)(15650500001)(2906002)(41300700001)(19627235002)(478600001)(316002)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(122000001)(86362001)(33656002)(38100700002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WC9MOWJCaDYra0YwTHlzRy9HbDVEcGZNa0wvbnpldWZycTBiYStrWll4N1lB?=
 =?utf-8?B?amRYUkZqVStKL0Fxb2YyVDA4K3E0a0FuK1JCUkZSUVpZV2x5cnMxS2RzOE5j?=
 =?utf-8?B?bDlYS2w4TXYrSGV3OHFFOEhydTNrZDV4NE9IRkQwOENqUVZ4c0NIZUZ5UGI5?=
 =?utf-8?B?S2dOM0lhOWlwOTlGdGZuY0gzZmI2c3ZBYkllN1Z5ZDk4cFA0TXpqMnA1cE5i?=
 =?utf-8?B?d0MzUTJkVUIwWURVWmVRLzRyV2JDYjZidWtxbnBjYWZ0V3ZjRnZFa3JDdjRB?=
 =?utf-8?B?UEtRUWh6NG5Xak5UVDBwSEQ5a3RDQmRyVUtabXNZZ3hXT0NNYUtsMTgvd3pk?=
 =?utf-8?B?ZTdHVmExMVJRZHFGVTl1OEdhbzkveWtTKzlJVmZNWkFmTEZxVmtVS01GMGVm?=
 =?utf-8?B?QXIvaG5XQ0o2UFg5NnJ1Tno3MWwzRk9zMzlsSWkxYlN6TVlXc2RkWGlscmxT?=
 =?utf-8?B?ck1LQ0duNXFwK1haRTkwVUdRdC9qZUI0a3UrNnd0RStPNU00YTkxOEhpemk3?=
 =?utf-8?B?ak1aSlJtU0gzR1BhZjZEejYrMENDVFk1SDE0ZDZoalRrcC90MmJPSzVJcHV4?=
 =?utf-8?B?V0lJUnVMVUdORnk4azZ2UzZISDVoTmhmODFqMHFkcU96K1hEWlpCVnhycGds?=
 =?utf-8?B?akJiYkFJSUVONGI3emFzQXBxSGQycXlUYi8rYmx6Mkl0MXZZUUtZbFh0RTFl?=
 =?utf-8?B?QkpFSlAzYXphOUxMVkhzRGlLMXp1aFNlNENnZ1VpMlRhRkZWbnNSOExKYjdv?=
 =?utf-8?B?MDk1OFFTcFprNllpaHJOU3RoSHQzRUl0c0JYVUhPeDJJR1pWR0g0eGVZaTNP?=
 =?utf-8?B?eHJBM1VLa0ZqK0t5a2Z3L2c0NnlHeE5NeGN6Z2cxdlo4blpMRFFMM0dCTFRK?=
 =?utf-8?B?c3Q0Z1hlb0ovemVtVzNzRXpscE9VSXUwamVZTUNLT25YR0ZoMDArZVZrUlFr?=
 =?utf-8?B?Z1NuYXRZd09xczYrYUVkODhOanJqUTN4RnRQTHdodTlHUHRlZWdDK1MzSDdu?=
 =?utf-8?B?QlNqQlA3czhjd1ZzOHZQT21kL2xXaUptaS9yZUQ5Uk81YmFkTWoxci9qT3hi?=
 =?utf-8?B?Vm81M3NnQjJCYVlNRzQvbndSQnBETDRpNkJMVlNxakFGL1JSWWsrWDJCL2oz?=
 =?utf-8?B?V2dWS2lmT2liYzByUnRTcjJhekl0R2l5SHdCUHNiL1FnUGtHMlEyTy9LU2dJ?=
 =?utf-8?B?VWQ0ZzdiT2hYeXpTcnFOVDd5OGlPUUlTTlJHQmk4M1gvVXhxSk9KK2RQV2hh?=
 =?utf-8?B?U3FCcEprNE92RFdiemhuZmZmakM0N1JJSW5ZQ0Yvd285Mk0rOXVQYTJSRmNT?=
 =?utf-8?B?WFd2TG1BempzZi92Z2piY1RNOG4vVkNhdDBydUJhS0wvY1d0V0dKK2lSRVkz?=
 =?utf-8?B?bHJUOWZ5Rnc1ZHlPNFRheVZibHg0R2hwWXZMdy85cnNEV2ZuaCszUitTeTh1?=
 =?utf-8?B?U2Y4cEVIdTV2L3RVS1NJd09UZUJNNjRPRVE2d0Jsb3hDd09OTW4ybzBoRUpp?=
 =?utf-8?B?akNYM05HcVFDS21kNnlpTFcwdGRabGRlSERlYmFkdDM1dTI1SGZMdlZBVzZw?=
 =?utf-8?B?Q3pKVUI0aW5qSXBHbTNTTW9CdWhjMS9nOVQzL09jOGVTNTF6eDd4cVNhRjM2?=
 =?utf-8?B?TU9WNjBOYW1SR1RiYTlSZzN0bFIyNzE0ZnBJTlc4VUNOVzZUaHQ5WGpNNWFq?=
 =?utf-8?B?OE9Pb044czQrVG4rWlVUZmh0SE1QNk14TlV0NjZlakZ4OHMyK3l2OHhGemoz?=
 =?utf-8?B?RWlWWndoSWMwSitpTEptYndpNjlaZS9GaTRSQlNlV2Y0WnNCZE91RDFTWHRn?=
 =?utf-8?B?R3VMeGZ5dE5yUmg1YVdUVGNxcmwzekZMbk1yL0srbjlmUklPNTA0RmxHck9J?=
 =?utf-8?B?dWpqenQ0MXZxcitLdzFMQld4SW51RkVlVm9hMnU4YzBvMVdjVzZweDk5bkJl?=
 =?utf-8?B?Y2NRN1BUMmRUQjRwRjZ1WDVLb0RuMzMrbHRqUFNMZG1DTGN1eVU5M29HeTZs?=
 =?utf-8?B?dTVGc29NQVVlSWVzTTZXTkN1L0RGd2FjMk9tRmRlaklKQzVJWUtoQU1RZXUy?=
 =?utf-8?B?WFVEODh1azFjNmRnVkJ5UFlqUy82OVg1ZkljWVMvOFlyNEZ5dWZnUGt6Q0lp?=
 =?utf-8?Q?8YtH4ZVJPQs8rhcOsqiSVygXW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123307c4-b5c3-4f66-f096-08dbe3fb6d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 03:48:41.0354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XimIC1PVumtPgJj/cahuMlqOdBEbgPPYNVe2p2zQHYG+UP0tFhFFUv1o7aS0QMj6ySFGl4PXIJEl6XqUD9ky2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7896
Received-SPF: pass client-ip=2a01:111:f400:feab::61a;
 envelope-from=KFTING@nuvoton.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Nov 2023 09:39:16 -0500
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
bmRhLUt1emlAbnV2b3Rvbi5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjUgMDIvMTFdIGh3L2FybTog
QWRkIFBDSSBtYWlsYm94IG1vZHVsZSB0byBOdXZvdG9uIFNvQw0KDQpDQVVUSU9OIC0gRXh0ZXJu
YWwgRW1haWw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgYWNrbm93bGVkZ2UgdGhlIHNlbmRlciBhbmQgY29udGVudC4NCg0KDQpGcm9tOiBIYW8gV3Ug
PHd1aGFvdHNoQGdvb2dsZS5jb20+DQoNClRoaXMgcGF0Y2ggd2lyZXMgdGhlIFBDSSBtYWlsYm94
IG1vZHVsZSB0byBOdXZvdG9uIFNvQy4NCg0KQ2hhbmdlLUlkOiBJOTQyMWZmNmJjN2QzNjViMDU1
OWMwYTFmNmI5OGNmZDI0YjZmMmQ5Zg0KU2lnbmVkLW9mZi1ieTogSGFvIFd1IDx3dWhhb3RzaEBn
b29nbGUuY29tPg0KU2lnbmVkLW9mZi1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhlc3RlZmFuQGdv
b2dsZS5jb20+DQotLS0NCiBkb2NzL3N5c3RlbS9hcm0vbnV2b3Rvbi5yc3QgfCAyICsrDQogaHcv
YXJtL25wY203eHguYyAgICAgICAgICAgIHwgMyArKy0NCiBpbmNsdWRlL2h3L2FybS9ucGNtN3h4
LmggICAgfCAxICsNCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vYXJtL251dm90b24ucnN0IGIvZG9jcy9z
eXN0ZW0vYXJtL251dm90b24ucnN0IGluZGV4IDA0MjRjYWU0YjAuLmU2MTEwOTk1NDUgMTAwNjQ0
DQotLS0gYS9kb2NzL3N5c3RlbS9hcm0vbnV2b3Rvbi5yc3QNCisrKyBiL2RvY3Mvc3lzdGVtL2Fy
bS9udXZvdG9uLnJzdA0KQEAgLTUwLDYgKzUwLDggQEAgU3VwcG9ydGVkIGRldmljZXMNCiAgKiBF
dGhlcm5ldCBjb250cm9sbGVyIChFTUMpDQogICogVGFjaG9tZXRlcg0KICAqIFBlcmlwaGVyYWwg
U1BJIGNvbnRyb2xsZXIgKFBTUEkpDQorICogQklPUyBQT1NUIGNvZGUgRklGTw0KKyAqIFBDSSBN
YWlsYm94DQoNCiBNaXNzaW5nIGRldmljZXMNCiAtLS0tLS0tLS0tLS0tLS0NCmRpZmYgLS1naXQg
YS9ody9hcm0vbnBjbTd4eC5jIGIvaHcvYXJtL25wY203eHguYyBpbmRleCBjNjllOTM2NjY5Li5j
OWU4NzE2MmNiIDEwMDY0NA0KLS0tIGEvaHcvYXJtL25wY203eHguYw0KKysrIGIvaHcvYXJtL25w
Y203eHguYw0KQEAgLTg2LDcgKzg2LDYgQEAgZW51bSBOUENNN3h4SW50ZXJydXB0IHsNCiAgICAg
TlBDTTdYWF9VQVJUMV9JUlEsDQogICAgIE5QQ003WFhfVUFSVDJfSVJRLA0KICAgICBOUENNN1hY
X1VBUlQzX0lSUSwNCi0gICAgTlBDTTdYWF9QRUNJX0lSUSAgICAgICAgICAgID0gNiwNCiAgICAg
TlBDTTdYWF9QQ0lfTUJPWF9JUlEgICAgICAgID0gOCwNCiAgICAgTlBDTTdYWF9LQ1NfSElCX0lS
USAgICAgICAgID0gOSwNCiAgICAgTlBDTTdYWF9HTUFDMV9JUlEgICAgICAgICAgID0gMTQsDQpA
QCAtNDYzLDYgKzQ2Miw4IEBAIHN0YXRpYyB2b2lkIG5wY203eHhfaW5pdChPYmplY3QgKm9iaikN
CiAgICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBzcGlbKl0iLCAmcy0+cHNw
aVtpXSwgVFlQRV9OUENNX1BTUEkpOw0KICAgICB9DQoNCisgICAgb2JqZWN0X2luaXRpYWxpemVf
Y2hpbGQob2JqLCAicGNpLW1ib3giLCAmcy0+cGNpX21ib3gsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFRZUEVfTlBDTTdYWF9QQ0lfTUJPWCk7DQogICAgIG9iamVjdF9pbml0aWFsaXpl
X2NoaWxkKG9iaiwgIm1tYyIsICZzLT5tbWMsIFRZUEVfTlBDTTdYWF9TREhDSSk7ICB9DQoNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9ucGNtN3h4LmggYi9pbmNsdWRlL2h3L2FybS9ucGNt
N3h4LmggaW5kZXggMjczMDkwYWM2MC4uY2VjMzc5MmEyZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
aHcvYXJtL25wY203eHguaA0KKysrIGIvaW5jbHVkZS9ody9hcm0vbnBjbTd4eC5oDQpAQCAtMTA1
LDYgKzEwNSw3IEBAIHN0cnVjdCBOUENNN3h4U3RhdGUgew0KICAgICBPSENJU3lzQnVzU3RhdGUg
ICAgIG9oY2k7DQogICAgIE5QQ003eHhGSVVTdGF0ZSAgICAgZml1WzJdOw0KICAgICBOUENNN3h4
RU1DU3RhdGUgICAgIGVtY1syXTsNCisgICAgTlBDTTd4eFBDSU1Cb3hTdGF0ZSBwY2lfbWJveDsN
CiAgICAgTlBDTTd4eFNESENJU3RhdGUgICBtbWM7DQogICAgIE5QQ01QU1BJU3RhdGUgICAgICAg
cHNwaVsyXTsNCiB9Ow0KLS0NCjIuNDIuMC44MjAuZzgzYTcyMWExMzctZ29vZw0KDQpTaWduZWQt
b2ZmLWJ5OiBUeXJvbmUgVGluZyA8a2Z0aW5nQG51dm90b24uY29tPg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQogVGhl
IHByaXZpbGVnZWQgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGVt
YWlsIGlzIGludGVuZGVkIGZvciB1c2Ugb25seSBieSB0aGUgYWRkcmVzc2VlcyBhcyBpbmRpY2F0
ZWQgYnkgdGhlIG9yaWdpbmFsIHNlbmRlciBvZiB0aGlzIGVtYWlsLiBJZiB5b3UgYXJlIG5vdCB0
aGUgYWRkcmVzc2VlIGluZGljYXRlZCBpbiB0aGlzIGVtYWlsIG9yIGFyZSBub3QgcmVzcG9uc2li
bGUgZm9yIGRlbGl2ZXJ5IG9mIHRoZSBlbWFpbCB0byBzdWNoIGEgcGVyc29uLCBwbGVhc2Uga2lu
ZGx5IHJlcGx5IHRvIHRoZSBzZW5kZXIgaW5kaWNhdGluZyB0aGlzIGZhY3QgYW5kIGRlbGV0ZSBh
bGwgY29waWVzIG9mIGl0IGZyb20geW91ciBjb21wdXRlciBhbmQgbmV0d29yayBzZXJ2ZXIgaW1t
ZWRpYXRlbHkuIFlvdXIgY29vcGVyYXRpb24gaXMgaGlnaGx5IGFwcHJlY2lhdGVkLiBJdCBpcyBh
ZHZpc2VkIHRoYXQgYW55IHVuYXV0aG9yaXplZCB1c2Ugb2YgY29uZmlkZW50aWFsIGluZm9ybWF0
aW9uIG9mIE51dm90b24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZDsgYW5kIGFueSBpbmZvcm1hdGlv
biBpbiB0aGlzIGVtYWlsIGlycmVsZXZhbnQgdG8gdGhlIG9mZmljaWFsIGJ1c2luZXNzIG9mIE51
dm90b24gc2hhbGwgYmUgZGVlbWVkIGFzIG5laXRoZXIgZ2l2ZW4gbm9yIGVuZG9yc2VkIGJ5IE51
dm90b24uDQo=


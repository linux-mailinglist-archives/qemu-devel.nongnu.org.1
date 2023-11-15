Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811457EBAF5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34pA-0007fs-KZ; Tue, 14 Nov 2023 20:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r34p7-0007fX-1N; Tue, 14 Nov 2023 20:36:09 -0500
Received: from mail-psaapc01on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:feae::60f]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r34p2-00062O-4H; Tue, 14 Nov 2023 20:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnIKBeIypO3quJh/hddwTvGpD6n6q+JBpYIkZZplPUwJ4j9YlHYqtYSbL0tjnqzh2fTNwAt+29CGdjct2BgbHtL0wvUiIEIO7pao0NzvZE2V2cbFsnmrshiJtyZT5dktLjKShNK0Y2MRjCokuS/LUtYE6Egt7d20e5kTSukxA1f7CIuPJUxIx6vjinaTYV+eR+MDKu0gLCF4Z4IeYG2OBGL41A0WLNJazS/h4nqpuILgCeRLJcWmtrYsi5DWLx6jLsIjY7zqE5QX21ua0bBBUE4/9VRWS34dtCYCm9xZkPXYNG9W5YVJOvXMjKX/QAP3sy7TCCL7gmn0+WNY7g6C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZTYDwy/zlfU1ZB0NmPWCYhSrc9XRzKSQFDtwBNwu7o=;
 b=VYNJEAo1qBgKpWVAV4kRpFi5RyaUyj9FZpSNeDac1nRZYD3Nomm+yq71R8LPauP3nSvMyEDMfta9f1KwfZ+i1A7d4d6+VABMTrPeCzZAqgwowpwJPYzI3d00W+luBrN6yyGdr71bElr3uI7vLRlgY/33cuC6xJ3KzhBiCw+xJEIfAdQPijx3LgB52thpecVbAdil5s5Gwc1h/voTPQL1qSbodi5s7dQl5qW26qgivoOPdmNvOsWbwkbj00O6T1SlSVhif2cycOAUT/gi59meQd+eOWwvBK5gNl5d93REhuBTZIp/PAANn9527GzIfjR1p2t0aPlbK2yMITeeF5tyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZTYDwy/zlfU1ZB0NmPWCYhSrc9XRzKSQFDtwBNwu7o=;
 b=Xx/bSfpsV5e9AxU6vNF1ip6KsOg5BwGLx4k13hzw7WSBveMp9Pp/TX1zkat5dOVARDF4Teo7JjrAYELraiB06OvdCe7zfV7CjzXE7Ur7tz4IbV2hC5gTqfUFLO7LRX6JFGQlf/jLyhuaAdDkbuAH8sDVIw6i46RNKUFjzh1TJDo=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by TYZPR03MB7437.apcprd03.prod.outlook.com (2603:1096:400:418::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 01:35:56 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b%5]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 01:35:55 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Nabih Estefan <nabihestefan@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, "jasonwang@redhat.com"
 <jasonwang@redhat.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "tomer.maimon@nuvoton.com"
 <tomer.maimon@nuvoton.com>, "Hila.Miranda-Kuzi@nuvoton.com"
 <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox
Thread-Topic: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox
Thread-Index: AQHaCP7Q61gwJ7Nz0k+5kv3ABox+AbB5IF6wgACghACAAPRM8A==
Date: Wed, 15 Nov 2023 01:35:55 +0000
Message-ID: <KL1PR03MB7744B774223D04CF466EC2BEDBB1A@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-4-nabihestefan@google.com>
 <KL1PR03MB7744A70A81045E5DC49C8191DBB2A@KL1PR03MB7744.apcprd03.prod.outlook.com>
 <CAFEAcA_9HT=tccyTu9RffMxq7Cm5GEanM+OcSxfkpbnJW2m6hQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_9HT=tccyTu9RffMxq7Cm5GEanM+OcSxfkpbnJW2m6hQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|TYZPR03MB7437:EE_
x-ms-office365-filtering-correlation-id: b344aa52-7a85-46e2-27e6-08dbe57b3644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhpClMnZ90yU7YlNwvCH67DQFfiTGT5BUexfcyadl5rxktFqI2vY/4bJuSMaZhmHjCZhED1RkuFTiTKAjjcQgjLoIl1PhYvKe45WJqcfKnWCNhPQ9QZpc4meZRUtcJd/j5udw2D2hDThujVGKojnMyAzeZCC/TAhq5wgTR4T6WzfQntDLBYsNcUWAa2qi9aqNN29ozMOzQG1qmkPtftnPdfYAFHhcGEg/mood7d+yq3oYbC2PXW4zqH0ACpV7mY2jWVucrz9BrAb0uql/UXFgoJko38Gm8rlym64l7GAxe7gcO/rCFqhtI5bhK1LLRFeamI/vEJrX7bf3JEx1cG+FSSMjsNxIeWKIkG5m0EczlGw2My9U1j06G8HVgha12GGbEtaps5gM7xtvW1QmeIX/XzQGWg+GJRc0y1OByulRl5qFvgGZC1ECWKCZv20gb0WQQVcO+B1ok0sdSc3S4jDRxAVUc2AxAcx4HmRz4EP6L3tc/R+EXNxykVLQrPg6LqkFNSnQW6RtJQv+Zl698k/FV25fMLxhgc9RFPPjrM7R0Q62YK0zhUSFU1noOlsG2AAW72X0EjQhDsmIO4hdMvNO+ueaV2syHGxabkQYQ/7x5Jjn8BN9Xll9U0NUII1kSx7gGGn5f/b7yMe+OlAnRNhDd3H2tiaX8pua12YWM0XQbOKK5zEYfzAEf3afGkgCG3NnsTZ6Rl3oTTzdmqKbu+Cmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(15650500001)(5660300002)(122000001)(2906002)(33656002)(86362001)(38100700002)(41300700001)(26005)(107886003)(6506007)(7696005)(53546011)(71200400001)(478600001)(9686003)(83380400001)(8676002)(8936002)(4326008)(52536014)(66446008)(64756008)(54906003)(66556008)(66476007)(6916009)(316002)(66946007)(76116006)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdOSFNGQVJaZzVFUDV0L2FpME9lYXhpM0NPcmc1VzNTU2xCdStHZDM0c1lJ?=
 =?utf-8?B?aTU0MHZibkVBWmRNU1AxM1hnM1pvajZUa1Fhcjc1b2xKWDNqa3NWN1VZbkRD?=
 =?utf-8?B?Z1RFR1ZMb2dkK0RkRC9JY1JsdzZWRnc4VktjbWJpWXZ4SGczUG9FVEIvWi9Q?=
 =?utf-8?B?Nk5WZ3htN3lJUkFEbDhicnU4QUJ0MXlkTFBrdlg5NW51YU5rVGp0UndXWlRz?=
 =?utf-8?B?MTJZNk5CQlhXcS9YWmEzMmowZnpIRDNuV1ZrVnlyVXZvWVAwUnprSkxVT2pi?=
 =?utf-8?B?dXE2aEJkejJMT25HSGhLRys5eXFWRG9yVmhOVTJEUnZqeTVCUEtNc3VXZnFv?=
 =?utf-8?B?ZnZ4bUZrVHZlNkQxa0MvWUNheWxlTUE3d0NyY0szUDhvWnk1c2JreHVHQWN5?=
 =?utf-8?B?cDIvWDhzK0wyVFJ2NXExN0RScFp0dDRUVUEvVlRyVkkzOHlIREp0SjNxWE1I?=
 =?utf-8?B?YmN4eE9XNENJb2x5eS9odG1oaGd0K3VwMG9kcFR4OVI5dDdObis1T3pDMmp4?=
 =?utf-8?B?cW1WYXdJSkxhdUl0MWJGS3RMdFJWUGVZOWlUdWRXcWZmWVBqZmh3Q1h3SEZm?=
 =?utf-8?B?WU9iU1NEOEZKdnFtRmo1T3NkWlhIUUQxNXRNTWxvM2dyeHZLTERuSFNwa0gw?=
 =?utf-8?B?ZW80N3dTc2pacHFhZEh2a0s1K2t1K0JiODlJWWZyVEZFdXRjMGdwTTh6Yjlw?=
 =?utf-8?B?WlZBbkVyNE93NHNFK0ppQjR6aTVnOU5jSHl2anJGRHVmV2FSTCsyMW9Tc3NC?=
 =?utf-8?B?d04rNnEyY1dWTy9FVkZnTkM0Tno4OXpReFFOTkVhUjlnbkNzcThGQmt6QW9w?=
 =?utf-8?B?aVRycjVQNVhEekhwVkZiK3VXYWs3SEt0MW10S3BHY2xFTVE2OGpRV3BlZTU4?=
 =?utf-8?B?VW03VmwxYmFyUWJzTzk0b1lCVHNtU2d3VUorT1kyeWRCaWhJV2wvWTQzSDRz?=
 =?utf-8?B?U2RIVjVtdy84TzFZTkhobHZ6VFJoREY5bUtmZUp1cERTMUh2cWRPZkhIb1kv?=
 =?utf-8?B?MG9tNWNYem12cGU3bTg2cXQ1MmJVMHUxWERtVGhndHFma2lseFpldzJ5b3VB?=
 =?utf-8?B?SmFRU3pBcDlGcHNHUDVGaFNNYm44aEpUUVJrLzQyVW5VZmo0WHMydFZqdUtZ?=
 =?utf-8?B?UTk5cVpOSW51VGZDS3BBck5kOVpQWUZmRCsycHhoL0Z5Ulo0TDltSzNHN3Ro?=
 =?utf-8?B?WHE5cGgxRW12b044ZWFJWnNabDVrUHhQNEEzdGMzdXl5UE8yV3pXUXUrNW9i?=
 =?utf-8?B?NmoxNWhDL0tpMGZxRmtZYzNyQXVSSVVvbklQK0Rrc0hYVSttZklwN2xDc3Zl?=
 =?utf-8?B?S0RFRUc1Vysrc1RQdGxya09WM3ZZT1d4b1o4YWFVbWNWNG9qSUtKTlRJMlE4?=
 =?utf-8?B?dW5WbE81ZkVRR1JXak9GcWxiamtvMWIvTlhUUkZFdlA1b3Y5UzFWa0NuZGpE?=
 =?utf-8?B?ayt3RzY1ay8yN0ZZS3drVnhoMjRpT2RxaDNrZWNXTTJIN2ZyYmRiOHl2TFJ4?=
 =?utf-8?B?SEFIUWwyZEhjM2t0aWM2SkdReGUzcHBDY2pmdlgrNUtlb0JwKzZoR2htTU5L?=
 =?utf-8?B?RWFYMzlmb2ttT2lvdzRoL280UGJ2RC9peVNFRFp0Z2dVODVyS2xaTXhzQUJH?=
 =?utf-8?B?Mmk3ZU9WTmZ4NERWOVNtRGxyZFloZmZBWXMrdGFJSzUwcTBaZVFvczQ4ejhq?=
 =?utf-8?B?dytUeG1sVTZQUkQyWkVGQkJhd2RRcXZMNmVBWFNkdjZuc2NBK0I3M0d0U3po?=
 =?utf-8?B?SWs0VUxtKy9sSURRZWY5Vm4vSitjS09UQkNjcjdhNkxOdFA2NmZNN0s0RVpy?=
 =?utf-8?B?Mk4ydTJQMGVVVkVUamxIdlhJZ3NBRjBpcStKMFNKL3JlWDFHcEFBYjNNeHVk?=
 =?utf-8?B?ZkE3MXUrVjc4UkhGVUdqQlhKN2V0RXhrWmIvMTl5Ui9LL2NVRUZBd1prY2JR?=
 =?utf-8?B?c05vYlpQbkVmLzNELy91SUgvcHNyVGdoTUhLcWtyTXNIVExYSUFNWjJrMG81?=
 =?utf-8?B?TytHa2ZtVWxFNGtmVDIvLzdtTjViTHhnMzIxTjFDZVl3eFNPaE4rT25rZURp?=
 =?utf-8?B?RTJZUGY0bTc5TUZzekk2N21zSmFoTnBkbERiaDhRNUhPR2JIdVozRmpicG83?=
 =?utf-8?Q?S5U1vpz5VaP6e0j8Xupc6R0/z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b344aa52-7a85-46e2-27e6-08dbe57b3644
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 01:35:55.6811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ex5orwEG51syLDWqNZhRNv975u5Bkuj4CkhX5oO6Rs2R4gLj10RYNBcFeYTBmTSs1U/I0Rxz6SPd21M5KkGmVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7437
Received-SPF: pass client-ip=2a01:111:f400:feae::60f;
 envelope-from=KFTING@nuvoton.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+DQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyA2
OjU4IFBNDQpUbzogQ1MyMCBLRlRpbmcgPEtGVElOR0BudXZvdG9uLmNvbT4NCkNjOiBOYWJpaCBF
c3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgd3VoYW90c2hAZ29vZ2xlLmNvbTsgamFzb253YW5nQHJlZGhh
dC5jb207IElTMjAgQXZpIEZpc2htYW4gPEF2aS5GaXNobWFuQG51dm90b24uY29tPjsgQ1MyMCBL
V0xpdSA8S1dMSVVAbnV2b3Rvbi5jb20+OyBJUzIwIFRvbWVyIE1haW1vbiA8dG9tZXIubWFpbW9u
QG51dm90b24uY29tPjsgSU4yMCBIaWxhIE1pcmFuZGEtS3V6aSA8SGlsYS5NaXJhbmRhLUt1emlA
bnV2b3Rvbi5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAzLzExXSBody9taXNjOiBBZGQg
cXRlc3QgZm9yIE5QQ003eHggUENJIE1haWxib3gNCg0KDQoNCk9uIFR1ZSwgMTQgTm92IDIwMjMg
YXQgMDE6MjQsIEtGVElOR0BudXZvdG9uLmNvbSA8S0ZUSU5HQG51dm90b24uY29tPiB3cm90ZToN
Cj4NCj4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFiaWggRXN0
ZWZhbiA8bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVy
IDI4LCAyMDIzIDE6NTUgQU0NCj4gVG86IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPiBDYzog
cWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBDUzIwIEtGVGluZw0K
PiA8S0ZUSU5HQG51dm90b24uY29tPjsgd3VoYW90c2hAZ29vZ2xlLmNvbTsgamFzb253YW5nQHJl
ZGhhdC5jb207IElTMjANCj4gQXZpIEZpc2htYW4gPEF2aS5GaXNobWFuQG51dm90b24uY29tPjsg
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb207IENTMjANCj4gS1dMaXUgPEtXTElVQG51dm90b24uY29t
PjsgSVMyMCBUb21lciBNYWltb24NCj4gPHRvbWVyLm1haW1vbkBudXZvdG9uLmNvbT47IElOMjAg
SGlsYSBNaXJhbmRhLUt1emkNCj4gPEhpbGEuTWlyYW5kYS1LdXppQG51dm90b24uY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjUgMDMvMTFdIGh3L21pc2M6IEFkZCBxdGVzdCBmb3IgTlBDTTd4eCBQ
Q0kgTWFpbGJveA0KPg0KPiBDQVVUSU9OIC0gRXh0ZXJuYWwgRW1haWw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgYWNrbm93bGVkZ2UgdGhlIHNlbmRl
ciBhbmQgY29udGVudC4NCj4NCj4NCj4gRnJvbTogSGFvIFd1IDx3dWhhb3RzaEBnb29nbGUuY29t
Pg0KPg0KPiBUaGlzIHBhdGNoZXMgYWRkcyBhIHF0ZXN0IGZvciBOUENNN1hYIFBDSSBNYWlsYm94
IG1vZHVsZS4NCj4gSXQgc2VuZHMgcmVhZCBhbmQgd3JpdGUgcmVxdWVzdHMgdG8gdGhlIG1vZHVs
ZSwgYW5kIHZlcmlmaWVzIHRoYXQgdGhlIG1vZHVsZSBjb250YWlucyB0aGUgY29ycmVjdCBkYXRh
IGFmdGVyIHRoZSByZXF1ZXN0cy4NCj4NCj4gQ2hhbmdlLUlkOiBJZDdhNGIzY2JlYTU2NDM4M2I5
NGQ1MDc1NTJkZmQxNmY2YjUxMjdkMQ0KPiBTaWduZWQtb2ZmLWJ5OiBIYW8gV3UgPHd1aGFvdHNo
QGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZh
bkBnb29nbGUuY29tPg0KPiAtLS0NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IFR5cm9uZSBUaW5nIDxr
ZnRpbmdAbnV2b3Rvbi5jb20+DQoNCkhpOyBjYW4geW91IGNsYXJpZnkgd2hhdCB5b3UgbWVhbiB3
aXRoIHRoaXMgU2lnbmVkLW9mZi1ieTogdGFnPw0KR2VuZXJhbGx5IHdlIHVzZSB0aG9zZSB3aGVy
ZSBlaXRoZXIgeW91J3JlIHRoZSBhdXRob3Igb2YgdGhlIGNvZGUgb3IgZWxzZSB3aGVuIHlvdSdy
ZSB0YWtpbmcgc29tZWJvZHkgZWxzZSdzIHBhdGNoIGFuZCBpbmNsdWRpbmcgaXQgaW4gd29yayB5
b3UgYXJlIHNlbmRpbmcgdG8gdGhlIGxpc3QsIGFuZCBpdCBkb2Vzbid0IHNlZW0gbGlrZSBlaXRo
ZXIgb2YgdGhvc2UgYXJlIHRoZSBjYXNlIGhlcmUuDQoNCg0KdGhhbmtzDQotLSBQTU0NCg0KSGk6
DQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4gSW4gdGhlIGVtYWlsIHRocmVhZCAiIFtQ
QVRDSCB2NCAwMC8xMV0gSW1wbGVtZW50YXRpb24gb2YgTlBJIE1haWxib3ggYW5kIEdNQUMgTmV0
d29ya2luZyBNb2R1bGUiLA0KaXQgc2F5cyAiIEhpOyBJJ20gYWZyYWlkIHRoaXMgaXMgZ29pbmcg
dG8gbWlzcyB0aGUgOC4yIHJlbGVhc2UsIGJlY2F1c2UgaXQgaXMgc3RpbGwgbWlzc2luZyBhbnkg
cmV2aWV3IGZyb20gR29vZ2xlIG9yIE51dm90b24gcGVvcGxlLiINCg0KSXMgaXQgb2theSB0byBw
b3N0ICJBY2tlZCBieToiIG9yICJSZXZpZXdlZCBieToiIGJ5IHNvbWVvbmUgZnJvbSBOdXZvdG9u
Pw0KDQpUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpUeXJvbmUNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRoZSBwcml2
aWxlZ2VkIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlbWFpbCBp
cyBpbnRlbmRlZCBmb3IgdXNlIG9ubHkgYnkgdGhlIGFkZHJlc3NlZXMgYXMgaW5kaWNhdGVkIGJ5
IHRoZSBvcmlnaW5hbCBzZW5kZXIgb2YgdGhpcyBlbWFpbC4gSWYgeW91IGFyZSBub3QgdGhlIGFk
ZHJlc3NlZSBpbmRpY2F0ZWQgaW4gdGhpcyBlbWFpbCBvciBhcmUgbm90IHJlc3BvbnNpYmxlIGZv
ciBkZWxpdmVyeSBvZiB0aGUgZW1haWwgdG8gc3VjaCBhIHBlcnNvbiwgcGxlYXNlIGtpbmRseSBy
ZXBseSB0byB0aGUgc2VuZGVyIGluZGljYXRpbmcgdGhpcyBmYWN0IGFuZCBkZWxldGUgYWxsIGNv
cGllcyBvZiBpdCBmcm9tIHlvdXIgY29tcHV0ZXIgYW5kIG5ldHdvcmsgc2VydmVyIGltbWVkaWF0
ZWx5LiBZb3VyIGNvb3BlcmF0aW9uIGlzIGhpZ2hseSBhcHByZWNpYXRlZC4gSXQgaXMgYWR2aXNl
ZCB0aGF0IGFueSB1bmF1dGhvcml6ZWQgdXNlIG9mIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBv
ZiBOdXZvdG9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQ7IGFuZCBhbnkgaW5mb3JtYXRpb24gaW4g
dGhpcyBlbWFpbCBpcnJlbGV2YW50IHRvIHRoZSBvZmZpY2lhbCBidXNpbmVzcyBvZiBOdXZvdG9u
IHNoYWxsIGJlIGRlZW1lZCBhcyBuZWl0aGVyIGdpdmVuIG5vciBlbmRvcnNlZCBieSBOdXZvdG9u
Lg0K


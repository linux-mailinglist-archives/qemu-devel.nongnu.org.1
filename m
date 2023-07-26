Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188A762D23
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYpT-00013f-HS; Wed, 26 Jul 2023 03:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qOYpE-0000zd-6j; Wed, 26 Jul 2023 03:20:51 -0400
Received: from mail-bjbon0115.outbound.protection.partner.outlook.cn
 ([42.159.36.115] helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Evanzhang@archeros.com>)
 id 1qOYpA-00089C-RN; Wed, 26 Jul 2023 03:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8VoT31RPf1068ooyPhOJeVGYmsKy4+anrBTYzCBw2n73kxiPY1AVB438S5qadFgW/VFt7LdTBZTWYHREdTw4nyL37Hw2ni0O7/o7VRTGJivc3Lpm3+5YDpSoRsH4I23OD+M8jV/RLTQ0Dy4hwMxCMuwPM3o3a7JFEqNS4LYxzhcNR/VKPqKL0A/l3sPi3Se3DiRbPK0Hl5TYtPe1Dd3172AYUJ8K3dzrK/oHgb4LKVTXFtaSfMrx2mGPqmfNB27+dil65esMTDb5WDk9dq+UddfRCqL71ov+bzV7Ebknvm6Y7DtJMqyzzpFXk1UAcaHBBoePIORwwMx8qsbovIxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVuIt5Wz5KUWoSKJFJiX+UIM6TQ5l1HoNogp2zJIrrU=;
 b=mIxXBLnoAR/iGdQTIV/oIcziiYFwlysoHpbjtn1SeXeqvAAU1a1TrfEvG6uam3YGrW7r2E9zx9PWoBjX/KqVQggcVriplbOc7EKB/6n+DorNSOszhI8LosDvdaLSV8CKoukV8EfWUMBkCDjIT20gJCcc1y2ufhlkVOiu6EARZfCOBs+HwezhelqNjWeqmKgQ73hhp+rj6G8bmhYr9+8qD5Czuz45LOW/Gl7nuXL+q3ACNsdSx9dr68OYu109Ziqxqf58J73sIDFMfjaGRTWEg5llIOtU6XTCdlAzE7yjySBEEL0ZTP4pXCRhPm2mRMiqMUv7DMubc6gqLkZx5HPdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=archeros.com; dmarc=pass action=none header.from=archeros.com;
 dkim=pass header.d=archeros.com; arc=none
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::13) by ZQ0PR01MB1061.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.35; Wed, 26 Jul
 2023 07:04:56 +0000
Received: from ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
 ([fe80::e286:ede3:7acd:f06a]) by
 ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn ([fe80::e286:ede3:7acd:f06a%4])
 with mapi id 15.20.6609.032; Wed, 26 Jul 2023 07:04:56 +0000
From: =?utf-8?B?5byg5om/?= <Evanzhang@archeros.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, "Denis V. Lunev"
 <den@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: "jsnow@redhat.com" <jsnow@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIGJsb2NrL3N0cmVhbTphZGQgZmx1c2ggbDJf?=
 =?utf-8?Q?table=5Fcache,ensure_data_integrity?=
Thread-Topic: [PATCH v1] block/stream:add flush l2_table_cache,ensure data
 integrity
Thread-Index: AQHZvfti2IplM4FRh0awlS2+MY1+v6/Ki+OAgAANQgCAABfcAIAA7/rg
Date: Wed, 26 Jul 2023 07:04:56 +0000
Message-ID: <ZQ0PR01MB101547C31818BC9FA9CD2090C000A@ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn>
References: <cover.1690166344.git.Evanzhang@archeros.com>
 <bce1328c87f7e5d877dead476e9e66036cc4f7d8.1690166344.git.Evanzhang@archeros.com>
 <9e3f6e08-92d5-7292-e94c-5f626f65d6c2@yandex-team.ru>
 <056da915-b243-bf5a-dea6-43a7a8c9ec9e@virtuozzo.com>
 <19134146-e90c-32d0-58e1-d4a67f6b797d@yandex-team.ru>
In-Reply-To: <19134146-e90c-32d0-58e1-d4a67f6b797d@yandex-team.ru>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=archeros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1015:EE_|ZQ0PR01MB1061:EE_
x-ms-office365-filtering-correlation-id: 8bcaaf72-614e-46b1-d582-08db8da69e82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNwnOClw+tvwFk0e16bLA9ArY7Vv1HjMOkgsNG0obYd62YuJ3Dn9GXWNnlwZb+NzgYAxSpCK0GwhHmRfe6i+b2bbXw0RPF8m0xz2T9+djMlRWOin2dCcKnEQM7oP0/SbI+JRI9uW0IQPB69cCs9s7gPxoNycybMkruyqBYjhU00vVcga2oPA7vRysS6AEM7TESABbE5HJEIItLvOMFECMieGjHSCG85NvSyv2qrK3bFFvjs/JUjb4231ZP2i6bnnBkrlbLE7gXEFdtzOBsSV6ZtMA4ja1tVriAmyTeuXpd/k6e/4+LMFD45/Bioh2Rww/yOJjxkKWvSkZzz1eiRDhK7AealTdXm/D54SfGG2bE/4Nr0GyjKFAIXVBz3EDexkJpgN2nbFujYXX4oZp7lYSTQBdTzen1wIjKkj7xlUGOWoObqZi1xpDZpgx7taYG9gpjLbezU8iAuXOUR79vqClBrLI56CSrXaiTgAGIpCk0us5sjbYdAmu5m81GUC28rg9dG3z9jSDW44eqJ42ISsSMxbQ9boi2no6DT5Uf7dp0KBQlc7ZkY3iSoUsw3hwJxwoXuFy+G5f9G/cOoqbBJY87GajFnXQPY48lzZcWbrniKrQ8g2viQxQRBuahyBEf+D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230028)(39830400003)(366004)(136003)(396003)(346002)(451199021)(55016003)(83380400001)(86362001)(38100700002)(9686003)(40180700001)(186003)(508600001)(33656002)(966005)(26005)(53546011)(41300700001)(76116006)(66446008)(66476007)(66556008)(66946007)(8936002)(4326008)(64756008)(7696005)(2906002)(5660300002)(38070700005)(40160700002)(71200400001)(41320700001)(224303003)(85182001)(54906003)(110136005)(122000001)(84970400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZERjWm9rOFdMdi8zSG0rc3d3OW1FU0dmcVZhTTBPeEV1U2t0UkM0RHVldWhS?=
 =?utf-8?B?dHc1ajNRMHNDMkt6QnB6cmdvQ0tkRGFLMklvbDd4SWNZTEcxVVNZUkkzYm0v?=
 =?utf-8?B?ckVmb3c3bFFUTzVCUXkzWmJud3dvZkhWWWtoNzhtUVQydGFCMDMvNVVPbXBQ?=
 =?utf-8?B?VFl0d0ZhSmIrZmc1TkNRZ21SN01lcy9qMVJaLzE4RWNhQTZHM1Arb25MNjBN?=
 =?utf-8?B?Z1RPcUROVzh4bUtkY0NlK245UTZSS0JjbVVnVXlhdHhueDBkV0pRL2dSQ1Jl?=
 =?utf-8?B?bmk4SEx2RFRFZUwxRjdzY0Nudkh3LzJvTlN4RERBeldPZzFGSnRnMUtHeCtl?=
 =?utf-8?B?dVNRV1JhR0pjczJuQWNpa2lNcU5KdHhGalQyUndibWRwbWxyYmJVbktKejcr?=
 =?utf-8?B?TTAvWGpTQmNubnFTdWVBTFZuMlI2eDU5dmNKWlIxYmxBRmZaaXNwTjlqblZL?=
 =?utf-8?B?eStIeTNVM0tXQSt5dnd1RysrWUxDRnZ6TGdjNHFSbGFBOFJpMTB1dGhNRlEy?=
 =?utf-8?B?NkV2L014N0V2TGJrZXJhYTlnK1h1ck1ZcEp6K1J6V1pRUnFoVzhMZjEwZkZO?=
 =?utf-8?B?ZGlmOGxEOVNlREQxcVNrOTd5WGtsNmdxbUYzZzFFL25QRUFFS29Mdm85aTJ3?=
 =?utf-8?B?RkY4V09mRXh6VVZTV2taTmxQNmhTaHZmalE3ZUduQWZjVy9qYVYwUVUzZDZj?=
 =?utf-8?B?M1dKTkZPOVF4R29ZQmRVN2thb0IxMFE3U25ZS2ZROXBlRWc3K0pPTk5tNzBI?=
 =?utf-8?B?a284NE9COTFobVVNUW5SSi9pQVlia0FIZHRJNnAwbTlHQUlsajd5YlBDZUww?=
 =?utf-8?B?TGpFOHdSdzlYY1RmMGZUS3c1YWREVUM5YzNoVE5pM1RkY0FFYzZjVDIyY0pr?=
 =?utf-8?B?WE9SNmdLNXhjTUhqTVNNOHh3RDFCVUk1K1JjZm5IOUJRRUhRSmhQNlUwZjZO?=
 =?utf-8?B?YVVqYjhZNnl4WFVKZFlJZTh6dngvOUVBaU1oWWZNVEJncEIvUmJPMmVqbmpj?=
 =?utf-8?B?WGZEaVNuWUN4S3RMeTZrVmtuN093NE1UTWFRZWRyTG5jZVNxVFNraDEzS216?=
 =?utf-8?B?c0RXUUtpVWR4K29YaHRBYmN6UUYzZC8xM2taUTZrTXorN2lnWlRwOEZHTy83?=
 =?utf-8?B?UWQ1b0NnOThucTFTaTB6YmRLVHZLdzlMZ3psQjZpSkpGUHlsVzNkaEtJa0dT?=
 =?utf-8?B?WVlITUtUaUZyWjBhYUVUWHkwai9MSHFuNnVZTTNRaDM0UDZ5WWI3bDBmTVU0?=
 =?utf-8?B?RkFJTjFpczRYMFNGNkR1MVhPWWw0OWpnUm8vTGhoNkNYbkxpckY3QVFzRXdX?=
 =?utf-8?B?MU1iWXBwbkpLbE5FWGpZQjBwTVVNWkIwV1h0V2xXc3JpdWI1Q0lIc2VIbmdv?=
 =?utf-8?B?d3Fua0p0eW9qd043NTd1cjR6cnZheEJwckpNeXBWcU5aOW1NMjE3WjZmWlIr?=
 =?utf-8?B?YVI4dlQ2c3ZYMkRKOVhHN1JrK0hCbW1SdkJtRkUzdWNkWUoyM3puNnczdHda?=
 =?utf-8?B?c3MzZ01oZitTeUVrdGJmUVJaYUJZTmt3aHRuZ09oTWYwZ2pLYkNMZHhaTU9l?=
 =?utf-8?B?WHBOdW4vUEVPRXk2MUdFL2F6TWN0NjAwbXhIbGg1VFdGZHQrYkFObjJabjFn?=
 =?utf-8?B?QTM1TjlWNXM5eDFCQWNUK2VUYjJxbnc5K1ZJQVpkb2w3aVo3MGNGMHZLV0Ez?=
 =?utf-8?B?REV4VlVBMmt3SEd3UWZIeU9COHIzQ1Bqa2hJaDZwSGIvR2M5K0dIMmx5Mkdm?=
 =?utf-8?B?a1BEdzExTGtqRTFQRjIwOHo2UUFVdklpM3FuZjdZUjYyS21wZzh3K01CQ1pV?=
 =?utf-8?B?N2Z0dFBoU3hRczJENTMzRmIzRjJaWkFuaVo5Wk1mbUxLNnlENVR2WHlkZWg1?=
 =?utf-8?B?dTIwYWpDclNZRnhsSzFPUmFlUktzVWtTMC9HTjIwUldnMFEzd05sclh3ZEEz?=
 =?utf-8?B?RTU4VkdxNDlMbzBsa1VlSlpQUWlvS1cySHdNNnVhci9hSXFTTG9JVjRzVmxF?=
 =?utf-8?B?WTZzZGRZVm5jcVBrK2xja2k5V29tSEVSbkNTaDI1MVVWZ0Rldi91dGNEdUNM?=
 =?utf-8?B?NUlnTHMvWit6WjBTdEErd0hSNkUrMkZvQ05KZmxCRy96cGY4bWhyTGhleit4?=
 =?utf-8?Q?sLiq/zgoBJn6BtmyP0dtfyh+F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: archeros.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1015.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcaaf72-614e-46b1-d582-08db8da69e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:04:56.6384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8387253c-f44a-4a28-8058-3e5c20af6b4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SttYB5su+kuxuJzaMf3EXJHlP0407ODBSUGkbsbrjFWFeXNdjst1I4rGCW/aWd5y7p9S7De+tDoBAmDCjxuIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1061
Received-SPF: none client-ip=42.159.36.115;
 envelope-from=Evanzhang@archeros.com;
 helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FORGED_SPF_HELO=1,
 KHOP_HELO_FCRDNS=0.001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Pk9uIDI1LjA3LjIzIDE4OjEzLCBEZW5pcyBWLiBMdW5ldiB3cm90ZToNCj4+T24gNy8yNS8yMyAx
NjoyNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pk9uIDI0LjA3LjIz
IDEwOjMwLCBFdmFuemhhbmcgd3JvdGU6DQo+Pj4+IE9uIDcvMjYvMjMgMDE6NDEsIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+YmxvY2tfc3RyZWFtIHdpbGwgbm90IGFj
dGl2ZWx5IGZsdXNoIGwyX3RhYmxlX2NhY2hlLHdoZW4gcWVtdSANCj4+Pj4gcHJvY2VzcyBleGNl
cHRpb24gZXhpdCxjYXVzaW5nIGRpc2sgZGF0YSBsb3NzDQo+Pj4+DQo+Pj4+U2lnbmVkLW9mZi1i
eTogRXZhbnpoYW5nIDxFdmFuemhhbmdAYXJjaGVyb3MuY29tPg0KPj4+Pi0tLQ0KPj4+PiDCoCBi
bG9jay9zdHJlYW0uYyB8IDYgKysrKysrDQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCj4+Pj4NCj4+PiA+ZGlmZiAtLWdpdCBhL2Jsb2NrL3N0cmVhbS5jIGIvYmxvY2sv
c3RyZWFtLmMgaW5kZXggZTUyMmJiZC4uYTVlMDhkYSANCj4+Pj4xMDA2NDQNCj4+Pj4gLS0tIGEv
YmxvY2svc3RyZWFtLmMNCj4+Pj4gKysrIGIvYmxvY2svc3RyZWFtLmMNCj4+Pj5AQCAtMjA3LDYg
KzIwNywxMiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBzdHJlYW1fcnVuKEpvYiAqam9iLCAN
Cj4+Pj4gRXJyb3IgKiplcnJwKQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+PiDCoMKg
wqDCoMKgIH0NCj4+Pj4gwqAgK8KgwqDCoCAvKg0KPj4+PiArwqDCoMKgwqAgKiBDb21wbGV0ZSBz
dHJlYW1fcG9wdWxhdGUsZm9yY2UgZmx1c2ggbDJfdGFibGVfY2FjaGUsdG8NCj4+Pj4gK8KgwqDC
oMKgICogYXZvaWQgdW5leHBlY3RlZCB0ZXJtaW5hdGlvbiBvZiBwcm9jZXNzLCBsMl90YWJsZSBs
b3NzDQo+Pj4+ICvCoMKgwqDCoCAqLw0KPj4+PiArwqDCoMKgIHFjb3cyX2NhY2hlX2ZsdXNoKGJz
LCAoKEJEUlZRY293MlN0YXRlIA0KPj4+PiArKilicy0+b3BhcXVlKS0+bDJfdGFibGVfY2FjaGUp
Ow0KPj4+PiArDQo+Pj4+IMKgwqDCoMKgwqAgLyogRG8gbm90IHJlbW92ZSB0aGUgYmFja2luZyBm
aWxlIGlmIGFuIGVycm9yIHdhcyB0aGVyZSBidXQgDQo+Pj4+IGlnbm9yZWQuICovDQo+Pj4+IMKg
wqDCoMKgwqAgcmV0dXJuIGVycm9yOw0KPj4+PiDCoCB9DQo+Pj4NCj4+PiBIaSENCj4+Pg0KPj4+
IEkgdGhpbmssIGl0J3MgbW9yZSBjb3JyZWN0IGp1c3QgY2FsbCBiZHJ2X2NvX2ZsdXNoKGJzKSwg
d2hpY2ggc2hvdWxkIGRvIGFsbCB0aGUgam9iLiBBbHNvLCBzdHJlYW1fcnVuKCkgc2hvdWxkIGZh
aWwgaWYgZmx1c2ggZmFpbHMuDQo+Pj4NCj4+PiBBbHNvLCBJIHJlbWVtYmVyIEkndmUgZG9uZSBp
dCBmb3IgYWxsIChvciBhdCBsZWFzdCBzZXZlcmFsKSBibG9ja2pvYnMgZ2VuZXJpY2FsbHksIHNv
IHRoYXQgYW55IGJsb2Nram9iIG11c3Qgc3VjY2VzZnVsbHkgZmx1c2ggdGFyZ2V0IHRvIHJlcG9y
dCBzdWNjZXNzLi4gQnV0IG5vdyBJIGNhbiBmaW5kIG5laXRoZXIgbXkgcGF0Y2hlcyBub3IgdGhl
IGNvZGUgOiggRGVuLCBLZXZpbiwgSGFubmEsIGRvbid0IHlvdSByZW1lbWJlciB0aGlzIHRvcGlj
Pw0KPj4+DQo+PiBUaGlzIHdhcyBhIHBhcnQgb2YgY29tcHJlc3NlZCB3cml0ZSBjYWNoZSBzZXJp
ZXMsIHdoaWNoIHdhcyBwb3N0cG9uZWQuDQo+PiANCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIxMDMwNTE3MzUwNy4zOTMxMzctMS12c2VtZW50c292QHZpcnR1b3oNCj4+IHpvLmNv
bS9ULyNtODczMTU1OTNlZDVhYjE2ZTVkMGU0ZTdhNWFlNmQ3NzZmYmJhZWM3Nw0KPj4gDQo+PiBX
ZSBoYXZlIGl0IHBvcnRlZCB0byA3LjAgUUVNVS4NCj4+IA0KPj4gTm90IGEgcHJvYmxlbSB0byBw
b3J0IHRvIG1hc3RlciBhbmQgcmVzZW5kLg0KPj4gV2lsbCB0aGlzIG1ha2UgYSBzZW5zZT8NCj4+
IA0KDQo+TywgdGhhbmtzISBQYXRjaCAwMSBhcHBsaWVzIHdpdGggYSBsaXR0bGUgY29uZmxpY3Qg
dG8gbWFzdGVyLCBzbyBJJ2xsIGp1c3QgcmVzZW5kIGl0IG15c2VsZi4NCj4NCg0KVGhhbmtzIGFs
bCAhIA0KV2l0aCBiZXN0IHJlZ2FyZHMgIQ0K


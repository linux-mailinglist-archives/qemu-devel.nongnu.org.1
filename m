Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A387C72B348
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 19:33:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Oun-0005M0-Gh; Sun, 11 Jun 2023 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8Oul-0005Lp-7Z
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 13:31:43 -0400
Received: from mail-vi1eur05on20631.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::631]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8Oui-0005hi-SC
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 13:31:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNR5LPYOT1AWf+0K+9iNZgawhNFgFBa4EWBmCiP/rsOlSgupP8B7Jf8PUrTQJn299fUrBebKB3WDiBazJdK5AuJ5ptgZ/VSH4jNtrhGqPWdWuPpTIzF/4tVDwyv9tAcfbXw2I0gtGp7ZC8IlOrwNw5jZPbktpi/Ncg/Dw4UgLxPRrVXoWxBkKB+BzIMAtdC4O27mFxRcp4mJNVkqHFxeG1GMJgbiNTSh+/pAf6c986w/JrpLYDNAXsEKpokd1+I23XT7Q6RNyg3OKzn5qPXa+sdacOfWPnStKXtHu5uEliHISXb6S/D8w3xbcZGWZdItcAVM/OmDtil7LGsOI4uavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAzLLCC5AuVT7cTaYqTBEVBjvDdcWfoXpotIp18hPlk=;
 b=ccfyKf/V0QXd2bPZPSmvQD6EK461JZXewedUujjMxXLXzB+rwNdkBVZAfItDO3Mc/KgPgCNZ4TjT3M+nMkltTw1fsbsS03+Tj02It176ks/OfLbAKWCxtf7jbEKubfdAPJWT+1t98UDppENmTF3cdGGSCIeWGqLtMITw52F/c39CB07ximQvuzIvyDqIL81BQk27S9vzr1LDshqXHQdOrSoakVfHLAgp/NcnTZ5403UCgUvh8PusBMsyPrVwNSTFEoUR1U/sqm8da3y+40YyuSSY+dn5gjX9f0KNucBhGvip4QGTAN3K5QbuRIpbx7cvIOoJi2AmMATM73KpcqicIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAzLLCC5AuVT7cTaYqTBEVBjvDdcWfoXpotIp18hPlk=;
 b=CW9KW0lDnpdwsV573i9pg/4iFISIb6qZnWic0XFatvpglHzpkLQGCRriZFnPW3VloZAL5R1KuQGWS9BO/pK0nK1RN3uFeBmgJpb44r6wVrxR2CY6XBSJg17ZEu31JBxzaRhsQNwfCuR79jp9kpIWBQRLyJdoLVXYPTK2VyQqaJY=
Received: from AS4PR07MB8826.eurprd07.prod.outlook.com (2603:10a6:20b:4f4::13)
 by AM8PR07MB7555.eurprd07.prod.outlook.com (2603:10a6:20b:24d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sun, 11 Jun
 2023 17:31:36 +0000
Received: from AS4PR07MB8826.eurprd07.prod.outlook.com
 ([fe80::194:263b:f2f7:eb61]) by AS4PR07MB8826.eurprd07.prod.outlook.com
 ([fe80::194:263b:f2f7:eb61%5]) with mapi id 15.20.6455.034; Sun, 11 Jun 2023
 17:31:36 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] target/arm: Handle IC IVAU to improve compatibility
 with JITs
Thread-Topic: [PATCH 1/2] target/arm: Handle IC IVAU to improve compatibility
 with JITs
Thread-Index: AQHZnFtsqWBGzxevUkOnHxqNQt8HSK+F0D0AgAAMMAA=
Date: Sun, 11 Jun 2023 17:31:36 +0000
Message-ID: <e9c30eedbc07c9a9e3e9e433435ee1dba0e9d47a.camel@ericsson.com>
References: <833e7382b3fb90a2bbb007932cb5dbb8cfff5a33.camel@ericsson.com>
 <6fc5af6f04a15a84a862b8d65ab3629891234649.camel@ericsson.com>
 <baa7eed9-8e39-f454-bad0-e6934ccd0778@tls.msk.ru>
In-Reply-To: <baa7eed9-8e39-f454-bad0-e6934ccd0778@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8826:EE_|AM8PR07MB7555:EE_
x-ms-office365-filtering-correlation-id: 80e9f016-eae1-449c-e1c1-08db6aa1b537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYoomlqxDcAG2QFiTQBio2JiN50G1Gttq47SibMv3DxMtVJox0KOqtBTqFR+Iyk4kjLozZmf4uLe7g86Si8K3qgPVwf33Mlim2OCcYzg4AFMB6X4bhRMnehSYvGtwD9NaMfY/Dfiw8kpBh5+N+sWq4o2pjZQo5tQu6US9Ff1MgEr7zYaagKi0iVKDEF78oSumN0i+hSbXUOSJS4ifblqzxhNQf+4iuYokYNZh4/2UngzKttJAO8O1jhi5TLSH2ucjwqjFgkOdhdPkV/jOmA5eQTSyhEK+D545gTJtzr/16w2zhirWi5gp6uT/iE0FLuX3lYMShXb+hSWpx0y/rCc3FJeMe7w9/80bYwn6syikawwGFRnzco75EUMTvlAAHsUxLMOgxMEyhNm/0leJvkkvt78OU1sjcLZmzQbR/pRvms7NX2l7LXjA4m/J6CTt59K1HH5jkVuUvXqFLgnLOfiA2kVdUCSJBuNBjdMzh9WSRX5xTkHtQDwEmEHhH7Lg+ALB//23nViJV1BHB4nosG8cJWsnQp20ACWyYJrwdtZsnOBcW2/blQzrZ7aIcafJWK/b36KizRBw6W3eIfN1tgmVMqh4yRxiuRCqWOycYHjQcv5txmBd6depUCuqKKCu27PdP2cCfX2lLxLUymfurEhYTJGsZPNA1WsvSvnOltC39s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR07MB8826.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(110136005)(86362001)(83380400001)(26005)(6512007)(6506007)(2616005)(38070700005)(82960400001)(186003)(38100700002)(122000001)(478600001)(71200400001)(85202003)(85182001)(36756003)(6486002)(4744005)(2906002)(41300700001)(316002)(8936002)(8676002)(5660300002)(64756008)(4326008)(76116006)(91956017)(66446008)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU8zd2crTGVyZzlGSFJSUjJkMGI2TVJ0UjhvMkQ0VjBHWEpiM3NkOWlId3VP?=
 =?utf-8?B?bE02dEJMMEYwTVdoTVd0aUFWb0FRRCtHQ1M2NTVaRDlpakJwbHNPQ1RZM2Nw?=
 =?utf-8?B?QmVha0xaWmJXVnZqS3JTWmlsOWxyOXRpYVMzUGhyYzg1dEppWXE1bDdWVnVG?=
 =?utf-8?B?VjBJbjZWclJ5MU8rbHpBK2FUM0d0NjJ5Sm5jMmpLRTZaWmk5MHNITjcvc0lB?=
 =?utf-8?B?VzBad1FWc2xlYWt4MjJ2d2ZQUDd1Q0gwaDRtQmhoTUJWMk1KVStGQXhMNlRF?=
 =?utf-8?B?NFpoU3crbTdmQVZuQmZzYmF6Mm8xUGdZaFgvU2kyNzJHRmdMYXlCTUh2THU0?=
 =?utf-8?B?WC9zbldLQ3hLTXBsZWNjaDVCYURtbXlETGcwL0Zkak1zTUV5MkRicTZKdERF?=
 =?utf-8?B?eTlHSmVZNFFjSjVTd0tZUm5uNFJWVWVjNEc5bUJwbzlESEFqVjNVRFo0cENS?=
 =?utf-8?B?TXExRldueTVpbld4dVdiRGtucXJvVWQ2eGFvaXAraGUvaTBKZTRndE8zZmFH?=
 =?utf-8?B?Q3lkMEh3bmErK0p0K2FMdFVjQW9IQmFTb1VzVDJOSDgrR3FJS0Q1NkhHaUNY?=
 =?utf-8?B?T0xRbVBrVnVITyttQXR4UjhoczZ1RXcwaERKU2NPZEVYRWlFR3NJUjVRaDNl?=
 =?utf-8?B?NEdZOXNuamJBT0xRTDA2RndaQkxMdmFjMnd6RW0vUGtVL1dRdUIvSUtDdWZ4?=
 =?utf-8?B?SU51dkZPSWkvdDlTMFBqQWppOXEvTk5vM2NRUStmN3NuUnFJVm4rTzJlbm9m?=
 =?utf-8?B?VnprZSt3Z0M0Vlk3K284OWdLdGwzL2NXRHg2SnpZLy9JL3lzd1l1SUkxYW94?=
 =?utf-8?B?bHlNakpDaWZ6bmNzNlozYkh1KzNKRVZuclFDTk5qU2JxK0U2am40RHdNbzli?=
 =?utf-8?B?RlV3VXZNOWJ6MkZkSm1IUXkyQS9TcC9yL0p5UkhYV0pvYVcvSGdoM3JNbDRr?=
 =?utf-8?B?QnQ0UFY3eXU3TE9IRHdSV0hHR1JuUnV0L2VyVmFTZDZ5RHJhMndWT2tNbkFR?=
 =?utf-8?B?ZjhNVEsyVU5xSlQ4S1NsaTNJUDR4b2NJU3cvL0FUWlliemtGZ1hPNTcra1RW?=
 =?utf-8?B?T0hRaDk1RGlhN3lsMkRFb0VhcjEvWXBuUElKR1BhSjlIYmNUNmRqUW01d2xj?=
 =?utf-8?B?WUhnWTVmUkY0dlBEYzl0elh1WFVXV2IvbGMwRkFqZ3lsblQwUWVHckpZL042?=
 =?utf-8?B?bFZYQW9kMW9CdlRNQ1ZQanhRaFJnb1NBQ2htQ1NRRGhZWlErVVhEYklLdU9Y?=
 =?utf-8?B?djV6WHdpcC9MdmRtVzZ4NUlXeHdqY0ZFbzhtbnQ2bWlqaVdYZGdQWTkzVDYx?=
 =?utf-8?B?a3lDd1VKVTZLZXdIYnNmOEs3aHRQeWQ1UktwWGR6eDhiMExRd0hHd0FLQjdR?=
 =?utf-8?B?a3pXOXo2YVhCalRCdVV0OGFEQ0M1Ykk5bXRnN0YwU0ZNMmFmMm9QNkY0bUdV?=
 =?utf-8?B?UVAyMmpzMnRPK1JwUUR4NjIzUUptWmVobmlMVHZMY0JEb01jV0pLRWhOQUow?=
 =?utf-8?B?aWVYaGM5VGl0bks3SGhPcEtUTlJmVUNmc1ZGVFg1WDdkcUxocmJUaWxWYVJQ?=
 =?utf-8?B?bEFiSWFCVTFYZGMwZ2k2QjNtMTBjMEZENGRwTWFjRkQ1WkJHMW85QWFraTd4?=
 =?utf-8?B?dm9uY0JrQmkrUVVNWEdlcUYwN3crSDYwbjdiZnFYUWF4QnpTQ21PNC8zeHZj?=
 =?utf-8?B?MkdqMTlKa0E0eGNCd3pYSXNITTFFTjNEWkhxajhkdU90a1AwYS9IbDJYZWFh?=
 =?utf-8?B?dW03NVNQNmZVU2lJdzJMeEpNdHdwdndtMWdrU2laOWpVb2NSWG9nNFRHQjVC?=
 =?utf-8?B?bmpUdzhHWkFFMHpBTzFURVJQb2h2c0lpMVNmYk85NDlBRko1SVNsNmxobGFV?=
 =?utf-8?B?amdGT1FRMVNkYkJBalcrNWM3empKWkNiY2xOc0oyUUwvTjJDT2Z3Z1JIZWhz?=
 =?utf-8?B?cTIzVVhEM3QzUTdLWHJZZEYyUVFEekNYd3RkcnhJV1JVczBidTNtdmVoVXgx?=
 =?utf-8?B?ZWV2Qm03dzRidkJXOTUzSnJ0Y0FuMzFkd0kzWkpHNU1GbDI4RkFoZEVGMXh0?=
 =?utf-8?B?eEo2Z29ENTZmbVNkWXRNSzNabkJnS1NubnZIQzJnWjRKdFZTZ3FHbytKMUJB?=
 =?utf-8?B?ZE9ZLzZZNDN1azVrQUk5ZVgzdUZsWU5KMGZwTzFwRnZTRHJENkY4TEVhWFdV?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DCCD75435138445BC6F1A74CBCA10D5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8826.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e9f016-eae1-449c-e1c1-08db6aa1b537
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 17:31:36.5528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmR2QKWPQP1lD8XF98AqTX15S3xSUt7THt5a/vo1hE+Z6fNoDEp66y8Fu7/S6PA0xHe+MftxE1Wwq8c3pRrer/gJ4BcKlnFrnsn97eMZ9Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7555
Received-SPF: pass client-ip=2a01:111:f400:7d00::631;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

U29ycnksIHNvbWV0aGluZyB3ZW50IHNpZGV3YXlzIG9uIG15IGVuZC4gSSdsbMKgdHJ5IHJlLXNl
bmRpbmcgdGhlDQpwYXRjaHNldCB0b21vcnJvdyB0aHJvdWdoIHRoZSB3ZWItYmFzZWQgaW50ZXJm
YWNlIG1lbnRpb25lZCBpbiB0aGUNCmRvY3VtZW50YXRpb24sIGhvcGVmdWxseSB0aGF0IHdpbGwg
YmUgZm9vbHByb29mLiA6KQ0KDQpSZWdhcmRzLA0KSm9obiBIw7ZnYmVyZw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4N
ClRvOiBKb2huIEjDtmdiZXJnIDxqb2huLmhvZ2JlcmdAZXJpY3Nzb24uY29tPiwgcWVtdS1kZXZl
bEBub25nbnUub3JnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENI
IDEvMl0gdGFyZ2V0L2FybTogSGFuZGxlIElDIElWQVUgdG8gaW1wcm92ZSBjb21wYXRpYmlsaXR5
IHdpdGggSklUcw0KRGF0ZTogU3VuLCAxMSBKdW4gMjAyMyAxOTo0Nzo1OCArMDMwMA0KDQoxMS4w
Ni4yMDIzIDE0OjUzLCBKb2huIEjDtmdiZXJnIHdyb3RlOg0KLi4uDQo+IMKgIA0KPiArI2lmZGVm
IENPTkZJR19VU0VSX09OTFkNCj4gKy8qDQo+ICsgKiBgSUMgSVZBVWAgaXMgaGFuZGxlZCB0byBp
bXByb3ZlIGNvbXBhdGliaWxpdHkgd2l0aCBKSVRzIHRoYXQgZHVhbC0NCj4gbWFwIHRoZWlyDQo+
ICsgKiBjb2RlIHRvIGdldCBhcm91bmQgV15YIHJlc3RyaWN0aW9ucywgd2hlcmUgb25lIHJlZ2lv
biBpcyB3cml0YWJsZQ0KPiBhbmQgdGhlDQo+ICsgKiBvdGhlciBpcyBleGVjdXRhYmxlLg0KDQpU
aGUgcGF0Y2hlcyBzZWVtcyB0byBiZSBsaW5lLXdyYXAtZGFtYWdlZCwgYW5kIGFsc28gYmFzZTY0
LWVuY29kZWQuDQpEdW5ubyBpZiBpdCdzIHBvc3NpYmxlIHRvIHVuLWRhbWFnZSBpdCBlYXNpbHku
Li4NCg0KL21qdA0KDQo=


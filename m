Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203682BC52
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 09:24:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOCow-0007oV-TM; Fri, 12 Jan 2024 03:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rOCou-0007ju-Fc
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:23:16 -0500
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com
 ([40.107.236.100] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rOCor-0001T4-PR
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 03:23:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLtNS+JgzEs9C8k/9gzAlbDmcfwjTZouCvObYmX2tEVvXeNiMkUmiyFHCs8wkSivl5GMSQy8XYqJrBdkm8K8aHbU7APRxKhmTfC1opT9rxE/ZGhKQ9Re5K7TjnZ9gkwmfdBMcSxIRJe5Z3AL98TWXvGkmvxqjnuoDT5NiFyO9WhKVdEyCZOIye5b/PLROb6uBv4dGTNXYkw8ZSz5etw6stWGaqv62pKVQB69IL8g7G7U5q740n+HMFi3RuYdaXhVn++e2thPM9UwGjx0MVsfcEDGOP+EsWqMEINh//lWCHtJr5KitwwDOBpJ7CLL4IUTJqinQ0AzA1X+nm1sBrG+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCGTmDGxmjfTc/+rjH0fD/9TSwrisPGYKdanS72wOIE=;
 b=GHrJreGrGyPpzSPulUOcngqSdUDrbye/FNw9z38DAV7dI/QAqr+lqGy38go83ohD1THQWrGTDnEFLsPBmVVhjirEpvbecevYse6H8wOl5zDlBNWjV7tKGlCDw41k+g0hHgKL66W0cHD7LwhsfiVCDJ/m86VaysNiodaOTWEo6VEYbl48wt5L9aOxhVGXwElGjUviMWIWBWsWJ5KMdCYZO8ls5nQbgWFJq2puG8w1dGgyPxLCVw2TNlmWefwsUHcqrYnEHtWB/RSoWFkjRAbco56YL4kjhAnHAHBxVC4g3lq9t4vN8QuipBnoCE4eDf74PXcgwKvNfwoNHVynYhoc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCGTmDGxmjfTc/+rjH0fD/9TSwrisPGYKdanS72wOIE=;
 b=mBnubA7OpYc71KMajHqCN/z6joqfuG+3rMkKuDgVzDCV/u0d7BqximxgP2v077jihzefUi6mEvmUq1E5jOAfCu5JieGZBZ7MUpzT9aQvqhOfGYKJtnyXr246RvngwFDX4DJa51YwYin4Y+5FzdV9Q4LFfbE30QAfJtFPOiU7UAIx95s4LPmohRtgFZdoE1q2D9gdAo6QxGPFAQ4asBIVBdEaDAq+vszNQbAXpKsnHzNYW3rnUByAFqVL0ADacPfrYIr+4LGsdq3MiZlO+F04fPwv/xPRYDEgcRfMxKyNLCJ6/0u6rP5jr2pYzZz1fkyWJegeihbkqTJyKSMt5JvysA==
Received: from SN4PR13MB5727.namprd13.prod.outlook.com (2603:10b6:806:213::12)
 by SA3PR13MB6393.namprd13.prod.outlook.com (2603:10b6:806:39a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 08:18:08 +0000
Received: from SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350]) by SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 08:18:07 +0000
From: Wentao Jia <wentao.jia@nephogine.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, Rick Zhong
 <zhaoyong.zhong@nephogine.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Topic: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8ygAfvHuzA=
Date: Fri, 12 Jan 2024 08:18:07 +0000
Message-ID: <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR13MB5727:EE_|SA3PR13MB6393:EE_
x-ms-office365-filtering-correlation-id: 540fe2ee-4f50-49e1-9c27-08dc13470219
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kFd/NB1KsDa9qu7w5UF9AamdECb3NvpiPN7JGsnFFh9gQ8lrfQa5sXS0IaeMXQVRMPw+SOBQXJj8o6A65GkAzHuEIr8nNYkmrJtZCfMuKWn6HK2UtyIH6mXvDFU5pq2Vdpsw9c99CVpUBsi3x7POrz6A7FSM9rY53EQOdB4uuQOOqBZ+bf+w+pIvN8IeW16erRCrN37dkdxIJlzq+nftlko21YDRdZ6laQQrI5xnueiM1I10XKs1fCEyEEsNus9vSlew3/3VzTsJnsjdbrlwb/eMZ61RcQULfojiHTVU3+VhiS8URe8SoFkB/NHtKQAkx0zCNnGXXhA8MdRnqlb0+GVyC8vlc0cJzAvPLikyH3PBBXM5tGHzvmUmlB1e2UrzUT/h/Kf2yhUll6qaYfg+5bbPuCiT51z3jD2cOgnn8ZeHZoGvZSGCZBi15oFyjC1hjIy27kxE5MyaSuaVWIhaHt58hxO6uxF2HbLq10swADI5JUEjd8ThQ5HL+dif1u60g09ESAzZQyxrSguF41MCIM+FXo7VdFxEq8LiCCLBkjLMdqVRSbb1U/XteEhAaJ1VGEWb0VZPRo2eB+LVMYie+ORMuSIXhEx0inQbLS8hUioGiolZE/l82YbOaVhKu9A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR13MB5727.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39840400004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(7696005)(6506007)(9686003)(478600001)(26005)(53546011)(71200400001)(86362001)(38100700002)(122000001)(38070700009)(33656002)(76116006)(2906002)(66446008)(83380400001)(5660300002)(44832011)(6916009)(66946007)(66476007)(8936002)(8676002)(41300700001)(64756008)(52536014)(316002)(54906003)(66556008)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2N3WnhqYlM1cWlDNWthNVJ3K3NSRVVuMU52OW5NY2NIemRUYnJrWU1qQnR3?=
 =?utf-8?B?ZG1tN2NNUHIvMG9QdnVWQWxGRmJYZW5xVmRrQlFNeXRjZ1RIKzh5QW9JakNj?=
 =?utf-8?B?T3ltQTNocjhselpEZ1lET29zVEFwTGF0anJvKzVUZTdLUnlBKzNsNjVFK1BD?=
 =?utf-8?B?cHcvYzB4MXBBUnJObVUwVXVta0FPSEVOMzl0cDZtZVdiRjBoL1VwT1ZDS2c4?=
 =?utf-8?B?UkM1VkV1NFlBYndMUTRqeHRLcmZyYnhvVVR4bUluK2Mzai93UHdHa0FoQ0RT?=
 =?utf-8?B?dzBlVVMxMXlMeU1XVEpldTdQRUtFK3h3Mmw5d09BUUZaS2VmZ2hJekVrNndj?=
 =?utf-8?B?aUtsWDZYZWRYUDMrVkJ0ZFl0RWdoV2tWQ20yZ0p0SjV2b05ySUU3NWZ6Ulho?=
 =?utf-8?B?aDZtNEc2SnIzZFV2WUZIZzU3WXQyaSs4OTNmSVAzNFpzb0g0Zk8xZjd6UlJK?=
 =?utf-8?B?bXVqWEFlZGt0bXl4WklxRlRNMW1ac2tPRmszNzlCV1lNZlBmQUc5K3FYQmp3?=
 =?utf-8?B?MlFiNjloY3pzcDBZWUcyTTZtczBpOVYwS0M3c0Q3eUNLN2huNUliYWFRN1I4?=
 =?utf-8?B?L09qbStuenFRMG1ySCs0UTBJZ0o0WnFUVEZqVUpmTENlQldNMzEwcnVsMWRI?=
 =?utf-8?B?SmF6aUVXNkU0bEpFWi9jbExvNXp1cDd5TkdVc2NTck55RTgvaG1lcVVpSEV0?=
 =?utf-8?B?S05GYnFBWG1JMWpKa1dzSlJXTDZML2RvY2tZanFPWE1KeGZyQVdobUFOY2F4?=
 =?utf-8?B?Q1l0ZGcvYnpING5XazBSMTRWbFp3RUdQaWxzWTJnY2htUnUxVHQ1czJPcFlF?=
 =?utf-8?B?MDAxeUpUejNxNXFNcEVNV0lvMVZxWWIxT0IzK0t6UERnVzBPdlZCZnFVR1hC?=
 =?utf-8?B?YnRHd1Z0eVQyRHBvbVBXYWN0NTFuSnpXMW1Ob2dLUG8ycWpIQ3EvMzI2TDlW?=
 =?utf-8?B?U05GSXNIcmlhdjJuQzd1MnVNSVM5MlErQ3dYY0JsZGJZdzRGck1FaHpSUzND?=
 =?utf-8?B?eW5oT3hac09UcE1GSkdhYnplOWZpazE1L0R4R3VWZEhLZ0Z4a0w0VXFEdHcz?=
 =?utf-8?B?cHJqRSt4dDRrRU9DVWRJZnVlUHh0U1l1N3hhQUxXdGxGV0pNaVRNTS9JUHR6?=
 =?utf-8?B?c2Z3blk4a1RJTUxZWEw1VStTc2tXY0NZOFNqcjByUzEyS05xa0locWEyWVA3?=
 =?utf-8?B?eGp4NnB5MVZxSzE2NnNrQ2ptTCtKaVRIUU54VUw5dUsrR2Nady8wMnhYNXY1?=
 =?utf-8?B?Y25LRkx2Si9IMnFBS2hWc09FbzZSR3ZRbWNWbUg1eC9QSW40MEZ5c0xIVi83?=
 =?utf-8?B?Wm5GV3paZUtxOFAxS0dyQ3IwdDdIM1czY1JqU0c4U0RvenFROUlISmJUVUVK?=
 =?utf-8?B?eDFDbHQvaHp3NHJFMW1sMStreWg1NUlYSmJrVldkekRrVTh6blJOamp4cTUw?=
 =?utf-8?B?UldKcTBmWTAyUWFvb1ZrV3hnS1cwTk5oNnB1eERJWEdxSmZKSlYrZmVVSGVJ?=
 =?utf-8?B?UVdWVzJoSkpOUm5TVlpYV3ZRU2R3eVdMcXVVcGNENi8zeXB2ZlRoRnAwbS9C?=
 =?utf-8?B?bXJ5ODR4V05PVEM5Tk1JSDcxanFhOGg4U1lNT3FIUCtBVStrdFdqOVN5ek9v?=
 =?utf-8?B?eHR5VDhRNXh3QTJQVHFQb0ROUDBrL0NMVFcvZUpPMlpjQ3FYK1R4YUJjbFVV?=
 =?utf-8?B?dUNHTGpuVGRwc1N4MklweEl5MnpUQzk3aDRqMVo4QTBwS1VZZmdqSWVTVTlJ?=
 =?utf-8?B?MFhwTXE1SkVFL1doRzY5ZXJSZUVtOUdXa2wwc2RqYnFOYmRGWEtKVlluSFlW?=
 =?utf-8?B?aElQT2xGMTZGYWN5S0dFd1U0eDV1NTJ1L0JiSER1ZEJkMWg0Qm9MT3NOVkRK?=
 =?utf-8?B?S2RwRnVQRUdKRzRMZFMrVWs0dDJpMnJBWTVTaFpoQjZSZWYwUjZwUXoyb1p6?=
 =?utf-8?B?MFNEQm1WMkt4cC82cVcxc2ZTTCtpOEUwdVd3bjJoS1p0WWc4OXlqR0dyTmtn?=
 =?utf-8?B?cGM3ZzFkT2N3aUF1OVlkaDByRlBZT3RtZHNFQzhPendySVQxRCtIOVJQY29y?=
 =?utf-8?B?aVNQTGRIZys4bjY0TlZTSWFjOTI0eEJXaURvajI2bEtnZkZYN3dxZldOcS96?=
 =?utf-8?Q?UwJacAVe88bhXtFkL7SMCBdR6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR13MB5727.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540fe2ee-4f50-49e1-9c27-08dc13470219
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 08:18:07.8061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yho3L3iXeI53/CZNjt4N9b78i7i2biI81syhJYpT5WDrqugs9KuzxDUD4+1eRvOMdn85eKXlU1TImD2sGwsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6393
Received-SPF: pass client-ip=40.107.236.100;
 envelope-from=wentao.jia@nephogine.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

SGksIE1pY2hhZWwgYW5kIEphc29uDQoNCkRvIHlvdSBoYXZlIGFueSBvdGhlciBjb21tZW50cz8g
DQpJcyB0aGVyZSBhIHNjaGVkdWxlIGZvciBtZXJnZSB0aGUgcGF0Y2ggaW50byB0aGUgY29tbXVu
aXR5Pw0KVGhhbmsgeW91IA0KDQpXZW50YW8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFdlbnRhbyBKaWEgDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIsIDIwMjQgMTo1NyBQ
TQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6ICdtc3RAcmVkaGF0LmNvbScgPG1zdEBy
ZWRoYXQuY29tPjsgUmljayBaaG9uZyA8emhhb3lvbmcuemhvbmdAbmVwaG9naW5lLmNvbT47ICdK
YXNvbiBXYW5nJyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NClN1YmplY3Q6IFJFOiBGVzogW1BBVENI
XSB2aG9zdC11c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNB
VElPTl9EQVRBIGZlYXR1cmUNCg0KDQotLS0NCiBody9uZXQvdmhvc3RfbmV0LmMgfCAyICsrDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvbmV0L3Zo
b3N0X25ldC5jIGIvaHcvbmV0L3Zob3N0X25ldC5jIGluZGV4IGU4ZTE2NjE2NDYuLjIxMWNhODU5
YTYgMTAwNjQ0DQotLS0gYS9ody9uZXQvdmhvc3RfbmV0LmMNCisrKyBiL2h3L25ldC92aG9zdF9u
ZXQuYw0KQEAgLTc2LDYgKzc2LDggQEAgc3RhdGljIGNvbnN0IGludCB1c2VyX2ZlYXR1cmVfYml0
c1tdID0gew0KICAgICBWSVJUSU9fRl9JT01NVV9QTEFURk9STSwNCiAgICAgVklSVElPX0ZfUklO
R19QQUNLRUQsDQogICAgIFZJUlRJT19GX1JJTkdfUkVTRVQsDQorICAgIFZJUlRJT19GX0lOX09S
REVSLA0KKyAgICBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSwNCiAgICAgVklSVElPX05FVF9G
X1JTUywNCiAgICAgVklSVElPX05FVF9GX0hBU0hfUkVQT1JULA0KICAgICBWSVJUSU9fTkVUX0Zf
R1VFU1RfVVNPNCwNCi0tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXZW50
YW8gSmlhDQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIsIDIwMjQgMTozOCBQTQ0KVG86IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQpDYzogbXN0QHJlZGhhdC5jb207IFJpY2sgWmhv
bmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQpTdWJqZWN0OiBSRTogRlc6IFtQQVRD
SF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJT19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklD
QVRJT05fREFUQSBmZWF0dXJlDQoNCkhpLCBKYXNvbg0KDQpJdCBpcyBnb29kIGp1c3QgY2hhbmdl
IGZlYXR1cmUgYml0cywgSSB3aWxsIGNvbW1pdCBhIG5ldyBwYXRjaCwgdGhhbmtzDQoNCldlbnRh
byBKaWENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+DQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIsIDIwMjQgMTE6MjQg
QU0NClRvOiBXZW50YW8gSmlhIDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+DQpDYzogbXN0QHJl
ZGhhdC5jb207IFJpY2sgWmhvbmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQpTdWJq
ZWN0OiBSZTogRlc6IFtQQVRDSF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJT19GX0lOX09SREVSIGFu
ZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlDQoNCk9uIFR1ZSwgSmFuIDIsIDIw
MjQgYXQgMTA6MjbigK9BTSBXZW50YW8gSmlhIDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+IHdy
b3RlOg0KPg0KPiBIaSwgTWljaGFlbCAgYW5kIEphc29uDQo+DQo+DQo+DQo+IHBsZWFzZSByZXZp
ZXcgdGhlIHBhdGNoIGF0IHlvdXIgY29udmVuaWVuY2UsIHRoYW5rIHlvdQ0KPg0KPiB2aG9zdC11
c2VyOiBhZGQgVklSVElPX0ZfSU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRB
IA0KPiBmZWF0dXJlIC0gUGF0Y2h3b3JrIChrZXJuZWwub3JnKQ0KPg0KPg0KPg0KPiBXZW50YW8g
SmlhDQo+DQo+DQo+DQo+IEZyb206IFdlbnRhbyBKaWENCj4gU2VudDogRnJpZGF5LCBEZWNlbWJl
ciAxLCAyMDIzIDY6MTEgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0hdIHZob3N0LXVzZXI6IGFkZCBWSVJUSU9fRl9JTl9PUkRFUiBhbmQgDQo+IFZJUlRJ
T19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUNCj4NCj4NCj4NCj4gVklSVElPX0ZfSU5fT1JE
RVIgYW5kIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUgYXJlIGltcG9ydGFudCAN
Cj4gZmVhdHVyZQ0KPg0KPiBmb3IgZHBkayB2ZHBhIHBhY2tldHMgdHJhbnNtaXR0aW5nIHBlcmZv
cm1hbmNlLCBhZGQgdGhlIDIgZmVhdHVyZXMgYXQgDQo+IHZob3N0LXVzZXINCj4NCj4gZnJvbnQt
ZW5kIHRvIG5lZ290aWF0aW9uIHdpdGggYmFja2VuZC4NCj4NCj4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogS3lsZSBYdSB6aGVuYmluZy54dUBjb3JpZ2luZS5jb20NCj4NCj4gU2lnbmVkLW9mZi1ieTog
V2VudGFvIEppYSB3ZW50YW8uamlhQGNvcmlnaW5lLmNvbQ0KPg0KPiBSZXZpZXdlZC1ieTogICBY
aW55aW5nIFl1IHhpbnlpbmcueXVAY29yaWdpbmUuY29tDQo+DQo+IFJldmlld2VkLWJ5OiAgIFNo
dWppbmcgRG9uZyBzaHVqaW5nLmRvbmdAY29yaWdpbmUuY29tDQo+DQo+IFJldmlld2VkLWJ5OiAg
IFJpY2sgWmhvbmcgemhhb3lvbmcuemhvbmdAY29yaWdpbmUuY29tDQo+DQo+IC0tLQ0KPg0KPiBo
dy9uZXQvdmhvc3RfbmV0LmMgICAgICAgICB8IDIgKysNCj4NCj4gaW5jbHVkZS9ody92aXJ0aW8v
dmlydGlvLmggfCA0ICsrKysNCj4NCj4gMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykN
Cj4NCj4NCj4NCj4gZGlmZiAtLWdpdCBhL2h3L25ldC92aG9zdF9uZXQuYyBiL2h3L25ldC92aG9z
dF9uZXQuYw0KPg0KPiBpbmRleCBlOGUxNjYxNjQ2Li4yMTFjYTg1OWE2IDEwMDY0NA0KPg0KPiAt
LS0gYS9ody9uZXQvdmhvc3RfbmV0LmMNCj4NCj4gKysrIGIvaHcvbmV0L3Zob3N0X25ldC5jDQo+
DQo+IEBAIC03Niw2ICs3Niw4IEBAIHN0YXRpYyBjb25zdCBpbnQgdXNlcl9mZWF0dXJlX2JpdHNb
XSA9IHsNCj4NCj4gICAgICBWSVJUSU9fRl9JT01NVV9QTEFURk9STSwNCj4NCj4gICAgICBWSVJU
SU9fRl9SSU5HX1BBQ0tFRCwNCj4NCj4gICAgICBWSVJUSU9fRl9SSU5HX1JFU0VULA0KPg0KPiAr
ICAgIFZJUlRJT19GX0lOX09SREVSLA0KPg0KPiArICAgIFZJUlRJT19GX05PVElGSUNBVElPTl9E
QVRBLA0KPg0KPiAgICAgIFZJUlRJT19ORVRfRl9SU1MsDQo+DQo+ICAgICAgVklSVElPX05FVF9G
X0hBU0hfUkVQT1JULA0KPg0KPiAgICAgIFZJUlRJT19ORVRfRl9HVUVTVF9VU080LA0KPg0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmggYi9pbmNsdWRlL2h3L3ZpcnRp
by92aXJ0aW8uaA0KPg0KPiBpbmRleCBjOGY3Mjg1MGJjLi4zODgwYjY3NjRjIDEwMDY0NA0KPg0K
PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaA0KPg0KPiArKysgYi9pbmNsdWRlL2h3
L3ZpcnRpby92aXJ0aW8uaA0KPg0KPiBAQCAtMzY5LDYgKzM2OSwxMCBAQCB0eXBlZGVmIHN0cnVj
dCBWaXJ0SU9STkdDb25mIFZpcnRJT1JOR0NvbmY7DQo+DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgVklSVElPX0ZfUklOR19QQUNLRUQsIGZhbHNlKSwgXA0KPg0KPiAgICAgIERFRklORV9QUk9Q
X0JJVDY0KCJxdWV1ZV9yZXNldCIsIF9zdGF0ZSwgX2ZpZWxkLCBcDQo+DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgVklSVElPX0ZfUklOR19SRVNFVCwgdHJ1ZSkNCj4NCj4gKyAgICBERUZJTkVf
UFJPUF9CSVQ2NCgibm90aWZpY2F0aW9uX2RhdGEiLCBfc3RhdGUsIF9maWVsZCwgXA0KPg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBLCB0cnVlKSwg
XA0KPg0KPiArICAgIERFRklORV9QUk9QX0JJVDY0KCJpbl9vcmRlciIsIF9zdGF0ZSwgX2ZpZWxk
LCBcDQo+DQo+ICsgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfSU5fT1JERVIsIHRydWUp
DQoNCkRvIHdlIHdhbnQgY29tcGF0aWJpbGl0eSBzdXBwb3J0IGZvciB0aG9zZT8NCg0KVGhhbmtz
DQoNCj4NCj4NCj4NCj4gaHdhZGRyIHZpcnRpb19xdWV1ZV9nZXRfZGVzY19hZGRyKFZpcnRJT0Rl
dmljZSAqdmRldiwgaW50IG4pOw0KPg0KPiBib29sIHZpcnRpb19xdWV1ZV9lbmFibGVkX2xlZ2Fj
eShWaXJ0SU9EZXZpY2UgKnZkZXYsIGludCBuKTsNCj4NCj4gLS0NCg0K


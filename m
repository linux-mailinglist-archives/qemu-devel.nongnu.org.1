Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE81678D02F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:17:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mw-0000jV-HT; Tue, 29 Aug 2023 19:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qb6wd-0000f5-C8; Tue, 29 Aug 2023 18:12:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qb6wZ-0005si-QT; Tue, 29 Aug 2023 18:12:19 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37TG2BB9007163; Tue, 29 Aug 2023 15:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=aFPd6EUzDPC81n/Q+FhfbI0MLh0vKsgEiiFWTW
 ymm9g=; b=qOQ+2dOoNtLNhJOfAzNG0taJW0k+x5Z8ooUB6C/V4IQX3yb4CSSXXt
 pC2JQHKoGFzi3gSz3/XoK9vDrIDv79P2a9fz4Z+3ZEyeT3qsUbtY5RI2Vke1rKXF
 WK8O78uQYW3s3r+vdK7kF1RpvE4Qr0BCjCw/ofBdJw8/0rb64ChJJV/q77YKWZ/g
 Dg3qx2IhLBBETg8vI8JZZEjTmj+96md5X+eXcPgoKGaAqwdehsXdLtrWaTJc7PTF
 kjRidCXZXWuMTzk2XDLmG/nAEqGd87YHtOLXp5K/r6iYSTNVqTYZNXv2SI09xpRp
 btp4u0xBr0u9/BZwV6ZZAEKU29JLySLg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sqgwxr2f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 15:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQPpJRvv2Es7jUCs1qe4Jnal9TNkHvLqiu8qab0YldPTikironNaft6SlAs+mN6JG7+ONsfmeI3aZKxldoeK+phrzbipKScZALTdjntLg+AZrxuxZvB7/sPXeq80hZr+vnX1P8LTnqoWYL4R12Q4Wx/pZel2+9aiETCKt5A/rm5Nlzxi4k2eZAND35c3N8UgqJO+hB8B0F1PUxjMe0GVBXGgacD1UK1LmH1SglR6WdttewFY6Kw2DcvpAE0yPdInEixFcLC8EFrHjV2TL5c5JA/Vt0d26+gKgctFlkdVlrmesH0lcwhG6cZLiHHPSXYHrZNdBGsUr4yXnOB+1n//0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFPd6EUzDPC81n/Q+FhfbI0MLh0vKsgEiiFWTWymm9g=;
 b=DKBJTEaXRmOxrG7c90ibLMQxEq1/9c/KkIsSsWXdKZ+hlbFWbPC+bYbKy9FbGqxcIBYFOuZ5HNUea+k+fPa63OAiArxqyNVZNBo32SHowj3LOdxbTIGJdRPMNth+bI3x7ZrswP4IG6jTG48gEyhboUVhPfTCACa42Hu9SBbdtrBsvLhX8i3uBljT4My+pnlg1IAClOD05hvEBaU0pwJ+Ap9LrT5lW5TN20zdZtmWWK99P3mYyE+7PPxtFo0dMlZ/rjD07EFI1/M1xSPI91tOMm+0NGAdw/xV901OxgfdL5EdMahb7wFMvB28skohPR9E9iW7Gx4CFSpP3AFq1ndcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFPd6EUzDPC81n/Q+FhfbI0MLh0vKsgEiiFWTWymm9g=;
 b=LqGlYAjKtawLAZJZi5LdIhm0WoDku1es8pX8a/3FbS++4wyB6NO7hJxSEgP/H6uiTj8F8mU+fad8F4Sv7phV6h03wHVvu/Mc62o07XcfFF8BxpF7/VM+U93IB2sGnxuALaX7RxdHKlhua/VkcPnLS2ITz810bpiHb18xfkMTS3xghxakgu0lCNj+Fs8bJwlin+jDxVGkmVSRumw05DA/zBG3tVBk4K7E/7x40H+aLmJAIxQV6hYNhzRhHbQju0gLb+ZfdiKIhyp1fOfPRIhZIXYJCIlw5GoJIj/bTv3YdyKKJkwLnYAgH/+SPoQ06kftof3Wqnmjb+iQOPrZlWJi1g==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by SJ2PR02MB9413.namprd02.prod.outlook.com (2603:10b6:a03:4d2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 22:11:55 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 22:11:54 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/2] vhost-user: Fix lost reconnect
Thread-Topic: [PATCH v2 1/2] vhost-user: Fix lost reconnect
Thread-Index: AQHZ1l5vmR6QBZRhe0iUCW78VCRWPLAB3uSA
Date: Tue, 29 Aug 2023 22:11:54 +0000
Message-ID: <C8126682-6FA5-4511-80B9-289EF83EB59F@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230824074115.93897-1-fengli@smartx.com>
 <20230824074115.93897-2-fengli@smartx.com>
In-Reply-To: <20230824074115.93897-2-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|SJ2PR02MB9413:EE_
x-ms-office365-filtering-correlation-id: 8d51bf3e-f34c-4990-d109-08dba8dcf45b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +M1syTBilzSk4gaG47LQIyPM6NHIo43etQLRMu7zZI1u/F/p3c6reIrInNZTqfEg7yTMyDNRpNsjfDc5oB5tB7D+n3IDcUhm0J3UlKvRxAhMTaPYCVUisleG+TQotaWvLbl+vv+bIEHVihONsWSXspoOiJmw+KL8c1OHLjqbD8nDNfC0/dgfaRN0QLxPZHRFU+qj4351X/O7nfMVnEId3OXZBkEwlibvhdPHLGwqIt0rasQmEdoXz9JcHiWjUgWe/4cnJNFtLPllgxK49gvVDohmY1ct1PUpqFgWXQ/oOnVAW3/DRz0LqzPEqlvlcLnzZmrc8IdHV1H2wgTop1U1t5sxjj/i07w1p03CFuYjldCzT1h+yTTULMtNwok9amsCudNUN/MbusfUSH1Ph54E6I54qk1Mb5rCqq9d9ySQlUpjHOlSMQMTO2HJdztMwxgV8RXTQo5YPc743uvXAtsIvbGuwOCnS/MNHKjkiVzV1vyG+Zxjnopy09FxS0yOeF54/67jhvWO8EwS2qDaX8UQ4vYbSl3sAHpTXtAppV1tK11mMj81AKtNdlwKNQSsw9DBhSlOsBkvcRhMTSPNm5tQMr3ZELpG8I+WKyKHWI2C8v6570aJeI9K1VcrIGHmi8t+vTCnPfVtQg9licwN6LBFKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(186009)(451199024)(1800799009)(33656002)(38100700002)(36756003)(66446008)(41300700001)(44832011)(83380400001)(66946007)(316002)(2906002)(64756008)(4326008)(66476007)(86362001)(26005)(8936002)(6916009)(7416002)(6506007)(71200400001)(2616005)(66556008)(5660300002)(8676002)(53546011)(122000001)(6486002)(6512007)(91956017)(76116006)(54906003)(38070700005)(478600001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2JFS3BmZGhUZXA3UFJUWElaWCtiUGErczI0cDUzdFp1VGxWRHlrS3JWQWNt?=
 =?utf-8?B?OUNCTkUrUnlGdHRTWVp3eVJxNklmd3cwN1B3N1R4eGdpbS9xdXRsbUZTczVV?=
 =?utf-8?B?S05zYW9zSi9EeXFRcG1tNUJUYXl4Z1p1UDF1QTI2eHJWVWZoZW5HOVQ3VkM4?=
 =?utf-8?B?NDhYQ3hIVU11aXh0ZFJGOFdKUWFudVIzZTVzRTVKWUdWeUkxY1QxSnVpV2NB?=
 =?utf-8?B?b3ZER0tmZjN0RDdjTnRCZDJtc3dHRXV0U2hiR2tWRklXa3U4Wm5qRHZTMHdo?=
 =?utf-8?B?cXZLdzNKTlFWd2REbUVkTE9QcDZ6NTRmMEk0akdYcStGQ2xkbmlxeGVJZlVC?=
 =?utf-8?B?Z0kyalpqWmdQeElNVWxTSWg4eWN3M0VKbVdKOVUwM0hvYXlPaCtlZkxnRnNo?=
 =?utf-8?B?YXQwZkFUazJKTE84L3JLVW1ZVy9mTHgwUjhOUFBxM3czdk9SS0xSM1hHV29W?=
 =?utf-8?B?SXIxYzF2dmg2M0NFalJvWTM2V05RU2Z1VkVKOFFXaStqTyt1QndTTmVDMGVk?=
 =?utf-8?B?WWZoTmptNUt5b0xRTTZaU0xVSzZ3NURkd1I1Rng3QjdEMXdZQkV6cmhpQlNr?=
 =?utf-8?B?T2pSek5KdDFJWHphVHg1ZDBlVVFjaDZrQU02NEF4WW9vR1dYQmhtWnFjd01y?=
 =?utf-8?B?QzR3b0lLMWw4bjFtYjBCK1ZvMHg1OVpOUzBKd2c1RUxKNHNhcjdSMFZoNUhF?=
 =?utf-8?B?cHkwaFNLQVFBMDk3Tit0Zm5zNDBzRXQwcFhGd1cwQTA2WEE1TXluSWRHZEpi?=
 =?utf-8?B?STFjTlRFQ3pvWGVaLzBmN2dCdy9TMkttM1phWEp6Rk5EVm9uZU5KR2pyN2xy?=
 =?utf-8?B?aXdFZGNiWVh0Yi80bDZZbS81SkY3OWhaTTFYY0JJMjA4OUNoanNuWWY1dUM0?=
 =?utf-8?B?eU1oVUYzL0thd1E5Vlp0TFhLRFhMQWQzTjNDYzFYSVMvbnk2RU9KSWZ6K3V0?=
 =?utf-8?B?bENaWEd0L3lKNjJVeEVUbUFGYm9VUXdYVHk3V0tZWE1DcFNGQ3hzOVMyeklr?=
 =?utf-8?B?TUdzQUV6WS9QdkJGbE1remZxd0NXY09BbVN0a2ZiMStLK2cyejg0YkhNTnpa?=
 =?utf-8?B?RG1IaXd4L2JzRHdFMVdWMGw0Zkg5dHJTZ1ZGdFdFcnRiQTIySjhIcSt2QUow?=
 =?utf-8?B?VGROVU5YL2FNR0QxZHlNekdRWnFNNHUrQ1dZcmlWaDFPVHhkQUNXT29WUG02?=
 =?utf-8?B?YlJ0ZUhtZ085RVVMQndBdm52T01pZEZONUxacTZZSDhRTUY3NlVGUGR6MjVM?=
 =?utf-8?B?Q3VXakVwYTNBWTRmSlhJbTRiOTJTaWtXNEtHaFBpMmJGeTZCMXNZUTNXNlR5?=
 =?utf-8?B?S0o4VjlJdFpxNXJ2SGM4YXF6czQ0TTcxQjErTFJ3UC8zN0djbzE4S3Z2YnFJ?=
 =?utf-8?B?UFZFQVp2eEdXQ1FOTUFUZytjbWFpUjhGdnU5blM4Ukd0UVZhY3FKL1Y3ekRo?=
 =?utf-8?B?SU5IUU9uSVVERnB4ZXZ0cWZ5Z2ZXV0RydVBWRmFHbnMrL016aTI3NkJ6WWlQ?=
 =?utf-8?B?VUdVNVFSellZTER4RkVQZG5ON01OMDI3NXZTL05Hd1hQZndYZE5QUjhDY1JK?=
 =?utf-8?B?VjVVejRSTFF4QS9vL21GU2Vld1YrNGY1MEtuQVNoc1FVaWNvS1VVSXNZR3h5?=
 =?utf-8?B?cGRrK3YrT0ZyVUpCY1RxbCtxNkF5M3ZPMDN5SitWK2ZEWkx3VWtFZGdMQ3ZO?=
 =?utf-8?B?dzFHRjJxL3N2TzJlUTdZMWVNK1RjZXRZNGsvK3NtMWZadjREbG51RmUwVS9h?=
 =?utf-8?B?MEhVZ09GODN1VWdTT0V2WWJXV1RoMTlnKzl3d09yTnBnWGJBM21tcXpIZnFQ?=
 =?utf-8?B?eHZlOTFUcENLQU5Ka1ZzKzZqOTA4ak13UHNzVUNBR0tvU1I1ZDJ4REpna1dY?=
 =?utf-8?B?Y1MyMXNEU0JkeTg1VERBWDZhQUJKemNrK1BNMXhtOGR1N2x0cE00SzRSUnF2?=
 =?utf-8?B?VFZYMkdLSlJLbHNDbkpHVC95UTYxNmlEbFBCc0pIYWx2b0RmT2JOd0ZxNVlH?=
 =?utf-8?B?UERCOFpBRjFqY0NGTlYySWxObXB2UmpGaHpmSGlFN3dNTU01ZFkxYS9DZ0dB?=
 =?utf-8?B?dGI1QWo3bE1kT1ZuOWUrc2FIZk1XTkU2eWZ1R3JCNVlqRjF2VXp4MENvQytu?=
 =?utf-8?B?emg2anJuL2VZWW9IZHBWU2VJa25XdlF4eFY4MXVHRlFyWUdKUnVMMHpkREFz?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F8B7CC9A48F74A92C9C38ED4DC924C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d51bf3e-f34c-4990-d109-08dba8dcf45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 22:11:54.8445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEfMKW7jrl8A/HG1J+xnMVZEbvyJPurvepeW9c4cCTEzKMgEbiOTpjinP3jnwUkRsUFYEzvc1/l5UcS1tvyJcSlV+QxrheCzpfXN272DzhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9413
X-Proofpoint-GUID: R-GUEXnoDyvlG35ag-AHoI1XIIdWVjD_
X-Proofpoint-ORIG-GUID: R-GUEXnoDyvlG35ag-AHoI1XIIdWVjD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gQXVnIDI0LCAyMDIzLCBhdCAzOjQxIEFNLCBMaSBGZW5nIDxmZW5nbGlAc21hcnR4
LmNvbT4gd3JvdGU6DQo+IA0KPiBXaGVuIHRoZSB2aG9zdC11c2VyIGlzIHJlY29ubmVjdGluZyB0
byB0aGUgYmFja2VuZCwgYW5kIGlmIHRoZSB2aG9zdC11c2VyIGZhaWxzDQo+IGF0IHRoZSBnZXRf
ZmVhdHVyZXMgaW4gdmhvc3RfZGV2X2luaXQoKSwgdGhlbiB0aGUgcmVjb25uZWN0IHdpbGwgZmFp
bA0KPiBhbmQgaXQgd2lsbCBub3QgYmUgcmV0cmlnZ2VyZWQgZm9yZXZlci4NCj4gDQo+IFRoZSBy
ZWFzb24gaXM6DQo+IFdoZW4gdGhlIHZob3N0LXVzZXIgZmFpbHMgYXQgZ2V0X2ZlYXR1cmVzLCB0
aGUgdmhvc3RfZGV2X2NsZWFudXAgd2lsbCBiZSBjYWxsZWQNCj4gaW1tZWRpYXRlbHkuDQo+IA0K
PiB2aG9zdF9kZXZfY2xlYW51cCBjYWxscyAnbWVtc2V0KGhkZXYsIDAsIHNpemVvZihzdHJ1Y3Qg
dmhvc3RfZGV2KSknLg0KPiANCj4gVGhlIHJlY29ubmVjdCBwYXRoIGlzOg0KPiB2aG9zdF91c2Vy
X2Jsa19ldmVudA0KPiAgIHZob3N0X3VzZXJfYXN5bmNfY2xvc2UoLi4gdmhvc3RfdXNlcl9ibGtf
ZGlzY29ubmVjdCAuLikNCj4gICAgIHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycyA8LS0tLS0gY2xl
YXIgdGhlIG5vdGlmaWVyIGNhbGxiYWNrDQo+ICAgICAgIHNjaGVkdWxlIHZob3N0X3VzZXJfYXN5
bmNfY2xvc2VfYmgNCj4gDQo+IFRoZSB2aG9zdC0+dmRldiBpcyBudWxsLCBzbyB0aGUgdmhvc3Rf
dXNlcl9ibGtfZGlzY29ubmVjdCB3aWxsIG5vdCBiZQ0KPiBjYWxsZWQsIHRoZW4gdGhlIGV2ZW50
IGZkIGNhbGxiYWNrIHdpbGwgbm90IGJlIHJlaW5zdGFsbGVkLg0KPiANCj4gQWxsIHZob3N0LXVz
ZXIgZGV2aWNlcyBoYXZlIHRoaXMgaXNzdWUsIGluY2x1ZGluZyB2aG9zdC11c2VyLWJsay9zY3Np
Lg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoLCBpZiB0aGUgdmRldi0+dmRldiBpcyBudWxsLCB0aGUg
ZmQgY2FsbGJhY2sgd2lsbCBzdGlsbA0KPiBiZSByZWluc3RhbGxlZC4NCj4gDQo+IEZpeGVzOiA3
MWUwNzZhMDdkICgiaHcvdmlydGlvOiBnZW5lcmFsaXNlIENIUl9FVkVOVF9DTE9TRUQgaGFuZGxp
bmciKQ0KPiANCg0KQSBjb3VwbGUgb2YgTklUcywgb3RoZXJ3aXNlIExHVE0NCg0KUmV2aWV3ZWQt
Ynk6IFJhcGhhZWwgTm9yd2l0eiA8cmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tPg0KDQo+IFNp
Z25lZC1vZmYtYnk6IExpIEZlbmcgPGZlbmdsaUBzbWFydHguY29tPg0KPiAtLS0NCj4gaHcvYmxv
Y2svdmhvc3QtdXNlci1ibGsuYyAgICAgIHwgIDIgKy0NCj4gaHcvc2NzaS92aG9zdC11c2VyLXNj
c2kuYyAgICAgIHwgIDMgKystDQo+IGh3L3ZpcnRpby92aG9zdC11c2VyLWdwaW8uYyAgICB8ICAy
ICstDQo+IGh3L3ZpcnRpby92aG9zdC11c2VyLmMgICAgICAgICB8IDEwICsrKysrKysrLS0NCj4g
aW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci5oIHwgIDQgKysrLQ0KPiA1IGZpbGVzIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvYmxvY2svdmhvc3QtdXNlci1ibGsuYyBiL2h3L2Jsb2NrL3Zob3N0LXVzZXItYmxrLmMNCj4g
aW5kZXggM2M2OWZhNDdkNS4uOTVjNzU4MjAwZCAxMDA2NDQNCj4gLS0tIGEvaHcvYmxvY2svdmhv
c3QtdXNlci1ibGsuYw0KPiArKysgYi9ody9ibG9jay92aG9zdC11c2VyLWJsay5jDQo+IEBAIC0z
OTEsNyArMzkxLDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9ibGtfZXZlbnQodm9pZCAqb3Bh
cXVlLCBRRU1VQ2hyRXZlbnQgZXZlbnQpDQo+ICAgICBjYXNlIENIUl9FVkVOVF9DTE9TRUQ6DQo+
ICAgICAgICAgLyogZGVmZXIgY2xvc2UgdW50aWwgbGF0ZXIgdG8gYXZvaWQgY2lyY3VsYXIgY2xv
c2UgKi8NCj4gICAgICAgICB2aG9zdF91c2VyX2FzeW5jX2Nsb3NlKGRldiwgJnMtPmNoYXJkZXYs
ICZzLT5kZXYsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdXNlcl9i
bGtfZGlzY29ubmVjdCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3Rf
dXNlcl9ibGtfZGlzY29ubmVjdCwgdmhvc3RfdXNlcl9ibGtfZXZlbnQpOw0KPiAgICAgICAgIGJy
ZWFrOw0KPiAgICAgY2FzZSBDSFJfRVZFTlRfQlJFQUs6DQo+ICAgICBjYXNlIENIUl9FVkVOVF9N
VVhfSU46DQo+IGRpZmYgLS1naXQgYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jIGIvaHcvc2Nz
aS92aG9zdC11c2VyLXNjc2kuYw0KPiBpbmRleCBhN2ZhOGU4ZGYyLi5lOTMxZGY5ZjViIDEwMDY0
NA0KPiAtLS0gYS9ody9zY3NpL3Zob3N0LXVzZXItc2NzaS5jDQo+ICsrKyBiL2h3L3Njc2kvdmhv
c3QtdXNlci1zY3NpLmMNCj4gQEAgLTIzNiw3ICsyMzYsOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF91
c2VyX3Njc2lfZXZlbnQodm9pZCAqb3BhcXVlLCBRRU1VQ2hyRXZlbnQgZXZlbnQpDQo+ICAgICBj
YXNlIENIUl9FVkVOVF9DTE9TRUQ6DQo+ICAgICAgICAgLyogZGVmZXIgY2xvc2UgdW50aWwgbGF0
ZXIgdG8gYXZvaWQgY2lyY3VsYXIgY2xvc2UgKi8NCj4gICAgICAgICB2aG9zdF91c2VyX2FzeW5j
X2Nsb3NlKGRldiwgJnZzLT5jb25mLmNoYXJkZXYsICZ2c2MtPmRldiwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2aG9zdF91c2VyX3Njc2lfZGlzY29ubmVjdCk7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdXNlcl9zY3NpX2Rpc2Nvbm5lY3QsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdXNlcl9zY3NpX2V2ZW50KTsN
Cj4gICAgICAgICBicmVhazsNCj4gICAgIGNhc2UgQ0hSX0VWRU5UX0JSRUFLOg0KPiAgICAgY2Fz
ZSBDSFJfRVZFTlRfTVVYX0lOOg0KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXIt
Z3Bpby5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXItZ3Bpby5jDQo+IGluZGV4IGQ5OTc5YWE1ZGIu
LjA0YzJjYzc5ZjQgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC11c2VyLWdwaW8uYw0K
PiArKysgYi9ody92aXJ0aW8vdmhvc3QtdXNlci1ncGlvLmMNCj4gQEAgLTI4Myw3ICsyODMsNyBA
QCBzdGF0aWMgdm9pZCB2dV9ncGlvX2V2ZW50KHZvaWQgKm9wYXF1ZSwgUUVNVUNockV2ZW50IGV2
ZW50KQ0KPiAgICAgY2FzZSBDSFJfRVZFTlRfQ0xPU0VEOg0KPiAgICAgICAgIC8qIGRlZmVyIGNs
b3NlIHVudGlsIGxhdGVyIHRvIGF2b2lkIGNpcmN1bGFyIGNsb3NlICovDQo+ICAgICAgICAgdmhv
c3RfdXNlcl9hc3luY19jbG9zZShkZXYsICZncGlvLT5jaGFyZGV2LCAmZ3Bpby0+dmhvc3RfZGV2
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ1X2dwaW9fZGlzY29ubmVjdCk7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnVfZ3Bpb19kaXNjb25uZWN0LCB2
dV9ncGlvX2V2ZW50KTsNCj4gICAgICAgICBicmVhazsNCj4gICAgIGNhc2UgQ0hSX0VWRU5UX0JS
RUFLOg0KPiAgICAgY2FzZSBDSFJfRVZFTlRfTVVYX0lOOg0KPiBkaWZmIC0tZ2l0IGEvaHcvdmly
dGlvL3Zob3N0LXVzZXIuYyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMNCj4gaW5kZXggOGRjZjA0
OWQ0Mi4uOTU0MDc2NmRkMyAxMDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0K
PiArKysgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jDQo+IEBAIC0yNjQzLDYgKzI2NDMsNyBAQCB0
eXBlZGVmIHN0cnVjdCB7DQo+ICAgICBEZXZpY2VTdGF0ZSAqZGV2Ow0KPiAgICAgQ2hhckJhY2tl
bmQgKmNkOw0KPiAgICAgc3RydWN0IHZob3N0X2RldiAqdmhvc3Q7DQo+ICsgICAgSU9FdmVudEhh
bmRsZXIgKmV2ZW50X2NiOw0KPiB9IFZob3N0QXN5bmNDYWxsYmFjazsNCj4gDQo+IHN0YXRpYyB2
b2lkIHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgodm9pZCAqb3BhcXVlKQ0KPiBAQCAtMjY1Nyw3
ICsyNjU4LDEwIEBAIHN0YXRpYyB2b2lkIHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgodm9pZCAq
b3BhcXVlKQ0KPiAgICAgICovDQo+ICAgICBpZiAodmhvc3QtPnZkZXYpIHsNCj4gICAgICAgICBk
YXRhLT5jYihkYXRhLT5kZXYpOw0KPiAtICAgIH0NCj4gKyAgICB9IGVsc2UgaWYgKGRhdGEtPmV2
ZW50X2NiKSB7DQo+ICsgICAgICAgIHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycyhkYXRhLT5jZCwg
TlVMTCwgTlVMTCwgZGF0YS0+ZXZlbnRfY2IsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVUxMLCBkYXRhLT5kZXYsIE5VTEwsIHRydWUpOw0KPiArICAgfQ0KPiANCj4gICAg
IGdfZnJlZShkYXRhKTsNCj4gfQ0KPiBAQCAtMjY2OSw3ICsyNjczLDkgQEAgc3RhdGljIHZvaWQg
dmhvc3RfdXNlcl9hc3luY19jbG9zZV9iaCh2b2lkICpvcGFxdWUpDQo+ICAqLw0KPiB2b2lkIHZo
b3N0X3VzZXJfYXN5bmNfY2xvc2UoRGV2aWNlU3RhdGUgKmQsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBDaGFyQmFja2VuZCAqY2hhcmRldiwgc3RydWN0IHZob3N0X2RldiAqdmhvc3Qs
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgdnVfYXN5bmNfY2xvc2VfZm4gY2IpDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnVfYXN5bmNfY2xvc2VfZm4gY2IsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9FdmVudEhhbmRsZXIgKmV2ZW50X2NiDQoNCk5p
dDogd2h5IHRoZSBuZXdsaW5lIGJlZm9yZSB0aGUgY2xvc2luZyBwYXJlbnRoZXNpcz8NCg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICkNCj4gew0KPiAgICAgaWYgKCFydW5zdGF0ZV9j
aGVjayhSVU5fU1RBVEVfU0hVVERPV04pKSB7DQo+ICAgICAgICAgLyoNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXVzZXIuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0
LXVzZXIuaA0KPiBpbmRleCAxOTEyMTZhNzRmLi41ZmRjNzExZDRlIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L3ZpcnRpby92aG9zdC11c2VyLmgNCj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8v
dmhvc3QtdXNlci5oDQo+IEBAIC04NCw2ICs4NCw4IEBAIHR5cGVkZWYgdm9pZCAoKnZ1X2FzeW5j
X2Nsb3NlX2ZuKShEZXZpY2VTdGF0ZSAqY2IpOw0KPiANCj4gdm9pZCB2aG9zdF91c2VyX2FzeW5j
X2Nsb3NlKERldmljZVN0YXRlICpkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ2hh
ckJhY2tlbmQgKmNoYXJkZXYsIHN0cnVjdCB2aG9zdF9kZXYgKnZob3N0LA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZ1X2FzeW5jX2Nsb3NlX2ZuIGNiKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2dV9hc3luY19jbG9zZV9mbiBjYiwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJT0V2ZW50SGFuZGxlciAqZXZlbnRfY2INCg0KTml0OiBkaXR0byAtIGRv
buKAmXQgdGhpbmsgd2UgbmVlZCB0aGlzIG5ld2xpbmUgYmVmb3JlICk7DQoNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICApOw0KPiANCj4gI2VuZGlmDQo+IC0tIA0KPiAyLjQxLjANCj4g
DQoNCg==


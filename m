Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C48A11B43
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 08:50:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXy9d-0003Sr-Hu; Wed, 15 Jan 2025 02:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXy9O-0003SU-2r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:49:18 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tXy9F-0000cg-69
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736927349; x=1768463349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xXZc93eMKH8wzjGhg3Nu0FmBTnSgQqmDOtnxAafQLic=;
 b=oa1Ny7XraK+bltlng/MiFnzi+By3wltzwn9Hx5ng55Ghtsjj4A4J/zhB
 0inmc8v1FCUm4HN40ZxrGIPUEIa3sTpH6UpDIjWpqxkXhahrqwvGhEcY+
 ajLPj37euVwwxdZKxnGY7UFNiVWYHBZjoJYfM/rq9e5gv/iiPGN+9uU6j
 4Jw6h31O5lRnzVFvpI9zaIb/q0G2tXthdvNtpwB0v25UT+ky9JVLRMKZT
 JWl9s/GmAep0tlrOaZM9rao/qvzB9ixVQ7ynUPccw0r3PYEFYJU1utehK
 Gn4KsqDkrVy090J2s3UXJwsvZNzRc9ehtE8Q++M1EEMJcy5FCbb/CUZvL g==;
X-CSE-ConnectionGUID: GkN6TxuyQjyycj1a74MBFw==
X-CSE-MsgGUID: 95X0MIArTjGooGa/dFBAgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="53939196"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; d="scan'208";a="53939196"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 16:49:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF0Ki6eSdwW8VKUxfJlBtOJXwSkVPXWy4fPk4FonR/ZCGZrryDW0hgVMr/kJ/9AqLwgdPe2HiWoawDNOe7/Eg54BfiYQXWnBdHBSorr51UD1x8wP6Yb+x5zbhKbD4nyyJxp+HsHyNbGeQB0rXeXPM4owAemv/bmOocqRe14vtJr9bFljyI20Q264TQwLJsfFOGi0CaxfuHpGfMxYWLDa4K6slg+2EtHFM47beLaclO7GRpaIHyg7mOZ44sv6EDYQFcAp3jzTZqhaHsw9FEaXx4ighZloRMmHJhmcXfMoyn7WOzA61ybDjwEdLvaO0ABUkCfBhtEQMLnEs8O0MmwWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXZc93eMKH8wzjGhg3Nu0FmBTnSgQqmDOtnxAafQLic=;
 b=wYWbOfRDdUgXeROtekbSDAAnH6Rqokee9ISKGYb0uGbNp7olP5U/wx6VCPkLsjDkRV8iftIR1uLZI+C3fqPub1yFgf6xpkO86OMP6FtTRUE9PXqcWkYne/q81hpKcuBNSkjonqDkGi3jenE9fBspwQzFpSyumBFvHlPN7WtrIcLWzwqEpnYFIrZ6f9aZVqOkbhHZ2lAC8aCP9b4hHlpiWyLW7GaAYW/9Br3nCpMgG8Si6ZQidcezSbTBf46KfZWY5d9/moZV3ph5vaFOYHhnF5LxEn3WQIs8gSjNTW+Gjs01uEDBQX9qgDm+wrQ6wto1T8spSqmhtma2fNvlq7ZMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com (2603:1096:403:11::17)
 by TY3PR01MB11971.jpnprd01.prod.outlook.com (2603:1096:400:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 07:48:59 +0000
Received: from TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14]) by TYXPR01MB1566.jpnprd01.prod.outlook.com
 ([fe80::f896:4d51:593e:6a14%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 07:48:59 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Topic: [PATCH v2] hw/cxl: Fix msix_notify: Assertion `vector <
 dev->msix_entries_nr`
Thread-Index: AQHbTUJy2+Bu04d+mESXzsaCQaFJ0bMQUpAAgAdVkAA=
Date: Wed, 15 Jan 2025 07:48:59 +0000
Message-ID: <4d4a138f-4648-4733-933b-02cd8d934699@fujitsu.com>
References: <20241213093602.3248246-1-lizhijian@fujitsu.com>
 <20250110154432.000031b0@huawei.com>
In-Reply-To: <20250110154432.000031b0@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1566:EE_|TY3PR01MB11971:EE_
x-ms-office365-filtering-correlation-id: 96768d4d-f766-45b3-cd9f-08dd35391288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VVBxMFIyYUVxd0hkSmthWmlpb2VHWmRscy9PaTdUZGJERGU4VTFic09NMGdG?=
 =?utf-8?B?WGpQdlpWWCtzQ1Bqb1hwUjVDVHFXc09mcTJyRFRGNnpuVk51eC8rR2xMNkpo?=
 =?utf-8?B?b3p1ZFZLdWVvTUxacEY2ZGJabXRMaURpYzREdXkvRTZUVVpBc2QwUFM3VjFw?=
 =?utf-8?B?WG04UFVZZGhQOFEvQSs1aVpTMUM1NzNqSGV1NlhKQkZRbGR1VG9wM2hTNWpx?=
 =?utf-8?B?N1NIY2FBSSt0ZGxuazR3T3JIUm1iNm0yd0tiOXRzbnFLa3lYOU1RMG45Q1ZF?=
 =?utf-8?B?SDI3bnQ4TXRORDIveENkZ2hyTXFoWEtFU2JtRmlNUHZNUmpnU3JXK3BzeWVX?=
 =?utf-8?B?QTRTRTJNbjlJNlA4ODR3cVd1SE44akpLYkNadjY5aHNnWjZTTXpqdFk0Z0ht?=
 =?utf-8?B?UHBSbzNRWGhhQzVWbDIydzl6VHkrOXQ2SUQ0bjRybzVrNVp3VkJIV1hneFJR?=
 =?utf-8?B?Y210bGgxOEhQdzlZM2c0TFUrenJnb2xMYmF4NFNzWkNHZGIyY0lRZi9PRVJx?=
 =?utf-8?B?cEx1WGRueDJZSXBPVzZscTVkM2N3L2x1MlVUdG1oc0xCdXd5a1p1LytQNU1L?=
 =?utf-8?B?VTZkVytlOEdRWkxhWVVwdzYyT3AxM2o5dkczbWhEU1paSUNIY0RGaU05MXRN?=
 =?utf-8?B?ODB5QTVYNzJpYWgwWFFPZExUcFZTUzl5amV4R1c4d3haQnZITXFLR0dkbm8z?=
 =?utf-8?B?WkFOcE82QXNURmVucC92WXJjME94enNaK1o0OTV1aFlteFE0Y3l2dDVIU1g5?=
 =?utf-8?B?ZVdTcDJEbWMxRFpqTHJHUkRHOG9TR1ZrMnA2c0tRS1E3RXNERlp6SmczZjYx?=
 =?utf-8?B?bHVvckw2L0dvdy9TVkQwSGxxeXJ3UkV2aWgzYTZLak5FSFJqUVlER3luS3VI?=
 =?utf-8?B?anpuenZPU3ErWDNZaGVCQklDZXJFbFFoc3hqNXVtcG9lY3FxZjU3TU4xMUg2?=
 =?utf-8?B?VnBlK0FvTWwxbWtVKzNDQUtVVis0NUJEK2tmTnFKdTRRSG1MWUl3NHU4aEgv?=
 =?utf-8?B?ekprbVU2WFdXRzR5WmZoOW1qN0o3OC93c0hlY1JFUmFGMk5UNkQzdDl1cHhv?=
 =?utf-8?B?elAycFhTQ3hxb1J5TGZOcGhVT2c5NDZVamxNY3pldlRTZWkvK3pJUEhLbVky?=
 =?utf-8?B?MEpTUTVmYU9HWkluV1k2d1I5eTJNVFJvMmRPWnVoNnd5R1k1TlUwM3JXUThX?=
 =?utf-8?B?bW5pZmUxNm9DOXRxUHFTQ3FFekhPTzZYcXpacWIrUmhwb1Z5KysvMVlMMG9k?=
 =?utf-8?B?TTkyV1ZDY3oxTE5LNVRXZjdaNjhlNHVYdURGQkIwR3lzbEZVdWZXSjU1K0ts?=
 =?utf-8?B?R3pGMk5HVnB5Q2Y1T2ZwZ1cxbzl2Rk5MNGFhOGVHTk0wSzgvbXlmWjNLMStC?=
 =?utf-8?B?ZDlveGhpY21iSGdocTVYZGFKNFV0WFRnL2Y5K1lnQ3ZDOVp0RzZWK3ZmVHJC?=
 =?utf-8?B?U1hBZHgzKzNXRWdibmRLK1pGdGhKODRiaVBzUXZKTU1QMHJBbktUMWtMOXlH?=
 =?utf-8?B?bXVBcDVNL3U2eXpuaFBpenBpZGVVb01nSCtrQjFBeTl4L3RCWnV2RlhudUsv?=
 =?utf-8?B?RlpGV0d4TEhGWkZhSDNNb0dmWjkyZ3RHYzZxcm9LUHdyb3BuSTNSU2hoZ3Bs?=
 =?utf-8?B?c2s1N3FUOFh2Ti9tSFhPYUdLTWpRTDY1aWx4S21LTVJxbEN3ZDZ5TnF6dGVW?=
 =?utf-8?B?K2pUSlY4NmlGYnBFNlBvTkVQbzBFZEdVQ0tlQ3ZmSDJVemhtZ2tKQW8rMmIz?=
 =?utf-8?B?am4yekc3Tm94eXRuNldqMTlRTTcwQmg3eEJYKzFqNzkrclhoY3RWVzdFd2Vk?=
 =?utf-8?B?dnBha2tENUNNTzZOeHB2MXJOQWxZV3dtOHJRMk1HR1FMWGtBVlZCWjYrWk1J?=
 =?utf-8?B?YTUzWnNuQnViQjZUTXhiT0w1TjZTUkxWLzVJM2FxWHRkVklXN1dxWHJ5OStq?=
 =?utf-8?B?OUk4SXJ6T1dRZGRNQ1FOU2tsMmN1VHRidm1KOTNvV21RMTV6cyt6Mmp1ZmxE?=
 =?utf-8?B?TmorRXYrMEZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYXPR01MB1566.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmRhZFdlbG0zbmlsR3MyZWZRSW5OYnI2V0E4b290VWU4MTJSOG9EUU9nZXNI?=
 =?utf-8?B?QS85UytqY29RK0lVK3RqanRDOUxIaXNDOEdVSFhDSmJZQXE3OGYvUmtMbGdi?=
 =?utf-8?B?YWYrRHZTcGtrd2c1NjROS1NreUt2WTNjZ3Z0TlVnZTRWbmRycTR1T1E2UnR2?=
 =?utf-8?B?aEhFcFIzQmp5NWVhSk1DdkFMbnRJTG5BZzFyUWgxNkx1N2MxdDYwOWozU0Ix?=
 =?utf-8?B?NGExYVExQ1FyUUhvZ1k4dWd1SytNNWVkWjFkNytZR0tIejF5MU9WcVVnYzRm?=
 =?utf-8?B?TzFHSkMyalpjczdsWlBHbHNSQWtXczhvOGc5TDEwaEpvbmg2WC8yaGNFNTI2?=
 =?utf-8?B?MzZDWERzYlBCWkQ3c08yamg5OG1kSjFFdE5XQVphRW5tT09BQWUwQzlpVkV3?=
 =?utf-8?B?a2NGckpqcFZPZWJjYlNGL1ovcjA3eXQ1c2lIYlQ1WkpScCtnTy9IdzNZSS9D?=
 =?utf-8?B?QzZnQmd3dHQ3NkF6WjhKUmh3STZzOVcrY0M3aW5nSjdCcWNQaENFZ0VVQXVN?=
 =?utf-8?B?ZDFpVnBhbytzS0tDLzg2MU5EdmNady84SlVseFRna3hoMnh3TlpGdkYwYWxm?=
 =?utf-8?B?dlloekFac0Z6NWhLZUlIclY5ZG9WbHpFRzJrV1N1OU5EV3lteXRkSEhlRG9C?=
 =?utf-8?B?K1c0SmpKeG1kNWRuVU9kYU1HNHlnSlR5bkx0RWd6S0J1UzZ6K1diVlJXa1NQ?=
 =?utf-8?B?WFp3Y3UyemExM0xLc3A5NDZtbVkzL1NPMnpsczRmT0x5ckUxaHo1bE4wQis2?=
 =?utf-8?B?MkJaaENnSWZ2Q0hXVFJXYXZGSUd6dnpOMmpOeUVkL3JQY1VaRzIvT3FJNlhm?=
 =?utf-8?B?NFh2VGxaMXJGVngyZlJjc2ZlamNCVTA2M2FKUE9KNXpXeXlhazl2QXFPR1h0?=
 =?utf-8?B?T1VtM2tybG9LWHA2bE1xY2k0NkFmVllhS3RxVVREMDBQa1FkV1NnTjIxTG5h?=
 =?utf-8?B?TDNYTUx0YkVQdUZKOTJRWC9lVS9YNjNjODBNT2lxa0V2WTRRcWh6RnNHYnN2?=
 =?utf-8?B?RG9ycGFUMmpLNWhCTC9YUVdxeTJyaHVhazhVMFovYjFyOFVSQkJkUmlEYmt4?=
 =?utf-8?B?ZkxqWXVYbHRvU0grTEJ2clRscmd4MU14eitteG9oMTF5TStGek1rZFozSWRM?=
 =?utf-8?B?d0FuMmdabWxJejdUYWh5VDFOR3M2cGR4b0JWR3ovazl6NE9aMUVBL2RBZTI3?=
 =?utf-8?B?bXI4alhRdUVkd3IreTUzNFROQU5IQXVOd2MwZlp1N0VxN3d2MHc2QXFwZWtX?=
 =?utf-8?B?WVpTVnhnZjBrUXo5MTM4NFlpK1BDVVpPOHNSb09SSW8yTjV4c01URXRkMEpJ?=
 =?utf-8?B?dVVVSmZQTGU2V29nRlNEbmg1TGllM1Y1VmUrbkJScjU0TTQ4ZjFTaHpHRVZ4?=
 =?utf-8?B?TXQ0eDVoM0ZxL0pZTHRVNmVERVlqSVJETjVab2xWZ0lWSWd4S1czNThkMU5j?=
 =?utf-8?B?RmxPc01BMFNNNWNWK01TOFg1U1ZSeFpseXF5eUpmazRJUXI5bE1pMi9icGkr?=
 =?utf-8?B?ckRNbkhPbkVSRFVxWFgrT1d5UmlRWTJzVFovWmFKcC9EWmtoSThOSDA3dVYr?=
 =?utf-8?B?ekNLVE41L1Fkb3N6Q2xmOHRtRU1LOWpSWEFweWtCT2JkS0VsQzhEQnBrNjEz?=
 =?utf-8?B?TlMrOGVEclpmL2lndDNzWDdLV0djZjVCNzlzaXNtYXFyMlZ1YmR5RGplUUUr?=
 =?utf-8?B?L29aTWliZk9laWNndEFNL3Q0Z2dxMU1RNDlXYUdTNzVMb09VTXZTaDRFUkJR?=
 =?utf-8?B?TUJ2dkhDR1B2KzJsRmI2RG9oL3VxMExoeU1BN29xaWVMQ0MraTZXcGRrTDBL?=
 =?utf-8?B?T3J6bTlnRko5NHMwN25JQ2hEaFFMMVUrVVVHVzhPSTF3aEFtRTFLY2NuS2NE?=
 =?utf-8?B?REdJT092QS9paG1JTVdPQ0ZKTHlEcHkwSzJxOUZDSkFpTkFBMUZDN1VpYklQ?=
 =?utf-8?B?Q1lJVVE4MXdMdlo4UXpQSVNBTFhGYTd6elhSeEhFcytHL2YwUzU4UkJPYXUv?=
 =?utf-8?B?OFRLUW9ibERqRnQ5alRDS3lBc0I1QjhtdGR2QXF5L2lKUEhJdDI1OFNaTkFZ?=
 =?utf-8?B?aXZqdzNUcExpNW1ubk5VTHNPckY2cktUSHZLWTNablZzaDJnOHlvRGVEOGl0?=
 =?utf-8?B?Tk1UN3V1Mmh6ZHMzcEtseUhySDlMOGQvL3pKWHhjNW92OW12Z2xWN0FROXls?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBEDF74F8DCBF046920944A6287A257D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VKDVFHktbQpa3SOv4+e+95pGqxC5PlbVEIgPJqXe2psgQxG4/+lADapepF7fiKQbc2F9kIPSAdjth2+uWBjLKVRSID4InlJjN9q3SZTGBhfQuE7PcMWBUrSM70GYe+zBqZuEuOMtm/i5CT0Ys9mO1Qx+NPKpynHywdKs0egce4cl7SyEESs31AlO/T3e9PAxfRljxIg0bL1Geak4Yhhh3sh7+L3g4TzXSHxLwQAQL3afk5xFSNfIJ5uGhesnoIMYFRiZHj2XVOV4/2rIqKsVY0+HZyg/7jvwsl9DHNuhY/Hus6SwKtLsdl+o+7rd1TfEUfmZvhvQsJUpusd7xmEKM3xPNFFxsIan21RQKXzOwbWsnVWs20KZTwrQI3M5VO3p8Z/5tQ8oYCGhX8oDTvTqdGvVOmdVotOP9KFmUSssNtJBLui7or32d5Iy+i3XawJ//dpddBMRhwhjouEdenxUK4Fnk3V5+496GFtSH+TDGfWebYXHBXZM/youAu1/mzh7T9q8N9QN4Vgm+R4yisrc1rQng5oJ4G+tNhwK+iJIEI82futSAMJNT036tqPKAGdeRavjKGvbIyySA39pEnymtu8W4vIJ6PJ5AKlBBlk4pcIa2S/XRBG/4brqqMBGkyLL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1566.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96768d4d-f766-45b3-cd9f-08dd35391288
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 07:48:59.6449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdgJIE4h9eWI+KeOJAisoSm6g8gwqN6rYhEaZnWkcivZ5UA5KeXgVKV+f6izOqkche7lCUU/j//KjZTIbFl2Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11971
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

DQoNCk9uIDEwLzAxLzIwMjUgMjM6NDQsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIEZy
aSwgMTMgRGVjIDIwMjQgMTc6MzY6MDIgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBUaGlzIGFzc2VydGlvbiBhbHdheXMgaGFwcGVucyB3
aGVuIHdlIHNhbml0aXplIHRoZSBDWEwgbWVtb3J5IGRldmljZS4NCj4+ICQgZWNobyAxID4gL3N5
cy9idXMvY3hsL2RldmljZXMvbWVtMC9zZWN1cml0eS9zYW5pdGl6ZQ0KPj4NCj4+IEl0IGlzIGlu
Y29ycmVjdCB0byByZWdpc3RlciBhbiBNU0lYIG51bWJlciBiZXlvbmQgdGhlIGRldmljZSdzIGNh
cGFiaWxpdHkuDQo+Pg0KPj4gRXhwYW5kIHRoZSBkZXZpY2UncyBNU0lYIG51bWJlciBhbmQgdXNl
IHRoZSBlbnVtIHRvIG1haW50YWluIHRoZSAqVVNFRCoNCj4+IGFuZCBNQVggTVNJWCBudW1iZXIN
Cj4+DQo+PiBGaXhlczogNDNlZmIwYmZhZDJiICgiaHcvY3hsL21ib3g6IFdpcmUgdXAgaW50ZXJy
dXB0cyBmb3IgYmFja2dyb3VuZCBjb21wbGV0aW9uIikNCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gVjI6IGp1c3QgaW5jcmVh
c2UgbXNpeCBudW1iZXIgYW5kIGFkZCBlbnVtIHRvIG1haW50YWluZXIgdGhlaXIgdmFsdWVzICMN
Cj4+IEpvbmF0aGFuDQo+IA0KPiBBaC4gU29ycnkgSSB3YXMgdW5jbGVhci4gVHdvIHBhdGNoZXMg
cGxlYXNlDQo+IA0KPiAxLiBNYWtlIHRoZSBudW1iZXIgYmlnZ2VyIHRvIGZpeCB0aGUgYnVnLiBP
bmx5IHRoaXMgb25lIGdldHMgYSBmaXhlcyB0YWcgYW5kDQo+ICAgICBpcyBzdWl0YWJsZSBmb3Ig
YmFja3BvcnRpbmcuDQo+IA0KPiAyLiBBZGQgYW4gZW51bSBpbmNsdWRpbmcgYWxsIG51bWJlcnMg
Y3VycmVudGx5IHVzZWQgYW5kIHVzZSB0aGF0IHRocm91Z2hvdXQgdGhlDQo+ICAgICB0eXBlMyBy
ZWxhdGVkIGNvZGUuIFRoYXQgd2lsbCBwcmV2ZW50IHVzZSBhY2NpZGVudGFsbHkgaW50cm9kdWNp
bmcgdGhlDQo+ICAgICBidWcgaW4gZnV0dXJlIGJ1dCBkb2Vzbid0IG5lZWQgdG8gYmUgYmFja3Bv
cnRlZC4NCj4gICANCg0KVW5kZXJzdG9vZCwgaXQgbWFrZSBzZW5zZS4NCg0KDQoNCj4gQSBmZXcg
b3RoZXIgY29tbWVudHMgaW5saW5lLg0KPiANCj4gVGhhbmtzDQo+IA0KPiBKb25hdGhhbg0KPiAN
Cj4+IC0tLQ0KPj4gICBody9jeGwvY3hsLWRldmljZS11dGlscy5jICAgfCAgNiArKy0tLS0NCj4+
ICAgaHcvbWVtL2N4bF90eXBlMy5jICAgICAgICAgIHwgMTAgKysrKystLS0tLQ0KPj4gICBpbmNs
dWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggfCAgNyArKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aHcvY3hsL2N4bC1kZXZpY2UtdXRpbHMuYyBiL2h3L2N4bC9jeGwtZGV2aWNlLXV0aWxzLmMNCj4+
IGluZGV4IDAzNWQwMzRmNmQuLmJjMjE3MWUzZDQgMTAwNjQ0DQo+PiAtLS0gYS9ody9jeGwvY3hs
LWRldmljZS11dGlscy5jDQo+PiArKysgYi9ody9jeGwvY3hsLWRldmljZS11dGlscy5jDQo+PiBA
QCAtMzU0LDggKzM1NCw2IEBAIHN0YXRpYyB2b2lkIGRldmljZV9yZWdfaW5pdF9jb21tb24oQ1hM
RGV2aWNlU3RhdGUgKmN4bF9kc3RhdGUpDQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCBtYWlsYm94
X3JlZ19pbml0X2NvbW1vbihDWExEZXZpY2VTdGF0ZSAqY3hsX2RzdGF0ZSkNCj4+ICAgew0KPj4g
LSAgICBjb25zdCB1aW50OF90IG1zaV9uID0gOTsNCj4+IC0NCj4+ICAgICAgIC8qIDIwNDggcGF5
bG9hZCBzaXplICovDQo+PiAgICAgICBBUlJBWV9GSUVMRF9EUDMyKGN4bF9kc3RhdGUtPm1ib3hf
cmVnX3N0YXRlMzIsIENYTF9ERVZfTUFJTEJPWF9DQVAsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgIFBBWUxPQURfU0laRSwgQ1hMX01BSUxCT1hfUEFZTE9BRF9TSElGVCk7DQo+PiBAQCAtMzY0
LDggKzM2Miw4IEBAIHN0YXRpYyB2b2lkIG1haWxib3hfcmVnX2luaXRfY29tbW9uKENYTERldmlj
ZVN0YXRlICpjeGxfZHN0YXRlKQ0KPj4gICAgICAgQVJSQVlfRklFTERfRFAzMihjeGxfZHN0YXRl
LT5tYm94X3JlZ19zdGF0ZTMyLCBDWExfREVWX01BSUxCT1hfQ0FQLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICBCR19JTlRfQ0FQLCAxKTsNCj4+ICAgICAgIEFSUkFZX0ZJRUxEX0RQMzIoY3hs
X2RzdGF0ZS0+bWJveF9yZWdfc3RhdGUzMiwgQ1hMX0RFVl9NQUlMQk9YX0NBUCwNCj4+IC0gICAg
ICAgICAgICAgICAgICAgICBNU0lfTiwgbXNpX24pOw0KPj4gLSAgICBjeGxfZHN0YXRlLT5tYm94
X21zaV9uID0gbXNpX247DQo+PiArICAgICAgICAgICAgICAgICAgICAgTVNJX04sIENYTF9NU0lY
X01CT1gpOw0KPiANCj4gU2hvdWxkIGJlIHBhc3NlZCBpbiBmcm9tIHRoZSB0eXBlIDMgc3BlY2lm
aWMgY2FsbCBzbyBhZGQgYSBwYXJhbWV0ZXIgdG8gdGhpcw0KPiBmdW5jdGlvbiBhbmQgcGFzcyB0
aGlzIGZyb20gY3hsX2RldmljZV9yZWdpc3Rlcl9pbml0X3QzLg0KPiBFdmVuIGJldHRlciBwYXNz
IGl0IGludG8gdGhlcmUgZnJvbSBjdDNkX3Jlc2V0KCkNCj4gDQoNCkF0IGEgZ2xhbmNlLCBgY3Qz
ZF9yZXNldCgpYCBoYXMgdGhlIGZvbGxvd2luZyBwcm90b3R5cGU6IGB0eXBlZGVmIHZvaWQgKCpE
ZXZpY2VSZXNldCkoRGV2aWNlU3RhdGUgKmRldilgLA0Kd2hpY2ggaXMgaW5oZXJpdGVkIGZyb20g
dGhlIFFFTVUgZGV2aWNlIGZyYW1ld29yay4gQ29uc2VxdWVudGx5LCBpdCBpcyBoYXJkIHRvIGV4
dGVuZCBgY3QzZF9yZXNldCgpYA0KdG8gaW5jbHVkZSBhbiBhZGRpdGlvbmFsIHBhcmFtZXRlci4N
Cg0KDQoNCj4gV2lsbCBwb3RlbnRpYWxseSBiZSBhIGRpZmZlcmVudCBudW1iZXIgZm9yIHRoZSBz
d2l0Y2ggQ0NJIHBhc3NlZCBpbiBmcm9tDQo+IHRoZSBjYWxsIG9mIGN4bF9kZXZpY2VfcmVnaXN0
ZXJfaW5pdF9zd2NjaSgpIGluIHN3aXRjaC1tYWlsYm94LWNjaS5jDQoNCkl0IHNvdW5kcyByZWFz
b25hYmxlLCBvZmZlcmluZyBhIG1vcmUgZmxleGlibGUgZGVzaWduIGZvciB0aGUgZnV0dXJlLg0K
DQpDdXJyZW50bHksIG1haWxib3hfcmVnX2luaXRfY29tbW9uKCkgd2lsbCBiZSBjYWxsZWQgZnJv
bSB0eXBlMyBkZXZpY2UgYW5kIHN3Y2NpLA0KaG93ZXZlciwgSSBkaWRuJ3Qgc2VlIGFueSB3aGVy
ZSB0aGUgc3djY2kgaXRzZWxmIGhhdmUgc2V0dXAgdGhlIG1zaS9tc2l4IGF0IGFsbC4NCg0KSXMg
dGhpcyBleHBlY3RlZCwgZmVlbCBmcmVlIHRvIGxldCBtZSBrbm93IGlmIEknbSBtaXNzaW5nIHNv
bWV0aGluZy4NCg0KPiANCj4gDQo+PiArICAgIGN4bF9kc3RhdGUtPm1ib3hfbXNpX24gPSBDWExf
TVNJWF9NQk9YOw0KPj4gICAgICAgQVJSQVlfRklFTERfRFAzMihjeGxfZHN0YXRlLT5tYm94X3Jl
Z19zdGF0ZTMyLCBDWExfREVWX01BSUxCT1hfQ0FQLA0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICBNQk9YX1JFQURZX1RJTUUsIDApOyAvKiBOb3QgcmVwb3J0ZWQgKi8NCj4+ICAgICAgIEFSUkFZ
X0ZJRUxEX0RQMzIoY3hsX2RzdGF0ZS0+bWJveF9yZWdfc3RhdGUzMiwgQ1hMX0RFVl9NQUlMQk9Y
X0NBUCwNCj4+IGRpZmYgLS1naXQgYS9ody9tZW0vY3hsX3R5cGUzLmMgYi9ody9tZW0vY3hsX3R5
cGUzLmMNCj4+IGluZGV4IDVjZjc1NGIzOGYuLmYyZjA2MGVkOWUgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9tZW0vY3hsX3R5cGUzLmMNCj4+ICsrKyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPj4gQEAgLTg0
Myw3ICs4NDMsNiBAQCBzdGF0aWMgdm9pZCBjdDNfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYs
IEVycm9yICoqZXJycCkNCj4+ICAgICAgIENvbXBvbmVudFJlZ2lzdGVycyAqcmVncyA9ICZjeGxf
Y3N0YXRlLT5jcmI7DQo+PiAgICAgICBNZW1vcnlSZWdpb24gKm1yID0gJnJlZ3MtPmNvbXBvbmVu
dF9yZWdpc3RlcnM7DQo+PiAgICAgICB1aW50OF90ICpwY2lfY29uZiA9IHBjaV9kZXYtPmNvbmZp
ZzsNCj4+IC0gICAgdW5zaWduZWQgc2hvcnQgbXNpeF9udW0gPSA2Ow0KPj4gICAgICAgaW50IGks
IHJjOw0KPj4gICAgICAgdWludDE2X3QgY291bnQ7DQo+PiAgIA0KPj4gQEAgLTg4NCwxNiArODgz
LDE3IEBAIHN0YXRpYyB2b2lkIGN0M19yZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwgRXJyb3Ig
KiplcnJwKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAmY3QzZC0+Y3hsX2RzdGF0ZS5kZXZp
Y2VfcmVnaXN0ZXJzKTsNCj4+ICAgDQo+PiAgICAgICAvKiBNU0koLVgpIEluaXRpYWxpemF0aW9u
ICovDQo+PiAtICAgIHJjID0gbXNpeF9pbml0X2V4Y2x1c2l2ZV9iYXIocGNpX2RldiwgbXNpeF9u
dW0sIDQsIE5VTEwpOw0KPj4gKyAgICByYyA9IG1zaXhfaW5pdF9leGNsdXNpdmVfYmFyKHBjaV9k
ZXYsIENYTF9NU0lYX01BWCwgNCwgTlVMTCk7DQo+PiAgICAgICBpZiAocmMpIHsNCj4+ICAgICAg
ICAgICBnb3RvIGVycl9hZGRyZXNzX3NwYWNlX2ZyZWU7DQo+PiAgICAgICB9DQo+PiAtICAgIGZv
ciAoaSA9IDA7IGkgPCBtc2l4X251bTsgaSsrKSB7DQo+PiArICAgIGZvciAoaSA9IDA7IGkgPCBD
WExfTVNJWF9NQVg7IGkrKykgew0KPj4gICAgICAgICAgIG1zaXhfdmVjdG9yX3VzZShwY2lfZGV2
LCBpKTsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAgICAgICAvKiBET0UgSW5pdGlhbGl6YXRpb24g
Ki8NCj4+IC0gICAgcGNpZV9kb2VfaW5pdChwY2lfZGV2LCAmY3QzZC0+ZG9lX2NkYXQsIDB4MTkw
LCBkb2VfY2RhdF9wcm90LCB0cnVlLCAwKTsNCj4+ICsgICAgcGNpZV9kb2VfaW5pdChwY2lfZGV2
LCAmY3QzZC0+ZG9lX2NkYXQsIDB4MTkwLCBkb2VfY2RhdF9wcm90LCB0cnVlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgIENYTF9NU0lYX1BDSUVfRE9FKTsNCj4+ICAgDQo+PiAgICAgICBjeGxfY3N0
YXRlLT5jZGF0LmJ1aWxkX2NkYXRfdGFibGUgPSBjdDNfYnVpbGRfY2RhdF90YWJsZTsNCj4+ICAg
ICAgIGN4bF9jc3RhdGUtPmNkYXQuZnJlZV9jZGF0X3RhYmxlID0gY3QzX2ZyZWVfY2RhdF90YWJs
ZTsNCj4+IEBAIC05MDgsNyArOTA4LDcgQEAgc3RhdGljIHZvaWQgY3QzX3JlYWxpemUoUENJRGV2
aWNlICpwY2lfZGV2LCBFcnJvciAqKmVycnApDQo+PiAgICAgICBpZiAocmMpIHsNCj4+ICAgICAg
ICAgICBnb3RvIGVycl9yZWxlYXNlX2NkYXQ7DQo+PiAgICAgICB9DQo+PiAtICAgIGN4bF9ldmVu
dF9pbml0KCZjdDNkLT5jeGxfZHN0YXRlLCAyKTsNCj4+ICsgICAgY3hsX2V2ZW50X2luaXQoJmN0
M2QtPmN4bF9kc3RhdGUsIENYTF9NU0lYX0VWRU5UX1NUQVJUKTsNCj4+ICAgDQo+PiAgICAgICAv
KiBTZXQgZGVmYXVsdCB2YWx1ZSBmb3IgcGF0cm9sIHNjcnViIGF0dHJpYnV0ZXMgKi8NCj4+ICAg
ICAgIGN0M2QtPnBhdHJvbF9zY3J1Yl9hdHRycy5zY3J1Yl9jeWNsZV9jYXAgPQ0KPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaCBiL2luY2x1ZGUvaHcvY3hsL2N4bF9k
ZXZpY2UuaA0KPj4gaW5kZXggNTYxYjM3NWRjOC4uM2Y4OWIwNDFjZSAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvaHcvY3hsL2N4bF9kZXZpY2UuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9jeGwvY3hs
X2RldmljZS5oDQo+PiBAQCAtMTMzLDYgKzEzMywxMyBAQCB0eXBlZGVmIGVudW0gew0KPj4gICAg
ICAgQ1hMX01CT1hfTUFYID0gMHgyMA0KPj4gICB9IENYTFJldENvZGU7DQo+PiAgIA0KPj4gK2Vu
dW0gew0KPiANCj4gTWF5YmUgd29ydGggbmFtaW5nIHRoZXNlIHRvIGJlIHR5cGUzIHNwZWNpZmlj
Lg0KDQpJdCBzb3VuZHMgZ29vZCB0byBtZS4NCg0KDQo+IA0KPj4gKyAgICBDWExfTVNJWF9QQ0lF
X0RPRSA9IDAsDQo+IE5hbWUgaXQgdG8gaW5jbHVkZSB0aGF0IHRoaXMgaXMgc3BlY2lmaWNhbGx5
IHRoZSBET0UgZm9yIHRoZSB0YWJsZSBhY2Nlc3MgcHJvdG9jb2wuDQo+IA0KPiAgICAgQ1hMX01T
SVhfUENJRV9ET0VfVEFCTEVfQUNDRVNTDQoNCm1ha2Ugc2Vuc2UuDQoNCg0KPiANCj4gDQo+IFRo
aXMgc2hvdWxkIGJlIHByaXZhdGUgdG8gY3hsX3R5cGUzLmMgd2hpY2ggc2hvdWxkIGJlIHBvc3Np
YmxlIGJ5IHBhc3NpbmcNCj4gaXQgdG8gYSBmZXcgbW9yZSBjYWxscyBmcm9tIHRoZXJlLg0KPiAN
Cg0KSWYgd2UgbWFrZSB0aGUgZW50aXJlIGVudW1lcmF0aW9uIGBjeGxfdHlwZTNgIHByaXZhdGUs
IGl0IGFwcGVhcnMgdW5uZWNlc3NhcnkgdG8gcGFzcyBpdCB0aHJvdWdoIHNldmVyYWwgbW9yZSBj
YWxscy4NCg0KSG93IGFib3V0IHRoaXMNCg0KKy8qIHR5cGUzIGRldmljZSBwcml2YXRlICovDQor
ZW51bSBDWExfVDNfTVNJWF9WRUNUT1Igew0KKyAgICBDWExfVDNfTVNJWF9QQ0lFX0RPRV9UQUJM
RV9BQ0NFU1MgPSAwLA0KKyAgICBDWExfVDNfTVNJWF9FVkVOVF9TVEFSVCA9IDIsDQorICAgIENY
TF9UM19NU0lYX01CT1ggPSBDWExfVDNfTVNJWF9FVkVOVF9TVEFSVCArIENYTF9FVkVOVF9UWVBF
X01BWCwNCisgICAgQ1hMX1QzX01TSVhfVkVDVE9SX05SDQorfTsNCisNCg0KDQpUaGFua3MNClpo
aWppYW4NCg0KPj4gKyAgICBDWExfTVNJWF9FVkVOVF9TVEFSVCA9IDIsDQo+PiArICAgIENYTF9N
U0lYX01CT1ggPSBDWExfTVNJWF9FVkVOVF9TVEFSVCArIENYTF9FVkVOVF9UWVBFX01BWCwNCj4+
ICsgICAgQ1hMX01TSVhfTUFYDQo+PiArfTsNCj4+ICsNCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgQ1hM
Q0NJIENYTENDSTsNCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgY3hsX2RldmljZV9zdGF0ZSBDWExEZXZp
Y2VTdGF0ZTsNCj4+ICAgc3RydWN0IGN4bF9jbWQ7DQo+IA==


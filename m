Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769AAD1689
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 03:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uORWE-0005ov-7g; Sun, 08 Jun 2025 21:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uORW7-0005oA-9W; Sun, 08 Jun 2025 21:41:39 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uORW5-0001wo-67; Sun, 08 Jun 2025 21:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1749433297; x=1780969297;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mmVmsVW/VkTT2vaXt3P4p/wHRc5/E/wFXJF2rVXg3sA=;
 b=IuivMElrHqBoBUPe94qhqcJRasMbwQ2BEXMdr7y3GI2HF8usak14/EH7
 /1V+v4zJZvL7JzAUDVLQEu3j+ZtDmEKxWRUugkR1si0DIDeffZjaNSr/n
 kZpD2aEKPZ9sXAnrGsYsUNfb09O471UibgDEJPI8CYqHuiaO3c1Fkucdg
 RHKjp71SbWy7BxcNJKfWZgAzbgJ3qa8ecdw2eeHt78kOYdfYfWmZ2sXX4
 fYgEy0uRdpIxukM/Kv+S4nWh9mKzlTT0+JBvO9qhOTPnwey/YtiP58IRS
 LO1QbolT/FySOVMs/S9ZF+MptucqSzVg5qvkT8Ekx1ZFy8S7QtxZNkTyt Q==;
X-CSE-ConnectionGUID: L3p1B6hLTLmXqGDImEDbeQ==
X-CSE-MsgGUID: CwXGUSV3QRyrnLHZCwVLXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="157403730"
X-IronPort-AV: E=Sophos;i="6.16,221,1744038000"; d="scan'208";a="157403730"
Received: from mail-japaneastazon11010067.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.67])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 10:41:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYHr+x6CTqQ6LrtUBsn/V04h0eH+u5OaMzqMxiUhgK5o3b70Gr654Qh4TPTNxZV5GJyS5IHBTz8Kjn3q04mZTCLCbO2jqD35kiJalpx7/QT1cYnL1NUAEhtaehnFVfqOl4JbQbsohirD6p+pEe3FOMOcc2Z3uFOsUFjch49gFBe7hJkZoFaj2XZ+aitMzFdt8rR6qBxFPkS+KYNd0y8NL2rrdHu1aqB06/tPcSkPOI153Nc6d30hyMea4RiCk4fgehfoMmNv1VSSKGLpKsMhAmLCCt3B5Ejh4WvosrTy8lDEu2A76JWvE2EvyYhN1J5coQXtbTx9qi2DOa7kwiffMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmVmsVW/VkTT2vaXt3P4p/wHRc5/E/wFXJF2rVXg3sA=;
 b=kT2UYeRjzu93FmrFDir6aLdwFbWY1jXxj8IvHOn6/TOcTfyrkA0s99Iq683oTMdgITu3LI42471+2Lke+FzQzTr6/r0ZPMOgwqwzcjFK/a2qvuAUmAn9zBT01ASVfDL9uiuFW4ktYdDrcUrC1FbY4yCzaxV5DB/Hu+aMfGMBfurJLECbt8tMRRgjnnFy1JzBjUm3WkS2MUKws60/dl0cKQAs3/0Fi8rR3F9Gqdg+VdGvlrJD6WuPmmidw7b/ioDjgH6iTq2/I0fFxxbKgHWnHFcVr8SuDlwwEDQoKa84F/4JbILiZz9MpKP/3YbPmfNhiX7FWAlaGUSR7xqyyncmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com (2603:1096:603:8::10)
 by OSAPR01MB7349.jpnprd01.prod.outlook.com (2603:1096:604:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 01:41:21 +0000
Received: from OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4]) by OSBPR01MB1557.jpnprd01.prod.outlook.com
 ([fe80::5178:3e63:18c:65e4%6]) with mapi id 15.20.8813.018; Mon, 9 Jun 2025
 01:41:21 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 0/5] arm/virt: CXL support via pxb_cxl
Thread-Topic: [PATCH v14 0/5] arm/virt: CXL support via pxb_cxl
Thread-Index: AQHbz8Djj5hzP7fA90Wz8po/tCSzBrP6HykA
Date: Mon, 9 Jun 2025 01:41:21 +0000
Message-ID: <24f07f02-8deb-4d82-80fd-7ea2cfa3541e@fujitsu.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1557:EE_|OSAPR01MB7349:EE_
x-ms-office365-filtering-correlation-id: 379f62c9-f9ef-41f8-d22d-08dda6f6bc95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?dmdRcklxMGxCVzVzbEhnemJuNUd3ZE5aYlg5NjhqazNOMXhiMUkwbVhoK093?=
 =?utf-8?B?OEFWcjg2dTFlVURVTzdyNUcwV1ZYOEVsZzVQbTlyb2xkWVBKa09qVStieTk5?=
 =?utf-8?B?S1B1WlBKUHZjTHJETVh1U3E0bVkvNFQzWGVJSzRhWVpIMC9KdUpXUUc5RDFm?=
 =?utf-8?B?L1pRZHVaYnp2bjE0aXU1MlFxcC9FZ1RBUWdEVTBHdzJZaFdtdC8wUGQxMTBD?=
 =?utf-8?B?ejRBZmx5WEJNa3g2dFpZYTFLTlowTXVNWGpxNkpYMTIvSXNmRWNkZXZLYTBq?=
 =?utf-8?B?U1NCbU9YU2pKQ05VZnRubUFvMW9QdHlUTkNEU25URzkrZXVEeHUxckp4THA1?=
 =?utf-8?B?ZUZrTVZYVlZCWmRmaFFNa3k0YVRvaEZpVDViQnhTUStTUTFJZXU2NU1TemQy?=
 =?utf-8?B?VDJGOXo4VXB2MmNMeXJoc0RsYUEzd3JLeXRJQWUyREgyYmtRYlZOWjA5aEpF?=
 =?utf-8?B?bmNaWGR4Nzc2U0xuVzRhMzhZeUdoc0dBTmdlSnlWL1c4NHprUkZpbXJPaUlI?=
 =?utf-8?B?UTJZenlXYlRSVURIeVV1Wi8vaDFkMmZJWHdxamNTVFRZNll3d3BPaG9iUmdr?=
 =?utf-8?B?VVJGeWtLdGVzNFJCSnlicy9EUUYzcG45U0RhU1lJVUxFUzdYYnhUL2JDMjl2?=
 =?utf-8?B?cWVPdWJvVFNOOTZKOURNeTlIdVFkVGNZUXhhdW9qTFpxanhYQXpOR0o4Q1l4?=
 =?utf-8?B?T2hzNk0zamxIT0VCZGJmZ3pMSmFvNFlndUppUURXYitFL2JaQVFoZXpvUkVC?=
 =?utf-8?B?U3l5ZVc5ZnR0cldDNW5YWVFTS3MzQzNHeC95UGR0OU40QkxzQTA1eG5KVGQw?=
 =?utf-8?B?U3JaTmJCL0kwTHJrdFBiRjRCS21IYUFiYk54QnJ0SVVVeEZ5aXZ4VFoxWVhr?=
 =?utf-8?B?ZFd5R0MxcnFtZnNnbldvdkRBUWxNa0hvTG8weXdVTTNjTVZOOXE4cEV6eE9k?=
 =?utf-8?B?cG1OV3hTK2ZWWmxqMjdTQTU3cjV1R3NXL3Z0bDFkN21NNjMrQ0ExMGpzS0Q5?=
 =?utf-8?B?bXBYYmE1WWJCM0NzeEpaS0F0aWtQUU5WMWJuMStwR0IvcFFoMkNkT1dKeWlV?=
 =?utf-8?B?azQ5d0pqdklvSVgyL3grVHc4TElSdXFiOHdtZlV2Q1hjMUU4QVV4OGdjbTN0?=
 =?utf-8?B?VXFpRy9aMEtybEpiUHl2Q1FDeG5DcC91WUhzR1pLSFd4Nmxyb0w3V2QyODIw?=
 =?utf-8?B?ZHJYYWZPTUJ1ckNCc2JaQlVBVUpzVkx2d2JjSy81bWlyU0RwaDdURzVQRlV6?=
 =?utf-8?B?NUJST2RiY2N4UmVtMkRSQ2pzVUpHTW53N3pQa0ZCUFdtZFYzcUFJRHFpaFBM?=
 =?utf-8?B?S0JQYnA1dW1TUzJ4Vk5GWlkyRjU0UFAyOEg4aWRPS2s5UEViZUF4bWkyTDNa?=
 =?utf-8?B?cUg2dVJ5T1JHRnc0cWpLZTlnUlFxV1pQLy9vTjRBSVU2S0dRTjlzb2hqUEhT?=
 =?utf-8?B?OEtGNjhPVTQwb3Bra2FXYXRaR2dKWGtsa3RqaGNMZ1J6eStBV3hIMW5BZW1F?=
 =?utf-8?B?SVBTZ202cGlrK0tsbE9TVFRXd09TREtIZHFhTU9WdkV3L0dwMUhHeVdYeGlK?=
 =?utf-8?B?ZHF6TXJPejBMTTdvQkdSTHpPczJrbXV4SlAxNGpUaTR3OGpSM1VEL041K1Ex?=
 =?utf-8?B?eEFwUkJtL0VJNWkvdU9VbFBqWEorTHZRSGFtWjZsNHdibmJYWUpNaFR1OXpz?=
 =?utf-8?B?Z1pjeThxRGVUK0c3QUdRVVNsVFYxRkpHeFdpRStKSHZpRFNxZ3hveENiM1ds?=
 =?utf-8?B?cVJUdU5uSzYyNjY1RzcySEcramtJalNkOFFYNXBwMXA0TmxTazhqTk1VdXVV?=
 =?utf-8?B?V2NwK1NBdUxHeUxaK1Jabm1HUnY3Y0cwRGVJczN4MVJXT3IxREt2aHVkUEZ0?=
 =?utf-8?B?SG5wMVQyQ3BPM2wwdmp6N1JKWCtiSGhWMWpQTTJBalN0UzVVV1JpUllPUzVI?=
 =?utf-8?B?ZVBZY2hBdDlxeHFmTTNPeVlXSjQvck5WZmxNWHgyZXRhVlNRaDEzK0tVWDB3?=
 =?utf-8?B?RVZKUmV5bzVXU0JKWDJCSjluS0U1RGJTY0t5MWhGWk56eHdqOGNaWFlVQ1c0?=
 =?utf-8?Q?17lC+z?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSBPR01MB1557.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEc1dlVkZHhGWHowT2R0d1FHQUtSbFIrSHh6TUFkSzZ0cFJsWnhrRUpLdWE2?=
 =?utf-8?B?cm53aTJ2ZjB2c0UrOTlUZ1JrYkp3TnIrQmkxZ1B5U0Y3eVZ4dE9QbzhhSCs4?=
 =?utf-8?B?RkJOT2xQcE5KUkNPd245THRTejU5QloyZUNZcXhuZGt1Y1VBQ3hMZjVoZ3Rk?=
 =?utf-8?B?MGhJdGhCNzRLSy9zc2dodE5SOWhxRDRTM1lPaXI3K2tDRXNEZm9hT0IvRFIz?=
 =?utf-8?B?YWN4N0lRTThyYkRTU3QwWlNSdmFmbEptSEo0NURXUGRpWWg5ZUlhTTRZMERu?=
 =?utf-8?B?SGVxVWQ3Y0xxRzdKV2l2ZTNWUE03bWRnSllubnFmNldHRllkSmFrOWJGZkw1?=
 =?utf-8?B?L2NlSDJoVFN1ZmJlQVZvZUdYS2RCcWo1VjVZTWRxV2xWZG1HZFQyV3J0NWhL?=
 =?utf-8?B?YW1BZzY1dE9TZ3l5SjhPbnJISXNzL3pFQ1pOOWtjaGQ3S3FUSnN6d2xRQlJH?=
 =?utf-8?B?VmdRalEzWFJvU3hLQmJKZGlJaWFkMGtIeVROcHdMbUFpQ21LWExCY0RudDNm?=
 =?utf-8?B?SzJyck5pVFFBVGNaeEJYTVZEclhrOHNtR3NncWoySFVvcElpREpSb0FyMXpZ?=
 =?utf-8?B?SXhqNTY3Slp2bjlpZmFaOGg3VURVd2FrNCtqZmNRZmt2ODJ3NGg2ejNZVmNo?=
 =?utf-8?B?MHU5cDY3aG5FbkZCbTlVWDYzRWpOYUNYKzBLTGxmOXUrNXRORXFQZERPNm4y?=
 =?utf-8?B?NCtqT1hpR1FWaWIxWGo0Kyt5WE1uZUdoNjlFSVdrUXRaeTg0eFNoUU5mV2ht?=
 =?utf-8?B?ZDRrNHEyU3lpSnNDOGtlTWg4UTFHVVVhdVRaK3NOMFNmUEFNaVFiREdLZU1V?=
 =?utf-8?B?ajRYWkZnRWY3OS9qQWJIdG9XZldoREVFSDBsQ3Z4SVJzWkliV3JOd2ZaaVMz?=
 =?utf-8?B?dkZaT1dNYUhnbjA0RDdhbmxEZTkwekx1dEFQOUUzRDFMaWUwUGpOeW53WHY0?=
 =?utf-8?B?eUJmL3pkM3JSVzhMc2dRNHNLM0FmTERzQ2s5R2E2dTEzWUkwUDRkanN6bVlZ?=
 =?utf-8?B?VTAxY1RGeW1Gc2xPaWdJeGZ0dGE0QVd6VjBuQ3NkVXFvb3ZUekRDTVc3ZHVS?=
 =?utf-8?B?SDlBSWVGOUtwUDVlY2t2ZHFhOEJBd1JMNFBncXNyM05iMDl5TU5JL0hZQjV2?=
 =?utf-8?B?RFZYWjB3c09vTG9vQ0IzMmhVSWdEL2dneDV3T2lNUjdUNnFSa2hhSHMzNlkz?=
 =?utf-8?B?ZWJzVWR5NThGcjlXekxrRU10R1JzaFlkN2lkNkRBNEdzUDVoNk9oMFk3cTBB?=
 =?utf-8?B?ZkJtL2l1M2hlbVcyanJlbXJIZCtBOWJ6LzNLTFVrakNmWlpwbU41MVBCSEhj?=
 =?utf-8?B?UDA3ZnlDRnl6MWtWTmRSMzdXWkc2Z3FLR1FkR3lTTHdrWTQ1d1R5bG9ka0dB?=
 =?utf-8?B?N3ZoME9VeFF3dnd6WE1MNzd5TkRBejhVUENsTUgxelQxWjY2RzJZNUFjTTJG?=
 =?utf-8?B?RGptWEMxTW5PUlltRVk2aTI0ZEg2azNha3k2WkRTZ0dBZk5LdGlNZXVXVk5v?=
 =?utf-8?B?V0VuWlp4aXVIdmx5dU01aUc0dFpoTnNrZGt6QUdPYUJNTFczYkhaaXliaXFY?=
 =?utf-8?B?Tis2dXpqenVvRXY4T2Y1SGZlc1BSN1I0bE5USll5Rjc0R2tEUTFOY0t3NFpN?=
 =?utf-8?B?d2tuTEdZc2xvZzcxWEdqV01RK1lIYWduQmFWU0RrZmhYeFdyNFQrR1hZTEdi?=
 =?utf-8?B?YWc1NjRpTDRUUzdXc1dkcDJicVE0T05zdjM0V0RROVgvZE9ieUs5YTNvU3Jn?=
 =?utf-8?B?d1pDaWg2WnY4UUNCbmc4bnZ6T0hrODY5SHJJc2diZEdCMEJEVktUNXdueUhn?=
 =?utf-8?B?QndXWWVoblEvc2FnRjNVTER2ZFE5cFVNL251MEtiY1YvMTlLYkRYZmZWWXJ6?=
 =?utf-8?B?WGxabWp4NWEyc3dJdGd6blJERXFNeTdmSmhkUGlYZlp0WjE5cFNFYmxqRU5z?=
 =?utf-8?B?azNkSHNZbDM2UlZMVGNUaWtYdlN5U3BCZDRUS0dHWjE1Wm9rZHRjSC9FVytR?=
 =?utf-8?B?WlU4RHc1UE1lQjBtMDB4RUswUW1UdGlwSDRWM2tBSzFSVzkyUCtXc24rUFFQ?=
 =?utf-8?B?Z0dxVTRHWmFpckdkN3BLQzN5ZWxqak9YL0l3dmpKWmpzT1hOanZGM0tmd254?=
 =?utf-8?B?YTBYZW1BcTNBU1ZNZVo1ZmdmOVRKUnZDTjkzSUVjYnBMazJUa0thNFd3Ynoy?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80479C1CAE82745B80F15D7BE4DD63B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pMV7mflbf/6LrOLb87xIoyV2D5sKvIHb8BBQbv0BZHamO2c0mJtVsAXkYMS+FyEnhvdJane7rPJ/uermU17tdz1qJceIj5xhwWFsaPMJ6pHIhHpe1CZs+N7JyFGoPF+npRfoTJElR6Pbv78xMagNdT9Bu222PAeM1XvRYLfDD7YnUFYkLvu53TOMwcJ0eGRo1eQFD7dbs9fZyabghjerSTBerVNa+CooSoYdnfXWXK7f4OXqZ558AMfn0cOo3TnTYsXNbfUNRh+4XTTcxdvUKjVc/2GST0+RIDVftTs6JosbmEIaI/xqeQf5ErWCtTOhMS4lQwy99pi1WYEoyXbm0WZ4Iq8CbUzVKE/0nUowuSk7OYgA8bpkggRpLsRLvdw32RkTRslEU9aklAf0P8cDPU8UpFQDMl90fJXfytHvLqVQu16VxG7fPUAl6qRmnVU9ae8KKi4KibJrxUzrX1F+Z7nlRDo+1CQCrcWTViMg4mu44/qtxYhdqfgxfz+YovnUye6Diz3Zsr12gzVodTV8RqpUJNHU0LSfqfmTlQL7dRGQqkJ9Y1PsGPy0WCAO5lqb2F2NMS9GuBnk33ttpWX7ssvF13b5m7CeIbG6MpMfwuuhfzLuxlBw+U67cyCYFTm+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1557.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f62c9-f9ef-41f8-d22d-08dda6f6bc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 01:41:21.2378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFxDIqboICwTSYlS4O9dDoTNIv9E19uXlo5ciRiLgTPixGX34XgNIAd4KH47rEdXgPmWTJokO0kOxJ4MZgVDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7349
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

DQoNCk9uIDI4LzA1LzIwMjUgMTk6MDcsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBK
b25hdGhhbiBDYW1lcm9uICg1KToNCj4gICAgaHcvY3hsLWhvc3Q6IEFkZCBhbiBpbmRleCBmaWVs
ZCB0byBDWExGaXhlZE1lbW9yeVdpbmRvdw0KPiAgICBody9jeGw6IE1ha2UgdGhlIENYTCBmaXhl
ZCBtZW1vcnkgd2luZG93cyBkZXZpY2VzLg0KPiAgICBody9jeGwtaG9zdDogQWxsb3cgc3BsaXQg
b2YgZXN0YWJsaXNoaW5nIG1lbW9yeSBhZGRyZXNzIGFuZCBtbWlvDQo+ICAgICAgc2V0dXAuDQoN
CldpdGggYWJvdmUgMyBwYXRjaGVzICsgeDg2XzY0IHBsYXRmb3JtLA0KVGVzdGVkLWJ5OiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCj4gICAgaHcvYXJtL3ZpcnQ6IEJhc2lj
IENYTCBlbmFibGVtZW50IG9uIHBjaV9leHBhbmRlcl9icmlkZ2UgaW5zdGFuY2VzDQo+ICAgICAg
cHhiLWN4bA0KPiAgICBxdGVzdC9jeGw6IEFkZCBhYXJjaDY0IHZpcnQgdGVzdCBmb3IgQ1hMDQoN
Cg0KUGxlYXNlIGZvcmdpdmUgbWUgZm9yIG5vdCByZXZpZXdpbmcgdGhlIGxhc3QgdHdvIHBhdGNo
ZXMsIGFzIEkgbGFjayBhY2Nlc3MgdG8gYW4gYWFyY2g2NCBtYWNoaW5lDQpub3Igc3VmZmljaWVu
dCBhYXJjaDY0IGFyY2hpdGVjdHVyZSBrbm93bGVkZ2UuDQoNCg0KVGhhbmtzDQpaaGlqaWFu


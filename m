Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1291B499
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 03:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN0LH-0000pS-GE; Thu, 27 Jun 2024 21:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sN0LE-0000pF-CD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:23:56 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sN0LC-00056J-9C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719537834; x=1751073834;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Hz7nt9TY0HTVvuKVNvk/L9mnWxGoioS0AvCeTNNdGSs=;
 b=k2Ea/532R4aCO/Qw2MZVpEzoPrCabUUM16Hjo7hhRU3++9Zun10caqtI
 7kWxykWfwHq9ELtCK1qU9enRIECfQ0QeuQIw1TkBzSSqpRYDnt8WMViIC
 y+v9zwJ4UqZOGwzukQYmF4FLNs9fEX7g1e02hVyPRuW6FSyCRRQIUucCL
 vD1GyA4WcHMQtsgKYNAGx8QAxlCgjEyRMGVrcwPFmX1B12wa2CVlh8jEX
 nC1m/GDQrHNgZzjdZEBRz/pqQai4OTSYvg7RzMYdRHdNYx0zdeguQy9dP
 twFO6E72PFa49EiANUQMPhhO0aXTDUv1/Cvx+2gE667RktDfyngZ+b0fx Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34702281"
X-IronPort-AV: E=Sophos;i="6.09,167,1716217200"; d="scan'208";a="34702281"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 10:23:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrmNE6kMFH5DEXRvSHBO0uZCunCqncOO/HQTjXqTxpwAyeRrSWJkSkg0eWLdjV3/dq+q8hIr9fdYvDKjWRRu0m1zTLCwl1JQOMso5socR6BBHAFZelKl9SrXOeiEW6rgUn2OrYaFPkgXp2n9x89CvEutj+faskBqunIHd2erWjy3RfdI0a7M03c+nchc3RiHz874rLJUsIGsZPOOmtJkY1d1d5azOOT5LW50OU+8XesJ6fcqtmFPNy+2mfvL0voGYwlxkpslB7Sth4dueFd5wfpNzBPxAoOtle4HlLuVU4agI2/jSjiLMn/GiBATNWlPEsvP9VtdxPRAI3mFh0SC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qpnKXKtjRUXi5KGAgW+TEhMJ72qhV88VFn9zgdBv5E=;
 b=Oxvn7XkG8VDXfTQLpXTr0ghyCCeokpSmcG4QOaZvzvM5Qv9xSikfACFMVHYQQeEKAVqO4ehN7Zh+z3sIABxrIdLcSvqABnOeh/oph8JVSuKSWIidnZnodrD1qzDOO0/vrEKjNmzGvW/L5TKZHVYJ/hjBZ24TdttwxG6C2WVAcx08x5hWE3i6vk/zfiZCCq4tlUokDpykKEfqC9pzWYjq4nqXfFI4WDRaRchRXH9iKBx6mcipdsz+KpvPHQ6P+nsu8kLARrMiiS7aZUFGrw2cvc+BYMSm5TnSBZDWV5qnIN22ai9afjXxHgJ0tcQAaiFk+ClPSMeWBDgf01e+Yq0UVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY3PR01MB10221.jpnprd01.prod.outlook.com (2603:1096:400:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 01:23:45 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 01:23:45 +0000
To: Gregor Haas <gregorhaas1997@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] hw/core/loader: allow loading larger ROMs
Thread-Topic: [PATCH v2] hw/core/loader: allow loading larger ROMs
Thread-Index: AQHayPZTDiFbeuSo+kKplnIIzUXQ67HcX20g
Date: Fri, 28 Jun 2024 01:23:45 +0000
Message-ID: <OSZPR01MB6453750795B028A49ECBD6868DD02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240628005817.1672298-1-gregorhaas1997@gmail.com>
In-Reply-To: <20240628005817.1672298-1-gregorhaas1997@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=10a78954-a802-4b77-aff0-eb632d4dd2ac;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-28T01:15:40Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY3PR01MB10221:EE_
x-ms-office365-filtering-correlation-id: 6580800c-d160-4da4-73f9-08dc9710f44a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?czZKSFZXazdXVkpqVDhnQ1IrSElyd2tFQnFHak1vdEVlOHluZExNU1Vq?=
 =?iso-2022-jp?B?aEdrWW14RmZONXI4MWhsdFMvU0h4dkc5STQxdndFR1lMdEdsTDJIa3hq?=
 =?iso-2022-jp?B?NktSK05xbEVJeUVMaXNHbGRqeGdLU0xRL3ROalpyaXBwQ3dNSXU5YnN0?=
 =?iso-2022-jp?B?NVdURkN5QXdPNjBVblUxSlNwc3Q4ZTZjTU95ZjZwazA1aVpEbm9yUXE3?=
 =?iso-2022-jp?B?OUd5UWJ0ZkljaldjYVlUeUo4NUd0L2trYks1VkEwdVQ2RkhLcVhKTHRJ?=
 =?iso-2022-jp?B?T2dBRWp3NGplWDBCZFZMVW1OWHBTRGtKOUNRcEVtQThMbmZ3OHZldnMx?=
 =?iso-2022-jp?B?TWdLeWlVQ3paK2dtc1I1NWZGRzA5ZVdNVlN6azFOeWZRV1IyaURLSEVG?=
 =?iso-2022-jp?B?YUNJSW9vVDFsM0JidDFnYlhwRERQOHdWT0p6MFRMdDFmTGRCNEU1SW13?=
 =?iso-2022-jp?B?d21DQnluR0wyZDhQNjBiZEYrZnFGcURsZmRwVXdIUzRUc3VhV211eWV6?=
 =?iso-2022-jp?B?MU9MUUV0bFU1byttZWt4YXA2VHoyZ1R2SmV0RFE2alUwczl0Uy9Ib0xL?=
 =?iso-2022-jp?B?UlF3cWE0MFBTOUdYOEZwbFBKWTdaQ0U1TWdZRVVSeklEdCtZQWlkVFFu?=
 =?iso-2022-jp?B?dkZOSVh1d3NLdjlOQSszenc5RkJqSDR6bHZyU0U5QWFQZGNRbmttMXZo?=
 =?iso-2022-jp?B?Ymx6WGVXTWxYbGZDbFNIQzdwQnFXUlo0dGVkaFhod0Jlb1l1ME12TDV6?=
 =?iso-2022-jp?B?QmZxZ2dlRW55UjNmTUdlb2wxRW84ZG9ZenJlN2lyK05jODllaDJRUGpi?=
 =?iso-2022-jp?B?a1FFMDJ3NGFSMjJQSXBZYzhQb0F1NUZFOSsyam1mOEFUcmt5d2psTXgy?=
 =?iso-2022-jp?B?ZnVCYmJkTGpjUEFxa1pwcFdxeVZvL2ZLVGtiZ3BGeG1MNXYzbTBpNU1u?=
 =?iso-2022-jp?B?eFZoSkFMVXdUakFkQXpCdnFULytBS3NTTWgrMElVMDlUcUNWcUhGVlUz?=
 =?iso-2022-jp?B?VUpXYUJOeENYQmFIUngrUU5ENHV5eEpXZ1RhTUV6MEt4YS95bmFWK3ZR?=
 =?iso-2022-jp?B?Y0QwQ3lsTWtHVHEyWDFhUmlzeUlqS3lSMURMU3dzVkd2M0krdFpxYkFl?=
 =?iso-2022-jp?B?aWVZQ1FIUURoSEJHd0JwOHdYS2t1dnMyVFY4dmI2cEZDcVo5VkluSGsy?=
 =?iso-2022-jp?B?d0FUbjk3amo5d29GRCszWmlIZyt2WElBaUZocDMvT1JPbm1SQTQveDk2?=
 =?iso-2022-jp?B?UFBVMHJmcHFDRytTeVo5clFZTXdEOVlvZFlweWtDVUF5NzVQTnIxc1d3?=
 =?iso-2022-jp?B?Q05jWENFMWYySmNXTVZXL2dBd1RjUE5NMXBubUNkd2pkVGVncXI0T3R0?=
 =?iso-2022-jp?B?R1FYWXNqWHlhWlZTL1lMNE4zd3dnRWJBYVNiNWRPalFHY1QvOEhyRWVG?=
 =?iso-2022-jp?B?TzVpM1cvSkZUcjVqR1ZZQ0dNZXJJWGpyTHFXc2dLKzFET09WMEVweTd0?=
 =?iso-2022-jp?B?eGF0RUVyYVZMMW4wRFlLem13WE5pV05HUXhSYTE4UktsbW11RGtXOHEy?=
 =?iso-2022-jp?B?NnF4WG56S1krVDNDKzY0M3NBOFkwdGxEQTdQZW1Ycm1HeVNxQmRwbUxK?=
 =?iso-2022-jp?B?cnByTy9oQ1ZSN04xUE9ENlNiaHBZVE1ac2lGQnhoNEZVeGRtRkUxYSsx?=
 =?iso-2022-jp?B?VUhXc0xFaDg0MHFBMVhKL3k5SWxRNjRaMGJlRnRSZ0RvM1NkbFFFWFNT?=
 =?iso-2022-jp?B?T1AzOFhGODR3S1pxeXp3RkNGSldHczkyVUY3RjZuQ3FNbGFhd2VKVTkx?=
 =?iso-2022-jp?B?eDRvS2FhQ3IvdVV1MGJ4bkIwWXVPR1QwT08wbG5WRmpsakkzVFdyQW5h?=
 =?iso-2022-jp?B?RTByQ0NRc2xyNnBwUVA0RnF3TDlPNHVUOC95Y1dvQnN2aGUrck1CUnVw?=
 =?iso-2022-jp?B?Y2JkV204ajZtUlJsUjdnN3hXRmlkV0VRZEcvelM4SE5URzA4S0JNNUY5?=
 =?iso-2022-jp?B?Y2NzajdJbGtsbmdqNjIrMk5jUnQ0SHRUQWJSTkx4a1MxSEJCWnNYRFRx?=
 =?iso-2022-jp?B?ZHhsY1pzQ0FacFdiVlFpdVZYbDJTWkk9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WUNaOHhXSmVnTHRSa2U3dkxKWlZDV0Q3SVpGYU9zWTkyQ3JscTF0M0ts?=
 =?iso-2022-jp?B?dU9VMzNuYWM4L2pjVDB5VDdmVjdXK2VkR0kyeXl6WFU3UFQwYmVDU2xH?=
 =?iso-2022-jp?B?cXBWYUR3RnNjSHNrRWtadmI4UFdsblhhdjV2NmtLdWVtZTRJeUU1M0Vx?=
 =?iso-2022-jp?B?L2dJM0M3WGdWUkp0MW1zNUE3YzVYRGcwYnNCSzdydmJxUTdYK29XUkNq?=
 =?iso-2022-jp?B?b3hzMEFjYm0valpXcUIzODQzOXE3VEd2K20xZTViOUpIV2N4S3ErSUtT?=
 =?iso-2022-jp?B?UDJzSzFMdTAvVDZGMDdpeHNvMFJQN3YzL3c1TlV4Q1lTaGY4L1JSV09Y?=
 =?iso-2022-jp?B?dkpPdnJKd2lIR3k2elV2RFVQNjFzSWkrZXdPY1JyaXc0dUZSNGZ2OFl6?=
 =?iso-2022-jp?B?akpoMlVwVFJEanNEblc2UFpvZ2FHZG0wc2EweG9ucm4yTHo2aDYybjNk?=
 =?iso-2022-jp?B?N3VyQTRYcGlhVDRSYXJDSVo2U1ZpbHp0MVpla0FvWjZ3cUxEUzFLeWhw?=
 =?iso-2022-jp?B?cFRONXdXVkFtWFRQZHY4enlWejRiSWk0dC9oSlJicytqdm1uMnkrbk1Z?=
 =?iso-2022-jp?B?MDE4cVB6UHNDdnVWWnpIUVBXK2kzc3B6WWJ4am9aRzlzcUNUd2lrWVZG?=
 =?iso-2022-jp?B?QkwwenAzQWFvMXdQQWovdzNTUHNuRlBtdWx1OXhUNmQ4SWdmdzZGS1Zv?=
 =?iso-2022-jp?B?ZGowM3ZYc1VCMDFMV1hmdUc4TjRFZjNhcHkwUEVFZUswQnVMWUVWMkVC?=
 =?iso-2022-jp?B?Y1YwUU50elRNMjIyNFUzZGMxVUk4ZFZtenNYb3V1dlkzeVVpcFRZei92?=
 =?iso-2022-jp?B?ekRFRVdMUWtEaWFUazhGL1dZQ2wzWXJJeUxKd3lLYXNia0p5ajNDakdj?=
 =?iso-2022-jp?B?UHpYZk84L05MWkhGelN2ejQxYlRmbUZXdGpYanNKb0tuTW5ycVNkOU9H?=
 =?iso-2022-jp?B?Y2Z0cHJQRWRpRTZndFdxUXRrZUpzVUw4eWZ2ZFBEMGlHdTRqcE1oSlhF?=
 =?iso-2022-jp?B?b3JyUy9jQi9qNitnYWJYN3pVQ1YvMTZNSnRSZzl1dE9tYW1jUDZMVnVi?=
 =?iso-2022-jp?B?cEpjOWZiTmtCU3FxcTFrRTB5RjVoT1FWYTVSZUducHViOS9ZZFE5VGEy?=
 =?iso-2022-jp?B?YWQ5WERBQlI0V0dVSjZHMWJnanRWM0RvTXROK0h1L0tRK0JNYmR6blV1?=
 =?iso-2022-jp?B?THZFQXRKR0xEdGFWdDFoeUpiaWdYZGJHY2I5SXduZjhEK1UrRndPVUdC?=
 =?iso-2022-jp?B?OFUxaTEyVGhHdU1zVm8xVkxzcjdSRlovRHg1NDE5WDVya0F1QmJEY0JV?=
 =?iso-2022-jp?B?aUdFWDZlbittTk83UWJ2ei9hZXhXY0NNN01aR3BLT0huaXBtYTd0dFJB?=
 =?iso-2022-jp?B?dWtCVzd2Y3ZmOGk0ZU1iMks2dFhiZXBMT0ppQzY0L1RuMU9tTitrdkZz?=
 =?iso-2022-jp?B?UW0zckVjeXptUFlScisxejVvWDF3NjVJbWlzSmxTanZ5WkNTb2w4ZE9t?=
 =?iso-2022-jp?B?UGFCVGIwVHRnWWZhTnpNb0llVllrZXRGcU1nT0FMUzdpZGpha1k2UmJu?=
 =?iso-2022-jp?B?UXVUZEZLZXhaSU95N0I4ZXRFNlhZRmNoaFliQXZDaWdwcmM0V2hOaENH?=
 =?iso-2022-jp?B?R1hFRi90RjVhcDdBTXA0NTFsVGcxaExuRzcxdXJRa0N3bnNJTEYvM1FZ?=
 =?iso-2022-jp?B?QTRvVFkvT3IwYVZ3L0lRcFVOdnpWSjY3S3hPLzUwY0tHYnN5UnVPWmNH?=
 =?iso-2022-jp?B?cFcxWU1xV2ZNWHlWSlk3WFR0dTJlU1Y3djN0dGtNYUVKVjF6bUZ6SzBp?=
 =?iso-2022-jp?B?dElyUXlmQnlCMmpGQzNSeUVwTks3RWV0Vml1YWx1U053SEJLYSt5QTU0?=
 =?iso-2022-jp?B?VytnK0xrcG40VjZqNUp1OE52Z1hFUGk4bjNpRTVvbE5DM1dnM2JOd0FS?=
 =?iso-2022-jp?B?M2xPbEpsRkl3YnhwUHMwRTUycnF3M0ZEZUdUVGtOZm1JQm5WOUpTSjJV?=
 =?iso-2022-jp?B?RnY1MGlXZG44YU9YWTRsL2Q5ZjRpbFNJa1NGUFFQcmlWWTRIWEx1QzBM?=
 =?iso-2022-jp?B?S1ZEVFRvdEsxNHBGcXNhVG9MRlRTaFhTOUFtaGkrSEZLRElnWVZla3NU?=
 =?iso-2022-jp?B?ZmhnZTY4akZJaWZ1NkNCZzBKS3ZCUkVKOVFIZXBiUFc1ZitQckxsdVpW?=
 =?iso-2022-jp?B?NW1GL1hERWdWRUdNbWtxbVZ1ZlN4VEtNWUdMNkU4eTYrZjA5NTh4anR2?=
 =?iso-2022-jp?B?RjNGRzBoSHgxYitudGxSR0hpTkdkRmQ2alVuWU5oTWVIUkRySzhUdUg5?=
 =?iso-2022-jp?B?ZVhkRQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9IVXZsXEwUON6fcyszIhdQPRuxHWINo1PLIVVDsbll1u6rBbqSzDLC0rvIRzjKCJvJwSLhkdTmG5Q0k3oR9p4Y3j5+CqvyMxVDmHpKW2FXuQpIPJvalh0Szn7mcPgb/kag/dj0oj7b0TdjjuLqbWAXBkZBBTeeycDvmRCDfTBziupM/pHtXlz6ollKDNuUjlUu7wWVl+92yfAMgWnS6+ydOD5oEEm47GSvPk1Z+Y1GjZGgkNuGhPTMsXlfnXkFzxBS7O+mcJxWeY3jgpE+EdUYi3NxZYybYjVeE+VL845xTh7lA8mW6r3XmxFoVvYkYS0rzckaBCB1t7bo/BJgdpAleYGnKMofS0uCWkq+mPe5L4X5i3lrxuB8z7VJFO16gzHxQLlY8SPWuHSH/cfSfrBxZM7h/zYeeuVJIHAvTKsupH39d/26IJcCE0ztoUdu8JqheldyHziACWYrsh14zm0JcSVpZ9NLw5y6A2sO7N4x+NHgkXJXRaOvAWYOpgmQ9zRZ+n6aCo9JrujxPowMXnjV3oWiHTQJEj8Rh0ORg7DruNJIY+1q2SbJ8rKrQFfe5oMM9JSLqudjEGYMjXlbCpQJ6yzJAc8s9bwIg+7CvRaUQDPSCwZUJqwiLE9KSJr1k0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6580800c-d160-4da4-73f9-08dc9710f44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 01:23:45.3445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNTYJDhECcJ5a3Gl930A5O95muCTxbEvIFXgqL/2FVbPXk6apEFl8Cqlq9fmQfW/2MMB4cYdO54ALC175idpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10221
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



> -----Original Message-----
> From: Gregor Haas <gregorhaas1997@gmail.com>
> Sent: Friday, June 28, 2024 8:58 AM
> To: qemu-devel@nongnu.org
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; Gr=
egor Haas
> <gregorhaas1997@gmail.com>
> Subject: [PATCH v2] hw/core/loader: allow loading larger ROMs
>=20
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into accou=
nt,
> instead failing if all bytes are not read at once. This change loads the =
ROM
> using load_image_size() instead, which correctly reads all data using
> multiple calls to read().
>=20
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---
>  hw/core/loader.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 2f8105d7de..8216781a75 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1115,14 +1115,13 @@ ssize_t rom_add_file(const char *file, const char
> *fw_dir,
>=20
>      rom->datasize =3D rom->romsize;
>      rom->data     =3D g_malloc0(rom->datasize);
> -    lseek(fd, 0, SEEK_SET);
> -    rc =3D read(fd, rom->data, rom->datasize);
> +    close(fd);
> +    rc =3D load_image_size(rom->path, rom->data, rom->datasize);
LGTM.

I think we may get romsize by get_image_size() and delete the redundant cod=
e like below:
-    fd =3D open(rom->path, O_RDONLY | O_BINARY);
-    if (fd =3D=3D -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
-                rom->path, strerror(errno));
+    rom->romesize =3D get_image_size(rom->path);
+    if (rom->romsize =3D=3D -1) {
+        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
+                rom->name, strerror(errno));
         goto err;
     }

@@ -1106,16 +1106,9 @@ ssize_t rom_add_file(const char *file, const char *f=
w_dir,
         rom->fw_file =3D g_strdup(file);
     }
     rom->addr     =3D addr;
-    rom->romsize  =3D lseek(fd, 0, SEEK_END);
-    if (rom->romsize =3D=3D -1) {
-        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
-                rom->name, strerror(errno));
-        goto err;
-    }

     rom->datasize =3D rom->romsize;
     rom->data     =3D g_malloc0(rom->datasize);
-    lseek(fd, 0, SEEK_SET);

>      if (rc !=3D rom->datasize) {
>          fprintf(stderr, "rom: file %-20s: read error: rc=3D%zd (expected=
 %zd)\n",
>                  rom->name, rc, rom->datasize);
>          goto err;
>      }
> -    close(fd);
>      rom_insert(rom);
>      if (rom->fw_file && fw_cfg) {
>          const char *basename;
> --
> 2.45.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBC8C4B31
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 04:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6i0q-00005a-Oa; Mon, 13 May 2024 22:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s6i0m-0008VJ-To
 for qemu-devel@nongnu.org; Mon, 13 May 2024 22:35:29 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s6i0k-0002E2-Ax
 for qemu-devel@nongnu.org; Mon, 13 May 2024 22:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1715654127; x=1747190127;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EGqBYIXMIs8Ahhm9/YfD59nxyvVIZhAxcwmP0bCrIbw=;
 b=Ck9XUL+8/o4rorPFvrq1jjcxbFZf+VM9VgSJvKmTRQ8eNPQSNhyaKoiq
 XH8fI5XCTQJzLe+pl1YykwEK+sO+U8AZzIkBm/9Ee4gLxP8fzQa0UwCJs
 HVFGcJjmJP7qt60gDUZNI4jJHEgWzRvG2EYoaPXa0JQAeDdmNLksTxEL3
 Pas+eqWuyLSfqIn1JH3jeqC/yrTpQr6nOUfRjVb3yF9/1PjDp197RPK64
 LyN2GL46iNICMR2/nAHhTGEPrB0f8fCqAAEGBr/behSD4gzoM2uNRqPCH
 ebVj19fJvVhSuAnN36B/6IrCUkLAb7x2Zp7hDkZmUl/Q/nN0RUkSv2DKi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="119094797"
X-IronPort-AV: E=Sophos;i="6.08,159,1712588400"; d="scan'208";a="119094797"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 11:35:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUZWzu15WkanPD9Ht8WD/jj049QSPRKk3ASGPUkg3TqxREEG69FG6vL2Jbgcoz/RTKuIdmOEiWi9+IVqcQnYrmzl0eKEhsm19RaYBjgLnE1NcpgZtLZ0XFSKCaCq9cYn/O14EWNs7TFKL9GGxERhb1DZX0lGhHR1I9wIstK5pwjxoBwYaMhXZhfNaYXJz6UKgrOC3rIBQirOVeSl4JIZZ1YZhygnbjbt+wFabhZiZ9/OwWnvzkKYDsMRUHbpmVsjIjZwOybdx0jKEiCr+UWSg2MpE2Tw6xbCOg2zZfKxv9N8Q5QFa/OhSNRf9dCIaW09MQvgW6R+MTQanPH+qNyn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGqBYIXMIs8Ahhm9/YfD59nxyvVIZhAxcwmP0bCrIbw=;
 b=HN3UU2wr1cj1BiSevLzMsJ0N2uJOO/V88SzNB4PFFUUgyPwkCVwxbEwO4B45E979SqXwmKSFHV3ZNtBlUuFmAEt1TXGJh1vdDQMqgNGN6NpcahKdo5PocW1MXlanCtVSlGVxywb5i7WOCTQLc06F+Wavsn1Nh6bQBfYSQ3efF3EZfLq/MnHRMbN5uZPMeIKez6PZw0BiBINUo/cnAnymGbjqU3SoMq8czfHjrLe1vMDG+qpDUb24FEtiRHSdOdWqba9umGRRxyI5jgi/aCykWVCWny1G1DGRpJWgGUjKsVhi92oPMPCvuWZXD0hyjo8RAC4oR16O/GMEsPBGVxtBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB10254.jpnprd01.prod.outlook.com (2603:1096:400:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 02:35:12 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 02:35:11 +0000
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "a.manzanares@samsung.com"
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>, "Jorgen.Hansen@wdc.com"
 <Jorgen.Hansen@wdc.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Thread-Topic: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Thread-Index: AQHakehxJLb4RA7OJEeTikQTHIT86bGWKtyA
Date: Tue, 14 May 2024 02:35:11 +0000
Message-ID: <cf241746-7fcb-49b9-9c94-e1ac9e95ec73@fujitsu.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
In-Reply-To: <20240418232902.583744-10-fan.ni@samsung.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB10254:EE_
x-ms-office365-filtering-correlation-id: 3a55bb29-8669-4065-413c-08dc73be7a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009|1580799018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkdrcEo3a0M4akNPSk5VclVzd21nbC9zRkdadTNOVUlXTzVrY3haZW95OFU4?=
 =?utf-8?B?UE5HNE9na001SlZMMEFnQzdleFdsRVFjdVQrcWJMWSsvVlpqR09UekQzb0gy?=
 =?utf-8?B?cUM0Vnc3bm5jMS90YTdMUTB6UzE4MytLWitpQWlPNno1RFQyZlBjVXI3bkVR?=
 =?utf-8?B?VVBpaURpRjQwTlozdTF0WkExWTZVNjdyT0ZrcExocGZYSHk4ejlUK0JoNURp?=
 =?utf-8?B?a1MvYnRNUHdpQnB3b1ZJdnYrZUhnbnAxQnhEUFB5UVZFWENZU3hpOWZGc3ZQ?=
 =?utf-8?B?ZUY4RHRCc2c2UVQ0SE5MWmoyVm1KakpPNFg0UmVycTJ5VlpjWnpPdGlqZ043?=
 =?utf-8?B?YnRPdjU1cnV3Q05lT1RkaEhPekdhQTByWjBkWmxOVEo1dCsyTmg2bTVQdG1M?=
 =?utf-8?B?QWVlYkhBWktIVjA2MzVDN0ROUTRVOWxMWTdzdG5Qb0t3WHcyTHZPOTNXUmM0?=
 =?utf-8?B?UjFVTEtqT1hXNHg3amlZVkFnUGNhYk1NaUpDNHRnRnNsV1g0NHZtTlFlZnEx?=
 =?utf-8?B?S1dhczZoTkRjUldyY2NELzNvN1Mzb1pIV2U5SDJXWTl0UlpZNlIwVmh6SGVs?=
 =?utf-8?B?L2JUbDBmL0lWY1RuK0lDTzRSai8yaFJ6aExWVnVQeUU0Sm5jQnl0MGZQNjAy?=
 =?utf-8?B?Q0phMGpMMC9EVHdpenE0azUwRVpUb3V3RUIvdXdGbGhlS1J2cU9WVUlxYk4z?=
 =?utf-8?B?bXR3bWI1TFlSQTdxRDRIbENGbjJGZ2JIL2hYS3N6d24xMmRGR1dIOHo3MW9a?=
 =?utf-8?B?dlpranBUc2RBZTUrbDNJbTVMalNpMFM0dnkvSDVJWWhneldYckl0VEV1MkRn?=
 =?utf-8?B?Znl1Y05oczcxYUFrTkJaMmREOHV1L3ZsTVZTOERJMDM4MlZJckpwMUx5VXZy?=
 =?utf-8?B?Wml0elR4N1VPalA1emVFZSs0NWhrRTNlL2h5T1lxUGpad1BkY2duM3hpZkFI?=
 =?utf-8?B?SlNpRWxFOFdvSTg5WVlicXdiYjM0MXRoM2E5dkV2NEtUa3BGQ3Z1a0tVUitQ?=
 =?utf-8?B?TnVPSnhZRkRSWDhQK1RwSWZYUEF1QXk5VEVWUWFxZng2citUejh5M0d2UnVU?=
 =?utf-8?B?cG43d2FqOEM5RHBmWDQyV0FabnhjVnJ1NnNkRlNKQlJQQnNQVUNGdUhadkVI?=
 =?utf-8?B?WTMzcnYrNkFPUEM3VTAvV2gxZG9kZ2gxNSt2VnQxbVhjcE1GUG5uandIelNG?=
 =?utf-8?B?eG9KVVZwYnVuY2UxdHNNVFE1RS9NUTljSG9FSTZVbEtmV2FhcTU5OUo5aklm?=
 =?utf-8?B?Y2ZLSkpaRktmWitCaTNTT0ZpYW95NHIrMmhVelJrc2MrZXoxZlRTeW9aNnJE?=
 =?utf-8?B?V2svRUtiSlZJeUNWQ0sveXh6N1lYWmNVbWVqQklYZzJrYVlwUjZabW9yMS9O?=
 =?utf-8?B?cmYwdTVHa2xVZk1USDRKREx4U2JkeE1CSElJQ25kSFdpYzU0QWJkYnp2anov?=
 =?utf-8?B?Mm8rTmRBS1pNbjUwV3Q3cVBkM1pvbU1WeEk1L2ZwalZyTHlNUzJjYjhxU1JP?=
 =?utf-8?B?WlBOcmdtazdRSnh3bzlpdnR1N0gvOUNkQUlPbE9TQi9PdzRESDQyQXFLWEht?=
 =?utf-8?B?TFpYLzA3SDJKM09mSUFpb3pIZkdCdGxnT3FUNExsaEhwZGlMci9kbjJrZGl0?=
 =?utf-8?B?emdKV0hjZFlRemFSVnc2dVlVVmpxL1FOcUEzR0FMa2ZDRTUvdUlHOHpWWkNn?=
 =?utf-8?B?WktUOFp0dFRsTjV1N3d0YVZqUGJ5UGFNRDQyU3VjQU9tWWZuR042VkU3K01y?=
 =?utf-8?B?QkIxYVNVSi9mYXVYRnBBUks1aTFXR3l6UjZaK3ZVdlQ3TWdMOW4rVFpJZUhO?=
 =?utf-8?Q?sbE9N/e6x8TeYP6QUAJQHmCwiQ6JfZ/gQH7sU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3lQTFpVN3FkbjNCbXNNR1hicUo4ZDQxYXB3Y3lYMTRNQjlTdXVGTU4weHNN?=
 =?utf-8?B?ai9RZElqM0Zza0pNUG9DSWtsUDJKSlBCY1BVcVB5VXdRaS9jY2p6djFyckZH?=
 =?utf-8?B?QlpqeGFEN0hlTk9oR1Vvb2NiYjhuUHFIWVYwcjRtNXRzbWxuNHFXV3AvU21o?=
 =?utf-8?B?V0U1TENlckMxSFA1QU5Kc3Y5NFUzaGc0OTFyUTVCbVh6ZXNtT1ZzZ2U0YUp1?=
 =?utf-8?B?MFlQWXA5amxzcVBKeHl4U3JwRE44K09XQ3FWZUp3T2VoTUFxb2NCK1lwQ20z?=
 =?utf-8?B?eWU5M1oxbk9xdnBhTC9UQ0VYWWhKcGNzY21ENjRLdjN6cmt2dlROWUV6TWZT?=
 =?utf-8?B?Zk4rYXZqcmMrV2tINzJ4eGhRTkgrbGlYbFlMQXRCeW9aZTFMOVFlWDVjZmxM?=
 =?utf-8?B?MllPQ08vNlR2bzY4SG4yRzZrRGJ4VkNBUDZXaGlCVVduRW5vMmlpR3M4NytT?=
 =?utf-8?B?ZGU5OGowbklwMjU4SDk3cUxzN09PQ1B0S2ZsU1dWaHRubHcvUmlrRnpFa3hP?=
 =?utf-8?B?akc2eTIvYTEwbCt6Rmd3elRWUHVQajVLNnJ5VEV6ZDRiamd3YWQyTUlLOUsw?=
 =?utf-8?B?bVo1UDNCVnlJMEVtbXF2YS92QlAxMFY2ekVpTzFKSC9EU1JhM2ZFakQ4RTds?=
 =?utf-8?B?dDBVcjNaQkYwUjBmdlh2RUttMDJpU3ZCN1NGZHEwbytXSmpNLzZJUTJqbytD?=
 =?utf-8?B?cDBWYXc2MW5WU2tpM2pUdU01T0M0NkxyM1h0VW13aTA3Uk9hbWE1RG1VUmpq?=
 =?utf-8?B?WnJHUkI4b1NuZXMybS8wOENoaUluSVVJWVBsTjJBakMzNExoNVgzc2ZNUmdY?=
 =?utf-8?B?L0I0blhsU0Q3eGRwek5VY0FHWUJ0UTJIcy9YMlBWZlJYdzlSUHFxYVdQOEJz?=
 =?utf-8?B?dXJOVllObHB2UmF6RUk0allwa2UzL0M1TE9xZjJUVFd0YnRXVm1HWlFvY3Vk?=
 =?utf-8?B?YmV3Ukw4dG5scHFXSVZhTkhjclgxczYyNGN5N1J0WURLS1BVN1Z1cTJWMzcy?=
 =?utf-8?B?TWpsTEJwV1g2QTQ2SFpWb0FMQnJiQ0V6R2lmY00xcWZhdE5udkErWTVwV0pU?=
 =?utf-8?B?QUdDSHpNelRNREJubjdyc0NlU1BsVWtyNGxhYVU1S1RXVHc3SFRKczFkbkdm?=
 =?utf-8?B?Z3loQVQ3WlJpdlBZb2RhaGQvUWpsSUxYNDBhMS8zV2xmSTA4eDNabVBaeWtG?=
 =?utf-8?B?SVJKNnRZcm03QVNad0phM0ZDQm1UOEh1aWd5TDRlZS9ndU93elV0V1lUMG1W?=
 =?utf-8?B?WmxTdE4wdS9tUUNXY2lSdEZ5TTZ2TnEwWU9wRGxqZ25oTFd4bjcyTFU3VGsv?=
 =?utf-8?B?bG13V3B3Rm9YeWhwcUU5UWVEWU1WYTQ2SjdVaDMwc00zNW5ua3didHFIOGlx?=
 =?utf-8?B?b3Z1bWkyRzRzSS9oajZnY1hBeGlacU8wZ1N6VXVNK2dGd08yeFBTSDJrTW1F?=
 =?utf-8?B?cEpuREt0QzVtTjN4eGptL1lpVUU2QXRQSG9ORzJvMjd4MDJjMWhZVE1WZ0Va?=
 =?utf-8?B?cEZmOXRaME5NeGhDWExKNnV0bXJ5Mit2K3V1cDZ0VTc2RnpXUDcrSy8xU2JE?=
 =?utf-8?B?QktMKzM0cC9FOWJyK3lWTjVYMFpyWVJKMVRLRE9icmgvbkVFMStHd05ZWEpN?=
 =?utf-8?B?Ykx5YkVTRXFxeWlncTVuRElxS09FSm9zS3V3SU0yS1VqaGtyNlhReXEzM29v?=
 =?utf-8?B?enVxdkxtNUxDeFE1Qzhka01SOVVNS2l0NGRJQy9JZFZ1L3Roa0U3MDNrZXpM?=
 =?utf-8?B?VVNuTVRZa0x6QzhpU2NYQ1QrNTA4L091S0txSU15SE9yQjBKVjVpRFl5b2ZJ?=
 =?utf-8?B?OUwrcGhIcytZbzRKZ0FQWEJXOWRIOHdndVk1cnpwRGFRYVpnODhZcTBqMjRt?=
 =?utf-8?B?SlhidzhyV1V2RkFaQUtWWjFVK3U4L050U0JUQnl0VXRTWmsrSXdXRC9JZngr?=
 =?utf-8?B?bHIvSTZLN2hRaFFCZ1hoNlF4MS9sQ00vbG5vaXQ1RlFjb2k5b1krRXNnWndu?=
 =?utf-8?B?dFJLdkppRCtyTDlZbFQ0YWxIc3VscWxXMXM0T2tZNTFWYzcranQxaGMrWEpK?=
 =?utf-8?B?K2NuK25JZXdEU1lydkJ1eXBuaVd3SC9NV2R1WDg5YVI5MWN3ZlZ1VnI3ZnFE?=
 =?utf-8?B?S2xSOUFQeVBneHVGYnRXM2d2M2ZBaThLK3dGZUF1Z1EydExzM2Jhb1pYSEVo?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC213EFCEB4454AB77616CA79956295@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w7fMvhqF+LuHoySzxaw3eMeInjJolajIZ2IY8onXpeQgWc74zm6iPbZF8Oj0hubVQ8PbywlqrgdHXMxwgLbP40RHUNRYRgT9Qfxb8NHVllA+ZOiLaG+gfoFoVH+7niGWaoZpQ65KkDkYzpLVLEAdS6xUx+jdJ/FV04xFiQLmeUDwOq+q9KQD9FKLmz1Ffdpt8z8wrTzEbzWvjYDEje/aNGaheu52JnNEo6LHibNikCDJl1jiD+//Ks2d702EuJ6NhuMePYCF9I4AoHDPx6b9yG3k72l04H18VVEK5iLgBMFdPY6RgYjUEm/lC5fbdXLIRNhHXNc0hhuCfZVbrkrovP7A32pkdjUjZpMYm+DWzbiwoM+3zKGbjjLRa4pgQ8TE7cH503NV9biw2Tb0oU3rFiyoBqb2AVLMCmBWN7bnc4qC+QPNHgkSL4tNSBNzSv4ORXjNrHeNcwRmOTYpJoCXZ0BG3TsYd/dOTUrZAbUj32tufJLd2H2c1K3ZqsKeInkSiKrRz/8eQ3va42r9HGZUxEL8VPEGXGMFAx0ew4E+6JR3ph/xV390uPXi35bD7wdVLTUiMUh6jmmN5A51j3CsQN9XnsYh83IR+QFXUA1uS8Xa3Hhn/NsYjKtcgHkF63jr
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a55bb29-8669-4065-413c-08dc73be7a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 02:35:11.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2Ia4CUVyoxbo9kAZaLdhQJRMjhUoc/E0lZg5gI56XqgmZjPDIOrVMyYkXLENzbgSYlgzIGuT2fOhXCuDDRwbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10254
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDE5LzA0LzIwMjQgMDc6MTEsIG5pZmFuLmN4bEBnbWFpbC5jb20gd3JvdGU6DQo+ICsg
ICAgICAgIH0gZWxzZSBpZiAodHlwZSA9PSBEQ19FVkVOVF9BRERfQ0FQQUNJVFkpIHsNCj4gKyAg
ICAgICAgICAgIGlmIChjeGxfZXh0ZW50c19vdmVybGFwc19kcGFfcmFuZ2UoJmRjZC0+ZGMuZXh0
ZW50cywgZHBhLCBsZW4pKSB7DQo+ICsgICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgImNhbm5vdCBhZGQgRFBBIGFscmVhZHkgYWNj
ZXNzaWJsZSAgdG8gdGhlIHNhbWUgTEQiKTsNCj4gKyAgICAgICAgICAgICAgICByZXR1cm47DQo+
ICsgICAgICAgICAgICB9DQoNCg0KRG91YmxlICpzcGFjZSogYmVmb3JlICd0bycNCg==


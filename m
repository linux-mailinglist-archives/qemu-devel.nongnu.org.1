Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA160AC46B1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 05:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJkmE-0006Uc-UZ; Mon, 26 May 2025 23:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJkmC-0006UT-7I
 for qemu-devel@nongnu.org; Mon, 26 May 2025 23:14:52 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJkm8-0004fG-Hp
 for qemu-devel@nongnu.org; Mon, 26 May 2025 23:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748315689; x=1779851689;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ywIBSIFrRq2rhrXIn46CBdzg/RbUJBz7CE/LiQrrUDY=;
 b=Wq8xi7nHkiSg2SpKt7n6MxrqOVDq2PZKjEMzr1Z+smcWK27efwu/ntwM
 HGOQ/W/zZlSBBHq7wtQt1vqRRiFSmU2pzLg3+JDFzzcAyRKTy3nl89aVE
 e1lJ2CW3kYHk7QqxsuDm4ZncVcNVKvt+mR377HQjyxt0+o1KmWnWwvspD
 BSeZWnbtIjWj006LxlfdSGJbO/PPekhKA+jurbcP1R2Rx2T5mWZ+2exrw
 VtvFkOXCsVK60PLfbMZpAsWVlnYCVJBu8ACdBxT5oIP69DzrSRu0Jz6Ie
 RbQHW2vLTKAEYqApw+SPYKWyVoPSNawmIjC/hEZZKCeuiim/ZzVhJrg8K A==;
X-CSE-ConnectionGUID: POcZxsVkRZ6wpRzqgOelSA==
X-CSE-MsgGUID: Zog+kMUGR22up2ghnIopvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60918110"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="60918110"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 20:14:46 -0700
X-CSE-ConnectionGUID: JkDCxMCKRvOOOG2qbhUNkA==
X-CSE-MsgGUID: fqdwByXvTl6QBFaldT8U5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="142468367"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 20:14:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 20:14:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 20:14:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 20:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yb4VrqbXkeKesEofOZacclk91GSALrmbh3b4kC4jFVeACtJLPRFFzCIThRE672cyJvjdksa+TLgMQ9ncCIY0RD4jo6L5TVJYmAxSAlawYJ+aF6i7Tc9bCaW+f+E+iuuyeiMU8aCV0YXyBBnMCtbDM/U9BA6M4AGrYqVAQTGaBIw5FfkHcHQtx0qsM2YlSWuh+buyI8TYHzVr136nIv2bgGEhRTfKpZMuXvjTqUtd0zj7yKzvsowlD52s+Cc9yrxrxXDRoDsx/JwkoLXHOW0RYwSlZxxF5sy1f+f+rGf57nkKlLjjzL1SEYh4PR4hKRSB23tRkE2au6K5k65ZxJeAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEiKzOUq5vLiFBekpL40IGFdk0XeugO7UEXi10Cn0pk=;
 b=PHNPn2IJc/WzOMxLTAAnk+3iwKSK0oh1cwWMS8z8xM4AVMOVGfSVL7vSkrtXa6MIqRaS7UIPse5TtAE+RoqIfo9ngAwjsLFbGotnY1aj2P/BjKQP1bAqvC9jkY/zFgnNtYzM39oVnpOVueQlnEGbuNocL/wCBG0H0Mk5zZ71OFJdWDKYTINNeW8G/vZ6MB2UoU/KPdrPa/iWjwYGvwDl/Jkx7iLOkwhJtGzO9kcaqHdLIHh2zOusc9J/FKLoPgLAMn41DZcKoOHegtLI6mIiNpZsBpUj5us6n7z7NzSA+g+bygXCqxXR0Lx/LxBm6B8Kwgen5hLiK3ZnZ1p//pseig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Tue, 27 May
 2025 03:14:25 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 03:14:25 +0000
Message-ID: <cc727bbc-fe37-4be5-9949-3f62d8734215@intel.com>
Date: Tue, 27 May 2025 11:14:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] ram-block-attribute: Introduce RamBlockAttribute
 to manage RAMBlock with guest_memfd
To: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-5-chenyi.qiang@intel.com>
 <e2e5c4ef-6647-49b2-a044-0634abd6a74e@redhat.com>
 <0bc65b4f-f28c-4198-8693-1810c9d11c9b@intel.com>
 <f28a7a55-be6e-409f-bc06-b9a9b4b3a878@amd.com>
 <6ebda777-f106-48fd-ac84-b8050a4b269f@intel.com>
 <173fd9e8-65f7-479e-b7ef-a8b9cca088e8@amd.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <173fd9e8-65f7-479e-b7ef-a8b9cca088e8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 108f200c-11b3-4ee5-91f2-08dd9ccc9550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTU0Und6ZnNWZ0w5YU1aRUVwTHIwaGFKcXlVKzJrbFVRR3p3OTRnOWQyZ08w?=
 =?utf-8?B?OGRMdTNiQkx1a3FEZlhSK29TMVRLRTRpWU1Bakt2N1ZGRzZOTFJiM2YwK0p0?=
 =?utf-8?B?TnVyVnBQVmZzR3pHazhwYkRYOG5EaXF3ZTNxdHhlNjZPaFBFbnkzb1R3cjZE?=
 =?utf-8?B?VHEzUlhZRjRHT1FrWDhaNnlha2hGdC8zZVZFUDJNb1dBSVFlY1lzazB5R0Zq?=
 =?utf-8?B?bHpGLzFQWHBrNnJUaWFGeE51ZCs1VnYrVitHSXk5NFltR2ZRUHVqTXg0ZVJj?=
 =?utf-8?B?NnU1emhQUEkzbnIvcERPWWNHaWNMaDhtcXo1cEdkaWtqMHNDMW9sSUZTRkt2?=
 =?utf-8?B?dXhNTTA4TmVLZUdTZlc3WVAxL1FmOC9JWENYZHNxUWFjWGUvdEJMNnRQT2M2?=
 =?utf-8?B?Z29uYUtpQW9HRS9mb3VsYnV6QmR0cGx3TW5DSU1wTHcrY09rVmxKL3U5ZjhZ?=
 =?utf-8?B?U0h5VTdHTm9GVUNGRnZGR2NEdExrT253ZHBHb2NSbmVMR3I4SmNOdFVQN1FG?=
 =?utf-8?B?NUZFdHh5Q3RjL0R2bkdzYjlRSG1ZVW10eDBsdzd5ZjlBNWFlM3NtZkV2RFNG?=
 =?utf-8?B?dWNjTkV2T2VmeUxHZVh2NGQ1OE5mSTNDTFlMeHBSVGVudEtZYUVTRjFtTmYr?=
 =?utf-8?B?c0Q5ZUU3N1VTcVhZNnlCY2RVQWxXNjVIL2lQZDFodTdlQkNqa2p1QThPcU03?=
 =?utf-8?B?eTVaVTA4YTBwUE5DSVEybWZTZkdrMVdheTJzZ2JldGdIcy9SbWN0VlFzdlRP?=
 =?utf-8?B?WU16VlNvRnloNExVQldWSUVxRnJOTEw5d2Y1VGRwRDBSZGxCZUg0T0x2YUsx?=
 =?utf-8?B?clR1cno2Tk1LK3N0cnlMcExLZDRMYmxubnpHVUU1NDhKN2VLMG5YQng2dTM1?=
 =?utf-8?B?NlU1Szl1Vjc5a003VEgrNFlzVHNMa2FpSjJIR1VDdWR0TU5hTDhxLzZOQkZp?=
 =?utf-8?B?SjgvOVFzc2Y3OFV4Nm9KWEVTdGRMMUxGNXREUlo0ZllzMDY1cGp2M200ZjdN?=
 =?utf-8?B?VVY3TG1hUWVQZGtjSjRDY2NtV0YwR2dDMytKTmtFSldLWWI1N3k0V1lpQTky?=
 =?utf-8?B?TnB6bjhldVY5UzVPT29HeVRPYkFsZnVTVzBqaXFTMTZCSzNuK3oyTHJyYzlM?=
 =?utf-8?B?K1hURVJYaTMwMitHZjNKeG0vK1cyRGlPOG5tQW50UHBzWlUwYi9OVG5heHky?=
 =?utf-8?B?R3hDSVMvZXpSSmhEWVZBSm9FeXNYZ05QTlVjMVl4Q0pCZnVFZ01FSGIwVUtk?=
 =?utf-8?B?cTlxK3o0VSs0bjc0UlhETWNmMGNVOWl4MHBMbUpCVkJnODFKMmJmK2EvcFhJ?=
 =?utf-8?B?VXBBOW5sSWpPTWdqNjBITUp4OGxDSE5uZjdkOWU3RDM5NGpuQmxIb3hId2lr?=
 =?utf-8?B?YXJPWWl2cURndGtYUjdEdHZJRGVrVkduWmdvOWZLcXl3ZkQyR2VSbXlPL2w5?=
 =?utf-8?B?RElQK0NjM3VYZmk2b2dkVjRwR0FzZVZEVGdiWi9UY3h2YkJEa2E0ZHdVbmdY?=
 =?utf-8?B?RlRZWldGNnl4VkltRmNLZllLRFBwY3lSN3orU2xQTlZKZDB3UUhpMGw1Q3VM?=
 =?utf-8?B?VHJ5WDV4K0xCQ09WeFVKQkUzUjRybXlNVWxBZ3BWdWhxUmw5bzN3dWJ3YkZy?=
 =?utf-8?B?UWIvZFUzVWR5cUVMaFREd2NLOTdjZDhtMnBHTkVnSXluOUxyRitWWmxrWlFI?=
 =?utf-8?B?eTJzTDQ5b2FVL3NGM3c3aFlUTDIySkh0ODFxcmpNOUpMNGZ6d05WRkcvZjQy?=
 =?utf-8?B?M3MwVFM0UHovQWpOV1lQRUFHeXlnaDd5dEVKQnREY2tQdDR3NGtvYk5KM3Qx?=
 =?utf-8?B?S1NrS2wvTHJ5Z0lxZm1ZQlJ4SmNlaERIcEtYQUpISDhrR0xkV0ZCL2kvQlcw?=
 =?utf-8?B?UTZmYVAvVURMc3k2R3JXZmFNQnFQUDNOaDI4cVJoNGRRanBWMFcyZ09sR3Ur?=
 =?utf-8?Q?CkpiztNlRyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXgxUGhRNFg3TE9QZnM4RFVDNUt4MlQ3SWhKN09TMW41SldQRUZJejZ0aExM?=
 =?utf-8?B?NHJrNHNqUEkzTy9ndndXdHlKNi9CNVVGV25keWxKMEZENVBFbzBxeElnTVVq?=
 =?utf-8?B?R2s2Ky9PQTNjYmpUNnoxKzZOUlFEODQ1aE5zZTJ3c2JkTjFvSmt3OWhlWXAw?=
 =?utf-8?B?WFJHcWZudk9KZ0w1d3M0ZVpWL21kdldsSmZ3dVVHamQwWUJIa1ZNclFRSWZC?=
 =?utf-8?B?NUZDM044UE95c1RuYUFnNWsxYk1USTNSSFE0QitmaXEvdjN1YklaVldIM0g5?=
 =?utf-8?B?aXpZOXRoM2pRcG5VamplSGZvdVQxVmt6aklKQUZRaWR4emZqOEtnblczR20z?=
 =?utf-8?B?STc4WTJwdHpVVFd0OFQvcmlRYW5KWG82cDJvc1gyenZEemlEQmdEbFNKUzFK?=
 =?utf-8?B?aS9OK2tDMmZmT3N1cVlLS3l4TnBxbDdxZG1oMDNJdkpoUy9PK05hREd3bkJX?=
 =?utf-8?B?ay9lZ2VFN2c4ZktSb0dmNitRZ3E0U2xPVjZrVko4NkMxWDBRRGUyRlV3Uy91?=
 =?utf-8?B?UE1EWU1zR0dyU2tNQTd0dzBqZHBtQTY2UEFTelRQWURrVm02dmltWHVwbVQx?=
 =?utf-8?B?YlZhNTZNcmJzNW5JV0txWjl0WTNqNlh3YXlaUWIyMm95c05EdE1xWWpPUkkz?=
 =?utf-8?B?UGYzdkwxamMvQm40TllmRUErc2J1NkJoamRRUStpaDFZVEdKb2FVVkl6MEZR?=
 =?utf-8?B?dDBWUlhBNW9xV0V2R2pXdUNVZ09vaW93NkRLWFVGS2RJV0paNk9KTjRXM0Nm?=
 =?utf-8?B?Z2NsVEVLaFViN2R5VTVTU0ZRT2x0RVJrUldNM3o4aHFzQS8vTGJSeWFQMlRj?=
 =?utf-8?B?V1NsVEdCMU4ra3NCdHhZT016T3R0QThETVFLaEx0b2o0cDgwS2Z4ZHNOd09G?=
 =?utf-8?B?RzRxcXE5L3dqd1NLLzlyNENWTG5UWnlQbElXTTM3SlIvdzQrdjNGZHZOT2xE?=
 =?utf-8?B?TVRBWURBcEN3SmdHbklWM1lhQ0JUallXWXZaOWxNblZXQUU5RC9uaFloQURh?=
 =?utf-8?B?T3pNVmJSaENKVHAzbWpFNmhNa3B1aTRxanhGY0RkZlF4Nkt2NUdFYzVEWG5O?=
 =?utf-8?B?aVZKMEg2VXJ0a240LzJGdGUvVVpzeHhZY2FLcDBiL3lnSkdMV1l2dGthSjND?=
 =?utf-8?B?WVQrbU90V21acTlDdW1EZUNuUDVVV2dlYkJEWFB4eUFXVTZIQXdiSzRWMXR1?=
 =?utf-8?B?Rkp5SnFKM1M3OUcxbkVPNTg1Zm5ZTEFmdFppa2x4MEZBUnZZWFZyOVhJblcz?=
 =?utf-8?B?ZStWcjVXWEk4UHdPQjJJcFNWcXk3YU1aTTg3emFWdURINDEzcXNMM25NcEhG?=
 =?utf-8?B?dlUzY29Vdy9vM1FCZlBBS0picVlhYzdGd014UEFtNTQ2OWQyWnNPYnVTMkUx?=
 =?utf-8?B?TTVxRnNZZlBYQkhwQXV2U2h4c2tDamNkUUVIRGlnNEpic25LeWFBNzZvMGNM?=
 =?utf-8?B?Q09EejJxTjZJS3NLVkxVMzNBT1ZXK3ppdFc5aWZ1QzUwZk9RRDU1NE8vRTl5?=
 =?utf-8?B?WnEyZHhmMmlialhoM1VIcnVnWmQvaXc0ejAvV09PTXAwWlBPYmdMemRnMTk5?=
 =?utf-8?B?bm41ZlhCQ0wxNHE4b1RtTXBhbGJBcVZLSWp0bXhRSVFzdHFYZmZUcHNjd2sz?=
 =?utf-8?B?V0NxTm1aNFVXN0ViS1F6ek9hQ1VHTXQ2SGdmZzFsS2dLdTJmVVhLbGNVb3Jz?=
 =?utf-8?B?czQzeS9icjhBaG5BTkV2UjJzSnBKSERMcUhFT2VETVlrQlgyc2JMRENaMi9I?=
 =?utf-8?B?QmJBK1libVJKWFNIcFBwbDgzUnFaS3dSTkU0RmQyL3ZtelNhdlBkQ3pBa011?=
 =?utf-8?B?dlA0NWlYNkoyemx1L0dFNkg4U1MxcnZRaTBPY203R1RIYWt6bkJuMzV2OVRB?=
 =?utf-8?B?bWo1bDFVc2lOZHo3NEVvais0NDdYQ1I4ZmxySUw5Tnp6eWc4RGlXTmNKbjkr?=
 =?utf-8?B?UHJydnhDNFFoSmNvMnRYODVHQ2pESDZnT2JOUGNrbDBEUjNFMWV3anRhZjJK?=
 =?utf-8?B?elFVcFU1cFB1M1dSSTloWVRrUHBhYU1lMEtkbTFtYXFTTmphZGN4VHQwM1lV?=
 =?utf-8?B?dCtRV0tJTXlxVzRKN3UrbmlqbzhaT1NxY3pnQ0Flb2VYR1ppNllmSnJsTi9n?=
 =?utf-8?B?eFVDS1BGUG14YVAwVHRLVW4rb2h2WmJYaU1qbTBKVStLOW9STWFtQWJLNUM1?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 108f200c-11b3-4ee5-91f2-08dd9ccc9550
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 03:14:25.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIZGpa0/OGsZ6AuaqkjWra4JND2I2B/LXPzErYbXzNhwPWeTJ2yxxH6ImegBAaMcQ5BVbto+4gh869p2mweYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/27/2025 9:20 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 27/5/25 11:15, Chenyi Qiang wrote:
>>
>>
>> On 5/26/2025 7:16 PM, Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 26/5/25 19:28, Chenyi Qiang wrote:
>>>>
>>>>
>>>> On 5/26/2025 5:01 PM, David Hildenbrand wrote:
>>>>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>>>>> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
>>>>>> discard") highlighted that subsystems like VFIO may disable RAM block
>>>>>> discard. However, guest_memfd relies on discard operations for page
>>>>>> conversion between private and shared memory, potentially leading to
>>>>>> stale IOMMU mapping issue when assigning hardware devices to
>>>>>> confidential VMs via shared memory. To address this and allow shared
>>>>>> device assignement, it is crucial to ensure VFIO system refresh its
>>>>>> IOMMU mappings.
>>>>>>
>>>>>> RamDiscardManager is an existing interface (used by virtio-mem) to
>>>>>> adjust VFIO mappings in relation to VM page assignment. Effectively
>>>>>> page
>>>>>> conversion is similar to hot-removing a page in one mode and
>>>>>> adding it
>>>>>> back in the other. Therefore, similar actions are required for page
>>>>>> conversion events. Introduce the RamDiscardManager to guest_memfd to
>>>>>> facilitate this process.
>>>>>>
>>>>>> Since guest_memfd is not an object, it cannot directly implement the
>>>>>> RamDiscardManager interface. Implementing it in HostMemoryBackend is
>>>>>> not appropriate because guest_memfd is per RAMBlock, and some
>>>>>> RAMBlocks
>>>>>> have a memory backend while others do not. Notably, virtual BIOS
>>>>>> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
>>>>>> backend.
>>>>>>
>>>>>> To manage RAMBlocks with guest_memfd, define a new object named
>>>>>> RamBlockAttribute to implement the RamDiscardManager interface. This
>>>>>> object can store the guest_memfd information such as bitmap for
>>>>>> shared
>>>>>> memory, and handles page conversion notification. In the context of
>>>>>> RamDiscardManager, shared state is analogous to populated and private
>>>>>> state is treated as discard. The memory state is tracked at the host
>>>>>> page size granularity, as minimum memory conversion size can be one
>>>>>> page
>>>>>> per request. Additionally, VFIO expects the DMA mapping for a
>>>>>> specific
>>>>>> iova to be mapped and unmapped with the same granularity.
>>>>>> Confidential
>>>>>> VMs may perform partial conversions, such as conversions on small
>>>>>> regions within larger regions. To prevent such invalid cases and
>>>>>> until
>>>>>> cut_mapping operation support is available, all operations are
>>>>>> performed
>>>>>> with 4K granularity.
>>>>>>
>>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>>> ---
>>>>>> Changes in v5:
>>>>>>        - Revert to use RamDiscardManager interface instead of
>>>>>> introducing
>>>>>>          new hierarchy of class to manage private/shared state,
>>>>>> and keep
>>>>>>          using the new name of RamBlockAttribute compared with the
>>>>>>          MemoryAttributeManager in v3.
>>>>>>        - Use *simple* version of object_define and object_declare
>>>>>> since the
>>>>>>          state_change() function is changed as an exported function
>>>>>> instead
>>>>>>          of a virtual function in later patch.
>>>>>>        - Move the introduction of RamBlockAttribute field to this
>>>>>> patch and
>>>>>>          rename it to ram_shared. (Alexey)
>>>>>>        - call the exit() when register/unregister failed. (Zhao)
>>>>>>        - Add the ram-block-attribute.c to Memory API related part in
>>>>>>          MAINTAINERS.
>>>>>>
>>>>>> Changes in v4:
>>>>>>        - Change the name from memory-attribute-manager to
>>>>>>          ram-block-attribute.
>>>>>>        - Implement the newly-introduced PrivateSharedManager
>>>>>> instead of
>>>>>>          RamDiscardManager and change related commit message.
>>>>>>        - Define the new object in ramblock.h instead of adding a new
>>>>>> file.
>>>>>>
>>>>>> Changes in v3:
>>>>>>        - Some rename (bitmap_size->shared_bitmap_size,
>>>>>>          first_one/zero_bit->first_bit, etc.)
>>>>>>        - Change shared_bitmap_size from uint32_t to unsigned
>>>>>>        - Return mgr->mr->ram_block->page_size in get_block_size()
>>>>>>        - Move set_ram_discard_manager() up to avoid a g_free() in
>>>>>> failure
>>>>>>          case.
>>>>>>        - Add const for the memory_attribute_manager_get_block_size()
>>>>>>        - Unify the ReplayRamPopulate and ReplayRamDiscard and related
>>>>>>          callback.
>>>>>>
>>>>>> Changes in v2:
>>>>>>        - Rename the object name to MemoryAttributeManager
>>>>>>        - Rename the bitmap to shared_bitmap to make it more clear.
>>>>>>        - Remove block_size field and get it from a helper. In
>>>>>> future, we
>>>>>>          can get the page_size from RAMBlock if necessary.
>>>>>>        - Remove the unncessary "struct" before GuestMemfdReplayData
>>>>>>        - Remove the unncessary g_free() for the bitmap
>>>>>>        - Add some error report when the callback failure for
>>>>>>          populated/discarded section.
>>>>>>        - Move the realize()/unrealize() definition to this patch.
>>>>>> ---
>>>>>>     MAINTAINERS                  |   1 +
>>>>>>     include/system/ramblock.h    |  20 +++
>>>>>>     system/meson.build           |   1 +
>>>>>>     system/ram-block-attribute.c | 311 ++++++++++++++++++++++++++++++
>>>>>> +++++
>>>>>>     4 files changed, 333 insertions(+)
>>>>>>     create mode 100644 system/ram-block-attribute.c
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 6dacd6d004..3b4947dc74 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -3149,6 +3149,7 @@ F: system/memory.c
>>>>>>     F: system/memory_mapping.c
>>>>>>     F: system/physmem.c
>>>>>>     F: system/memory-internal.h
>>>>>> +F: system/ram-block-attribute.c
>>>>>>     F: scripts/coccinelle/memory-region-housekeeping.cocci
>>>>>>       Memory devices
>>>>>> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
>>>>>> index d8a116ba99..09255e8495 100644
>>>>>> --- a/include/system/ramblock.h
>>>>>> +++ b/include/system/ramblock.h
>>>>>> @@ -22,6 +22,10 @@
>>>>>>     #include "exec/cpu-common.h"
>>>>>>     #include "qemu/rcu.h"
>>>>>>     #include "exec/ramlist.h"
>>>>>> +#include "system/hostmem.h"
>>>>>> +
>>>>>> +#define TYPE_RAM_BLOCK_ATTRIBUTE "ram-block-attribute"
>>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttribute, RAM_BLOCK_ATTRIBUTE)
>>>>>>       struct RAMBlock {
>>>>>>         struct rcu_head rcu;
>>>>>> @@ -42,6 +46,8 @@ struct RAMBlock {
>>>>>>         int fd;
>>>>>>         uint64_t fd_offset;
>>>>>>         int guest_memfd;
>>>>>> +    /* 1-setting of the bitmap in ram_shared represents ram is
>>>>>> shared */
>>>>>
>>>>> That comment looks misplaced, and the variable misnamed.
>>>>>
>>>>> The commet should go into RamBlockAttribute and the variable should
>>>>> likely be named "attributes".
>>>>>
>>>>> Also, "ram_shared" is not used at all in this patch, it should be
>>>>> moved
>>>>> into the corresponding patch.
>>>>
>>>> I thought we only manage the private and shared attribute, so name
>>>> it as
>>>> ram_shared. And in the future if managing other attributes, then rename
>>>> it to attributes. It seems I overcomplicated things.
>>>
>>>
>>> We manage populated vs discarded. Right now populated==shared but the
>>> very next thing I will try doing is flipping this to populated==private.
>>> Thanks,
>>
>> Can you elaborate your case why need to do the flip? populated and
>> discarded are two states represented in the bitmap, is it workable to
>> just call the related handler based on the bitmap?
> 
> 
> Due to lack of inplace memory conversion in upstream linux, this is the
> way to allow DMA for TDISP devices. So I'll need to make
> populated==private opposite to the current populated==shared (+change
> the kernel too, of course). Not sure I'm going to push real hard though,
> depending on the inplace private/shared memory conversion work. Thanks,

Do you mean to operate only on private mapping? This is workable if you
don't want to manipulate shared mapping. But if you want both, for
example, to_private conversion needs to discard shared mapping and
populate private mapping in IOMMU, it may be possible to pass in a
parameter to indicate the current operation, allowing the listener
callback to decide how to proceed. Or other mechanisms to extend it.

> 
> 
>>
>>>
>>>>
>>>>>
>>>>>> +    RamBlockAttribute *ram_shared;
>>>>>>         size_t page_size;
>>>>>>         /* dirty bitmap used during migration */
>>>>>>         unsigned long *bmap;
>>>>>> @@ -91,4 +97,18 @@ struct RAMBlock {
>>>>>>         ram_addr_t postcopy_length;
>>>>>>     };
>>>>>>     +struct RamBlockAttribute {
>>>>>
>>>>> Should this actually be "RamBlockAttributes" ?
>>>>
>>>> Yes. To match with variable name "attributes", it can be renamed as
>>>> RamBlockAttributes.
>>>>
>>>>>
>>>>>> +    Object parent;
>>>>>> +
>>>>>> +    MemoryRegion *mr;
>>>>>
>>>>>
>>>>> Should we link to the parent RAMBlock instead, and lookup the MR from
>>>>> there?
>>>>
>>>> Good suggestion! It can also help to reduce the long arrow operation in
>>>> ram_block_attribute_get_block_size().
>>>>
>>>>>
>>>>>
>>>>
>>>
>>
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EBAC3DC4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 12:23:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUyH-0000j7-3A; Mon, 26 May 2025 06:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJUyF-0000ir-9u
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:22:15 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJUyC-0002Q3-QX
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748254933; x=1779790933;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L3eOz5qtm9KR+K7vRCGqwaItQHT65Ctnwfw88SnKogM=;
 b=b8vPPG0EcjeVMsg64kDUF2fEnf1rTnUIIsOQzBnyzYaIEcbs5XdY3+/b
 +6KUVHXogz56o0aEXVZ00LtY2EXIkGXm4aXoDa3xWLMcy7DIHwlYr6Qym
 Up/Ir55xvYB+8pVtx9ahvnvM85C/Zv5hikQ0xdgUnroaMnLpgm5NLoltV
 sCCwOnT/KS1UyUcF8yAx7Wbia9TjYzCITLvmOHZ8kZ45N2mmKdkdWRB3X
 tYjEgy7tXVC00hOWlLDw7KW/ReYnWhSPEyYspXIlKU4C8u85GER0QklRm
 B9fdBm4JYalCecPcjHehn0enDGPfqZhb90ThaPQ4KF0zSiFzAAfWgGZ6C A==;
X-CSE-ConnectionGUID: kqzO1UGtR0Wsu0i/Wo9fyg==
X-CSE-MsgGUID: Mnm1M/o2R8SdmhII1m2HNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="67635525"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="67635525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 03:22:09 -0700
X-CSE-ConnectionGUID: oQ/RNkOrRC6GSa5JhBwIPQ==
X-CSE-MsgGUID: 26v7HLneQoCcSP81N4ptDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="147076354"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 03:22:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 03:22:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 03:22:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.86)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 03:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9+RVlKeLmMooyQZiHTkwwbp6gC/mYHpHv9JvRYn7emheIkyzZLe41OCwKC5nCW1F5RTFjI3xTvbnwgG1Boh2yT/NRh9KjHfjFdqtqmaM3pxeSG0i2SknkRn3Bdcq4Wcvpz07J4ENoOKpvO/l3+P0wC3zrbilUpQq/KTBZg0ZCinW4hKZ/HMf5l9hVTnZI9HChtvPK0bppoLG5jwiAefSj6wgL+jT5xAbjTQTT1e93LCdcAGcRN8MMEOwIBsQ7bm2ryulWtm8En8gINZjD6wqZJ3RyucJXRqWn2uD4tagE96UiducnRfFs1B9tIYuo8ZiOI30J88YJ+XuaOmQLVLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLP54ku+DeeMcK05tHW2tqfeZdJhXvC3eCcKZ4u+INI=;
 b=G5dR62GeT0aE/kbSXDaPU9koy5JTHJWkMyDyI0cQrSWqYnaWm3DJIsYp0dgQ9vXWpfPa8hfeKFHZhbt9lAi4XZSbHMNOhau3yNQ5VkB0ZDA1rTHfsOkP5zjaMC6EwfVfmH7pHb1EI+3j0IHZECvWDtlLs/XlkL46nICRXhPs8cAvsV1/PvuX/jEI90QNl7EMBxUhdE7zG4hgyWuzg23K52CpuzGhII5ylm2N9Cd52LbS4GUuud/EXTayn7r02yuWERCsxxVmyF9ityGeMxB5RVaLqGCgcX8O6AYZQZmXfOB5pWbeQsuqLVC3xUzkmjluNMY5ot/aGfAO2p0tsEUJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.24; Mon, 26 May 2025 10:22:06 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 10:22:06 +0000
Message-ID: <b7bc6ce6-fdf4-43f7-b4b3-de0b3924f0fc@intel.com>
Date: Mon, 26 May 2025 18:21:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "David
 Hildenbrand" <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, Peter Xu
 <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-4-chenyi.qiang@intel.com>
 <dca6ed89-e704-44ce-b9f1-deb3c6dd8dc3@linaro.org>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <dca6ed89-e704-44ce-b9f1-deb3c6dd8dc3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0056.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::9) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 74aa65ad-0391-4053-d3c1-08dd9c3f29fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRUNnFWb2VTT1pHb3RLZkJKMnVtd09Ca2FhcnZ4YjU0ck95WXlJeXFGN2lq?=
 =?utf-8?B?OEJWdC9yMWIrZk9XSzR3dE0xU0RhTElJM3crR1A1UjBPQXZtTlQ1a0l3S1Rv?=
 =?utf-8?B?ZHBZZHZTclRSN3JMcEcvZEJ6SzI0ZjdYeXNCejV1TDJBa1JzWUNocFBXRkxu?=
 =?utf-8?B?OVIrbjAzaVZ5R01LUm1OQVlSR1pkU042NHJYMldmZ05ISW0zR3hIYnBtSk45?=
 =?utf-8?B?ZzNBd01iWXhBbHFXbEl3d2FES3NsZWc4d1lBUXZwVUM1RFoyOU1VMnU3aEtl?=
 =?utf-8?B?NXgwUnE3eEtlN2NZWTV5bDZuRk1lQnNod2dTTTBxVHRUVnBzanVRRWxMUzRB?=
 =?utf-8?B?Y2tvczAxYVo3Y2Q1ekE4NkxYQjduWGF3c0o1eEc2WTRLUko0dllPU2thK0tw?=
 =?utf-8?B?bUJ1Z1hEenBlWVJDYThtQXRlZ1EzUGdxRDJWWTFUOEpEbGV1K3p0bktxdEJ5?=
 =?utf-8?B?QUlnM2N6SERjT1VNbW1Iem5vb2tFTmJWdFhMNmNwWFBXdkRrOWdiTytZSjRn?=
 =?utf-8?B?R25nT2R0QWFDU0lzRUpMYTl6R1IwcGpZeXpOYTBaUUkzKzJIcGlGTmdBUUUv?=
 =?utf-8?B?YjQwZFVEb3BsbUJTNElMemRFcUM4clljV000S2NQOEZGamRPaDhVVGV0QTcy?=
 =?utf-8?B?RDdGYXY0U0tMdnkzTy8zMityL0xleU1nQS9EVllWRVJnQXZrdFZjejRDQ2Qy?=
 =?utf-8?B?dmhPR3ZYV2VHSFg4UmhDbjNKS1c5OHZJbHJXQjhSbUlyUldjSHlMODc5dXpz?=
 =?utf-8?B?VHdxN0tlQ0V2YkNvMXNsRGxhV3VHZUppM3VHd29iMkR5VlRLdnJ6dEJuWTdN?=
 =?utf-8?B?UGxHMGhReHk5TXk0Wi8xQytRbU5BcjNoYUIrSVVIbjdrK2J6OXBtYXhJUkwr?=
 =?utf-8?B?cDl1NFdrWklWUEdFbHZZRWRVK3hWbDhtMFhnakhaVmY2bVl5NXVVTTE1bk5h?=
 =?utf-8?B?NkUwZzZiZVB6ZlQwNGNTdVN4TjAvQk9DU0JvWVc5cDAvOHdkc25HSHpLVEJw?=
 =?utf-8?B?SkdPUEZWTVNKUmdqT3B6NUZ4aUladnp2d0duM21rb0I5SFJRc0tpZVlWUFM2?=
 =?utf-8?B?NE9pd2hxdVFXaG9tcWhPd3VTTnJqeDBPcENhbEpSTDVIR09KVjMvOUg3dVZS?=
 =?utf-8?B?RWwzZ01KVUFuR1JWUVg5b3NCRHJZM1k3NHZ3N2dkZ3lSeDg5NVhWZUwyaWFx?=
 =?utf-8?B?QkQ1V0dCVGdraFc1M2lVY2h2Wk9qa2haaG5LcVowNDRBYld5L0Q0bGZBQlJv?=
 =?utf-8?B?TTE1eXBsZVIrNTQrNlIzcVE4OU1hSzhXeVpDY3VjcXk1MnVoSEFwRlcrSVlx?=
 =?utf-8?B?WVN3dFpzaVdnbDNhNllSNzYyTWprMTJIT2ZLOU5pWDRtM1J0aWwzYnkvMkla?=
 =?utf-8?B?VjJhVU9INnZzT0JJcmJ5OThHWEF2U2p6ZnI1aDhDdHJKVytuT05oYWVLS3VC?=
 =?utf-8?B?U1AySnBzc3JzdFNpWE1VeVd1ZTVXc1NZV1JYNmxZSkVxUTI3S01Yc2hHMlkx?=
 =?utf-8?B?Z3NJTk1zYmlNSFM0NDFxcEovbVRaTlJpbkczSjNwSE9yM0wvUDZRRHkxaSs5?=
 =?utf-8?B?YUMvWVg4VHJTRGdlbjRvazFEMTFRUDcwUVVkcll2WkNHek1JeDZLamw1ajRJ?=
 =?utf-8?B?R1JnRVBwZHAzSy9WZkorNTNsVUJBeXhxbHZzV05nU1M1OXprcDBaREFHYXo4?=
 =?utf-8?B?dzRFKzdaVFBlODJuRzVRZ0d1RHBQaEk0bnI5aWZmdW9rb1pWclFPYWFVeGVp?=
 =?utf-8?B?OENZZFlMMDlqQlRuVC9WNSsvWTRSemN0NXpZdmw4Zi9vSUhXUUxaTm9JZktk?=
 =?utf-8?B?ZVhlZUw5MXR3b1g4Tm8xZjczYjBpYmY0cWx1OHdzdU1CcGlnRXlPck9uMjEz?=
 =?utf-8?B?QUhLVmtSaExaTVFiNWhXWTl5c25ZTEt0R2xyREFNeWl2UVZ4NlNJRklhbGN3?=
 =?utf-8?Q?/8PZgOBspPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFSa2pMZ1ZSdGM1RTdDbUV0b2o0UW9Jc2dQY3lqOThvY3NEa3RocDdvQ0VJ?=
 =?utf-8?B?ZC9Tdk5kMHVDNjI2TURGVG1NaHBjRWJEcUxjY2hFK2laY1pwK2w3UCtMTmFO?=
 =?utf-8?B?V2FObVBLd2VmTnVteDc1b0ZFZXVQZVV3c3loYjFWVlJNTXRFZXhkTFFiT0hS?=
 =?utf-8?B?QUh2QmJ4R3NXVjZZWExlTFV6cUlxTDZJYU53MXArblo1YUhJaXdqbUtLWWNm?=
 =?utf-8?B?aTZpV29qUDhvYTVTbTk1anJleERNZWtnSUxzdlAyNFFkRVE3UHJZbWY5T1l1?=
 =?utf-8?B?S3pzTFVyMzJyKzhZOEZKUG5URFhzaW5vUFlZVitnQUljaTljd0NzdGx4SHNV?=
 =?utf-8?B?NkJUbVBUcmVQWVZwOEdvQTIzd0hrVTh0VTUyNDNkWXBOR1JYUzR4ZnV6N056?=
 =?utf-8?B?clBIS3Vuc3pHZkliZjd5WEVBYWVtd3V6MC9RZE1qZ25nbDJ3R0F6QW9PNWNa?=
 =?utf-8?B?MjJPeFYxVnJScW1sMVJ0cFk5Y2NTaCtZK0daaEM1c1hYbGNwQUh6bDdoVEdE?=
 =?utf-8?B?cEdVZEhOMTZzQTBISEJQNGFBOWp3QndzWDNJTSt0VTNjczJZQ2g3TW5zSFhp?=
 =?utf-8?B?aHBLWUdHKzA1R3pGZTNTNmpTQlhGb0tnNE43UC9laGJZNW45YWdBNVlGSXZx?=
 =?utf-8?B?dkF3cVA1alpUODZCdTNuL1VrYm52QmxjbjdqUjBqYTZOaEdFRk50a1dTWlFS?=
 =?utf-8?B?RDYzZWptbGhFYXUvQW9GWVVtdVBGTkphYjNIVStoc0N1QmdpSWJkblZyWGdL?=
 =?utf-8?B?eTlsM2UxWFBzKyttUFN1WGpaZWZLQXBELzIwSXI3Ryt6YTgyamg5NDF2TjBp?=
 =?utf-8?B?T0J5djBKUUxyYituemo5WFNDR1dnUFNvRC9zSEtEa1pQajJxUHhQRGh3N2hm?=
 =?utf-8?B?ZWxUZVdoSVAvY1BxYlpxY2JNL1RudVcvY0d0NFZ2eUM5YUdPMk5EcDNXcmRR?=
 =?utf-8?B?T1pBVm43ZnZOenNNTnF0QmY2QlRhekExRFRKM2VRbGliSUlxRm45L1lVSXlC?=
 =?utf-8?B?a2JEbDNzTU1tSGFWZEZ6MHlxeWZrZStXTDJGK3lNOVZrZE8zQmFITThEWVJQ?=
 =?utf-8?B?SER6bnVHQklIVTdjVDk2bXdGVnhVQ1Fsa0Zhb3UvSlZaVmNpKzFXVWcrZm5u?=
 =?utf-8?B?WXd2eG9yRnZPRlVWS2ppZUF4dEZsaGtlVENzT3RSQjl1UVdEQU93VFZJV0Z3?=
 =?utf-8?B?U1BQUEdMbjgxRENJNTZURmtNSCtJUTY3UkNnclZuNDl4SVRSb0t3Q2tUVFFB?=
 =?utf-8?B?VWQrM1VpMkJGRTBML1VSamZZWGdrQ0FxVE8wUFRzaXR6K1ZwK2N6YklmUUJE?=
 =?utf-8?B?eEw2Y3ZGVlpiTXVWcTYxelhQTThFdWpsR1puY3lxbkM5K2RLeWEzcnhheGlK?=
 =?utf-8?B?WWVBbDdWOGUxN1JpZW9jLzNLZnRsRHl0UHFIYWdkY2VheDNiWVFDblorNWVt?=
 =?utf-8?B?M1Z2eXlUYVgyKzBSZjBHLzg0SEhEZVhyMUoyL0Z6aW9KVmNlK09nUzd5WGNq?=
 =?utf-8?B?d09DN3dIT05aKys1clBpa3V4MmlrSkZyL3lqa0VrUVhCc0s4dlFnZjBBV3Aw?=
 =?utf-8?B?b3JJTlRnWE5naHlqSWh2SlJ6bFcwWktXZHdmSFVrSUpkMWhEUkU4Q0pVbFRa?=
 =?utf-8?B?ZWk4Z2txaHpqS1BPRElxOWtIaXdZREQzUEcyM2Ura0lRTHJNWG9ucjBtQWM2?=
 =?utf-8?B?NG1pcUxZOEtScVZwZ1l4eUNlMUxFa1Q0bkNSN1BlWU5lTHJIWGdUaEdsK3hm?=
 =?utf-8?B?SHRyY1ZIRXNzYVVOVWpNWGcydDNKUGlyT1J6U2RKczJtZER0eHgwWTFSa0Qx?=
 =?utf-8?B?a3N0UXY3Vm1vVDlYdFRvOUprODRIclFVRDQ5VG5KME9OMld3akZDZFZ2dzk4?=
 =?utf-8?B?ZFJibEVPNnBiWjdIUXNld3poVzBmb2RnSytVR3NjdFBnSXppREdDbXliK2d5?=
 =?utf-8?B?cWxGM3R1OXJhTUp3enMrSjdOL2M2bWM4TDhTVzhrRExhUmlZQ3EyWkxUMDd0?=
 =?utf-8?B?N3QvenVlZ3UxYXc1UjZkN1ltNytJbjJVZmVIblZDL2dpbVBoclRqdk1xTXhZ?=
 =?utf-8?B?ZklEdDdpMkpaZlhmRjE4Q3B0RE9VQnVGYmFYaTB6Q3hJZkpzc3JFTVZDVHNr?=
 =?utf-8?B?NFVWa1dpU0hpR29Xa25tNEVTd0d1cWJ1c1ZXK3RlSnJSSmhyMWEyeml5WENL?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aa65ad-0391-4053-d3c1-08dd9c3f29fe
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 10:22:06.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yJgtO8JqGx6OufqyFe8krXuy5OpJsAW0OM5j3za68D0a9b6n9lswJO0yj7j8Mefvniw4hKbcip06UxkehAOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 5/26/2025 5:35 PM, Philippe Mathieu-Daudé wrote:
> Hi Chenyi Qiang,
> 
> On 20/5/25 12:28, Chenyi Qiang wrote:
>> Update ReplayRamDiscard() function to return the result and unify the
>> ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamDiscardState() at
>> the same time due to their identical definitions. This unification
>> simplifies related structures, such as VirtIOMEMReplayData, which makes
>> it cleaner.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>> Changes in v5:
>>      - Rename ReplayRamStateChange to ReplayRamDiscardState (David)
>>      - return data->fn(s, data->opaque) instead of 0 in
>>        virtio_mem_rdm_replay_discarded_cb(). (Alexey)
>>
>> Changes in v4:
>>      - Modify the commit message. We won't use Replay() operation when
>>        doing the attribute change like v3.
>>
>> Changes in v3:
>>      - Newly added.
>> ---
>>   hw/virtio/virtio-mem.c  | 21 ++++++++++-----------
>>   include/system/memory.h | 36 +++++++++++++++++++-----------------
>>   migration/ram.c         |  5 +++--
>>   system/memory.c         | 12 ++++++------
>>   4 files changed, 38 insertions(+), 36 deletions(-)
> 
> 
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index 896948deb1..83b28551c4 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -575,8 +575,8 @@ static inline void
>> ram_discard_listener_init(RamDiscardListener *rdl,
>>       rdl->double_discard_supported = double_discard_supported;
>>   }
>>   -typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void
>> *opaque);
>> -typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void
>> *opaque);
>> +typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
>> +                                     void *opaque);
> 
> While changing this prototype, please add a documentation comment.

[...]

> 
>>   /*
>>    * RamDiscardManagerClass:
>> @@ -650,36 +650,38 @@ struct RamDiscardManagerClass {
>>       /**
>>        * @replay_populated:
>>        *
>> -     * Call the #ReplayRamPopulate callback for all populated parts
>> within the
>> -     * #MemoryRegionSection via the #RamDiscardManager.
>> +     * Call the #ReplayRamDiscardState callback for all populated
>> parts within
>> +     * the #MemoryRegionSection via the #RamDiscardManager.
>>        *
>>        * In case any call fails, no further calls are made.
>>        *
>>        * @rdm: the #RamDiscardManager
>>        * @section: the #MemoryRegionSection
>> -     * @replay_fn: the #ReplayRamPopulate callback
>> +     * @replay_fn: the #ReplayRamDiscardState callback
>>        * @opaque: pointer to forward to the callback
>>        *
>>        * Returns 0 on success, or a negative error if any notification
>> failed.
>>        */
>>       int (*replay_populated)(const RamDiscardManager *rdm,
>>                               MemoryRegionSection *section,
>> -                            ReplayRamPopulate replay_fn, void *opaque);
>> +                            ReplayRamDiscardState replay_fn, void
>> *opaque);
>>         /**
>>        * @replay_discarded:
>>        *
>> -     * Call the #ReplayRamDiscard callback for all discarded parts
>> within the
>> -     * #MemoryRegionSection via the #RamDiscardManager.
>> +     * Call the #ReplayRamDiscardState callback for all discarded
>> parts within
>> +     * the #MemoryRegionSection via the #RamDiscardManager.
>>        *
>>        * @rdm: the #RamDiscardManager
>>        * @section: the #MemoryRegionSection
>> -     * @replay_fn: the #ReplayRamDiscard callback
>> +     * @replay_fn: the #ReplayRamDiscardState callback
>>        * @opaque: pointer to forward to the callback
>> +     *
>> +     * Returns 0 on success, or a negative error if any notification
>> failed.
>>        */
>> -    void (*replay_discarded)(const RamDiscardManager *rdm,
>> -                             MemoryRegionSection *section,
>> -                             ReplayRamDiscard replay_fn, void *opaque);
>> +    int (*replay_discarded)(const RamDiscardManager *rdm,
>> +                            MemoryRegionSection *section,
>> +                            ReplayRamDiscardState replay_fn, void
>> *opaque);
>>         /**
>>        * @register_listener:
>> @@ -722,13 +724,13 @@ bool ram_discard_manager_is_populated(const
>> RamDiscardManager *rdm,
>>     int ram_discard_manager_replay_populated(const RamDiscardManager
>> *rdm,
>>                                            MemoryRegionSection *section,
>> -                                         ReplayRamPopulate replay_fn,
>> +                                         ReplayRamDiscardState
>> replay_fn,
>>                                            void *opaque);
>>   -void ram_discard_manager_replay_discarded(const RamDiscardManager
>> *rdm,
>> -                                          MemoryRegionSection *section,
>> -                                          ReplayRamDiscard replay_fn,
>> -                                          void *opaque);
>> +int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
>> +                                         MemoryRegionSection *section,
>> +                                         ReplayRamDiscardState
>> replay_fn,
>> +                                         void *opaque);
> 
> Similar for ram_discard_manager_replay_populated() and
> ram_discard_manager_replay_discarded(), since you understood
> what they do :)

Sure, will do. Thanks!

> 
> Thanks!
> 
> Phil.
> 



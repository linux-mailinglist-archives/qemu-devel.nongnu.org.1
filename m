Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C906487943A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 13:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Ku-000482-KX; Tue, 12 Mar 2024 08:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk1Kc-0003yc-NM; Tue, 12 Mar 2024 08:34:11 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk1KY-0006U7-K6; Tue, 12 Mar 2024 08:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710246846; x=1741782846;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=tl1SMN3XvWB7Nu/09qbEpOC1BKEy49Uq3HLICnX34hw=;
 b=cn6HPwqq8l/xtgEnTjz05OlNyYY5bsrvJsUxCBfspecNztMFSNOCUVtQ
 wq0mCmRi/0+P21ss9TNMPBGyn3Xty50TOvnrxaTcofh/h7s7S93gDoE7q
 pR/DrcFlG/05ss/8KuqQ9c2S2897u0hd7SIHmQx5DN8HyVPCwQuSVJljx
 K7s2t0EqyXvkdttU/m1IfCieB7qPYPNO8UHCWl/Xy0GT5VjK/ZPMoVQ2W
 KHqGHPE7+0OB+vrnqfIO4WKv3wT2dOQHDKu6vyun3ed+Bm9T8+G1X6F3s
 RfALSSKunVwM+HD4C6WOX9O6qHjU7aCKaDiLIuwCL09HcHMO+4HPeJiON Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4823685"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4823685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 05:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16127076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Mar 2024 05:34:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 05:34:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 05:34:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 05:34:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 05:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MueQruPZE1+6QhaIPMX3LZjHKzkZuPjYaeEzicYvxOZ2oJHXiFE96Mgr4z7Gr9FP2QkK7IMbQp6jmDnp4GiA5RqanY3+eNrL3yj8/Dh/XdP55d7yQnGbxv9luJnMYlWQxOnYgt5Qj0rH/LfVp02BHzaTsBL102BPrmyq6ywfw4fFPm0LDyyvUJ6c/fVp19N6ev0119vpl2GpKfMa/qLhtSrnKBXzlhIkrvSqMzcsD+suGV7JCOMXNlKvYVmAdC1YrzA7lj/7yWjVkGGU1e9gF69hTtVKKsnmQZepeHWGp9zFBTHTk4gKUSGFSYuLcudgEerTgUDXnlgVsjVtkhbmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvtvRaPFr2kCdt67Vhm92WsdcejJzyaiMAqzwjW9khU=;
 b=VamMKGXlhalLIuBWHQeLCMUaBtQaPHeGofW5DBvDr4g1LQfr2gYoMDxdeeVbeHFnn3uHkHnjwFOQYvVKNqF8XGL3smMmqYHf8ypQVNWP/hb2WPZXSVrI2aZGCdSe/Hm2enEaAZG9nyxY9M208gE4wKA1EbNwbZCTTHKGOEy8XttJ14l3YyOoHgKB7qhIBTCBcYC9gYYUX6IKgTvkTEO51eCGFSWKni01LtG+OrHcIE30wEKcxrkJd8/XQWS6+iy49SVHSkZbX8fSfayQ2eJ+EODB4srYlDY+cS2cgcEmHeLWsJ+wuwlh9M8DEsIUSSlOTn991drZGhtwQadTNTffUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 12:33:55 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 12:33:55 +0000
Message-ID: <603b8000-3949-4710-bcd1-7ce2f0fb9fbc@intel.com>
Date: Tue, 12 Mar 2024 20:33:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
Content-Language: en-US
To: <tech-server-soc@lists.riscv.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <andrei.warkentin@intel.com>, <shaolin.xie@alibaba-inc.com>,
 <ved@rivosinc.com>, <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>,
 <evan.chai@intel.com>, <yin.wang@intel.com>,
 <tech-server-platform@lists.riscv.org>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
 <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
 <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
 <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
 <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
 <52159cae-2f95-45e4-85c5-14b36984039c@ventanamicro.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <52159cae-2f95-45e4-85c5-14b36984039c@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: f1132960-cfd4-47a8-0076-08dc4290a3e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8FRMZRtbzz9cBc2lMwzNwDBvUCMNai0WkH+h5RJdwv91AP33B6xRmbB4zfhIbBbTJBJD7sMkbXq/Ik7LXbPma+HYQDBeIKjsCrT4EJJNLU0d9HIKp14Fso6AieLVSi+sIFHwn3FAHkQxUK3Dk4wYW8dQyvbrWCe7X26+KLHqW2bAT14MYvNwsLL8W3UNi5kdmu5JuTjYPzg1aCN1WFR/rMudaokys9PQXXfHucPKP4CxcuTaRDoJSGwNwWL+vudVkkWzw1GWLNx71uEzrxc1V6gErs28659p7RHSIVf7tU4FRb0D7b00H2BTzQegGBXwJx3GvPQ4Ya66dR0iJBNS8ANQ+IsH30MN7pM/JZtkgsrNMVU1JtrvqTLHPF7LyDsiG9b0eHDiEyUpJ8XyxSdqUz4iMVrgWAJx7YaUdfNXzcMMYKnuhAIQkJujSOkzhzdCvRd/NMaX92GZ6uQTjyvxQbAyRwFjO6X4nUn9zb1N6GWmZILlu+22j9SksC4FdUbcB8brrTme9hsoNByFLyV8VfvDXOsHgQgY3cQC5meshJlt/V5V/O/7hgNl2ed1buTD7r+Kcuhb4/LS/LBPuXXVKBTmTVIrp5vtOcSiTRUhPYR/mpeAZT/wm3CPDwOHBFZBNjnUu9XZm3TYqOyu8DtxlthNgL2agKcF1HgShzz+y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JYR00zZU1rUU0ra3BvdENMYSs4SW1hM0tSaUE0SC9pbkhoM3VaeE5pVGVM?=
 =?utf-8?B?a1FyUVRmVlNzQ21GaUtHS0xNTUgyQ1BOUXhkYVRpNktSNTU5dVhqMnpxVERO?=
 =?utf-8?B?UjkzbkVqcGxNTnVkTmU2c0NsdTR5aG5uWVRHaWVjRmxNMmd1REROM0hJWTd4?=
 =?utf-8?B?Y0ZPamZndjJOd1BSQ25hdkluNDdpM2x3REZRTncxeTlFN0NRL1JrOTdxbU5x?=
 =?utf-8?B?ODZFMUw5aTYwVUdWYmMveUZaQVBaREFaWW9BeFNjYU1tTFZPdDFGTTl2eGlM?=
 =?utf-8?B?OG9kMjA2cDdWWnQ4RE0xQzdYcW5zTFdWT0t2Rk1KWGRIOTM2WW1EK0xHUm5R?=
 =?utf-8?B?dkM2dlo2WFhLTDU5MzJxSUd0bW1vYTN6SzlZYkp4bEtEajFOczVERWRyeFJp?=
 =?utf-8?B?V054b1ppZFdPbkVjRlhsbm1TUy9mN1dCQlZLQ3Yrc2M0RDNLaGc5ZnFXT1Vn?=
 =?utf-8?B?Qm9DcXh4TmVxVlVCQzRraklBa1ZjcHg4emkxM3dXSkViS0gydVZ6NDNyaTd1?=
 =?utf-8?B?cGgzZ3pGQ3JhN0Qwb3ZMakxVemh1WnNCU2pBSGRRelR2OU5kZEErZUpraGZY?=
 =?utf-8?B?YUFPb0ZFZTJLVUtCR0JaOXN5RzV6ZTZ3eEg5UStLMzRETUNaYUIzU2hCTFYw?=
 =?utf-8?B?cUI1NmhHSDZjYTVGcVlMLzRvRzVGWVpmN1BVT0FXcXEvNE51RVNGL1VKZ2I0?=
 =?utf-8?B?TXZwQzlPS1dKOFR1OGpXTitxM1Jqc3dpbHdObTBBdjFtWnJIQng3N3NpY2Vv?=
 =?utf-8?B?YzVRakxRZFVWcis4SjN3Q0VoK1BudTc2VXpwOUNtZjhCNDFhelhkS2dPU0lU?=
 =?utf-8?B?R0hwYnJJaHhIT1lKZFYzVFg2bkMzSDE3OTFuU2lOaWRnNDV3cE1ERmE5empw?=
 =?utf-8?B?clFieVVxRVRKRENjOHJNR1N1V2NkZW00cysxb051RXo4ZEtSazB3WVdNWnU0?=
 =?utf-8?B?RVJOd0dOZ0VFaEdIdkk1VlpiaHY1K01Fb21JaE05d3QwZjdNcWc3MXNpOXk5?=
 =?utf-8?B?aXRLbmh5V1p5ZmdHSytpbGNaUHBFdFg3ak15VDVYdzRaSWNnLzZyaEtKTTEw?=
 =?utf-8?B?SkFmKytKQWFKR0pObk9SMDBXai9JZ2N3UWs3bXNhSForenlwM3JWbGpxUXI3?=
 =?utf-8?B?cEkzSFZ3OU83SFhYOU9kenFINkVoL1VueWxzT3kwTFZiR24yNUlYUWdtY1pV?=
 =?utf-8?B?a2x0M3JhOHROcWxkKzBpci93WERybkFYdWcvLzZ4bUxJVm96KzBhN2xIUlFa?=
 =?utf-8?B?MGYzdlJidXlMQURwakVFKzJLaXhWaGhUSVQvVy9DNzRNZmRPSzh1SVNYSE8x?=
 =?utf-8?B?eU5rSzMrMjBVbzlHbllnN0ppTEovYytRZXI1WFdWcitVSHhSdWRVWGF5RHRl?=
 =?utf-8?B?MUQwZHAxQWMzUGlBQlpjQnJLYzBwZHZGMjZUQ1FDOTE0Vnlqai9xTkl6djkz?=
 =?utf-8?B?eWZ1RGFZdXFWOFd3ZUZ0eC9JNjlEN3dMY2h3RUVsNC8yaytHZmk5ZEJuaDUw?=
 =?utf-8?B?YUZ4NW9pUkJXR3V3UDZRNFRZOXViK29JdmthYkhMVTcrVkJHRDdRWWRpditG?=
 =?utf-8?B?bmZRNURuV2pWTHhHZFBIclM2czJGZzl4ZzhNeGFBL3JzQlk1UEpyVSs2VWJm?=
 =?utf-8?B?Q01KeXpnMkRBNkNzRFVodzN3RDNKR1lzTGFLMy9zSWZTLzF3THBDZ2h0SUtk?=
 =?utf-8?B?Y2lRQkVmaWhpOTZqSXA2TnFzV0FKMW9XVkk1ajQ5dkhYdzRCaVdhWGpoeFYz?=
 =?utf-8?B?dEI3cC9jbDFBSVMveWp1anRFSDFxQjlaYm1CcmJjTUJZaXdtZ0RDK0RCWEpW?=
 =?utf-8?B?SUhENWJhTnE0RW5QVURjWVZwa2pSTjlnTzBicjNESmxRMC9mSFE3OHo2Zlpl?=
 =?utf-8?B?ZU1YNmE3SnJoeENkdXM1YlBXVTM5RldZcHVFRFlsdGdWTzFPN2RiOUhEdUpn?=
 =?utf-8?B?b1hOdFcvbVIwak45UkVzRWpUcWI1VkpOUGMzSWZQQzhRTDFESkZvb1I4bzRp?=
 =?utf-8?B?eXVteGIrbDViUjJuL1lNQkt5VGE0aHJGOWZHSlRRZThwMU40cURpT1ZXRXZs?=
 =?utf-8?B?OWlmZjBWUVpuN0RZdU42a0syd1l4VXZMTzIrOExmeXRUMW9Za0dxV0RuVUU4?=
 =?utf-8?Q?IPBZ2C/HPqkDHe0q0QT5699Bn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1132960-cfd4-47a8-0076-08dc4290a3e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 12:33:37.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPi0EUM5IExaQMU4ptpg6ZeTTkHiAf4HLiqhYy/8syPApq1gDuir02QBP9wNO64Zcd+Yvb01rcpKOM6xbFq1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/8/2024 3:15 AM, Daniel Henrique Barboza wrote:
> 
> 
> On 3/7/24 04:36, Wu, Fei wrote:
>> On 3/6/2024 9:26 PM, Wu, Fei wrote:
>>> On 3/5/2024 1:58 PM, Wu, Fei wrote:
>>>> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>>>>
>>>>>
>>>>> On 3/4/24 07:25, Fei Wu wrote:
>>>>>> The harts requirements of RISC-V server platform [1] require RVA23
>>>>>> ISA
>>>>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch
>>>>>> provides
>>>>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>>>>
>>>>>> [1]
>>>>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>>>>
>>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>>>>    target/riscv/cpu-qom.h         |  1 +
>>>>>>    target/riscv/cpu.c             | 62
>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 68 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/riscv/server_platform_ref.c
>>>>>> b/hw/riscv/server_platform_ref.c
>>>>>> index ae90c4b27a..52ec607cee 100644
>>>>>> --- a/hw/riscv/server_platform_ref.c
>>>>>> +++ b/hw/riscv/server_platform_ref.c
>>>>>> @@ -1205,11 +1205,15 @@ static void
>>>>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>>>    {
>>>>>>        char str[128];
>>>>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>>>> +    static const char * const valid_cpu_types[] = {
>>>>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>>>>> +    };
>>>>>>          mc->desc = "RISC-V Server SoC Reference board";
>>>>>>        mc->init = rvsp_ref_machine_init;
>>>>>>        mc->max_cpus = RVSP_CPUS_MAX;
>>>>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>>>>> +    mc->valid_cpu_types = valid_cpu_types;
>>>>>
>>>>> I suggest introducing this patch first, then the new machine type that
>>>>> will use it as a default
>>>>> CPU. The reason is to facilitate future bisects. If we introduce the
>>>>> board first, a future bisect
>>>>> might hit the previous patch, the board will be run using RV64 instead
>>>>> of the correct CPU, and
>>>>> we'll have different results because of it.
>>>>>
>>>> Good suggestion.
>>>>
>>>>>>        mc->pci_allow_0_address = true;
>>>>>>        mc->default_nic = "e1000e";
>>>>>>        mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>>>> index 3670cfe6d9..adb934d19e 100644
>>>>>> --- a/target/riscv/cpu-qom.h
>>>>>> +++ b/target/riscv/cpu-qom.h
>>>>>> @@ -49,6 +49,7 @@
>>>>>>    #define TYPE_RISCV_CPU_SIFIVE_U54
>>>>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>>>>    #define TYPE_RISCV_CPU_THEAD_C906
>>>>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>>>>    #define TYPE_RISCV_CPU_VEYRON_V1
>>>>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>>>>> +#define TYPE_RISCV_CPU_RVSP_REF        
>>>>>> RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>>>>    #define TYPE_RISCV_CPU_HOST            
>>>>>> RISCV_CPU_TYPE_NAME("host")
>>>>>>      OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>>>> index 5ff0192c52..bc91be702b 100644
>>>>>> --- a/target/riscv/cpu.c
>>>>>> +++ b/target/riscv/cpu.c
>>>>>> @@ -2282,6 +2282,67 @@ static void
>>>>>> rva22s64_profile_cpu_init(Object *obj)
>>>>>>          RVA22S64.enabled = true;
>>>>>>    }
>>>>>> +
>>>>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>>>>> +{
>>>>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>>>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>>>>> +
>>>>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>>>>> +
>>>>>> +    /* FIXME: change to 1.13 */
>>>>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>>>>> +
>>>>>> +    /* RVA22U64 */
>>>>>> +    cpu->cfg.mmu = true;
>>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>>> +    cpu->cfg.ext_zicsr = true;
>>>>>> +    cpu->cfg.ext_zicntr = true;
>>>>>> +    cpu->cfg.ext_zihpm = true;
>>>>>> +    cpu->cfg.ext_zihintpause = true;
>>>>>> +    cpu->cfg.ext_zba = true;
>>>>>> +    cpu->cfg.ext_zbb = true;
>>>>>> +    cpu->cfg.ext_zbs = true;
>>>>>> +    cpu->cfg.zic64b = true;
>>>>>> +    cpu->cfg.ext_zicbom = true;
>>>>>> +    cpu->cfg.ext_zicbop = true;
>>>>>> +    cpu->cfg.ext_zicboz = true;
>>>>>> +    cpu->cfg.cbom_blocksize = 64;
>>>>>> +    cpu->cfg.cbop_blocksize = 64;
>>>>>> +    cpu->cfg.cboz_blocksize = 64;
>>>>>> +    cpu->cfg.ext_zfhmin = true;
>>>>>> +    cpu->cfg.ext_zkt = true;
>>>>>
>>>>> You can change this whole block with:
>>>>>
>>>>> RVA22U64.enabled = true;
>>>>>
>>>>>
>>>>> riscv_cpu_add_profiles() will check if we have a profile enabled
>>>>> and, if
>>>>> that's the
>>>>> case, we'll enable all its extensions in the CPU.
>>>>>
>>>>> In the near future, when we implement a proper RVA23 support, we'll be
>>>>> able to just do
>>>>> a single RVA23S64.enabled = true in this cpu_init(). But for now we
>>>>> can
>>>>> at least declare
>>>>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>>>>
>>>
>>> Hi Daniel,
>>>
>>> I'm not sure if it's a regression or the usage has been changed. I'm not
>>> able to use '-cpu rva22s64' on latest qemu (db596ae190).
>>>
>> I did a quick git bisect and found that commit d06f28db6 "target/riscv:
>> move 'mmu' to riscv_cpu_properties[]" disabled mmu by default, so that
>> an explicit mmu option should be added to qemu command line like '-cpu
>> rva22s64,mmu=true', I think rva22s64 should enable it by default.
>>
> 
> This is fixed in alistair/riscv-to-apply.next by this commit:
> 
Hi Daniel,

The following still doesn't work for me with this commit (already
upstreamed now)

  RVA22S64.enabled = true;

cpu_set_profile() does nothing for vendor cpu as it checks
riscv_cpu_is_vendor() at the beginning, and it's still not working even
if it's removed. I think rvsp-ref is supposed to be
TYPE_RISCV_VENDOR_CPU, changing to other type such as DYNAMIC doesn't
work either, how to make this work?

Thanks,
Fei.

> commit 5b8d66e6bf7904535ee277e9c70b332c4462f10a
> Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Date:   Thu Feb 15 19:39:50 2024 -0300
> 
>     target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
>         Recent changes in options handling removed the 'mmu' default the
> bare
>     CPUs had, meaning that we must enable 'mmu' by hand when using the
>     rva22s64 profile CPU.
>         Given that this profile is setting a satp mode, it already
> implies that
>     we need a 'mmu'. Enable the 'mmu' in this case.
> 
> 
> 
> Thanks,
> 
> Daniel
> 
> 
>> Thanks,
>> Fei.
>>
>>> -- latest qemu, cannot see linux boot message and blocked
>>>
>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>    -cpu rva22s64 \
>>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>    -kernel $Kernel
>>>
>>> Boot HART ID              : 1
>>> Boot HART Domain          : root
>>> Boot HART Priv Version    : v1.12
>>> Boot HART Base ISA        : rv64imafdc
>>> Boot HART ISA Extensions  : time
>>> Boot HART PMP Count       : 0
>>> Boot HART PMP Granularity : 0
>>> Boot HART PMP Address Bits: 0
>>> Boot HART MHPM Count      : 16
>>> Boot HART MIDELEG         : 0x0000000000000222
>>> Boot HART MEDELEG         : 0x000000000000b109
>>>
>>> -- latest qemu, w/o rva22s64, looks good
>>>
>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>    -kernel $Kernel
>>>
>>> Boot HART ID              : 0
>>> Boot HART Domain          : root
>>> Boot HART Priv Version    : v1.12
>>> Boot HART Base ISA        : rv64imafdch
>>> Boot HART ISA Extensions  : time,sstc
>>> Boot HART PMP Count       : 16
>>> Boot HART PMP Granularity : 4
>>> Boot HART PMP Address Bits: 54
>>> Boot HART MHPM Count      : 16
>>> Boot HART MIDELEG         : 0x0000000000001666
>>> Boot HART MEDELEG         : 0x0000000000f0b509
>>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>>
>>> -- commit dfa3c4c57, patch to enable rva22s64, looks good
>>>
>>> $Q -machine virt -nographic -m 2G -smp 2 \
>>>    -cpu rva22s64 \
>>>    -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>>>    -kernel $Kernel
>>>
>>> Boot HART ID              : 0
>>> Boot HART Domain          : root
>>> Boot HART Priv Version    : v1.12
>>> Boot HART Base ISA        : rv64imafdc
>>> Boot HART ISA Extensions  : time
>>> Boot HART PMP Count       : 16
>>> Boot HART PMP Granularity : 4
>>> Boot HART PMP Address Bits: 54
>>> Boot HART MHPM Count      : 16
>>> Boot HART MIDELEG         : 0x0000000000000222
>>> Boot HART MEDELEG         : 0x000000000000b109
>>> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
>>> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
>>> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
>>>
>>> Thanks,
>>> Fei
>>>
>>>> Let me try.
>>>>
>>>> Thanks,
>>>> Fei.
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Daniel
>>>>>
>>>>>
>>>>>> +
>>>>>> +    /* RVA23U64 */
>>>>>> +    cpu->cfg.ext_zvfhmin = true;
>>>>>> +    cpu->cfg.ext_zvbb = true;
>>>>>> +    cpu->cfg.ext_zvkt = true;
>>>>>> +    cpu->cfg.ext_zihintntl = true;
>>>>>> +    cpu->cfg.ext_zicond = true;
>>>>>> +    cpu->cfg.ext_zcb = true;
>>>>>> +    cpu->cfg.ext_zfa = true;
>>>>>> +    cpu->cfg.ext_zawrs = true;
>>>>>> +
>>>>>> +    /* RVA23S64 */
>>>>>> +    cpu->cfg.ext_zifencei = true;
>>>>>> +    cpu->cfg.svade = true;
>>>>>> +    cpu->cfg.ext_svpbmt = true;
>>>>>> +    cpu->cfg.ext_svinval = true;
>>>>>> +    cpu->cfg.ext_svnapot = true;
>>>>>> +    cpu->cfg.ext_sstc = true;
>>>>>> +    cpu->cfg.ext_sscofpmf = true;
>>>>>> +    cpu->cfg.ext_smstateen = true;
>>>>>> +
>>>>>> +    cpu->cfg.ext_smaia = true;
>>>>>> +    cpu->cfg.ext_ssaia = true;
>>>>>> +
>>>>>> +    /* Server Platform */
>>>>>> +#ifndef CONFIG_USER_ONLY
>>>>>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>>>>>> +#endif
>>>>>> +    cpu->cfg.ext_svadu = true;
>>>>>> +    cpu->cfg.ext_zkr = true;
>>>>>> +}
>>>>>>    #endif
>>>>>>      static const gchar *riscv_gdb_arch_name(CPUState *cs)
>>>>>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[]
>>>>>> = {
>>>>>>        DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,
>>>>>> rv64e_bare_cpu_init),
>>>>>>        DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,
>>>>>> rva22u64_profile_cpu_init),
>>>>>>        DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,
>>>>>> rva22s64_profile_cpu_init),
>>>>>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,
>>>>>> rv64_rvsp_ref_cpu_init),
>>>>>>    #endif
>>>>>>    };
>>>>>>    
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#135):
> https://lists.riscv.org/g/tech-server-soc/message/135
> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
> Group Owner: tech-server-soc+owner@lists.riscv.org
> Unsubscribe:
> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 



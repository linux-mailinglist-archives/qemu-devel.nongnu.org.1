Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22076D52A
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 19:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRFbb-0004ol-NG; Wed, 02 Aug 2023 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRFbZ-0004o0-41
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:25:49 -0400
Received: from mail-dm3nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::603]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRFbW-0008Ab-3Y
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjXsp5cO6LvnHbN8JoaT/qQTL+HcxV/J1iTXWRJ5b2mpAhRjHa0WkJmsoMiyN6EfWGnkPwspZNXgN1mATuAFyHvMtPaEATDDJL5knrKawTnxOC00cYzd7RwuPjLroKwuPEgm1pf6B/DRtG3WkkiknXRKgTnaUpnLQe3cv2zcgGMU7YOfw6Fn6bav+hyNMqlTBGYL10/daH8rclrzM2T0mf48j/hI1jdBLFKMeyj5vI+wzqsXmUDmwEYgOZd7+G1pC80DA1Ef8YQa6cuXhLpKHqPXHOpzLbBFwqoJtFpP+5/MtmRPX92GHaRQPUsU6RsKQaArghrFRLJIKSF8bXuEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ6PzA9h/PZ7SdR7VybrYYhmv0UIzGQicbNkDYoXRSA=;
 b=aSz/Iqt78dg9S0qnfUTxkHfZryvfuba9CabNfz3Rm/RSgse1z6rCqN70cZ9yUTgZ/H0VBwjZ59DVDk80hfeozToL/VNAq4AzBjasDZQlJGs3oqkfN0HMLBl+DlJ7FnsOlvpoeHqo0jumP9m7yqLGaJhHUQkfoB87+71UKx8Wy/t5TCwlR2WWLXXfZv4NGLtRVqxdLKcL78nYMvtE2pLwNRPz6336cA8OWmEciH7Qe8fq04izQAwRH7+2bxKuJAKoTXA7VLo2xs6UQIK33a80LW6zxT58Z9U25VIXpo+XomU1gCDZqTsrJd2eIMC1Bf9b+mPQsmq/pH+3R1N+/wBybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ6PzA9h/PZ7SdR7VybrYYhmv0UIzGQicbNkDYoXRSA=;
 b=ikp1pkATWBXvYKXs5BskH1YYEWTYqLMVcvmeoQkYgGEQSGuxUu+sk7+F94bVmrUR48AiW4FfwUfvWAuPhVTy0adOzuKTD35ZdtHmh7GlyN0vMUeQBzzPOBPGgRbDWYQvtGv66buz10T4TqwPr3nHpls45Oaai6wrXwvK20uAUd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:25:41 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 17:25:41 +0000
Message-ID: <cc472f47-2cb0-3cb8-f4c4-6f6db7bea782@amd.com>
Date: Wed, 2 Aug 2023 12:25:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/17] i386: Support modules_per_die in X86CPUTopoInfo
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-9-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-9-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf2999d-c00b-4dfa-5079-08db937d6b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8f271Fn2s8/QOToBCovqO3CRMdg3SUjmajzQv9AgPFOS8l1Fq2etY0ddaoGaiRJ2DoNmV1ImZ7PAd+SRUYZtMJ10WZvpaSRm/gU5N55DItg76NFWUeZ/qNNRECbkaTDJoGBj8lvdrtZNrbGaZKH7oCf7OSSXChY2xFk9zkxx3F1jKKk8l2zWGe3vODevMJq+0F0w86qSXrb8cp/2zxHREYSmP2LE9dwtPYFAhP4CwqqvopMM7W08DPnjUGBnWI7tdGapMvA7JLQr1Bm8f+VuFLI6XEYBiMeXFXgbgI5ayCG4CGKjuzNN39zO398G69sAQTmhNQhxLe1LcoYkxua7Omgoq4NCdUWji4N4gxADUiSIxdFhqsBoqlLD8ZabIPTFAyoo/xtMWveJP/2jeNz5/+ZAP9KRSrsmzHTE+khYUG0WmeyniaCPlV7Ni4wQZkhs7cc8K370utmE6nezD2HcYRGiTMDobitIUXXp0tnASY3ymsxJ1t8q+UcWgsTou1yaL2PO2PnMX6cwbsnjFTp2OTyuLOXxuccnHzVgXbTsnprw1iS8kFIy7yjzh/yqCJqJO/bsPgDoY8qNUsMPoC2FVSl3JzynO33Kaj62OrYNhsG8i7VyX22UKBPl+YQhnXe/3Jd8c7z8RkOyW3Tnot9ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(2616005)(53546011)(186003)(83380400001)(26005)(6506007)(41300700001)(30864003)(4326008)(3450700001)(66946007)(2906002)(66556008)(66476007)(5660300002)(7416002)(8676002)(8936002)(6486002)(316002)(6666004)(6512007)(54906003)(110136005)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0E0RXpINjk1bHdBWFRZbjUzQnRIY2lNS3RrNTBDak54NGUybHRtbUpsSERx?=
 =?utf-8?B?Nkk0RFFXNlNXc25teW5zdGNxS29JcDhzTWZybmhoTFNEOUIrRi9mdWNJd0Zn?=
 =?utf-8?B?OElBVmVJL2NXaXNiT2pnSmJGenFETmQ2M2RUTHloWStrWmlVZWl4aWVITHNK?=
 =?utf-8?B?RWZDb2Q0QXZMYjVJcjA1cldLVWR5WmYrM3BqZ0RZRHpaT09MdFlkMWp1MXVX?=
 =?utf-8?B?V3g0WEdYS0NZcTNNeGh4TVBUUXRGbWdmMGw4RGVtM2lIMEFJckVCVDdBdnFn?=
 =?utf-8?B?Q2V0VktvNzVING0yRm1kWDhSMmZscWFvdGFEL01BY0wxa3BvWGdRS1hyb3Bh?=
 =?utf-8?B?eG1QS2IzbVJSVTFFVFdVMm54NTJsMFZxajRsV0g5VXAvRU9yejFBQmw4aTV6?=
 =?utf-8?B?Nm1ycm5DOHd6amNGMkRWdWNzdEhFUTdQNzdncFBPbjIyME5XdGpTaVhwTVY5?=
 =?utf-8?B?ZnVTMHhUalAvakpaKzh1V2tteUxGZTVTRFBpVzRHNUtGUnN3VGVYUGZ2NWdO?=
 =?utf-8?B?ams3c21IZkc1cWc5UUhtRTlMeWFGNHJMVVlBT1A3ZU94SWRSREtkRzFKUEc3?=
 =?utf-8?B?NHpSSE5KYjJEYWluVVpTQ2R1YTlWVGdCOWJSVDVKL1ZBSGVwNzRPd1JHVjdI?=
 =?utf-8?B?d0ZJU1pqVWFDeDY0S0lzOHc0MnFpN2phSGVUSk5nK3hnTVpBVS8yckpvRy84?=
 =?utf-8?B?cWx3SVd2VVNZaHhxa2hwSFRUWlhSZTdNajdUUGsySjZsM1Mxall6SzcxQzJy?=
 =?utf-8?B?TkFaNmNFQzBzRnZONU5uQkVLSkVRWUFyRVFXdFVDTmRZbGdDajMyYis0eHBQ?=
 =?utf-8?B?eCsrSjlLdzVOWWt3ZnljelUyZTF2dmRvQmtzakR4d1NnWXI5Ny9yNlN3WFdB?=
 =?utf-8?B?UzFuV1EwNmVBZWtkR0phT1p6ejR5R0pzSlgxZ2ZnZkE4VDhYS1FmWkdZWmo3?=
 =?utf-8?B?bW44SHU4SzQvcml2NDZUZEQ3amxQMlZhQzNGRVBhbjh2b2ppRGhGYVR4Ulho?=
 =?utf-8?B?QVpkMUtPK05qMldYdm9ndzBUZXR6UnJ0ZVp1elljMk1teGlpTGl2c0laa3di?=
 =?utf-8?B?SFo5eHVneDVsNjJBUXptUVg1cU56NzlUWkZlcmVVWVhkK1Ezc1dYYnlkQXdn?=
 =?utf-8?B?b0tpb0ptdjE1WUZPekF1dkJoNzJHdFFGRm9jaXdWMlExUWJxb2ViWVlKOFdO?=
 =?utf-8?B?L0JVbGpWbCszQk9NSFRud3JpTTNjcWNRcVg1RW5aYUh6d0YzME4vNzc3N3RP?=
 =?utf-8?B?V2Q5L2l5T0hPYi9wSWh0UDBnbGQ3VXdnUGlWY0RkUWxWMlEwRmZpU0UzZnZz?=
 =?utf-8?B?aE44VXhncFI4R2pyTkEwUVFRSmRrSTRUbkNjNEthbnZDUGtSaExGNW91eEFQ?=
 =?utf-8?B?SDVWT3c5SGYwTkN3TTh0MHBxcUJPLzJZYmkwR1h2cFh4VWVqVW9SQ3YzSHZ6?=
 =?utf-8?B?RzFrNmNzWG1GaGlxd2ZaUEZ2aU95RlNjbmlSUUZGdTJaZVdOakZyeFRVUGtT?=
 =?utf-8?B?RU8zbGFWTTFmd2NGRStWYkp4Um5oL2NEbTVnQ3lzc05XeEVKbG9wd254TExw?=
 =?utf-8?B?dG8zR3gvTVptVWdmSURnZjlLSkYwZjBRSmp5c2NRYUprajJqc0l5djAvNGd2?=
 =?utf-8?B?TGpsSUN4UWx2VWV4SGtLV0RrdGlxUGlxZXdPRU15WHlpd2tJS3ZHMjFWTWJ6?=
 =?utf-8?B?S21ISFd5SWpxNVkyZDBvQ3RFYkw2MmczOWl0V1A2VkJESVk5cGI1MVNsaTFJ?=
 =?utf-8?B?dDZDZ1k5dzJ4dEpxSnc2c09uVGduQlE5cjJKNEhKWHg3Vks2ZSttOGVzdzgw?=
 =?utf-8?B?THVzTjhWUDlKWlpXWVVXUk9YZEtFcG5UbmlmTDBaTDdPOWtCYnhhcm1IV3Ax?=
 =?utf-8?B?L3JLbm1oUTd4MzdTK052SVRaMUpYN3A3NHlSU2NldHQzbTRqaXorQjlvbmFh?=
 =?utf-8?B?L1VyRk80S3VIQWtBcm5DM0xFdXhWc0h3QzV1OHdpajVpelBHOUFHS2tFSEhm?=
 =?utf-8?B?ZEFVVTBtUHBZa3VjK1dLM0dIa1RSNDE1VzFUb1lPbVZQNDZtdE1hNjFBa1A5?=
 =?utf-8?B?ckN2VHdkdHQwL1hickpOQ0YxbTluQWxDNWZQMVdvM0RFbzZrRTRZcXN3L1I0?=
 =?utf-8?Q?KSfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf2999d-c00b-4dfa-5079-08db937d6b5e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:25:41.4072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRD+ru+bvIr/wRpVoYVmK5+j/Dg95AkaL9lzBxJfSoSE+/Z85I55BTi0F7LaJkH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
Received-SPF: softfail client-ip=2a01:111:f400:7e83::603;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
> Support module level in i386 cpu topology structure "X86CPUTopoInfo".
> 
> Since x86 does not yet support the "clusters" parameter in "-smp",
> X86CPUTopoInfo.modules_per_die is currently always 1. Therefore, the
> module level width in APIC ID, which can be calculated by
> "apicid_bitwidth_for_count(topo_info->modules_per_die)", is always 0
> for now, so we can directly add APIC ID related helpers to support
> module level parsing.
> 
> At present, we don't expose module level in CPUID.1FH because currently
> linux (v6.4-rc1) doesn't support module level. And exposing module and
> die levels at the same time in CPUID.1FH will cause linux to calculate
> the wrong die_id. The module level should be exposed until the real
> machine has the module level in CPUID.1FH.
> 
> In addition, update topology structure in test-x86-topo.c.
> 
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
>  * Include module level related helpers (apicid_module_width() and
>    apicid_module_offset()) in this patch. (Yanan)
> ---
>  hw/i386/x86.c              |  3 ++-
>  include/hw/i386/topology.h | 22 +++++++++++++++----
>  target/i386/cpu.c          | 12 ++++++----
>  tests/unit/test-x86-topo.c | 45 ++++++++++++++++++++------------------
>  4 files changed, 52 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 4efc390905ff..a552ae8bb4a8 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -72,7 +72,8 @@ static void init_topo_info(X86CPUTopoInfo *topo_info,
>      MachineState *ms = MACHINE(x86ms);
>  
>      topo_info->dies_per_pkg = ms->smp.dies;
> -    topo_info->cores_per_die = ms->smp.cores;
> +    topo_info->modules_per_die = ms->smp.clusters;

It is confusing. You said in the previous patch, using the clusters for
x86 is going to cause compatibility issues. Why is this clusters is used
to initialize modules_per_die?

Why not define a new field "modules"(just like clusters) in smp and use it
x86? Is is going to a problem?
May be I am not clear here. I am yet to understand all the other changes.

Thanks
Babu

> +    topo_info->cores_per_module = ms->smp.cores;
>      topo_info->threads_per_core = ms->smp.threads;
>  }
>  
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 5a19679f618b..c807d3811dd3 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -56,7 +56,8 @@ typedef struct X86CPUTopoIDs {
>  
>  typedef struct X86CPUTopoInfo {
>      unsigned dies_per_pkg;
> -    unsigned cores_per_die;
> +    unsigned modules_per_die;
> +    unsigned cores_per_module;
>      unsigned threads_per_core;
>  } X86CPUTopoInfo;
>  
> @@ -77,7 +78,13 @@ static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
>  /* Bit width of the Core_ID field */
>  static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_bitwidth_for_count(topo_info->cores_per_die);
> +    return apicid_bitwidth_for_count(topo_info->cores_per_module);
> +}
> +
> +/* Bit width of the Module_ID (cluster ID) field */
> +static inline unsigned apicid_module_width(X86CPUTopoInfo *topo_info)
> +{
> +    return apicid_bitwidth_for_count(topo_info->modules_per_die);
>  }
>  
>  /* Bit width of the Die_ID field */
> @@ -92,10 +99,16 @@ static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>      return apicid_smt_width(topo_info);
>  }
>  
> +/* Bit offset of the Module_ID (cluster ID) field */
> +static inline unsigned apicid_module_offset(X86CPUTopoInfo *topo_info)
> +{
> +    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
> +}
> +
>  /* Bit offset of the Die_ID field */
>  static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
> +    return apicid_module_offset(topo_info) + apicid_module_width(topo_info);
>  }
>  
>  /* Bit offset of the Pkg_ID (socket ID) field */
> @@ -127,7 +140,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
>                                           X86CPUTopoIDs *topo_ids)
>  {
>      unsigned nr_dies = topo_info->dies_per_pkg;
> -    unsigned nr_cores = topo_info->cores_per_die;
> +    unsigned nr_cores = topo_info->cores_per_module *
> +                        topo_info->modules_per_die;
>      unsigned nr_threads = topo_info->threads_per_core;
>  
>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8a9fd5682efc..d6969813ee02 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -339,7 +339,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>  
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_threads = topo_info->cores_per_die * topo_info->threads_per_core;
> +        l3_threads = topo_info->modules_per_die *
> +                     topo_info->cores_per_module *
> +                     topo_info->threads_per_core;
>          *eax |= (l3_threads - 1) << 14;
>      } else {
>          *eax |= ((topo_info->threads_per_core - 1) << 14);
> @@ -6012,10 +6014,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t cpus_per_pkg;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
> -    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
> +    topo_info.modules_per_die = env->nr_modules;
> +    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
>      topo_info.threads_per_core = cs->nr_threads;
>  
> -    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
> +    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
> +                    topo_info.dies_per_pkg;
>      cpus_per_pkg = cores_per_pkg * topo_info.threads_per_core;
>  
>      /* Calculate & apply limits for different index ranges */
> @@ -6286,7 +6290,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          case 1:
>              *eax = apicid_die_offset(&topo_info);
> -            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
> +            *ebx = cpus_per_pkg / topo_info.dies_per_pkg;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          case 2:
> diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
> index 2b104f86d7c2..f21b8a5d95c2 100644
> --- a/tests/unit/test-x86-topo.c
> +++ b/tests/unit/test-x86-topo.c
> @@ -30,13 +30,16 @@ static void test_topo_bits(void)
>  {
>      X86CPUTopoInfo topo_info = {0};
>  
> -    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> -    topo_info = (X86CPUTopoInfo) {1, 1, 1};
> +    /*
> +     * simple tests for 1 thread per core, 1 core per module,
> +     *                  1 module per die, 1 die per package
> +     */
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>  
> -    topo_info = (X86CPUTopoInfo) {1, 1, 1};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> @@ -45,39 +48,39 @@ static void test_topo_bits(void)
>  
>      /* Test field width calculation for multiple values
>       */
> -    topo_info = (X86CPUTopoInfo) {1, 1, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 2};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {1, 1, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {1, 1, 4};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 4};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {1, 1, 14};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 14};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {1, 1, 15};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 15};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {1, 1, 16};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 16};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {1, 1, 17};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1, 17};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
>  
>  
> -    topo_info = (X86CPUTopoInfo) {1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {1, 31, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 31, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {1, 32, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 32, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {1, 33, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
>  
> -    topo_info = (X86CPUTopoInfo) {1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> -    topo_info = (X86CPUTopoInfo) {2, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {3, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {4, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
>  
>      /* build a weird topology and see if IDs are calculated correctly
> @@ -85,18 +88,18 @@ static void test_topo_bits(void)
>  
>      /* This will use 2 bits for thread ID and 3 bits for core ID
>       */
> -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
>      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
>  
> -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
>                       (1 << 2) | 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,

-- 
Thanks
Babu Moger


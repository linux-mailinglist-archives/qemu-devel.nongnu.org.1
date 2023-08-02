Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B4476D266
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDyh-0007em-C2; Wed, 02 Aug 2023 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRDye-0007eL-AJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:41:32 -0400
Received: from mail-dm6nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::626]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRDyc-0002Eh-57
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV0o1vGwQT+nau5OgIJb7MV2e5WD2xmhg4Y2tFzfmfEoKDpNBfJ3cRDM4kgPqfz67+QWM45Hu0NlGr+A9J3os5jXj4G6xt6Hv2Jj3VZBrAssDbpm47ik8LruPum/VgxWxqjqqceDAud1v/X9pxYfOR7WcFMLOphugfU28DFrbXRnbtqKtVblWjr+9OC7jtdzcugam/WPHNUnG4FRk79Qh4OpryjupbxlPmI7Aogm2pD2jyyN8kRu2vj6GG5/uDHsX9bDnYR7ti5rx9Nx6YTEUDJ2FzO1z7uhKspcbQIIOquWfL9i+xFLicUMSwuIVFS0IM3f0p//O1dNnAbyGamLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrJunMQsUiN0ygMUS5Utn0JVaiyty0XXN6wkHvBsjMo=;
 b=Os4A1a04D7ecLpUMgXF/2HhEatj3PzzGpoYvaJT5NxRYJWh4QUEklPMlMHSSdatKPhrVghCBmPw/ELN9RHfzmPuw4AwDkZT/yYzfDywqQhvxVjIksK2GatZACiZgosRmvQzO4QYl1kMEIHUS0hC6PHP5ZHVllz56pDSEmrV5yRk5+/lUPzY+T5OSFfE53Q/aDi8NOZRNMC/gXDjyh606IWdlBKM8EniWZ0TqqiC45yBRo8Z62pqQ95zsovjuhqIeVI9rXlIOWSYR2GGXcJoFDPEfXv7LJtSMMdLlPv4XqbAOl2zvj01ybSNgF3BIZ6wgC1ziikA4rojbfvCc9Mt0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrJunMQsUiN0ygMUS5Utn0JVaiyty0XXN6wkHvBsjMo=;
 b=Tf8omo4oSopLZUEuA3Wilw15TH1ErognZSCqS2f07Bdg9ozE4FM86A+RRLwwfuZQgF6LEiRdKQhbSSKHYGzVekneSQWcGDZWuyJlKxLYSeAJaVSQ6cZFdWRb4+TrOATm9A6AF/7uhy9ShY75O8iXaFNyNYkOSsnuFd1c5zooLls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 15:41:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:41:19 +0000
Message-ID: <39c38442-cabf-985c-6125-5d0b3583de58@amd.com>
Date: Wed, 2 Aug 2023 10:41:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/17] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
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
 Robert Hoo <robert.hu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-6-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-6-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0197.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: e0115233-7663-4102-ae17-08db936eeab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rtx1QWnbJ+60dkghnbRBExMwOu93QGFAOVov7GcAlBw2KHvuRPGh9ibHem+70XXFY+hBK21DEV3BmPmoG4UyFx5n1Y73/idGrtKpiOf00UPf065Vbad2M0orK61jKJQMpSF8HmQPgqZcMXtT7qYeKWN6R++bLG9Sui5dN/BFuUDPTleOFUGkyPWqKEfRPFD1soc4GgwnRbQ0DPSs0eC2KOiGWStnMYt4l/96G1xp0N7+i104dWaYasdd7oFmhVtlR2L5hDd2+uLYts/5H7FQ2MsFCSpK3rZ2r5LoX5LcW3Sqq3jnJE000Pau4QWPJSv+YmhbpMj/G+yI+Ig1E637DFiv1eZrZ1lwSpofyb+VuEF+7pI6OAUJRCG4gcr5vXUpZLFC++jDWBLPj+Gg4aHkvWGRjh5JX8+dzIZQuLccTEVXKsMd+vGhxrgBQ9iLSUgo3OyNCOi+p5oFtLKFPy4J7N7qH+EHb1aapcaECpNw+VVl9PMF4FyHh0zA98S0cLqAzqeKEGwwhy9JFcGoIc3xvB+Rt3+mFax4EhZxqfSbFfe3AAlt5X6D2YMxyq/Wcb+kxli73jqlk0cSQ9Z6JsLafssPNY2y4lLj7kjNYSbt2s7Xrmq38N87nMJ/qYogKgUf4edG4qqjtgX5ip9OEYlBVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(53546011)(186003)(26005)(83380400001)(6506007)(3450700001)(316002)(66946007)(2906002)(66556008)(66476007)(5660300002)(4326008)(7416002)(41300700001)(8676002)(8936002)(6486002)(6512007)(54906003)(478600001)(110136005)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlJaTlqWjJQdHpLUlVJWGNBRXNSb1RzcERYaldKZ3Y2RzZ0T1Y3OXRJK25J?=
 =?utf-8?B?eG5iWTNwN3Fmc3Z0YnRGbGZQeGsveTBoaUthdUp0bTBsaS9KQmRQMnhDazY1?=
 =?utf-8?B?dWoxZTZ0ZFBuU1VOR01KVzhQWjRuVG1ZQWVBdGhxYW1KWERFMmx4QkNPRy9i?=
 =?utf-8?B?SW9GdW5UdHA3UjNpTWQ4czU2MHRuTHdkL21GT3ZPNnNMa2dpQzA4K3BWRFdo?=
 =?utf-8?B?QkF4VW5mcDFPMzQ1dWkwV0pidG9XYkZYUVA4RVMwa2QxRDhJRTFId014UFJX?=
 =?utf-8?B?VkpJZTUrTExUaDlDQnhGN3puU3g4aHMvWHR6eWlLSTBVNHdkNVlCMFFkUXpj?=
 =?utf-8?B?dDRGcUxZVDhjcFNWcDZaRWpWdnZXWDlPdGVkSUVVTVoyTkF2UWdnVFAzcDRj?=
 =?utf-8?B?TVk2QXRmVHZiaUdDU09iREwyazZaaGJXa3VCeVFZZVJaMWl2WHdDbVdpVkw1?=
 =?utf-8?B?QlpwS00xR3RvcjBNbVFGc3plVmQzNXVOYmRwcnJoTGxIZUI0Tzg2b25rQ2F0?=
 =?utf-8?B?VXhIR2l1NytsOGhRUjA0Y1NXZHBPUjBLRmhoaThLRmIzSlFPWkU1dnNYMEc3?=
 =?utf-8?B?OG50Y2NzdkdQRldJWXlMbmxZek1vY0hrc3g4cXFLMjdQeTlnbVQ4TUc2ZGVF?=
 =?utf-8?B?Q21EMkpGM0FXOXFkc1lEeS9oMC8xRy9LSTJpUVJBMFd3eGlTT1hRUHJIcUxi?=
 =?utf-8?B?cExNV3Bkd1BIYkZGRkxCOVhCVWZvRWtvSFJiZFg3d0ZLTkxScjJTVVBNdzZ1?=
 =?utf-8?B?TE8vemlOSHF1MFBPU2RoS2s1dDlJOVorenozTk8wMnFNL3VROWNjSkVrK3FL?=
 =?utf-8?B?SVF5c1FhMTFUaEdLK3FCNVFoU2FZN1ZlcndhaU1LcUJ3b1NNWE1FZmJNVnF6?=
 =?utf-8?B?WlptOC9xKzdxUis5ejZLNVlUU09RUGNGakFTUUdoaCtuZE1PYlAxWTRWNkx5?=
 =?utf-8?B?V2NaQUtiUlJ0R2JCUWJFRTcwRVAxME9JL3JmTlBLRENUQnlPamhEcHcxNDly?=
 =?utf-8?B?aDc2QTlkN1laOC9sbjYrMDV3Q2FCNU1PVmp5WVpOTS9XUFY2a1BOQ1g3OVRk?=
 =?utf-8?B?b2dpVmZFRUJLZHdWV1lCeHlpWVhlZVdlemh4dnljUjNIaTI0aDBHSXB6SUFq?=
 =?utf-8?B?WGhvV25uQkx1MG0xWGM5Q0JBeFhtVGxTRDNzRlhOQThZT0VxczArZDZEMFg2?=
 =?utf-8?B?RCt3V1FLa3B4NXRXMWtxMCtiNjlDOXV5bG1mQkxFY2pKUU1ydTJ1RWhvZzY2?=
 =?utf-8?B?WDV2b29UZ2xhd1VhM2N1SXM2cEpUMlRQODNSNXhPNXNmaldLclllL3I5TUlo?=
 =?utf-8?B?SHcrN3RWZ2RuZjRGem10TmZ4eHR2c1hNUkxoc205Y0NJbUQzZldjNVdFL1cy?=
 =?utf-8?B?MGFqemgrb2daK05yMHlqYjVVNnQ1WWdBeEdQMGpsVGlhRXpNa1NDVE1NNklP?=
 =?utf-8?B?djhaY0FQWVpDZkJKdnY3ZExkU3pieTBVWm5PQWhvVWtZV3RsNEVyRlZlM0tQ?=
 =?utf-8?B?MFlSQXE4Q1FYV0N1M3JCR3JQYWN3bzhBOHo5RnE1Nk9DbU05NCtBWldjSlcw?=
 =?utf-8?B?VEUrMTloUm92d0pkd3V4NVRPeHUvMGs5UTAzNFhObHppakY1ckE3YzhmdS9G?=
 =?utf-8?B?NXpSZUhRdkc5emUrem5zbFVoS2ZSVDltQ0hXN3NsRU16RHpzMlVpc29GdUZv?=
 =?utf-8?B?YnprdmtaT2I5ZmZtQlg5cUh2bzFrcjZOd3dEMU1adGFrV3RtV3RJZ2xrRWFX?=
 =?utf-8?B?bElVUEJIZkFUNFlEWVNyRkpNT3QxRVhxUXlpNVdZdTc0R3lWNlcrN0pKVThQ?=
 =?utf-8?B?QlJ3WXZ4eG1jS0Q0dlZ2dDZSaTR6TndEN2J6WldCODRCd1RXekswQmdCdTZ6?=
 =?utf-8?B?M3JNRFB5UThrRlZLbCs4azcyYnlQVXJ4U0hjSHVySzdMTkZSejk4d1Z2VTJE?=
 =?utf-8?B?MEJzbWZ4V25RdWZRcHgzdkpJRlQxZ2NZRmNFcFhCL2hoc3M2b08yVUJoS0RZ?=
 =?utf-8?B?aksrU3NKbVlFc3BWL1NQU0xIbVVjQ3ZMRmFXYUNYNXFid2hDdFExblYwdzM0?=
 =?utf-8?B?Q2hmUlNOZTVDUGZPTmVndnRrckJ6UkJTM1NiSWZJTEtYV29hby9BMzRKaDdE?=
 =?utf-8?Q?L0Dw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0115233-7663-4102-ae17-08db936eeab7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 15:41:19.8285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXYtagUa0j+/pZlAmoo8QtSl05m15xLqwAJx19nCw8qGgzGt1Y7ca6vZoAGIKB1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
Received-SPF: softfail client-ip=2a01:111:f400:fe59::626;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
> nearest power-of-2 integer.
> 
> The nearest power-of-2 integer can be caculated by pow2ceil() or by
> using APIC ID offset (like L3 topology using 1 << die_offset [3]).
> 
> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> are associated with APIC ID. For example, in linux kernel, the field
> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> matched with actual core numbers and it's caculated by:
> "(1 << (pkg_offset - core_offset)) - 1".
> 
> Therefore the offset of APIC ID should be preferred to caculate nearest
> power-of-2 integer for CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits
> 31:26]:
> 1. d/i cache is shared in a core, 1 << core_offset should be used
>    instand of "cs->nr_threads" in encode_cache_cpuid4() for
>    CPUID.04H.00H:EAX[bits 25:14] and CPUID.04H.01H:EAX[bits 25:14].
> 2. L2 cache is supposed to be shared in a core as for now, thereby
>    1 << core_offset should also be used instand of "cs->nr_threads" in
>    encode_cache_cpuid4() for CPUID.04H.02H:EAX[bits 25:14].
> 3. Similarly, the value for CPUID.04H:EAX[bits 31:26] should also be
>    replaced by the offsets upper SMT level in APIC ID.
> 
> In addition, use APIC ID offset to replace "pow2ceil()" for
> cache_info_passthrough case.
> 
> [1]: efb3934adf9e ("x86: cpu: make sure number of addressable IDs for processor cores meets the spec")
> [2]: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> [3]: d65af288a84d ("i386: Update new x86_apicid parsing rules with die_offset support")
> 
> Fixes: 7e3482f82480 ("i386: Helpers to encode cache information consistently")
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Use APIC ID offset to replace "pow2ceil()" for cache_info_passthrough
>    case. (Yanan)
>  * Split the L1 cache fix into a separate patch.
>  * Rename the title of this patch (the original is "i386/cpu: Fix number
>    of addressable IDs in CPUID.04H").
> ---
>  target/i386/cpu.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b439a05244ee..c80613bfcded 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6005,7 +6005,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>  {
>      X86CPU *cpu = env_archcpu(env);
>      CPUState *cs = env_cpu(env);
> -    uint32_t die_offset;
>      uint32_t limit;
>      uint32_t signature[3];
>      X86CPUTopoInfo topo_info;
> @@ -6089,39 +6088,56 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                  if (cs->nr_cores > 1) {
> +                    int addressable_cores_offset =
> +                                                apicid_pkg_offset(&topo_info) -
> +                                                apicid_core_offset(&topo_info);
> +
>                      *eax &= ~0xFC000000;
> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> +                    *eax |= (1 << addressable_cores_offset - 1) << 26;
>                  }
>                  if (host_vcpus_per_cache > vcpus_per_socket) {
> +                    int pkg_offset = apicid_pkg_offset(&topo_info);
> +
>                      *eax &= ~0x3FFC000;
> -                    *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> +                    *eax |= (1 << pkg_offset - 1) << 14;
>                  }
>              }

I hit this compile error with this patch.

[1/18] Generating qemu-version.h with a custom command (wrapped by meson
to capture output)
[2/4] Compiling C object libqemu-x86_64-softmmu.fa.p/target_i386_cpu.c.o
FAILED: libqemu-x86_64-softmmu.fa.p/target_i386_cpu.c.o
..
..
softmmu.fa.p/target_i386_cpu.c.o -c ../target/i386/cpu.c
../target/i386/cpu.c: In function ‘cpu_x86_cpuid’:
../target/i386/cpu.c:6096:60: error: suggest parentheses around ‘-’ inside
‘<<’ [-Werror=parentheses]
 6096 |                     *eax |= (1 << addressable_cores_offset - 1) << 26;
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
../target/i386/cpu.c:6102:46: error: suggest parentheses around ‘-’ inside
‘<<’ [-Werror=parentheses]
 6102 |                     *eax |= (1 << pkg_offset - 1) << 14;
      |                                   ~~~~~~~~~~~^~~
cc1: all warnings being treated as errors

Please fix this.
Thanks
Babu


>          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>              *eax = *ebx = *ecx = *edx = 0;
>          } else {
>              *eax = 0;
> +            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> +                                           apicid_core_offset(&topo_info);
> +            int core_offset, die_offset;
> +
>              switch (count) {
>              case 0: /* L1 dcache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 1: /* L1 icache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 2: /* L2 cache info */
> +                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> -                                    cs->nr_threads, cs->nr_cores,
> +                                    (1 << core_offset),
> +                                    (1 << addressable_cores_offset),
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 3: /* L3 cache info */
>                  die_offset = apicid_die_offset(&topo_info);
>                  if (cpu->enable_l3_cache) {
>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> -                                        (1 << die_offset), cs->nr_cores,
> +                                        (1 << die_offset),
> +                                        (1 << addressable_cores_offset),
>                                          eax, ebx, ecx, edx);
>                      break;
>                  }

-- 
Thanks
Babu Moger


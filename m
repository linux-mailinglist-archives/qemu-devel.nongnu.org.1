Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817176DBDD
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 01:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRLfh-00068J-CR; Wed, 02 Aug 2023 19:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRLff-000680-Kg
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:54:27 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com
 ([40.107.220.67] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRLfc-00031v-Oe
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 19:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TykG8n3Q/opifVHQ5a0DRCUtRyUmhzXDpQFaHWHMTD1RZ9uaPrnBlnC5m4dSIuLspduLpgP+qhzAdqN9CSyeY00Fr9F8LpTnzE5gRQrPeJlGWxKPrqreJLa98Q1GzRThH8tsBGFUGK7p9fUI6awnQReZM0xXY/EXQWe7WUFX3Itc0FJSSjX75KSG2XVQAjmMmyOiPVWJ2lx66VGveqMq54Q8Nm8+tlq9dKonlX6RNTkD/0WSgFEGH4CyyAUL5s5MCguOwGQTGcgEsHpXumKqFib67q569UBEUDY+cIp9YQ/3wQ2h/eKpS307IguI6kJ++gGAKqDe9N58uxPdCb+/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb1OyXiS1m2UEG1+Ojrt6oAzRW5QNz20igwXoW8Tcdo=;
 b=UGLhDEIQ6WY7WSUSp+v76FkVKefswv00kGqgCQXyd8s2jX7lAON+agQgI+LnKro+SJjSXW156cECokN6HPpkpkSqye0iHBpoLBe/8GEOGGarlGx/OGsSzdbKQQ40AD24V0Jole6RtTj9EinA39BVstJmZQ3Ld2/Jf/Sn01SQZauYtUw+TumYdY0ZSEx0ryVNcSdrguGQwAkeIaOFDWD+0ftt2pBA+rZEsf0NxwdK724vPu4Y1a4S7GvRtEjZnLlWY9iTi8uwuD0cUG+93K4ARWpbsJBKFshy90nbOz5TF1MzffShiTylZXItdwSyYWVaNYyvhNoh88Wy+Gz8SOzaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb1OyXiS1m2UEG1+Ojrt6oAzRW5QNz20igwXoW8Tcdo=;
 b=sW3kDr1RAYbsF+yRq0AtBbUQ8di/x84kIahSGrYfdkXZMD14n+5kJvh0Net7YxOufvMEKGWjY1f9JhPh6VDt2SGN3xEu5I3LJjN1lm53vAFYrFROr7/LRgxAFUCTqLZy5X8wf6cbTxCALtCdFksuQn70zdW4wwKdkb4nv70GOgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 23:49:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:49:13 +0000
Message-ID: <19ba8210-3e11-a36f-3b26-52cbe40042b1@amd.com>
Date: Wed, 2 Aug 2023 18:49:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-15-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-15-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b07908-439e-487a-fe01-08db93b31323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmVsimev3bipyw9bFeDBS2lTFOfqw9G3sIYxPVbb4+NVI2aDnV4RNKEtUupsxUs46vbf2A+wN3NwuK7KZAVyhy50UfYFyW4OVJWp4B9EmFDn9+2P9lpgSY+RXEXyRs4eosSkyfl2ktKGste3ISX+b0YMJuXdqN1r+rFQ9hgoKTC153EFzoBd2WiXKoB50VOWAx8EqEUNw8fq2yer4W8bl1I2i/UCv1avorW+M5uFdXH3MdUKH4sUXBHG28orGcMRQpS1/HwoLkZJPuBbiO2zvmoS3Da/Bs/Ut9KKog2o4oz53XVMNJ+LwmA9pIsnYGKS584sFdyRNJCZuRyBE/EywtNXx35koksaCNmKQnR+gAkpecKWdXLIY2HbCpIdOttfwkukAmv75x7IRJ5u1OVsLzu42gwPlM3xXc57eOqV/XpeVa2oGst0rfNKOYhIKzvah+KnPI6vThkv/kgI82FvWuvXtvsol6moRLsaEPHcMyCJkkt4V4RjkgXDZbD0Wae6maS9vOSFgZK3U/2ygoMQeCAUvfrUsm63odUR5DT+7ibCv73N0C47ieL++YkpfrNWbq5svB4GQG5RO3TLszFutLDCg+4qX/Aays/fwTXOqC0MmIvCHE0nLVYITVcQeFvurXU2JMFtUCCX9BVyGL3s5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(6486002)(6512007)(478600001)(54906003)(110136005)(186003)(6506007)(26005)(316002)(53546011)(2906002)(2616005)(41300700001)(66476007)(8936002)(66946007)(4326008)(7416002)(5660300002)(8676002)(66556008)(38100700002)(36756003)(86362001)(31696002)(83380400001)(3450700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdmNzVpemxZM1NiNEdJbHp5bW1YMkVHejNnS2NlK3RhampqZ2tDd3JORHd0?=
 =?utf-8?B?RFAzOVk0WG9hOEVSZ2hmSzF2VkRzN1VLY0RRT2l5SzQ0ZGVqU2wzMVRCWG03?=
 =?utf-8?B?RTl4NjJucE9jUWlLU0prd211aWZwbTdqK1hLMGdsNDl5eXczQ0pHWS94ZUJz?=
 =?utf-8?B?NzVSeXZ3VTlGTGxJV1c1NzNDYzJJbW5FS1BCTmYzMTc3OFprdDl3OHowQUxK?=
 =?utf-8?B?dXRNYlp6RUE3RWdodDI0YnVuWDdQeElEdit4YUJKTVVjeGhRWm9mYzlQMjBB?=
 =?utf-8?B?b0hwaXR4WU81Z1YzanU2ZDg5OTdneVptRTN4eGdHTllkOUdvbnBZb29GTGhC?=
 =?utf-8?B?UEJDSThsWnN3NWl6enFqWk84clcxUlg0TkpKdk5INXpZRGZ6YlJRd0Q1b3BP?=
 =?utf-8?B?L3BveUhjTVdqWDJUdi9xeUU2MndDd2llY1JadFhGenJMUlA1YkN5RkljUHZH?=
 =?utf-8?B?ZFlUQmR6Unp0eGIxd0FraWU2UmsxUmNFYVN0bHdTSDkxSmVpRFpCekkzOXg4?=
 =?utf-8?B?RXhFV0xmanFYNmlIdDNndzc5VzBKdzhzeUhzWm9jRzh6aGg3WUErV2dFNUpi?=
 =?utf-8?B?TSt1bnd4SWVFZlNOUFRQV0ZENDhkd3lMdjg1QThFNGxpUzlQRWFqZkliMXY5?=
 =?utf-8?B?ZjlOT3ZIemh6VG1YZ2ZuTmF6cjByd0RmN1FLcHZSeXRIYmU1djB6VkJWSC9l?=
 =?utf-8?B?LzYrZ2xHemoraWpJRFZVZnFtU1hoY3BBdEw0QXhYZklYZDJuUkcvejdiZnc3?=
 =?utf-8?B?WStDdm9kMTRTcC9BWnBWNng3dGNnU3gyL1IxUHBxTDNrZnFBQ0d2SWwwZUt6?=
 =?utf-8?B?RkE2eDlYUzRIUkVYZHVOeXlFR0xTMGJPVGVQMUoxRUZsTVBoOU82UEd5bTcv?=
 =?utf-8?B?OFhKcFR3ZHVRSDBvTjdZT1YvQisrNHRYT25qNWVCd0NENXJIcDZyblU2QWFk?=
 =?utf-8?B?dzI4dGRpOWNLOXNyWFlmYUFHZmx1S1pYa3VHYXlWbFBRWlRoNGFCaXlKSTd4?=
 =?utf-8?B?UHdUMDRmdTFQZzVyVHEwYTFHQW5xYnZmMU5oR3BBR1RJRUtYZDkwVnFMVEpo?=
 =?utf-8?B?dWFscmRXQlcrSlpydm83b1VZN3l4UmUycS9xS25Rbit6NmVXK2hUYzZuVU5u?=
 =?utf-8?B?RzA2WldNTXlIQmFvSVo5M21xU1JLb1YwZlVNODBZdWdBaHBwY1oydDNndEVO?=
 =?utf-8?B?TkllNnR6dW9WcXZHVFprZkgwOXYwaWZaMkp4d0hQMDkzRlVOMTR5S1VyaitP?=
 =?utf-8?B?RHgvcSt2VWJSZWQ4NzJIdXdyWEhWYkg4SkIwOC9NQlh6VnVXZ20zSmd6OE8v?=
 =?utf-8?B?YXJsRExpY0tlRS9XRUJMSHczc0lXMGhQSWZ0TnhESXYvN3pxZFdPUld2ZDYr?=
 =?utf-8?B?L01zN2xFa3BnSUJrUVJxaWRFRHNITjZyNTRpd1dRb1VFMWt0b3dUbE03LzNs?=
 =?utf-8?B?b0ZIUVZibklFVlNBZUJ4SWhoQTFHNmMrSlpkODV6WCtkMUhaeFVVZ0JXQ09Z?=
 =?utf-8?B?djJBVG01Sk14c2NpdWtvUFlod3JZNDlocm8rN01ISVVESHk2cVAyNlNZWjlv?=
 =?utf-8?B?MEw2ZEhHd2doZG8zMEl6MThFTlFUeDRxMEY3YkE0SGRaYjB2WHRQV2FWUzdO?=
 =?utf-8?B?OVk1alIwWlkyaEFVSWljcjJyZzRYaDZUMXVuNDNBUlg3dEttR01jOFdhR0Uw?=
 =?utf-8?B?TURNL0tLNmFxaHllOHFQc1BhZVEwUlFOVUd6UUYzbk5XZERUQ0pQRlZQZ3Iz?=
 =?utf-8?B?K3FIRXNEdVBadDJ5Zm9ieFgveUVRVWZ5UWllbUlVR25MRU9BdVdtT1praUpE?=
 =?utf-8?B?djJxNk85MDJ0UVRPbkRjZG1qUmJVRmliUG1GVlZPRW5PMnpnMEhDeTZ5Q1BF?=
 =?utf-8?B?OHp1SldFa0hZQ09IN1JPMlF5S0Y3QUJ6a1R0MnFJQzZTREh5Z21mOHFJVmtP?=
 =?utf-8?B?MVZwSlZ0MzZDbFJVd2lFUUpOTVdpb0xkcXNaeXRacWVIVmJvR0xhN2sxWGNy?=
 =?utf-8?B?UmtWNElhRXFmUlg1Z0gycFEwaGsxNjFYekllaDZWYzgraC9UM1BqWjVNVVhm?=
 =?utf-8?B?Q2c1WnQ4ZnVobDVxRUdmWWV6eEI1Mi9Ud3pmSzdHL216c0Z6UldYRXVDZ0FD?=
 =?utf-8?Q?X26s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b07908-439e-487a-fe01-08db93b31323
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:49:13.5755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZfHoDyUaE7ADpuw4dZ1Cq5xzS2e0bdiNr8nNJ4iq0UOqmZHJG2yymDy4owqWtqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
Received-SPF: softfail client-ip=40.107.220.67;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hitting this error after this patch.

ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code should
not be reached
Bail out! ERROR:../target/i386/cpu.c:257:max_processor_ids_for_cache: code
should not be reached
Aborted (core dumped)

Looks like share_level for all the caches for AMD is not initialized.

Thanks
Babu

On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
> intel CPUs.
> 
> After cache models have topology information, we can use
> CPUCacheInfo.share_level to decide which topology level to be encoded
> into CPUID[4].EAX[bits 25:14].
> 
> And since maximum_processor_id (original "num_apic_ids") is parsed
> based on cpu topology levels, which are verified when parsing smp, it's
> no need to check this value by "assert(num_apic_ids > 0)" again, so
> remove this assert.
> 
> Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
> helper to make the code cleaner.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Use "enum CPUTopoLevel share_level" as the parameter in
>    max_processor_ids_for_cache().
>  * Make cache_into_passthrough case also use
>    max_processor_ids_for_cache() and max_core_ids_in_package() to
>    encode CPUID[4]. (Yanan)
>  * Rename the title of this patch (the original is "i386: Use
>    CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
> ---
>  target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 55aba4889628..c9897c0fe91a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -234,22 +234,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
>                         ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
>                         0 /* Invalid value */)
>  
> +static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
> +                                            enum CPUTopoLevel share_level)
> +{
> +    uint32_t num_ids = 0;
> +
> +    switch (share_level) {
> +    case CPU_TOPO_LEVEL_CORE:
> +        num_ids = 1 << apicid_core_offset(topo_info);
> +        break;
> +    case CPU_TOPO_LEVEL_DIE:
> +        num_ids = 1 << apicid_die_offset(topo_info);
> +        break;
> +    case CPU_TOPO_LEVEL_PACKAGE:
> +        num_ids = 1 << apicid_pkg_offset(topo_info);
> +        break;
> +    default:
> +        /*
> +         * Currently there is no use case for SMT and MODULE, so use
> +         * assert directly to facilitate debugging.
> +         */
> +        g_assert_not_reached();
> +    }
> +
> +    return num_ids - 1;
> +}
> +
> +static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
> +{
> +    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
> +                               apicid_core_offset(topo_info));
> +    return num_cores - 1;
> +}
>  
>  /* Encode cache info for CPUID[4] */
>  static void encode_cache_cpuid4(CPUCacheInfo *cache,
> -                                int num_apic_ids, int num_cores,
> +                                X86CPUTopoInfo *topo_info,
>                                  uint32_t *eax, uint32_t *ebx,
>                                  uint32_t *ecx, uint32_t *edx)
>  {
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>  
> -    assert(num_apic_ids > 0);
>      *eax = CACHE_TYPE(cache->type) |
>             CACHE_LEVEL(cache->level) |
>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
> -           ((num_cores - 1) << 26) |
> -           ((num_apic_ids - 1) << 14);
> +           (max_core_ids_in_package(topo_info) << 26) |
> +           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);
>  
>      assert(cache->line_size > 0);
>      assert(cache->partitions > 0);
> @@ -6116,56 +6147,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>  
>                  if (cores_per_pkg > 1) {
> -                    int addressable_cores_offset =
> -                                                apicid_pkg_offset(&topo_info) -
> -                                                apicid_core_offset(&topo_info);
> -
>                      *eax &= ~0xFC000000;
> -                    *eax |= (1 << addressable_cores_offset - 1) << 26;
> +                    *eax |= max_core_ids_in_package(&topo_info) << 26;
>                  }
>                  if (host_vcpus_per_cache > cpus_per_pkg) {
> -                    int pkg_offset = apicid_pkg_offset(&topo_info);
> -
>                      *eax &= ~0x3FFC000;
> -                    *eax |= (1 << pkg_offset - 1) << 14;
> +                    *eax |=
> +                        max_processor_ids_for_cache(&topo_info,
> +                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
>                  }
>              }
>          } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>              *eax = *ebx = *ecx = *edx = 0;
>          } else {
>              *eax = 0;
> -            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
> -                                           apicid_core_offset(&topo_info);
> -            int core_offset, die_offset;
>  
>              switch (count) {
>              case 0: /* L1 dcache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 1: /* L1 icache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 2: /* L2 cache info */
> -                core_offset = apicid_core_offset(&topo_info);
>                  encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
> -                                    (1 << core_offset),
> -                                    (1 << addressable_cores_offset),
> +                                    &topo_info,
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 3: /* L3 cache info */
> -                die_offset = apicid_die_offset(&topo_info);
>                  if (cpu->enable_l3_cache) {
>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
> -                                        (1 << die_offset),
> -                                        (1 << addressable_cores_offset),
> +                                        &topo_info,
>                                          eax, ebx, ecx, edx);
>                      break;
>                  }

-- 
Thanks
Babu Moger


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CE76F418
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRf7X-0005Te-Ev; Thu, 03 Aug 2023 16:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRf7V-0005Rc-Kt
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:40:29 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRf7T-00081Z-5T
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4MofWWMxixPOcs2oGu29MQN7hqfVlEvzEgMNYp3tCqupjyh3uX0NHFyIr8FIpiU+KX7s69BtlaF+bOGZmS06rTFc2hQBWOIjpAODEBuN72k5eo4NzB+yHR9yfVyMaomgPJxqu94e/xp5ohR5Kt21eFIhFJnLwuIjPSIQ9AXu+US9Gpnglq4EWjxJl3oM2XHPEtA+GMie/pgzbrQ48cVDC4lwN1+WIepCdBOeYbX13mpGCKXVegKhAHDrz7s2yNBQEQErFSN6QwVQr2VFE6/mzPTAXNvmfL6Y8Op0cSYq/7PJCCjilcXR7hwmsz6VrIgPjJBVr5/eiKoK2gktWUSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+81xK1egxj719Xx4ECpscSg63qsvQxrhRUd7kAc7ic=;
 b=O0ZVYznfcOyaQUpO9o59+bm/57m9clRXrbJ9Qhk3lfmcpQx2qq3keI9/6IFR+GgsAtN3nubLG2J+qqbjc5ugjW+ecW8XinHRb6O0S7iVnMIXsw6dVKs4XlzR2yMmbMsfQRrllJ0aIjHMTEnfGInqNYnvFuvIg2Bl5ev+6ibLUOgEaXYI7+psGtvRKxInwdsroWFGOE7CsGto2YRBUa54eTzAMtFfO6HG8p6tasd2FE6fTkj8SMZ0bGBO90A0UeHAoConJJLYfxaL6OAMHeL7NCi/ns4MyNek2PNXwrisFN6pwDiX69BOAYJs7grcJRPrXm2AyegMGXCfdeyiUzAC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+81xK1egxj719Xx4ECpscSg63qsvQxrhRUd7kAc7ic=;
 b=saTbJ5ttJ0ii0uTQFktjZAwzWGOC2H6ThDS3pevpxJjwhipyp/gJrf2JQZT440irq74Yt7urtvkybWuI/37oNrXKq3Thz9U2CgBLJKpvKlQTHJv4H5lu4vgLThyEIUwyaF6c6aFL4fCPL7NRyiCK/VEKFhHelsjjiEQtYgIdCQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 20:40:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 20:40:23 +0000
Message-ID: <e05ca4e2-b4a8-99cf-cd4d-cfac71262a74@amd.com>
Date: Thu, 3 Aug 2023 15:40:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 15/17] i386: Fix NumSharingCache for
 CPUID[0x8000001D].EAX[bits 25:14]
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
 <20230801103527.397756-16-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-16-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:5:bc::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: dea23537-157f-40d0-26fe-08db9461dc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YxEQAJWGfDUVjdfSp6IByxEZenAFXsJ1S6N0fM5/CNxq93Di/3+n7WZmiALSVQJ969WyykrhhGib8KSm9JkkcIthq0PbBJbOBpPV0KGHwbmIiHRSKN8Swl0YoWuihLSh+wArmsY88OvZXPqpKxOoUlbq3OAeHBKZKRwr0640fGxF/Fa5HGthNKoxpV9yYTPQhDi/+zo2yOyyjV1hnekK6hDl9aAo+WGlBhLAP39waOFAhT39IIO8fkZBG4WaoWjjYWwkboPT8lwakoZDWdv+qCUPpQW/ef6QZvviCecuBjkxFmU6pDK0xDVbT72aaLB5b3q7kNrckx07aB8N7OmvSjbTvC83Q+vFLd3NohFV1MZ9s82Uwf+GmzeIjX3WKb3OLJGcP+OXzz0w+Ho2Zhe8up3sueTSfHS3nAVmDZsdrgebqKZibg5UWY7y2Se+UvRR+TjWRRoNQcSe/MEbxxbNDkBs96GDE8LLRijRzOO2weHDvmCsHUt3EjMlxsf8HYCXwfJl9SPmhS0h9nFoOsroRvaIIbetQL+KPbNL13VJrQQPK3K1f/9ueC9kj1xkKMnPCfPiG+9/asFAfsibr4yXuo5zix27L5U+CYwxIqtJyMp+0knmfbYJQPj7WtJJulLpXFQL1zUimdRgTyM4rq4Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(53546011)(6506007)(26005)(31696002)(2616005)(38100700002)(86362001)(316002)(478600001)(110136005)(6486002)(6512007)(54906003)(36756003)(66556008)(66476007)(4326008)(3450700001)(31686004)(2906002)(5660300002)(66946007)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGF1Wm5PNjFsWmxOSCtUaXRjNGFnczgvMlg0VjJlT3ZBdjRYNGR5TlkyY0ZF?=
 =?utf-8?B?cEtGSjgzK1hrbnAzUW01QjhSMW1uWCtHM0N1d25RZEFidzR5MzRnRWMxbTUv?=
 =?utf-8?B?cjJhVmZwdUdtZTZFS1lZUVFmSis2MXBnMk1ucjdPZEVrMWZxOXVzeDVNa0ZE?=
 =?utf-8?B?a1Y3YlQvUUZoNjdFZ0FHYXk1WEtyZU93OVBmRk9mMWZsbHlRdEZnTDFqcjhw?=
 =?utf-8?B?QUR3Z3daNVQwUzRFMXE4Und4ZXpqbHVrV280dTdyMm9tMm11Nm0rc2dVYlo5?=
 =?utf-8?B?WDdqdm8vaWVscFBiUHlqNjB3UXBOWGMrRE9MdHo2ZktmSEZybzNFYW00Yjg3?=
 =?utf-8?B?dVVWbDU3NnBpUEM5QUlpRkdSZStoY3JIY1RJK1BuajVoV29CMEl0SklVNDJn?=
 =?utf-8?B?Y3lVYmZZMUZ2Y1pLZGFRTjZFNjRKTERTLzZkUXhwRmlWN1V2NGJpVWJRMzZn?=
 =?utf-8?B?QlMxWlRKam04cnU3cHNNNk05TjAvUXBOclJ2L2R6bmRWMTd1V1F1eEcwazFZ?=
 =?utf-8?B?VUJDTkFVcEIzaWlvL0JPUzVsQjRKZ1dwMkZhWmpzUHBLdTlmR1M1ZFdYeVZC?=
 =?utf-8?B?cC84c2l1ZUhLMTViK3o2akpxemU2dCt3d24wWDFqQjU1S1NCWXNJeXk4OEIz?=
 =?utf-8?B?SWVVWDgyN2ptNm51WGlsTElCbWdzSmg0ZnZNT1FDRDJWc3FFc3ZJNDJNUmNt?=
 =?utf-8?B?Z1d1TzdPcmtUc1VNb21lY3h4NWlia0dpYUFKL3MyNFhUZGo1dFF2MTFmZUs4?=
 =?utf-8?B?ZVdiTkFpSnJqUW1aWVFPd2FvVFYvQ1hXWHR6b2QydzJwenI4Q3ozOHZTQjdW?=
 =?utf-8?B?WG9UWnorQ05VbUZaN0drcURXOXZDVjdxRjFyeGdzTVlqR0NEOTRsaGpFeU5W?=
 =?utf-8?B?YnBEWG1TSCs2b0xscjI0blMwQVE1NHlISjN2N0pVV1ZPWjdHdU8rMXpiNHVO?=
 =?utf-8?B?R2JBMVFEYWIzT1ZNUVdKSkF5aHpKUG1zTjRieW83N3BNbE5vQjVwNkY4Z3Ez?=
 =?utf-8?B?RWdWK2drQmhsblVDdmk0VDE1Y1B1T0pNUGg2YVljLzdONFNCREo4MUp0OE1L?=
 =?utf-8?B?b3ozNlV2d3gwaVpPM2NiNC9jVzdYUlZKU3JnZXJxRVhtZHVhSk81WUdHUWpZ?=
 =?utf-8?B?OGpwMlE4TkxKekhwOFcvNmdXOTJHWnB2bXlYc2FvaktqM1BZNDNzcy84Nlk5?=
 =?utf-8?B?M3o4VS9ncmN1WDlUVUxRMkZwNkRoREt2TmJqY1MzUjJsVk1nMWt2UERhR3pE?=
 =?utf-8?B?dk95aTF3S0VxRHlvVjRBQWlqQnh1N2ZYVzI4djV5bDFueHVONnJEOTRlbml5?=
 =?utf-8?B?Uy9qMXhJUE5tb2NpNDMzd29HSDZCelB5OVphRVRMVGVxeXlkcU9EeWRPU0g3?=
 =?utf-8?B?SGx2TlpjeVFodVJpR2JpMzZsMGYvL3o0d2tzbmFuK1RTakdpdXplOWlDNExG?=
 =?utf-8?B?c09iSldMNEx5NDA1a202b3Y1eHFGRWdld0tKemkwdzVvL3Nrb2NIWFRubTRq?=
 =?utf-8?B?UE9zTEJMOFF0ZnZHcmxxK0RpTlUzbEpLZkxFSXBXMUd0TDlPbDM2cERUZmtU?=
 =?utf-8?B?YU1xQ2F3OERURlpFc0FjbW9VSGgxazBSU2FTZmZSc2h0THdzT1lEM2F2eGlJ?=
 =?utf-8?B?eUVmY1JlVHdaTVdmZ3BjdXpncS9oalJCdjJIYXVrMEVCRzBSREZyd2NSaGlU?=
 =?utf-8?B?OVFUSkc2b0ZSaFR3TjhNaVBTZC9HYXFHMitYVDkxZkk2L1VyaW9uWERXdjRp?=
 =?utf-8?B?WkxOM0ZlSDkwei90SWpTOFc3N1lzUS9ub2RuM090L1BjRHBvbzdmckJ2WUE5?=
 =?utf-8?B?cHcrc2xGSjJhV0xEU2lUbDNIQk1OZHJ5T0RIdWdRdFliUlFhZlpFTXU0ZFZ1?=
 =?utf-8?B?WDJ4dllmWU8vcEhWMGs1RmlmMms4TTJsYXJxbXozZHpFK0ljNi9wTzNZbDFi?=
 =?utf-8?B?SFYvSlNyYW5RdFhhZWtXbDBnY0N2aGV6UUlKNy9OTUQvaVduYnVKUUdXK0Z4?=
 =?utf-8?B?UVhuTU5BOXNIVkdCRitXc3p6ODMrTXZqbXNqZGxTUjRUQ0NxV0tFRVFkRElB?=
 =?utf-8?B?bUprcnYvek5IN2ZOVGpCTnZQeEJ4ZXpFcUZOVmVTcjZzdThNMU5tMXJkcDl6?=
 =?utf-8?Q?7sww=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea23537-157f-40d0-26fe-08db9461dc1f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 20:40:23.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ2NI/tzQHzaf6mcLLSPamAjECCeS3mnaEwV+RChaca1MDhtP2YI4PGTFQWPH6Ki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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
> The commit 8f4202fb1080 ("i386: Populate AMD Processor Cache Information
> for cpuid 0x8000001D") adds the cache topology for AMD CPU by encoding
> the number of sharing threads directly.
> 
> From AMD's APM, NumSharingCache (CPUID[0x8000001D].EAX[bits 25:14])
> means [1]:
> 
> The number of logical processors sharing this cache is the value of
> this field incremented by 1. To determine which logical processors are
> sharing a cache, determine a Share Id for each processor as follows:
> 
> ShareId = LocalApicId >> log2(NumSharingCache+1)
> 
> Logical processors with the same ShareId then share a cache. If
> NumSharingCache+1 is not a power of two, round it up to the next power
> of two.
> 
> From the description above, the caculation of this feild should be same
> as CPUID[4].EAX[bits 25:14] for intel cpus. So also use the offsets of
> APIC ID to calculate this field.
> 
> Note: I don't have the AMD hardware available, hope folks can help me
> to test this, thanks!

Yes. Decode looks good. You can remove this note in next revision.

The subject line "Fix" gives wrong impression. I would change the subject
to (or something like this).

i386: Use offsets get NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]


> 
> [1]: APM, vol.3, appendix.E.4.15 Function 8000_001Dh--Cache Topology
>      Information
> 
> Cc: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Rename "l3_threads" to "num_apic_ids" in
>    encode_cache_cpuid8000001d(). (Yanan)
>  * Add the description of the original commit and add Cc.
> ---
>  target/i386/cpu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c9897c0fe91a..f67b6be10b8d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -361,7 +361,7 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                         uint32_t *eax, uint32_t *ebx,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
> -    uint32_t l3_threads;
> +    uint32_t num_apic_ids;

I would change it to match spec definition.

  uint32_t num_sharing_cache;


>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>  
> @@ -370,13 +370,11 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>  
>      /* L3 is shared among multiple cores */
>      if (cache->level == 3) {
> -        l3_threads = topo_info->modules_per_die *
> -                     topo_info->cores_per_module *
> -                     topo_info->threads_per_core;
> -        *eax |= (l3_threads - 1) << 14;
> +        num_apic_ids = 1 << apicid_die_offset(topo_info);
>      } else {
> -        *eax |= ((topo_info->threads_per_core - 1) << 14);
> +        num_apic_ids = 1 << apicid_core_offset(topo_info);
>      }
> +    *eax |= (num_apic_ids - 1) << 14;
>  
>      assert(cache->line_size > 0);
>      assert(cache->partitions > 0);

-- 
Thanks
Babu Moger


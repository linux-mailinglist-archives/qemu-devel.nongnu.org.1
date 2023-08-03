Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887876F41F
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfBJ-0003sI-Ju; Thu, 03 Aug 2023 16:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRfBH-0003s7-MQ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:44:23 -0400
Received: from mail-co1nam11on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::612]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRfBF-0000hj-S4
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:44:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcl27NmD0gCQ0kkhs6T2tH4GO6E/GJTtuaiWDM+dXNlGQ3vwIr+Pz23824baN8Kd4yxjSTrO2UMsjUj8sT55RXiM3hEHhx5QwYFSc4wAeOAMCTbeZ2kPkK4culM2EYFTakt+6aIBkg8BRBUOZl4Axct5z2Old0A7nYqal0Ing7iiPPBt2k90wNN2K5WBKcf4eTINTPkODYQ0E41ZBL2dnFJS++ZHkEf6UtgR/qpQ2FuutnHSduoWyRJQGFfUnqR53qqgMBu32GKsuP345bP0FVlAg65l4pVcRYu9AIHHz1XtziU3SI+ZPgzDTyH56+/uv7u+vNpbRoI5louvNxCrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWmU8re0dFQYwlcYiCQ/C9Zw8UOYc38//4mV3k88CqE=;
 b=cWT8YgSBAGltJ1tcKzLzdJng0ZH1IDotWTifQ1kBTzFKhPRnCVhGBBnzVN+KjPAKOLWzbZwgzMQ/5SnlvFMekua8teia6O07ufgIkcfTd4eWozx6M+y3sElLzniWDAlymoZq30oRIUlIIBdzkYUE9cTm3ogoT9TtsX/ajqWWq3w7vAWJBus6DXV5imfI1niMriVjv8k2MpDFKCSIpHCTnVj5WEaIIev3UgFQjvwy+ARBII17trjq55/ZNTCNEWWW/xQ7jLNZRbRwsx/FSl9raidpzLuMUmjzxg/hhwVfIoEZZWHyFwrAfdMnuUhvqFZow9Q/N/I3tikosgF1P1+3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWmU8re0dFQYwlcYiCQ/C9Zw8UOYc38//4mV3k88CqE=;
 b=aZShLt5EUmK+YSk0YJRcVC5CU9Z2s0bpxN+k6Q5Rp2scl6WN+9OM1kEyLGQReNZN50QNHdJCDIgmSu/2ob2GDuBmTDhRxEWo6+gR2HD6t4Z0tfGugRxNtUISzVaVUgvYU11BFYrXXZqQK0YzEeoi4rjIQ2IHnDtNECT2prMeLR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 20:44:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 20:44:16 +0000
Message-ID: <1902cfe3-f858-1442-8875-2b6bef83d68d@amd.com>
Date: Thu, 3 Aug 2023 15:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/17] i386: Use CPUCacheInfo.share_level to encode
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
 <20230801103527.397756-17-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230801103527.397756-17-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:5:54::48) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad2defd-9253-4011-4cba-08db94626705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYsKmMwZaIHaV/KSpq2HeDh7xAoDzW+fXDzn1l5UmmrzD8AD/9/4fJnORrMzaRg8ds2qYQym5rYSUcBMCgKRIE9pl/Ij1b9aNwckObtT3yJ7A43Rzi7oQ+XpKNlGXNFA4xMcJ6hFtUrBG7dtUVk1IoxosKpqNE6uX3Vfhqq2ZcpgOm1nk8G38DBnpyOywb9pC/Uyh4qxkksc6Bjr2vO3/05FLlAQiSnm2gEY2HlVpoJnNljQOey1AVq8q5VR3mK5ISi0BJTpKogaHk0lun2on7vtkMtuSVYm6rHx/TH5jbzuWIhOBQmkhlVGPeiBwpeDTUMl7aKPGiqsQIibRdqZdUTvEJFqy8xgsdoZJZnNMRgg9lQeer73VIq8kNERfwR0K4L80Ru0ryMaKXWtGyBaTG/7LasEfjd9+RQ73XAKLwePROxAWZHAwMYprS+74XLkQyTJ0YRAXnPSlna3LuEikaSarIgjugh+ByEOnjGj8C3mIOcgZo8Jn7At2Yz9D/7GS+72qhOUqI7eDronlbyu5nZrHeACRathVDJjtao1NOEP/Iy5US3TQNkcvSScirM7MS/F3PhosVvfNxQtdDz/hcGurlZKLW8Tb1N8HsACsJYXYwtlGmtj+0QhR8Ya0VjfazbqYiXTAfmbinsfAj0GFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(53546011)(6506007)(26005)(31696002)(2616005)(38100700002)(86362001)(316002)(6666004)(478600001)(110136005)(6486002)(6512007)(54906003)(36756003)(66556008)(66476007)(4326008)(3450700001)(31686004)(2906002)(5660300002)(66946007)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdldSt3MHorOGIwQWZYSWtjS0xWaHVLdlpCMXo2MXBad2lCZjJQdmwrczFQ?=
 =?utf-8?B?Vm5iS2hGWTMxLzVySFVtWmtnT1dtQ25ZVkhNaXhqOG1hRzhEK1ovVkRqN2dX?=
 =?utf-8?B?NmsrR2tzTUxWY1VlNG5mdEJJbTQ3OFViU3g0ekk0bmhCMVpRZ0tlMTNTV3pk?=
 =?utf-8?B?ZU9WS2R4U2JaTjJVT2xaMDMraVBzS0FNY0dYU3BWQlp3RXZoSTBtcUpoUDk2?=
 =?utf-8?B?OTJLdkY0Ylp4OS9pM3pBa2dMWHVuZjdCU1JMTnF3eWJUbHg3WUtDaGdaVWVJ?=
 =?utf-8?B?eWQyMU0veVRqQkU0VysyY1IvMDBHMENHZWZMZ0JDMWliN0lGWEliOVVDbWYz?=
 =?utf-8?B?Zm5tTmxNNVBwTTF6a25zVms3MHBNSWgxcjRDWXBuVlpQQ3d0c0d3VVFidC9C?=
 =?utf-8?B?ZTFEejdqNDFIWmNwSEJlekphTExrRDV2NkhTWkZVd2xqd2tYYk5xYU1RdmQz?=
 =?utf-8?B?U1FrTXVoM1V4T0MveHB1ek9QaHhYUGFHQkVtbThVYTRNVFIyK1R5QW9TY3Jy?=
 =?utf-8?B?WXN2SEpNNVBDNENOTjIvN0xvVXhhc2loTllnMEt5RnZjL0hIME0vQUxucFBk?=
 =?utf-8?B?VGZ2elZtdEMwZE4vUjh6NFZBSEgrMmlJZTBDUkM5Mk10N2V2dVNvTkxoTWJo?=
 =?utf-8?B?M1kzRE5mc0J1TFU0dGRVNHdqaVdQL0ZKUlJxS01VVmxBYVhydE9RYlNON2c4?=
 =?utf-8?B?OTRTTWJOQ0hYOXVsaXhkNWVRN1lBYTRYb3lwSXFGVVh4Q0hPVUp0OXV2VzNK?=
 =?utf-8?B?WlVNREpFVVVMcDBXZGlZZ2JSbkxGajNoMlJUR2VpU2t2NVk3OHZnbFJTY3J5?=
 =?utf-8?B?NW5HUWJyMlo2TzlMOCtQSnFIeHExSWEzeXFTbTJjUGVuWTRaL1I2cG9EL2dV?=
 =?utf-8?B?MWtYNW1SRVJoYThmZllrbjhYc2ZDKzR4U0l4YklIT054ZlVDbGpzY1BiTmMz?=
 =?utf-8?B?eEo1OXA2c3lLUzJ4WVZXK0U1N2NqcDAwSUhKL2FBWWdCY0k5RmFNRU9DOElO?=
 =?utf-8?B?QWRwVFljdXRlNVVrMi9pdUJFcmFKVlk0dVI4YUhXai9sNkMxTjN4RnJoV3Fl?=
 =?utf-8?B?TVM4Y3g3My9wdGprNVdZaGlZZTNLMXNEYnhheEEyR2M1dDZRMVR4QXhnclFa?=
 =?utf-8?B?bUFDUXFBVFFHTWoybGlGZ0YzNGNaL2ViYndaanR1ek80eDhLQ1NtVFl0ZTl6?=
 =?utf-8?B?V3BJYXo1TGR5WFZiaU4rZld3TkpTbERWRXpVYUNtTVYvSGtKcVZMa0Fxanh4?=
 =?utf-8?B?ditHcTFvbkRhcHQ2blpPREw1ZVA3L0FJQUZpcXVhWjIxSTdEdUt5dkl2dkVD?=
 =?utf-8?B?VEk3ZHlxVEVjcDNPNkVJNmR5SmRUMXRKM3V4NnppKysxTnRWR0IrUFh4eUZ6?=
 =?utf-8?B?N2kyK1g0cWhnSStKbk8vZStqYVlURDN4UEs2akY4cGFoY0N3bTN4OWtwSkZl?=
 =?utf-8?B?bllza2pOVlAydURZY1BJWUR1MGRvQ2JtbXluREtkSnNJdThmaVI5Q2dJVFVm?=
 =?utf-8?B?RUhPdTc4eFQ3Y1EreDZaNm5LTzBPQzQza281SG5uaDQ5Tkp5NThiZ3lqeUxB?=
 =?utf-8?B?N1Q1R0ZhNUJBb0lZK3hPbzd1ZHFIYWFibUJpeCtpbEdEd0VnWEFVaDhIWWZL?=
 =?utf-8?B?YzdDamZQNkxSYVpGSE1jMDlhcUgvRm1GY0J5cEo4WWZiais5VFFKQ21YZ28r?=
 =?utf-8?B?N1pJbXMzWUhvTUtCYWNDamZ1enZVUEtHbU5WUTNXZXhqNEhiREprZTE5SjRY?=
 =?utf-8?B?UlBlSTQ5bW1XaE1xU21NV3VYUFZtZmtmT3YvSUVnVHM0U0NPZ0tLczA3TGZt?=
 =?utf-8?B?ckJmZjBEVlM3dkxaRDR4eG5pT0ZPRFNhSGM4bVB2R1A5akVFY2RuMTVrU2tj?=
 =?utf-8?B?YzR0VElwbHQ1TEU5Rjl3b1VlRzQvMHV5T21xSWdlTS9rQ2h3WUF6SUtjYVBY?=
 =?utf-8?B?WFh1MGp4S0Z3anJZNForRmZqeC9ySmdpVExobVVZRU43WmhBKy9xcGFXVFRk?=
 =?utf-8?B?MmdJdFBGRTQ3a2l3ZzdwNzIrQ0NEWjNFMnNCYStOZzBmTjZHWlRnNjg1Y0Jh?=
 =?utf-8?B?dW95di9BSGNHYXBiZmxVTnBKYmZZblpnUDBtclIzeXM4bDE5NHRoRlVIUFh4?=
 =?utf-8?Q?3Xpw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad2defd-9253-4011-4cba-08db94626705
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 20:44:16.1101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zS3TSiUugQ54hiM+DFmdzEzco6FP3xRok9zfyFX3Y4xF6nSUjBTZAeWGiA7nrxeK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
Received-SPF: softfail client-ip=2a01:111:f400:7eab::612;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
  Please copy the thread to kvm@vger.kernel.org also.  It makes it easier
to browse.


On 8/1/23 05:35, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> CPUID[0x8000001D].EAX[bits 25:14] is used to represent the cache
> topology for amd CPUs.
Please change this to.


CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
processors sharing cache. The number of
logical processors sharing this cache is NumSharingCache + 1.

> 
> After cache models have topology information, we can use
> CPUCacheInfo.share_level to decide which topology level to be encoded
> into CPUID[0x8000001D].EAX[bits 25:14].
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>  * Use cache->share_level as the parameter in
>    max_processor_ids_for_cache().
> ---
>  target/i386/cpu.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f67b6be10b8d..6eee0274ade4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -361,20 +361,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                         uint32_t *eax, uint32_t *ebx,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
> -    uint32_t num_apic_ids;
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>  
>      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
>                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> -
> -    /* L3 is shared among multiple cores */
> -    if (cache->level == 3) {
> -        num_apic_ids = 1 << apicid_die_offset(topo_info);
> -    } else {
> -        num_apic_ids = 1 << apicid_core_offset(topo_info);
> -    }
> -    *eax |= (num_apic_ids - 1) << 14;
> +    *eax |= max_processor_ids_for_cache(topo_info, cache->share_level) << 14;
>  
>      assert(cache->line_size > 0);
>      assert(cache->partitions > 0);

-- 
Thanks
Babu Moger


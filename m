Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1983977085C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:58:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzxD-0003c6-PR; Fri, 04 Aug 2023 14:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRzxA-0003Qs-TS
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:55:12 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com
 ([40.107.223.59] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qRzx8-0008T2-LY
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 14:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfLTxqONn1xhsZvQZv3fCYMtnf3VVIfqAsDuvEAqdFt9MEnwvv12uWMn5YW36RjSvH6Fj5QbrJ4HjcHfjPiWJ9bElpqpJO7XFvpDYUm+fsrR9mhKYfzT4DLcts6U7Sc7/9Z1hJF4lZQnF8JeXi7Ye4ghogpcbpD0P3XWWwgoxs8eC+OxjX/osXkUpxXxZoVIlwjYgcMmv+y7GHTvuikM64qTUa+GtpLRmoR297JxL0lvnN2AQFaCJNPs1NR+T4MJLn5Gsg7FjiTHyoYs4ktSgzTAkzaEZ6bR8iMgr4CQwIJRAQLr3irqO09u5CeNymLbHtaE1YMRQjyLDMluUy4D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er2QXjSWCmCi+DZgjOvI5IcwfDyp0y/cjnBanpmt3Zk=;
 b=MC6ZzS9KdDgz8W0l6Hu7xdxkE+NcCmBkTdFLRsyaOZNZKFjbWeqcvkehfvBQ6zPrZLXfuODZ7/Bs79HJbVWYG4cfZePQQjLGBAAQBjiJCNES118sU1eMOIlcI/1KTcTtwMMQfZflOjBphex2uderaP9Fk6B/4YNLGLMXiLwUZIrvuI8FAl2FATAxIvNq+1YkDUZ7aCH5xgs2o4DR9/x3gky34+nMCXp/Kc/HVdweTpWDQXmMawwIyKXuuMmKecl524Y2+7Z7nQxEFBz7WwNplbH/wQaBrUllqCPgbt/tZ1LeGmPsmPsXrppX513AlT/rBQqCkba8xs74g+DlbvGGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er2QXjSWCmCi+DZgjOvI5IcwfDyp0y/cjnBanpmt3Zk=;
 b=DrmmjM6Y0w88UJLyvjxWJop9pw+6DB3qFE/ooPr6e+c+/UHuVU5NwM0gk2L9t9GoSbFoDNaHJkm6i5uReCoQIbOdoRk+8A5R3I0AMl692P8tCzFVLVfMpTpolmptMWnPVdNxolOl/0nXdkryv+5RA2DBqh4dQOhp3U77gvAY3u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:50:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 18:50:04 +0000
Message-ID: <cec7fdd2-1d2d-9829-a54a-561ccb7b73ed@amd.com>
Date: Fri, 4 Aug 2023 13:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/17] i386: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-17-zhao1.liu@linux.intel.com>
 <1902cfe3-f858-1442-8875-2b6bef83d68d@amd.com>
 <ZMzLXqx3hbUaARAU@liuzhao-OptiPlex-7080>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZMzLXqx3hbUaARAU@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:5:14c::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: a26dc2c1-d781-4606-7246-08db951b9d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R87BBNw1YH5QEFx7YfGS8y9AP5dNIRjueunWUvX2qNv8DsMNzlLN15pZrKUsZI/iR3Fhoyl8iIEgfht3EDpHKsUf8XOWwVweYeignu6Rd4440wtWw27qRdcJT3xgXKWCiAwjinFh8lSdpJrfuQPiZQWkClj7JEDB3gcJAXEsmtpvO3qlOI0qKTGO6Cz2k/AIyYgL3dlJVH6H7AOpxixLeNcVUJx+zUQ4FG2p5TA9j4w7xcat1d9Dy436JifNUVnMQkjzE6UhV/GObV7Dhw4+dDXi8N7Hoi8RI/nMmlSTdqknvwGrGuBK2d6WsDcHhkwEeN9rxVHE4AJUHVl4T39FrAhqeMcNjAFhgPwyRkMqNFCPvDr9h/y+ZtuQ4RgSiPD58Vzz6mCUFbgUCDf7Dlp0SCiWMh3cYY/uHp8ICkgIgdUjJiyXekAAsHM6mKD1dLJ6J+SyTCMPnoEm3y6gmgTTNdly5f9iUlodwK3jLqJyjWmMmdxJ5m2Czg9FBReMGKcGps31B+FLDL89y0UgoyVZrR2/8tlntGZ44h9sVG9/Y+zm1U4iPKkPtSn+TBJli+eijRyd5ar1Mgcycm+iGbprSqGJMwtONmD/yNqW52gyjJy0B8hViP0elaQ/FC+So78wo0oOPjajS5rA+yZFHSdFmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(1800799003)(186006)(8936002)(2616005)(8676002)(83380400001)(6506007)(26005)(53546011)(66556008)(4326008)(2906002)(3450700001)(6916009)(66946007)(5660300002)(66476007)(316002)(7416002)(6486002)(6666004)(6512007)(478600001)(54906003)(38100700002)(36756003)(31696002)(86362001)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmlLUFI4VmloYWp4anhiSGx4Vzl4QjFFRkRnZUc4cCtDc1FqbldOYmRaQzZY?=
 =?utf-8?B?UmluYjhVcmtzeXZoUE02YmFTTVpZYVFVL2NtSlNWYzkyM3poUGZpT2ZNUE5Z?=
 =?utf-8?B?WXZPNUdjdXNQaXZZM3JFcVBZZ3hzeU9hdG5CUnh5OGN6NW0xcVJ1Zy9hQk5V?=
 =?utf-8?B?QllLWUY1UVZlUkNDbWJVUDJRMSs5ZVlQbGp1MFZMWGdvOUJjUnpteTc2dGRo?=
 =?utf-8?B?eXF2ZjZnV3QzNVlVU0NtdjdBOVk2Z0lPbGFBVTkxUFNqdFJQVmxOWGk4RDV0?=
 =?utf-8?B?eGkyUC9sTzQwS0RwdkVKVng3MGt5S3VXenBXQjhKVTk0ZWFpd2NZSUhPaGNr?=
 =?utf-8?B?UlpSTDM0Y29PdWJSbnc0aTBzWktUbE42TWdjSXNlTlZMZXpHYmtYVGpka0ZG?=
 =?utf-8?B?RktYZmRLRzJaR2o5ZkJ6TnBBWkZwY2FqSm4vMXZkQkxrTmtFR2ZSLzRaN3g1?=
 =?utf-8?B?U1NOZXNXbDV6Z2QwSldVOElJcGp5bXQraXNlMUJDMksxeC93aVdQRTJhTmdS?=
 =?utf-8?B?d0xud2tWcGR6MkxvL0ZBYVV0d3FueVMyVGJGVG5td09VbHNoZFczcVo1R0dN?=
 =?utf-8?B?eUR5UWFTd01yemEyMG9GdXEwbExFSHpIM3BvdWc2K29ucjZoVWlzVkZ2cmNT?=
 =?utf-8?B?TndxZEFtdkFpNExQRU01bStvd0tEQUFSYnRxanB0YmRKY2xWUnRNeVNpTWlN?=
 =?utf-8?B?WTNXTG1rQ1BUMEV1MnViN1lPWjR3OXNXWER4SlRMejAwMWEzOUZQUXZjTHkv?=
 =?utf-8?B?TUViNjExZ0RoWDErd2NQcUZNMTB6RTNKMmJVajNCV05PV0pFQis1d1FHendt?=
 =?utf-8?B?d0VQVy9lU1RRRXM2azNaaEw5SktlNHBVQlRLZVJMNWN1YkRQYytQTEdtT01w?=
 =?utf-8?B?akNvVkRyK3ozUDFjeldSQ21vT3FpVDlPMXN0YW9CZzByV3VXRkE1TWZ0V1ZF?=
 =?utf-8?B?dmVRVUlvanJlTENqNXZRTStucG5qbW9LS3RDWkRySEd2ZWFHMnlvbVBuWFZY?=
 =?utf-8?B?MVVwK1RSaGNpRjJaNXloMktERWd0OVdpczQwcDhLa2puQm5WSGhNWUtQU1N2?=
 =?utf-8?B?SUVsOGc5Sm40ZkJZQTI5TFpjR1FXdTdjS3NMT2dCWlQxeFM5YzlOemxrb1BF?=
 =?utf-8?B?dE0xN1YwL25CZnNQNkVZVHlyZzFsQ0ZFRVVKS29xSUJ1NE1xRkJJUFYvY1lU?=
 =?utf-8?B?bGFDQS9jaWdFUkdpVktPTFlZKzNEYW0vaU9yd0JGb21YaGc2bVJaZVVjNUtO?=
 =?utf-8?B?MGRrcU0reWlhYkpWZGZCTU04eUZNWVBqNXl6T3Q5WXVxSHErNmpnRVdUTFlB?=
 =?utf-8?B?MFN2UUhiNkkyeGtJMk9mcDZzTkx0dDRZcHpRaFVIbGNBV0ZSeFYwNDBnZC9x?=
 =?utf-8?B?UFAyWURNMTNpWUpHbS9yTyswSWN5dzdjSW5iVkZvK1VaaUU4STQvQUNuQWdj?=
 =?utf-8?B?RElGMFlLMmZKQnZkQjlIdXhVNUFQbXV4aHBtN2dCVTQwaDQwM1hEZ2tSbnpu?=
 =?utf-8?B?TnBKVzloWFlSSm41UkkzUTgrOWZWMDRQVG8xQ3ZrVk9rbk5GMWFZeXNTY1JO?=
 =?utf-8?B?RG5IOThJQnRTQWlrcUxMS3NqNXBxYitDNHNYUDB1Uit6K2IwdytJL3VhbkhM?=
 =?utf-8?B?NUlDaSthT2tiY0tNSVJIK2ptaE0rNUZXekVldHozalB2REJPNncwYjJOQ1Nr?=
 =?utf-8?B?OGZmR2xiTDlvTmxJMFN1NnQrSjhhNUw5ZUlOczhtbW80Z2RWaUVEemdQYmRU?=
 =?utf-8?B?UGZOMjlFUXpTTXpubTJXVjZ0RG8wRGpQeFA4aTFWdHZMd0VZR0xIV3pHanRI?=
 =?utf-8?B?WmVsRnVra2JOYVBGcG02bmhNVjVZcXpzbEdja3BITFRac1RPYmI4dXJ2ZVY3?=
 =?utf-8?B?K2pYdXFQOW1pSEVQZUJGNE4zU3NZSm4ra3FMOWVRZmFhNG8wSnZoVm9jK21x?=
 =?utf-8?B?c3NaZVpiMzVKcEtKMHhwTWkvVUVwS1JXZkNwaFcxWmM5dFRUNXhZMVZOZWFT?=
 =?utf-8?B?Mnp5Rm1EcDg1ckY3MUlWNWlhNVRoZmh5K0VqMlRoaFp2cUVOOGdSd0Y5SXFP?=
 =?utf-8?B?UDZUaVhsOEFKSWNSWXYrUXZwc2JNMjFqdjY0bVp2cHQwbUZkNGw0UkhRYkxj?=
 =?utf-8?Q?Ysks=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26dc2c1-d781-4606-7246-08db951b9d9b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:50:04.5425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaSf3bozMScEgqMoRWT3EsvVIXaDlWOFhm6kXo88Ex8sInvz3JdUMGyjj0yol9Re
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Received-SPF: softfail client-ip=40.107.223.59;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

On 8/4/23 04:56, Zhao Liu wrote:
> Hi Babu,
> 
> On Thu, Aug 03, 2023 at 03:44:13PM -0500, Moger, Babu wrote:
>> Date: Thu, 3 Aug 2023 15:44:13 -0500
>> From: "Moger, Babu" <babu.moger@amd.com>
>> Subject: Re: [PATCH v3 16/17] i386: Use CPUCacheInfo.share_level to encode
>>  CPUID[0x8000001D].EAX[bits 25:14]
>>
>> Hi Zhao,
>>   Please copy the thread to kvm@vger.kernel.org also.  It makes it easier
>> to browse.
>>
> 
> OK. I'm not sure how to cc, should I forward all mail to KVM for the
> current version (v3), or should I cc the kvm mail list for the next
> version (v4)?

Yes. From v4.
Thanks
Babu
> 
>>
>> On 8/1/23 05:35, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> CPUID[0x8000001D].EAX[bits 25:14] is used to represent the cache
>>> topology for amd CPUs.
>> Please change this to.
>>
>>
>> CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
>> processors sharing cache. The number of
>> logical processors sharing this cache is NumSharingCache + 1.
> 
> OK.
> 
> Thanks,
> Zhao
> 
>>
>>>
>>> After cache models have topology information, we can use
>>> CPUCacheInfo.share_level to decide which topology level to be encoded
>>> into CPUID[0x8000001D].EAX[bits 25:14].
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>> Changes since v1:
>>>  * Use cache->share_level as the parameter in
>>>    max_processor_ids_for_cache().
>>> ---
>>>  target/i386/cpu.c | 10 +---------
>>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index f67b6be10b8d..6eee0274ade4 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -361,20 +361,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>                                         uint32_t *eax, uint32_t *ebx,
>>>                                         uint32_t *ecx, uint32_t *edx)
>>>  {
>>> -    uint32_t num_apic_ids;
>>>      assert(cache->size == cache->line_size * cache->associativity *
>>>                            cache->partitions * cache->sets);
>>>  
>>>      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
>>>                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
>>> -
>>> -    /* L3 is shared among multiple cores */
>>> -    if (cache->level == 3) {
>>> -        num_apic_ids = 1 << apicid_die_offset(topo_info);
>>> -    } else {
>>> -        num_apic_ids = 1 << apicid_core_offset(topo_info);
>>> -    }
>>> -    *eax |= (num_apic_ids - 1) << 14;
>>> +    *eax |= max_processor_ids_for_cache(topo_info, cache->share_level) << 14;
>>>  
>>>      assert(cache->line_size > 0);
>>>      assert(cache->partitions > 0);
>>
>> -- 
>> Thanks
>> Babu Moger

-- 
Thanks
Babu Moger


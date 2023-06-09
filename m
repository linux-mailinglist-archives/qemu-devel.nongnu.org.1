Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2453729279
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7XHG-0003o7-9L; Fri, 09 Jun 2023 04:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyanan55@huawei.com>)
 id 1q7XH9-0003na-1B
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:15:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyanan55@huawei.com>)
 id 1q7XH1-0005lh-V8
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:15:11 -0400
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qcv2L6ntLztQW8;
 Fri,  9 Jun 2023 16:12:26 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 16:14:50 +0800
Message-ID: <868e0bae-0426-a874-d703-91967a2b8079@huawei.com>
Date: Fri, 9 Jun 2023 16:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] i386/cpu: Don't emulate L3 cache on 8000_001D if l3-cache
 is disabled
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Michael Roth <michael.roth@amd.com>,
 <qemu-devel@nongnu.org>
CC: <yuzenghui@huawei.com>, <zhangjianguo18@huawei.com>,
 <wanghaibin.wang@huawei.com>
References: <20230531120028.25144-1-wangyanan55@huawei.com>
 <3f060dcb-fb7c-683f-7543-8e8c615f3ed5@intel.com>
In-Reply-To: <3f060dcb-fb7c-683f-7543-8e8c615f3ed5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=wangyanan55@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  "wangyanan (Y)" <wangyanan55@huawei.com>
From:  "wangyanan (Y)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

在 2023/6/2 14:52, Xiaoyao Li 写道:
> On 5/31/2023 8:00 PM, Yanan Wang wrote:
>> Currently, we only avoid emulating L3 cache properties for AMD CPU
>> when l3-cache is off, but failed to consider this case on CPUID 
>> 8000_001D.
>> This result in a fact that we will still have L3 caches in the VM
>> although we pass "host-cache-info=off,l3-cache=off" CLI to qemu.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Thanks.
>
> Out of curiosity, do you have a valid real use case to run VM with 
> "l3-cache = off"?
No, actually. This problem is found just in testing.

Yanan.
>
>> Fixes: 8f4202fb108 ("i386: Populate AMD Processor Cache Information 
>> for cpuid 0x8000001D")
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   target/i386/cpu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 1242bd541a..17c367c5ba 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6337,8 +6337,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>> index, uint32_t count,
>>                                          &topo_info, eax, ebx, ecx, 
>> edx);
>>               break;
>>           case 3: /* L3 cache info */
>> - encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
>> -                                       &topo_info, eax, ebx, ecx, edx);
>> +            if (cpu->enable_l3_cache) {
>> + encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
>> +                                           &topo_info, eax, ebx, 
>> ecx, edx);
>> +            }
>>               break;
>>           default: /* end of info */
>>               *eax = *ebx = *ecx = *edx = 0;
>
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C62027A5AD0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiV5W-0003Sc-6o; Tue, 19 Sep 2023 03:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiV5S-0003S8-SR; Tue, 19 Sep 2023 03:23:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiV5Q-0003z0-NQ; Tue, 19 Sep 2023 03:23:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D74872318B;
 Tue, 19 Sep 2023 10:24:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8EE8928F4E;
 Tue, 19 Sep 2023 10:23:51 +0300 (MSK)
Message-ID: <5bd5a600-e7a5-fe37-1a2f-d00aa7e84428@tls.msk.ru>
Date: Tue, 19 Sep 2023 10:23:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Stable-8.1.1 11/34] softmmu: Assert data in bounds in
 iotlb_to_section
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
 <20230909102747.346522-11-mjt@tls.msk.ru>
 <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru>
In-Reply-To: <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

18.09.2023 12:19, Michael Tokarev wrote:
> 09.09.2023 13:27, Michael Tokarev wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Acked-by: Alex Bennée <alex.bennee@linaro.org>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> (cherry picked from commit 86e4f93d827d3c1efd00cd8a906e38a2c0f2b5bc)
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>>
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 3df73542e1..7597dc1c39 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>>       int asidx = cpu_asidx_from_attrs(cpu, attrs);
>>       CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
>>       AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
>> -    MemoryRegionSection *sections = d->map.sections;
>> +    int section_index = index & ~TARGET_PAGE_MASK;
>> +    MemoryRegionSection *ret;
>> +
>> +    assert(section_index < d->map.sections_nb);
> 
> This assert now triggers on staging-8.1
> 
> https://ci.debian.net/data/autopkgtest/testing/amd64/d/dropbear/37993610/log.gz
> https://ci.debian.net/data/autopkgtest/testing/amd64/c/cryptsetup/37993606/log.gz
> 
>> +    ret = d->map.sections + section_index;
>> +    assert(ret->mr);
>> +    assert(ret->mr->ops);
>> -    return &sections[index & ~TARGET_PAGE_MASK];
>> +    return ret;
>>   }
>>   static void io_mem_init(void)
> 
> In this upload I removed softmmu-Use-async_run_on_cpu-in-tcg_commit.patch (0d58c660689f6da1),
> and the test run uses tcg and -smp 4, which is the configuration which 0d58c6606
> was supposed to fix.

So, should this change not be in 8.1.1 too (together with 0d58c6606),
or is it just the "messenger"?

Or both should go?

Today is the deadline day for 8.1.1.

Thanks!

/mjt


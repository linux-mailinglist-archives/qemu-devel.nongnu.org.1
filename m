Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0B7C6154
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 02:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqjBt-0006Hd-Hu; Wed, 11 Oct 2023 20:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qqjBr-0006HI-Rr
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:04:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qqjBp-0000Pg-QD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 20:04:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32615eaa312so360063f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697069072; x=1697673872; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HupSkrEWNHMj1fERoz4SiEugGSlMx1IhoH/Ah1hz8KU=;
 b=MlJ0fMD6KS9M0HrkarZeI9j7VCe4GWKktHlZ44UlnLz4Cd2LRfTyPUSqR3TKypy6BE
 7KxXFzjjgvWuUKgGgY0NxJNWg+tn/xLKdjvT9DBVeNDw9J54ApiSRYNm5rsyIMOGeSoL
 zAy+0WxmIBe/Lbc+KdlfMLw9afZzN3xoAySvy0PgePWvSCYEfgCHu9Yf3oFtPDiTgdMJ
 +5LeGozBTYQuFwhRGp2FdVXAbQuYaApT41W29pVKJwAk2zo++9bLFSdt1M4t2PTj0jJ6
 QxmoOJxj/v93ine0R2fOE/dZclVyjqX1zxIfGmuXgq8ohWJz+7RGnXmg3TY0SsfK7Pjk
 yDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697069072; x=1697673872;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HupSkrEWNHMj1fERoz4SiEugGSlMx1IhoH/Ah1hz8KU=;
 b=LCDcMNyaFgLg96L+a3SFLzUbzLW1OMiAd1X6aYDy+bHJuhGZLJw7TuPdEcB/sK0yIY
 fRzZYzAEllViCOfNvG7nqn5gPOe4RBWjEiMjou+mJvSh2MzBcvGe7DbGbT23iiT5pV80
 v/dq/ElxnCA9KR7wA1Tuyqb8LrRLSRe0hGY07AKKCKvoZhKekgk6W3xAc4NCzmgzkkEb
 /wSc+56ftgoLOrbU6nXmNvLpFVMlcAQE1qrEbq1LzgPO359aZB+HcQqBo1mTabcq7N3I
 YmO7D3NkGLE98bKB0SvQQkckmGl1cnJMmugLlryXU5MkdBEv9MoIgn6R8613gRud7iHY
 RvCw==
X-Gm-Message-State: AOJu0YzL7/n8/NHxdDeXeBUlylRQUpxag1ML6qMcTYclo0kivE5LfFXT
 fIrER9VeqyqJ/hwz8vS1+EWODA==
X-Google-Smtp-Source: AGHT+IFOmWM/9hH+3k2udZcOlNFMutJ0qoGhgEP4ILSNOIbn0YBjKItBOQD9mEhZ3hnICZV4pOEWcg==
X-Received: by 2002:adf:fdd0:0:b0:321:6fe4:d4eb with SMTP id
 i16-20020adffdd0000000b003216fe4d4ebmr18813209wrs.2.1697069071887; 
 Wed, 11 Oct 2023 17:04:31 -0700 (PDT)
Received: from [10.8.0.16] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a5d4389000000b0031ad5fb5a0fsm16689726wrq.58.2023.10.11.17.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 17:04:31 -0700 (PDT)
Subject: Re: [PATCH V5 8/9] physmem: Add helper function to destroy CPU
 AddressSpace
To: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-9-salil.mehta@huawei.com>
 <69098d56-8b68-2734-ef40-7338386d7fa9@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Message-ID: <e73217f7-e6c2-81e7-0174-54ef575ebbce@opnsrc.net>
Date: Thu, 12 Oct 2023 01:04:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <69098d56-8b68-2734-ef40-7338386d7fa9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x433.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Gavin,

On 12/10/2023 00:31, Gavin Shan wrote:
> Hi Salil,
> 
> On 10/12/23 05:43, Salil Mehta wrote:
>> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
>> involves destruction of the CPU AddressSpace. Add common function to help
>> destroy the CPU AddressSpace.
>>
>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>> ---
>>   include/exec/cpu-common.h |  8 ++++++++
>>   include/hw/core/cpu.h     |  1 +
>>   softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
> 
> I guess you need another respin since 'softmmu/physmem.c' has been
> renamed to 'system/physmem.c' by 8d7f2e767d ("system: Rename softmmu/
> directory as system/"). 


Gosh. Will do.

So please consider leveraging the respin chance
> to address the following minor comments. With that,
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 41788c0bdd..eb56a228a2 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>>    */
>>   void cpu_address_space_init(CPUState *cpu, int asidx,
>>                               const char *prefix, MemoryRegion *mr);
>> +/**
>> + * cpu_address_space_destroy:
>> + * @cpu: CPU for which address space needs to be destroyed
>> + * @asidx: integer index of this address space
>> + *
>> + * Note that with KVM only one address space is supported.
>> + */
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>>                               hwaddr len, bool is_write);
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 648b5b3586..65d2ae4581 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -355,6 +355,7 @@ struct CPUState {
>>       QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>>       CPUAddressSpace *cpu_ases;
>> +    int cpu_ases_count;
> 
> The prefix 'cpu_' is duplicate here because the container (CPUState)
> indicates it explicitly. I think it was inherited from @cpu_ases.
> Besides, @ases_count seems not better than @remaining_ases. If it
> makes sense, please rename it to @remaining_ases
> 
>>       int num_ases;
>>       AddressSpace *as;
>>       MemoryRegion *memory;
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 4f6ca653b3..4dfa0ca66f 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>>       if (!cpu->cpu_ases) {
>>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
>> +        cpu->cpu_ases_count = cpu->num_ases;
>>       }
>>       newas = &cpu->cpu_ases[asidx];
>> @@ -774,6 +775,30 @@ void cpu_address_space_init(CPUState *cpu, int 
>> asidx,
>>       }
>>   }
>> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
>> +{
>> +    CPUAddressSpace *cpuas;
>> +
>> +    assert(asidx < cpu->num_ases);
>> +    assert(asidx == 0 || !kvm_enabled());
>> +    assert(cpu->cpu_ases);
>> +
> 
> The two asserts on @asidx and @cpu->cpu_ases can be combined
> to one so that these 3 asserts can be combined to two.
> 
>         /* Only one address space is supported by KVM */
>         assert(asidx == 0 || !kvm_enabled());
>         assert(asidx >= 0 && asidx < cpu->cpu_ases_count)

We can do that.

I am not in favor to remove  'assert(cpu->cpu_ases);' as this can save 
lot of debugging.


> 
>> +    cpuas = &cpu->cpu_ases[asidx];
>> +    if (tcg_enabled()) {
>> +        memory_listener_unregister(&cpuas->tcg_as_listener);
>> +    }
>> +
> 
> We need to detach CPUState::as here if @asidx == 0 because the alias was
> populated in cpu_address_space_init(). Even the CPUState is going to be
> release pretty soon, we have inconsistent states temporarily.
> 
>         /* Detach the alias to address space 0 */
>         if (asidx == 0) {
>             cpu->as = NULL;
>         }


Yes. Good catch.

Thanks.


>> +    address_space_destroy(cpuas->as);
>> +    g_free_rcu(cpuas->as, rcu);
>> +
>> +    if (cpu->cpu_ases_count == 1) {
>> +        g_free(cpu->cpu_ases);
>> +        cpu->cpu_ases = NULL;
>> +    }
>> +
>> +    cpu->cpu_ases_count--;
>> +}
>> +
> 
> I'm not sure, but Linux's kref_put() decreases the reference count before
> the object is released. In order to follow that pattern, we need something
> like below. However, it's something related to personal taste, I guess :)
> 
>         if (--cpu->cpu_ases_count == 0) {
>             g_free(cpu->cpu_ases);
>             cpu->cpu_ases = NULL;
>         }

I can see your point but the only way this can cause race is when 
multiple CPUs are being destroyed simultaneously. I am not sure that 
will ever happen. Hence, this code might not either be required or will 
be insufficient to avoid the race you are pointing at.

Anyway, I do not mind changing to above.

Thanks
Salil.


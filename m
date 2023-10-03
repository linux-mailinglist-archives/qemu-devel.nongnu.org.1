Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2117B6071
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnY3c-0001MU-8F; Tue, 03 Oct 2023 01:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnY3a-0001Ld-Dr
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnY3Y-0000D9-4E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696311291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyM7OqyiATgS8HigwYZfJJrs0gBnSktAGCIRTdSZaH4=;
 b=C+7YWqA4HI8PB+F9UNrWaa6R0KwWsdG8Fw1bIGNokO857WDFPejM8Nd/Fz6bj1gYCrRRoj
 92mONAsqBKGXYeLKM2rYx9uMX2G+WWOB3R2/zJz8EhT4ZwHXI2EtTdpX61N+NYCVRk76xb
 mp+hspJpHIu+6FszUN7AidReN2ub+Hg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-jxMAHXMWOBmaOOYi30oyww-1; Tue, 03 Oct 2023 01:34:49 -0400
X-MC-Unique: jxMAHXMWOBmaOOYi30oyww-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-692161c3948so457997b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 22:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696311288; x=1696916088;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pyM7OqyiATgS8HigwYZfJJrs0gBnSktAGCIRTdSZaH4=;
 b=mV48Oj8ROjY3yVqik7O+lXUfYRsq3ZkV/ZYvO9amUzrXavyJphe17cu6mJ4cwSRjQE
 GF7MyUEXCBnO2NmExA8OcxZQ19h/V44nardmcjKi50fjmVPIsATYmEDzoJoo1JHPJvNN
 HlcoUSgA1eDJWtyDOQ9QmQwl2mEyLlXKH3I8hs8Y2CGBiRK3sJcZBS39ex2GK/akot5V
 emIxxzjHZDIh8Tij8Ys8lTb7tH5/rxjFdjDM7cSFH97bRZkNCsOP7rGo3I0xVjp2MhqG
 /+rK+oxIJIl8xEqN/9iNb0XdSyCoCSeX2iOFn7aParuchHWW0Ml0A5w4xbqkzPr7qw7K
 ZUeg==
X-Gm-Message-State: AOJu0YwQcMIH6VKBf4NJGh29C8wk8kPhD3OGmND9FvrlAtmW8nsvjOw8
 krdgqJNP70p21a+OZ7N5h646usluItQQuyy0WoRUruKKjihdHJcBhqHC110WyClfoycJmwwK8h9
 SZIGhYJsX3a1ulNo=
X-Received: by 2002:a05:6a00:895:b0:68e:2c2a:5172 with SMTP id
 q21-20020a056a00089500b0068e2c2a5172mr2522866pfj.6.1696311288358; 
 Mon, 02 Oct 2023 22:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08vY2Xf/54ObMagaNkyt2w79YO2kI5U9jR6eJifkEarKgLYQ8ZEwHdPZcCN4zPk6JdreUPg==
X-Received: by 2002:a05:6a00:895:b0:68e:2c2a:5172 with SMTP id
 q21-20020a056a00089500b0068e2c2a5172mr2522840pfj.6.1696311287976; 
 Mon, 02 Oct 2023 22:34:47 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a656a94000000b00553dcfc2179sm405677pgu.52.2023.10.02.22.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 22:34:47 -0700 (PDT)
Message-ID: <adb880c1-f90b-30b5-6066-95dff426971e@redhat.com>
Date: Tue, 3 Oct 2023 15:34:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 02/37] cpus-common: Add common CPU utility for
 possible vCPUs
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-3-salil.mehta@huawei.com>
 <44e4f955-ab51-92ca-8d65-e3a38d8d6657@redhat.com>
 <b002d32909f64a048371ff501bcedfc3@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <b002d32909f64a048371ff501bcedfc3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 10/2/23 20:21, Salil Mehta wrote:
>> From: Gavin Shan <gshan@redhat.com>
>> Sent: Wednesday, September 27, 2023 4:54 AM
>> To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org
>> Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> imammedo@redhat.com; andrew.jones@linux.dev; david@redhat.com;
>> philmd@linaro.org; eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
>> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
>> rafael@kernel.org; borntraeger@linux.ibm.com; alex.bennee@linaro.org;
>> linux@armlinux.org.uk; darren@os.amperecomputing.com;
>> ilkka@os.amperecomputing.com; vishnu@os.amperecomputing.com;
>> karl.heubaum@oracle.com; miguel.luis@oracle.com; salil.mehta@opnsrc.net;
>> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
>> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 02/37] cpus-common: Add common CPU utility for
>> possible vCPUs
>>
>> Hi Salil,
>>
>> On 9/26/23 20:04, Salil Mehta wrote:
>>> Adds various utility functions which might be required to fetch or check
>> the
>>> state of the possible vCPUs. This also introduces concept of *disabled*
>> vCPUs,
>>> which are part of the *possible* vCPUs but are not part of the *present*
>> vCPU.
>>> This state shall be used during machine init time to check the presence
>> of
>>> vcpus.
>>     ^^^^^
>>
>>     vCPUs
> 
> 
> Yes. Thanks.
> 
> 
>>> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> ---
>>>    cpus-common.c         | 31 +++++++++++++++++++++++++
>>>    include/hw/core/cpu.h | 53 +++++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 84 insertions(+)
>>>
>>> diff --git a/cpus-common.c b/cpus-common.c
>>> index 45c745ecf6..24c04199a1 100644
>>> --- a/cpus-common.c
>>> +++ b/cpus-common.c
>>> @@ -24,6 +24,7 @@
>>>    #include "sysemu/cpus.h"
>>>    #include "qemu/lockable.h"
>>>    #include "trace/trace-root.h"
>>> +#include "hw/boards.h"
>>>
>>>    QemuMutex qemu_cpu_list_lock;
>>>    static QemuCond exclusive_cond;
>>> @@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)
>>>        cpu_list_generation_id++;
>>>    }
>>>
>>> +CPUState *qemu_get_possible_cpu(int index)
>>> +{
>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
>>> +
>>> +    assert((index >= 0) && (index < possible_cpus->len));
>>> +
>>> +    return CPU(possible_cpus->cpus[index].cpu);
>>> +}
>>> +
>>> +bool qemu_present_cpu(CPUState *cpu)
>>> +{
>>> +    return cpu;
>>> +}
>>> +
>>> +bool qemu_enabled_cpu(CPUState *cpu)
>>> +{
>>> +    return cpu && !cpu->disabled;
>>> +}
>>> +
>>
>> I do think it's a good idea to have wrappers to check for CPU's states since
>> these CPU states play important role in this series to support vCPU hotplug.
>> However, it would be nice to move them around into header file (include/hw/boards.h)
>> because all the checks are originated from ms->possible_cpus->cpus[]. It sounds
>> functions to a machine (board) instead of global scope. Besides, it would be
>> nice to have same input (index) for all functions. How about something like
>> below in include/hw/boards.h?
> 
> These are operations related to CPUState and hence cpus-common.c seem to be
> more appropriate to me. You can see similar functions like qemu_get_cpu()
> already exists in the same file.
> 
> Yes, some operation do make use of the possible list which is maintained at
> board level but eventually what we are returning is the CPUState.
> 
> I am open to move some of above to board level not all like present,
> enabled checks should exist in this file only. I would prefer to keep
> all of them in this file.
> 

There are two lists (arrays): ms->possible_cpus->cpus[] and cpus-common.c::cpus.
The former one is a board's property and the later is a global property. In our
implementation, the vCPU state depends on ms->possible_cpus->cpus[], for example:

- The possible vCPU is determined by checking its index falls in the range of
   [0, ms->possible_cpus->len]
- The present vCPU is determined by checking ms->possible_cpus->cpus[index].cpu

However, other two states have to be determined by checking CPUState

- CPUState::acpi_persistent, for always-present vCPUs
- CPUState::disabled, for enabled vCPU

As suggested in other replies, we may manage the vCPU states from board level
due the fact: the vCPU state changes on Creation, hot-add or hot-remove, which
are all driven by a board. Besides, the hotplug handler is managed by board.
Lastly, scatting the information in different places (ms->possible_cpus->cpus[]
and CPUState), which helps to determine vCPU states, seems not a good idea.

In order to maintain all the information in board level, 'struct CPUArchId'
need some adaption like below. With it, the vCPU states can be determined
from ms->possible_cpus.

#define CPU_ARCH_ID_FLAG_ALWAYS_PRESENT		(1UL << 0)
#define CPU_ARCH_ID_FLAG_ENABLED		(1UL << 1)
typedef struct CPUArchId {
     unsigned long flags
        :
};

> 
>>
>> static inline  bool machine_has_possible_cpu(int index)
>> {
>>       MachineState *ms = MACHINE(qdev_get_machine());
>>
>>       if (!ms || !ms->possible_cpus || index < 0 || index >= ms-
>>> possible_cus->len) {
>>           return false;
>>       }
>>
>>       return true;
>> }
>>
>> static inline bool machine_has_present_cpu(int index)
>> {
>>       MachineState *ms = MACHINE(qdev_get_machine());
>>
>>       if (!machine_is_possible_cpu(index) ||
>>           !ms->possible_cpus->cpus[index].cpu) {
>>           return false;
>>       }
>>
>>       return true;
>> }
>>
>> static inline bool machine_has_enabled_cpu(int index)
>> {
>>       MachineState *ms = MACHINE(qdev_get_machine());
>>       CPUState *cs;
>>
>>       if (!machine_is_present_cpu(index)) {
>>           return false;
>>       }
>>
>>       cs = CPU(ms->possible_cpus->cpus[index].cpu);
>>       return !cs->disabled
>> }
>>
>>> +uint64_t qemu_get_cpu_archid(int cpu_index)
>>> +{
>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
>>> +
>>> +    assert((cpu_index >= 0) && (cpu_index < possible_cpus->len));
>>> +
>>> +    return possible_cpus->cpus[cpu_index].arch_id;
>>> +}
>>> +
>>
>> I think it's unnecessary to keep it since it's called for once by
>> hw/arm/virt-acpi-build.c::build_madt. The architectural ID can be
>> directly fetched from possible_cpus->cpus[i].arch_id. It's fine
>> to drop this function and fold the logic to the following patch.
> 
> It is a very useful accessor API. I can see this code is being
> replicated everywhere which also means many time its related
> variables are repeatedly defined.
> 
> Maybe this is being used once now. But this can be used across
> architectures later.
> 

Ok, then please make it inline at least.

>>
>> [PATCH RFC V2 21/37] hw/arm: MADT Tbl change to size the guest with
>> possible vCPUs
>>
>>
>>>    CPUState *qemu_get_cpu(int index)
>>>    {
>>>        CPUState *cpu;
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index fdcbe87352..e5af79950c 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -413,6 +413,17 @@ struct CPUState {
>>>        SavedIOTLB saved_iotlb;
>>>    #endif
>>>
>>> +    /*
>>> +     * Some architectures do not allow *presence* of vCPUs to be changed
>>> +     * after guest has booted using information specified by VMM/firmware
>>> +     * via ACPI MADT at the boot time. Thus to enable vCPU hotplug on these
>>> +     * architectures possible vCPU can have CPUState object in 'disabled'
>>> +     * state or can also not have CPUState object at all. This is possible
>>> +     * when vCPU Hotplug is supported and vCPUs are 'yet-to-be-plugged' in
>>> +     * the QOM or have been hot-unplugged.
>>> +     * By default every CPUState is enabled as of now across all archs.
>>> +     */
>>> +    bool disabled;
>>>        /* TODO Move common fields from CPUArchState here. */
>>>        int cpu_index;
>>>        int cluster_index;
>>
>> I guess the comments can be simplified a bit. How about something like
>> below?
>>       /*
>>        * In order to support vCPU hotplug on architectures like aarch64,
>>        * the vCPU states fall into possible, present or enabled. This field
>>        * is added to distinguish present and enabled vCPUs. By default, all
>>        * vCPUs are present and enabled.
>>        */
> 
> I can definitely try to simplify it but above is not properly conveying the
> reason why we require the disabled state.
> 

Ok, I think the association between this field and MDAT still need to be
mentioned.
  
>>
>>> @@ -770,6 +781,48 @@ static inline bool cpu_in_exclusive_context(const
>> CPUState *cpu)
>>>     */
>>>    CPUState *qemu_get_cpu(int index);
>>>
>>> +/**
>>> + * qemu_get_possible_cpu:
>>> + * @index: The CPUState@cpu_index value of the CPU to obtain.
>>> + *         Input index MUST be in range [0, Max Possible CPUs)
>>> + *
>>> + * If CPUState object exists,then it gets a CPU matching
>>> + * @index in the possible CPU array.
>>> + *
>>> + * Returns: The possible CPU or %NULL if CPU does not exist.
>>> + */
>>> +CPUState *qemu_get_possible_cpu(int index);
>>> +
>>> +/**
>>> + * qemu_present_cpu:
>>> + * @cpu: The vCPU to check
>>> + *
>>> + * Checks if the vCPU is amongst the present possible vcpus.
>>> + *
>>> + * Returns: True if it is present possible vCPU else false
>>> + */
>>> +bool qemu_present_cpu(CPUState *cpu);
>>> +
>>> +/**
>>> + * qemu_enabled_cpu:
>>> + * @cpu: The vCPU to check
>>> + *
>>> + * Checks if the vCPU is enabled.
>>> + *
>>> + * Returns: True if it is 'enabled' else false
>>> + */
>>> +bool qemu_enabled_cpu(CPUState *cpu);
>>> +
>>> +/**
>>> + * qemu_get_cpu_archid:
>>> + * @cpu_index: possible vCPU for which arch-id needs to be retreived
>>> + *
>>> + * Fetches the vCPU arch-id from the present possible vCPUs.
>>> + *
>>> + * Returns: arch-id of the possible vCPU
>>> + */
>>> +uint64_t qemu_get_cpu_archid(int cpu_index);
>>> +

Thanks,
Gavin



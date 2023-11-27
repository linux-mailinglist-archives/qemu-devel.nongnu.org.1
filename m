Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F87F9CEE
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:54:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7YJ8-0005s9-2v; Mon, 27 Nov 2023 04:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r7YIy-0005px-BX
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:53:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r7YIo-0003lO-KR
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701078796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6S5ZZqc2/yOEvrP8To9FIsw2F7vPwlcHaWZ7RqmM9g=;
 b=UR9k2ADobR3pk+XwStmB4zpzdD9t1hhrGOSJaZoM037rKuaOqefy4fjPXNETtmaG/VVKdO
 1fziY2KW/mVteYGnteg0CAuS8Fw5JYQWxvwWEAmiCL0+pxTe12GYjUNia4TQ5ujPbBl9L5
 ipDho534sGg785j931sfCmR6krRIjAw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-nhVLW9UkM220fxttLaMifg-1; Mon, 27 Nov 2023 04:53:13 -0500
X-MC-Unique: nhVLW9UkM220fxttLaMifg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1cfb93fa6c1so4784985ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 01:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701078793; x=1701683593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6S5ZZqc2/yOEvrP8To9FIsw2F7vPwlcHaWZ7RqmM9g=;
 b=fncORaI6+aFPjrJwTNS4T29NZvgZaZEDarbphkf8Y98bSiy8cbU8uGH8jZJJjHhR0J
 SWijKAHtII684xVkD3UJ5NTBF38zk49clSMJk0ZsINFjpxldJPMwQ3aGWcJF+ajmwwmw
 BOiNoOv/ztC1szN9aNOBeCX/erM8mOtL7DT5C21V7nFgg2LCbHtg9kb8O0RR8oeCy3sT
 7ycORkZTVR2GHyUFZY7ihPS6HqtasuC3HjcUp5RpI1huI34BgmzFhh+FyrfnYgZJ4vk4
 /tG4Ns8qfBbZOC+7InroksnEFRalgmY9OygZ7D4sfmM0j0v8lwuKRSrsBRRo4RmcA3vV
 5kzg==
X-Gm-Message-State: AOJu0YwfVn2BB3onBEjHHDf3HAOsrAqQ5zG8BseCa3nHt6G1x/JRRoeN
 juXnK84+XQvw3RZdQUs3rTo65ubXpD2R7Ju+e0ESt4tFMR2B0qG3/Z1CQxUg22pEXrtssg96EbC
 /3lPW6B7+g5zocQY=
X-Received: by 2002:a17:902:8685:b0:1cf:ce83:3b5d with SMTP id
 g5-20020a170902868500b001cfce833b5dmr2639519plo.6.1701078792778; 
 Mon, 27 Nov 2023 01:53:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOg4kADTllyOIs5S1oSl6a7oUXXPuwQQ5sWiqXnHTwfUJzcciPoNBNQqrJfNE3EZy7N4ATWQ==
X-Received: by 2002:a17:902:8685:b0:1cf:ce83:3b5d with SMTP id
 g5-20020a170902868500b001cfce833b5dmr2639505plo.6.1701078792335; 
 Mon, 27 Nov 2023 01:53:12 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170902d35200b001cf838dadbesm7841072plk.56.2023.11.27.01.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 01:53:11 -0800 (PST)
Message-ID: <8bf20712-2788-6636-a7b8-c504cf80114a@redhat.com>
Date: Mon, 27 Nov 2023 17:53:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20231117060838.39723-1-shahuang@redhat.com>
 <b00544d2-1a0e-4aa6-b56a-fbe3e18f817d@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <b00544d2-1a0e-4aa6-b56a-fbe3e18f817d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.477, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 11/24/23 18:40, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 11/17/23 07:08, Shaoqin Huang wrote:
>> The KVM_ARM_VCPU_PMU_V3_FILTER provide the ability to let the VMM decide
>> which PMU events are provided to the guest. Add a new option
>> `pmu-filter` as -accel sub-option to set the PMU Event Filtering.
> you remind the reader the default policy without filter (ie. expose all
> events from the hots)

Yes. I will add this description to the default policy.

>>
>> The `pmu-filter` has such format:
>>
>>    pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
>>
>> The A means "allow" and D means "deny", start is the first event of the
>> range and the end is the last one. The first filter action defines if the whole
>> event list is an allow or deny list, if the first filter action is "allow", all
>> other events are denied except start-end; if the first filter action is "deny",
>> all other events are allowed except start-end. For example:
> 
> I prefer the kernel doc wording
> The first registered range defines the global policy (global ALLOW if
> the first @action is DENY, global DENY if the first @action is ALLOW).

I can replace it this by kernel doc description in next version.

>>
>>    pmu-filter="A:0x11-0x11;A:0x23-0x3a,D:0x30-0x30"
> shoudn't the "," be replaced by a ";"?

Yes. Thanks for catching this. It should be ";".

> 
> 
> I would add: since the first action is allow, we have a global deny policy.

That makes the example more clear, will add it.

>>
>> This will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
>> also allowed except the event 0x30 is denied, and all the other events
>> are disallowed.
>>
>> Here is an real example shows how to use the PMU Event Filtering, when
>> we launch a guest by use kvm, add such command line:
>>
>>    # qemu-system-aarch64 \
>> 	-accel kvm,pmu-filter="D:0x11-0x11"
> Since the first filter action is deny, we have a global allow policy.
> this disables the filtering of the cycle counter (event 0x11 being
> CPU_CYCLES)
> 
> kernel doc says that the ranges should match the PMU arch (10 bits on
> ARMv8.0, 16 bits from ARMv8.1 onwards). How do you handle that?

Currently I think I can rely on the SET_DEVICE_ATTR, when set the 
KVM_ARM_VCPU_PMU_V3_FILTER, check the errno number, if it equals to 
EINVAL, then report the error to the use it's an invalid filter.

Or another way is to detect the ARM version, and do more check in the 
userspace?

Do you have any good suggestions on handle the two different event space 
in QEMU?

>>
>> And then in guest, use the perf to count the cycle:
>>
>>    # perf stat sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>                1.22 msec task-clock                       #    0.001 CPUs utilized
>>                   1      context-switches                 #  820.695 /sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  55      page-faults                      #   45.138 K/sec
>>     <not supported>      cycles
>>             1128954      instructions
>>              227031      branches                         #  186.323 M/sec
>>                8686      branch-misses                    #    3.83% of all branches
>>
>>         1.002492480 seconds time elapsed
>>
>>         0.001752000 seconds user
>>         0.000000000 seconds sys
>>
>> As we can see, the cycle counter has been disabled in the guest, but
>> other pmu events are still work.
> 
> perf list should work as well

It works, should I post it output at here?

>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>> v1->v2:
>>    - Add more description for allow and deny meaning in
>>      commit message.                                     [Sebastian]
>>    - Small improvement.                                  [Sebastian]
>>
>> v1: https://lore.kernel.org/all/20231113081713.153615-1-shahuang@redhat.com/
>> ---
>>   include/sysemu/kvm_int.h |  1 +
>>   qemu-options.hx          | 16 +++++++++++++
>>   target/arm/kvm.c         | 22 +++++++++++++++++
>>   target/arm/kvm64.c       | 51 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 90 insertions(+)
>>
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index fd846394be..8f4601474f 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -120,6 +120,7 @@ struct KVMState
>>       uint32_t xen_caps;
>>       uint16_t xen_gnttab_max_frames;
>>       uint16_t xen_evtchn_max_pirq;
>> +    char *kvm_pmu_filter;
>>   };
>>   
>>   void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 42fd09e4de..dd3518092c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -187,6 +187,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>>       "                tb-size=n (TCG translation block cache size)\n"
>>       "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
>>       "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
>> +    "                pmu-filter={A,D}:start-end[;...] (KVM PMU Event Filter, default no filter. ARM only)\n"
>>       "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
>>       "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
>>   SRST
>> @@ -259,6 +260,21 @@ SRST
>>           impact on the memory. By default, this feature is disabled
>>           (eager-split-size=0).
>>   
>> +    ``pmu-filter={A,D}:start-end[;...]``
>> +        KVM implements pmu event filtering to prevent a guest from being able to
>> +	sample certain events. It has the following format:
>> +
>> +	pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
> you may add []* to express that you have any number of ranges
>> +
>> +	The A means "allow" and D means "deny", start if the first event of the
>> +	range and the end is the last one. For example:
>> +
>> +	pmu-filter="A:0x11-0x11;A:0x23-0x3a,D:0x30-0x30"
> is is hex format only?

Yes, only support hex format now. Because we need to handle the input 
string by ourself, handle different format at the input is not 
interesting. If it really need to support different format, we can 
consider it in next version?

>> +
>> +	This will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
>> +	also allowed except the event 0x30 is denied, and all the other events
>> +	are disallowed.
> s/disallowed/hidden?

I think disallowed is properly.

>> +
>>       ``notify-vmexit=run|internal-error|disable,notify-window=n``
>>           Enables or disables notify VM exit support on x86 host and specify
>>           the corresponding notify window to trigger the VM exit if enabled.
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 7903e2ddde..74796de055 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -1108,6 +1108,21 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
>>       s->kvm_eager_split_size = value;
>>   }
>>   
>> +static char *kvm_arch_get_pmu_filter(Object *obj, Error **errp)
>> +{
>> +    KVMState *s = KVM_STATE(obj);
>> +
>> +    return g_strdup(s->kvm_pmu_filter);
>> +}
>> +
>> +static void kvm_arch_set_pmu_filter(Object *obj, const char *pmu_filter,
>> +                                    Error **errp)
>> +{
>> +    KVMState *s = KVM_STATE(obj);
>> +
>> +    s->kvm_pmu_filter = g_strdup(pmu_filter);
> can the user specify the option several times in which case we would
> leak here?

It seems will leak. I should add more code to handle the case here.

>> +}
>> +
>>   void kvm_arch_accel_class_init(ObjectClass *oc)
>>   {
>>       object_class_property_add(oc, "eager-split-size", "size",
>> @@ -1116,4 +1131,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>>   
>>       object_class_property_set_description(oc, "eager-split-size",
>>           "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
>> +
>> +    object_class_property_add_str(oc, "pmu-filter",
>> +                                  kvm_arch_get_pmu_filter,
>> +                                  kvm_arch_set_pmu_filter);
>> +
>> +    object_class_property_set_description(oc, "pmu-filter",
>> +        "PMU Event Filtering description for guest pmu. (default: NULL, disabled)");
>>   }
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index 3c175c93a7..6eac328b48 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -10,6 +10,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include <asm-arm64/kvm.h>
>>   #include <sys/ioctl.h>
>>   #include <sys/ptrace.h>
>>   
>> @@ -131,6 +132,53 @@ static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
>>       return true;
>>   }
>>   
>> +static void kvm_arm_pmu_filter_init(CPUState *cs)
>> +{
>> +    static bool pmu_filter_init = false;
>> +    struct kvm_pmu_event_filter filter;
>> +    struct kvm_device_attr attr = {
>> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
>> +        .addr       = (uint64_t)&filter,
>> +    };
>> +    KVMState *kvm_state = cs->kvm_state;
>> +    char *tmp;
>> +    char *str, act;
>> +
>> +    if (!kvm_state->kvm_pmu_filter)
>> +        return;
>> +
>> +    /* This only needs to be called for 1 vcpu. */
>> +    if (!pmu_filter_init)
>> +        pmu_filter_init = true;
> where is it used?

It's only used in this function. It's a static variable, because the 
pmu_filter only need to be init once from the vcpu ioctl. But the 
kvm_arm_pmu_init() will call the kvm_arm_pmu_filter_init() multiple 
times since every cpu needs to init pmu.

>> +
>> +    tmp = g_strdup(kvm_state->kvm_pmu_filter);
>> +
>> +    for (str = strtok(tmp, ";"); str != NULL; str = strtok(NULL, ";")) {
>> +        unsigned short start = 0, end = 0;
>> +
>> +        sscanf(str, "%c:%hx-%hx", &act, &start, &end);
>> +        if ((act != 'A' && act != 'D') || (!start && !end)) {
>> +            error_report("skipping invalid filter %s\n", str);
>> +            continue;
>> +        }
>> +
>> +        filter = (struct kvm_pmu_event_filter) {
>> +            .base_event     = start,
>> +            .nevents        = end - start + 1,
>> +            .action         = act == 'A' ? KVM_PMU_EVENT_ALLOW :
>> +                                           KVM_PMU_EVENT_DENY,
>> +        };
>> +
>> +        if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
>> +            error_report("Failed to init PMU Event Filter\n");
> you may add some hints about why this failed.

I think I can report it depends on the errno, and gives more detailed 
information for the user.

>> +            abort();
>> +        }
>> +    }
>> +
>> +    g_free(tmp);
>> +}
>> +
>>   void kvm_arm_pmu_init(CPUState *cs)
>>   {
>>       struct kvm_device_attr attr = {
>> @@ -141,6 +189,9 @@ void kvm_arm_pmu_init(CPUState *cs)
>>       if (!ARM_CPU(cs)->has_pmu) {
>>           return;
>>       }
>> +
>> +    kvm_arm_pmu_filter_init(cs);
>> +
>>       if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
>>           error_report("failed to init PMU");
>>           abort();
> 
> I see x86 seems to have a similar capability (see
> KVM_CAP_PMU_EVENT_FILTER). But I am not sure this is integrated in qemu?
> 

I don't see the x86 capability has been integrated into qemu. But I know 
there is a kselftest for this capability on x86.

Thanks,
Shaoqin

> Thanks
> 
> Eric
> 

-- 
Shaoqin



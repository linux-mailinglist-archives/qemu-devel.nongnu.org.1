Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC680BED8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 02:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCVQR-0005DR-Hr; Sun, 10 Dec 2023 20:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rCVQP-0005DA-Bt
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 20:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rCVQM-000278-Q2
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 20:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702259372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCqBfZ1HkhWwkB06lkoTIk7CqVAPs8Ua9cElNqaoVPI=;
 b=WVd4DGluar4309nOBrpb4XwPlOXTCDeICWsd5gMr8IaSl52rwAa7WAIX+Vex5Qha0MdRvS
 JAVsq1epjZ+0lwl7MzcYAIBLdReTLABf15q9EigE1skz9/t5Pkzk612VxJxxrdye3VK0+Z
 68pEgoP4M5Eb/GrC8tsr4yYH/gvcyfc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ZpdHxHmyMOWnymhdvuQ7zQ-1; Sun, 10 Dec 2023 20:49:31 -0500
X-MC-Unique: ZpdHxHmyMOWnymhdvuQ7zQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b9fe44d7daso2372533b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 17:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702259370; x=1702864170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TCqBfZ1HkhWwkB06lkoTIk7CqVAPs8Ua9cElNqaoVPI=;
 b=m7hsFpysrm1+fy+i8Zid4gpeLMm/0crAB6LKy4eAvDhnhFa/gCkoOZCOmig3fa3eew
 cq7DrtRWwCqyORmD1rClkbZTTIXQBGUNNcuYrTa4aqWcx1NzDAglmdSaFVp+QdLg/9Il
 qEqRlh1PLtq2FF5GfRdyWf/yJ9sC74LO6fyJRJkwwKbiD1NAieiZ13HmP8FRkFjkcxZD
 8QGBedN3JH9b7IRF8iI2nTySIRB8up3clIo39clVCf216EmIriUB6uEubfPJrjiqmxic
 zzy1xCvHbrcbdpCL0qknCt1QjdAncr19FoB4kKlEiAy1kAPajRhH8LKc/Z9gbHS35xf2
 GEWA==
X-Gm-Message-State: AOJu0Yz+merudNCzGSKVWvD5bvnkTUpmxwRB9rwjWFYnjWHefp0nmhpa
 OuxaYsZTxzAjGnp38H8T5m3mp+VMYqBn7Qu8sagoPiFf3EQA2psWyFDwp0XDvJ9cId6F4DXRDWC
 RQos6aorhuzE40Vw=
X-Received: by 2002:a05:6808:128b:b0:3b9:dd5e:86f2 with SMTP id
 a11-20020a056808128b00b003b9dd5e86f2mr5208175oiw.13.1702259369667; 
 Sun, 10 Dec 2023 17:49:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPA9BFkNYyULW8I8Zl3eF/RGET7ECdvHJxmAiX96kbgH1Xh5XtqQzjLxe20VPFDmk/Gw2g9w==
X-Received: by 2002:a05:6808:128b:b0:3b9:dd5e:86f2 with SMTP id
 a11-20020a056808128b00b003b9dd5e86f2mr5208144oiw.13.1702259368919; 
 Sun, 10 Dec 2023 17:49:28 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ff16-20020a056a002f5000b006ce742b6b1fsm5141241pfb.63.2023.12.10.17.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Dec 2023 17:49:28 -0800 (PST)
Message-ID: <47d6fd0e-5ad8-4290-b064-ecb76ca8576c@redhat.com>
Date: Mon, 11 Dec 2023 11:49:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20231207103648.2925112-1-shahuang@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231207103648.2925112-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Shaoqin,

On 12/7/23 20:36, Shaoqin Huang wrote:
> The KVM_ARM_VCPU_PMU_V3_FILTER provide the ability to let the VMM decide
                                  ^^^^^^^
                                  provides
> which PMU events are provided to the guest. Add a new option
> `pmu-filter` as -accel sub-option to set the PMU Event Filtering.
                   ^^^^^^
                   '-accel kvm'

> Without the filter, the KVM will expose all events from the host to
> guest by default.

Without the filter, all PMU events are exposed from host to guest by
default.

> 
> The `pmu-filter` has such format:
> 
>    pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
> 
> The A means "allow" and D means "deny", start is the first event of the
> range and the end is the last one. The first registered range defines
> the global policy(global ALLOW if the first @action is DENY, global DENY
> if the first @action is ALLOW). The start and end only support hex
> format now. For example:
> 
>    pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
> 
> Since the first action is allow, we have a global deny policy. It
> will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
> also allowed except the event 0x30 is denied, and all the other events
> are disallowed.
> 

The section explaining how 'pmu-filter' is used has been well documented
in qemu-options.hx. So it can be dropped Instead, it can be mentioned in
the commit message, something like below.

The usage of the new sub-option can be found from the updated document
(qemu-options.hx).

> Here is an real example shows how to use the PMU Event Filtering, when
           ^^^^^^^^^^^^^^^
           an example
> we launch a guest by use kvm, add such command line:
> 
>    # qemu-system-aarch64 \
> 	-accel kvm,pmu-filter="D:0x11-0x11"
> 
> Since the first action is deny, we have a global allow policy. This
> disables the filtering of the cycle counter (event 0x11 being CPU_CYCLES).
> 
> And then in guest, use the perf to count the cycle:
> 
>    # perf stat sleep 1
> 
>     Performance counter stats for 'sleep 1':
> 
>                1.22 msec task-clock                       #    0.001 CPUs utilized
>                   1      context-switches                 #  820.695 /sec
>                   0      cpu-migrations                   #    0.000 /sec
>                  55      page-faults                      #   45.138 K/sec
>     <not supported>      cycles
>             1128954      instructions
>              227031      branches                         #  186.323 M/sec
>                8686      branch-misses                    #    3.83% of all branches
> 
>         1.002492480 seconds time elapsed
> 
>         0.001752000 seconds user
>         0.000000000 seconds sys
> 
> As we can see, the cycle counter has been disabled in the guest, but
> other pmu events are still work.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> v3->v4:
>    - Fix the wrong check for pmu_filter_init.            [Sebastian]
>    - Fix multiple alignment issue.                       [Gavin]
>    - Report error by warn_report() instead of error_report(), and don't use
>    abort() since the PMU Event Filter is an add-on and best-effort feature.
>                                                          [Gavin]
>    - Add several missing {  } for single line of code.   [Gavin]
>    - Use the g_strsplit() to replace strtok().           [Gavin]
> 
> v2->v3:
>    - Improve commits message, use kernel doc wording, add more explaination on
>      filter example, fix some typo error.                [Eric]
>    - Add g_free() in kvm_arch_set_pmu_filter() to prevent memory leak. [Eric]
>    - Add more precise error message report.              [Eric]
>    - In options doc, add pmu-filter rely on KVM_ARM_VCPU_PMU_V3_FILTER support in
>      KVM.                                                [Eric]
> 
> v1->v2:
>    - Add more description for allow and deny meaning in
>      commit message.                                     [Sebastian]
>    - Small improvement.                                  [Sebastian]
> 
> v2: https://lore.kernel.org/all/20231117060838.39723-1-shahuang@redhat.com/
> v1: https://lore.kernel.org/all/20231113081713.153615-1-shahuang@redhat.com/
> ---
>   include/sysemu/kvm_int.h |  1 +
>   qemu-options.hx          | 21 +++++++++++
>   target/arm/kvm.c         | 23 ++++++++++++
>   target/arm/kvm64.c       | 75 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 120 insertions(+)
> 
I would simplify the commit message like below, for your reference.

---

The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability letting the VMM
to decide which PMU events are present to the guest. Add a new option
`pmu-filter` as '-accel kvm' sub-option to set the PMU Event Filtering.
The usage of the new sub-option can be found from the updated docuement
(qemu-options.hx).

Here is an example shows how to use the PMU Event Filtering.

   # qemu-system-aarch64 -accel kvm,pmu-filter="D:0x11-0x11"

Since the first action is deny, we have a global allow policy. This
disables the filtering of the cycle counter (event 0x11). In the
guest, we use the perf to count the CPU cycles. The PMU event has
been disabled, but other events are still present.

   # perf stat sleep 1
   Performance counter stats for 'sleep 1':
               1.22 msec task-clock         #   0.001 CPUs utilized
                  1      context-switches   # 820.695 /sec
                  0      cpu-migrations     #   0.000 /sec
                 55      page-faults        #  45.138 K/sec
    <not supported>      cycles
            1128954      instructions
             227031      branches           #  186.323 M/sec
               8686      branch-misses      #  3.83% of all branches

     1.002492480 seconds time elapsed
     0.001752000 seconds user
     0.000000000 seconds sys

> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index fd846394be..8f4601474f 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -120,6 +120,7 @@ struct KVMState
>       uint32_t xen_caps;
>       uint16_t xen_gnttab_max_frames;
>       uint16_t xen_evtchn_max_pirq;
> +    char *kvm_pmu_filter;
>   };
>   
>   void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 42fd09e4de..054865ba0d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -187,6 +187,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>       "                tb-size=n (TCG translation block cache size)\n"
>       "                dirty-ring-size=n (KVM dirty ring GFN count, default 0)\n"
>       "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
> +    "                pmu-filter={A,D}:start-end[;{A,D}:start-end...] (KVM PMU Event Filter, default no filter. ARM only)\n"
>       "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
>       "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
>   SRST
> @@ -259,6 +260,26 @@ SRST
>           impact on the memory. By default, this feature is disabled
>           (eager-split-size=0).
>   
> +    ``pmu-filter={A,D}:start-end[;{A,D}:start-end...]``
> +        KVM implements PMU Event Filtering to prevent a guest from being able to
> +        sample certain events. It depends on the KVM_ARM_VCPU_PMU_V3_FILTER
> +        attribute supported in KVM. It has the following format:
> +
> +        pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
> +
> +        The A means "allow" and D means "deny", start is the first event of the
> +        range and the end is the last one. The first registered range defines
> +        the global policy(global ALLOW if the first @action is DENY, global DENY
> +        if the first @action is ALLOW). The start and end only support hex
                                                                           ^^^
                                                                           hexadecimal
> +        format now. For example:
> +
> +        pmu-filter="A:0x11-0x11;A:0x23-0x3a;D:0x30-0x30"
> +
> +        Since the first action is allow, we have a global deny policy. It
> +        will allow event 0x11 (The cycle counter), events 0x23 to 0x3a is
> +        also allowed except the event 0x30 is denied, and all the other events
> +        are disallowed.
> +
>       ``notify-vmexit=run|internal-error|disable,notify-window=n``
>           Enables or disables notify VM exit support on x86 host and specify
>           the corresponding notify window to trigger the VM exit if enabled.
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7903e2ddde..1f73b83674 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1108,6 +1108,22 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
>       s->kvm_eager_split_size = value;
>   }
>   
> +static char *kvm_arch_get_pmu_filter(Object *obj, Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +
> +    return g_strdup(s->kvm_pmu_filter);
> +}
> +
> +static void kvm_arch_set_pmu_filter(Object *obj, const char *pmu_filter,
> +                                    Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +
> +    g_free(s->kvm_pmu_filter);
> +    s->kvm_pmu_filter = g_strdup(pmu_filter);
> +}
> +
>   void kvm_arch_accel_class_init(ObjectClass *oc)
>   {
>       object_class_property_add(oc, "eager-split-size", "size",
> @@ -1116,4 +1132,11 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>   
>       object_class_property_set_description(oc, "eager-split-size",
>           "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
> +
> +    object_class_property_add_str(oc, "pmu-filter",
> +                                  kvm_arch_get_pmu_filter,
> +                                  kvm_arch_set_pmu_filter);
> +
> +    object_class_property_set_description(oc, "pmu-filter",
> +        "PMU Event Filtering description for guest PMU. (default: NULL, disabled)");
>   }
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 3c175c93a7..0ed6744057 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -10,6 +10,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include <asm-arm64/kvm.h>
>   #include <sys/ioctl.h>
>   #include <sys/ptrace.h>
>   
> @@ -131,6 +132,77 @@ static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
>       return true;
>   }
>   
> +static void kvm_arm_pmu_filter_init(CPUState *cs)
> +{
> +    KVMState *kvm_state = cs->kvm_state;
> +    static bool pmu_filter_init = false;

Needn't to initialize it to the default value, which is false.

        static bool pmu_filter_init;

> +    struct kvm_pmu_event_filter filter;
> +    struct kvm_device_attr attr = {
> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> +        .addr       = (uint64_t)&filter,
> +    };
> +    char act;
> +    int i;
> +    gchar **event_filters;
> +
> +    if (!kvm_state->kvm_pmu_filter)
> +        return;
> +

Missed { }

> +    if (kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr)) {
> +        warn_report("The kernel doesn't support the PMU Event Filter!\n");
> +        return;
> +    }
> +

Need to drop "\n", no new line is allowed for warn_report().

The followup call to kvm_arm_set_device_attr() already had the check. So the
duplicate check isn't needed here.

> +    /* The filter only needs to be initialized for 1 vcpu. */
                                                       ^^
                                                       one vCPU

> +    if (pmu_filter_init) {
> +        return;
> +    }
> +    pmu_filter_init = true;
> +
> +    event_filters = g_strsplit(kvm_state->kvm_pmu_filter, ";", -1);
> +
> +    for (i = 0; event_filters[i]; i++) {

I would remove these empty lines, to:

        if (pmu_filter_init) {
            return;
        }

        pmu_filter_init = true;
        event_filters = g_strsplit(kvm_state->kvm_pmu_filter, ";", -1);
        for (...) {

> +        unsigned short start = 0, end = 0;
> +
> +        sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end);
> +        if ((act != 'A' && act != 'D') || (!start && !end)) {
> +            warn_report("Skipping invalid PMU filter %s\n", event_filters[i]);
> +            continue;
> +        }
> +

"\n" needs to be dropped and it breaks 80-chars in one line:

            warn_report("Skipping invalid PMU filter %s",
                        event_filter[i]);

> +        filter = (struct kvm_pmu_event_filter) {
> +            .base_event     = start,
> +            .nevents        = end - start + 1,
> +            .action         = act == 'A' ? KVM_PMU_EVENT_ALLOW :
> +                                           KVM_PMU_EVENT_DENY,
> +        };
> +

Suggest to access to @filter directly. Otherwise, there is another unnecessary
and temporary struct in the stack if the tool-chain isn't smart enough, leading
to memory waste in the stack.

            filter.base_event = start;
            filter.nevents = end - start + 1;
            filter.act = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
                                        KVM_PMU_EVENT_DENY;

> +        if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
> +            if (errno == EINVAL) {
> +                warn_report("Invalid PMU filter range [0x%x-0x%x]. "
> +                             "ARMv8.0 support 10 bits event space, "
> +                             "ARMv8.1 support 16 bits event space",
> +                             start, end);
> +            }
> +            else if (errno == ENODEV) {
> +                warn_report("GIC not initialized");
> +            }
> +            else if (errno == ENXIO) {
> +                warn_report("PMUv3 not properly configured or in-kernel irqchip "
> +                            "not configured.");
> +            }
> +            else if (errno == EBUSY) {
> +                warn_report("PMUv3 already initialized or a VCPU has already run");
> +            }
> +
> +            break;
> +        }

"} else if {" is needed.

The last warn_report() line breaks 80-chars in a line.

I'm wandering if we really need these explicit messages, which are usually a intrest
to developers. They still need look into kernel space to figure out the cause. There
already has a error_report() raised for the failing case in kvm_arm_set_device_attr().
So I would suggest to drop all of them and bail for simplicity.

            if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
                break;
            }

> +    }
> +
> +    g_strfreev(event_filters);
> +}
> +
>   void kvm_arm_pmu_init(CPUState *cs)
>   {
>       struct kvm_device_attr attr = {
> @@ -141,6 +213,9 @@ void kvm_arm_pmu_init(CPUState *cs)
>       if (!ARM_CPU(cs)->has_pmu) {
>           return;
>       }
> +
> +    kvm_arm_pmu_filter_init(cs);
> +
>       if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
>           error_report("failed to init PMU");
>           abort();

Thanks,
Gavin



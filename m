Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67437B28B8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 01:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm0HC-00023v-Cg; Thu, 28 Sep 2023 19:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0HA-00023Z-BD
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0H3-0004L8-Re
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695943103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHL/skch3O5y6l+up3a0CvHT3tJgOE/wMIIHZaKvcek=;
 b=NThvpmikXFesAwNE4oRuAQTE4jWAI3EUp2+Y4fU2/VonBfTVH6An4ReccLw8W5Q9eUBYPP
 YwbgXsD+y5Qk4GZgGD9oMJQBroPLKNwtXx3IwlPRUZ/2I0oQF6LYJmXo4X2uDLKsyiyEI5
 HXVmI/TtNy6QvF68qbqnqOdIE3BqhM4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-F4r5gcERMIaABKRMbxtb3g-1; Thu, 28 Sep 2023 19:18:22 -0400
X-MC-Unique: F4r5gcERMIaABKRMbxtb3g-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c60d6f2c6bso662575ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695943101; x=1696547901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHL/skch3O5y6l+up3a0CvHT3tJgOE/wMIIHZaKvcek=;
 b=CIcwynZ7i7TjAZhAWcJ5eOfNqp6Ybu9s3B0Hdwne7tqIfMIn3j55tZ8O5c2CxEpUyo
 LueCyucei/cbfKKIe80cmPTVafUKMHhEgbhuqhxwf/Ps9yzUUssQEIPWa6F+Adjf7B/G
 7HXKe1Bqx7JzwIoWPXVqmywzM7QRKul8KsYQFaka0W5WqXGMMfSE8fwNTLoJZA1KknLo
 oKQzQHTpNgZX0cKVpdnr717Y5XKQudUunoWQG8NF0AIhctq25R+BPL+LKhRsZpu8p5cq
 OUya1wjcHlpohNtlQr2/fD1H4eDessk0o6XVytxsymge5/DTZAUAFQjLmjfRLusVuvvp
 gqtA==
X-Gm-Message-State: AOJu0Yw32LDyMd5t+KbG//vBXF++vrfTeSmRYL5+MZBx/3l/0nAitqTa
 2TJ9KZIH4pDaChvJG0A/JsF5CjOWaPuqjT34IXlNr7KWF4a4GBSfielGvLuQzTg/KPgzZtWdP6P
 9Fw9977O2BLMOdy4=
X-Received: by 2002:a17:902:ce84:b0:1c5:7d49:570e with SMTP id
 f4-20020a170902ce8400b001c57d49570emr4556853plg.29.1695943100866; 
 Thu, 28 Sep 2023 16:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuKFRZ/T/HRemN7X2Y7nxOx25VUzRt1grBDbGxWd+zjQij3znVXrQ0OL7NhaEHxN56PQjXkQ==
X-Received: by 2002:a17:902:ce84:b0:1c5:7d49:570e with SMTP id
 f4-20020a170902ce8400b001c57d49570emr4556825plg.29.1695943100447; 
 Thu, 28 Sep 2023 16:18:20 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a170902d4d000b001c74718f2f3sm30453plg.119.2023.09.28.16.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 16:18:19 -0700 (PDT)
Message-ID: <550271cb-c415-f98e-afb4-d62df70c3ffb@redhat.com>
Date: Fri, 29 Sep 2023 09:18:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 18/37] arm/virt: Make ARM vCPU *present* status
 ACPI *persistent*
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-19-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-19-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/26/23 20:04, Salil Mehta wrote:
> ARM arch does not allow CPUs presence to be changed [1] after kernel has booted.
> Hence, firmware/ACPI/Qemu must ensure persistent view of the vCPUs to the Guest
> kernel even when they are not present in the QoM i.e. are unplugged or are
> yet-to-be-plugged
> 
> References:
> [1] Check comment 5 in the bugzilla entry
>     Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   cpus-common.c         |  6 ++++++
>   hw/arm/virt.c         |  7 +++++++
>   include/hw/core/cpu.h | 20 ++++++++++++++++++++
>   3 files changed, 33 insertions(+)
> 

hmm, it's another CPU state. There are 4 CPU states, plus other 3 CPU states:
possible, present, enabled. Now we're having always-present state. I think
those CPU states can be squeezed into the previous present state. What we
need is to ensure all possible vCPUs are present from the beginning. How
are to do something like below?

/*
  * The flag is set for all possible vCPUs in hw/arm/virt.c::virt_possible_cpu_arch_ids()
  * The idea is the flag is managed by specific board because the always-present is
  * the special requirements from hw/arm/virt board.
  */
#define CPU_ARCH_ID_FLAG_ALWAYS_PRESENT   (1UL << 0)
typedef struct CPUArchId {
     uint64_t  flags;
       :
}

static inline bool machine_has_possible_cpu(int index);
static inline bool mahine_has_present_cpu(int index)
{
     if (!machine_has_possible_cpu(inde)) {
         return false;
     }

     if (!ms->possible_cpus->cpus[index].flags & CPU_ARCH_ID_FLAG_ALWAYS_PRESENT) {
        return false;
     }

     return true;
}

static inline bool machine_has_enabled_cpu(int index)
{
     CPUState *cs;

     if (!machine_has_present_cpu(index)) {
         return false;
     }

     /* I'm thinking of cpu.enabled can be replaced by another
      * flag in struct CPUArchID::flags due to the fact:
      * The vCPU's states are managed by board and changed at
      * creation time or hotplug handlers.
      */
     cs = CPUSTATE(ms->possible_cpus->cpus[i].cpu);
     if (!cs || !cpu.enabled) {
         return false;
     }

     return true;
}

> diff --git a/cpus-common.c b/cpus-common.c
> index 24c04199a1..d64aa63b19 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -128,6 +128,12 @@ bool qemu_enabled_cpu(CPUState *cpu)
>       return cpu && !cpu->disabled;
>   }
>   
> +bool qemu_persistent_cpu(CPUState *cpu)
> +{
> +    /* cpu state can be faked to the guest via acpi */
> +    return cpu->acpi_persistent;
> +}
> +
>   uint64_t qemu_get_cpu_archid(int cpu_index)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cbb6199ec6..f1bee569d5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3006,6 +3006,13 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           return;
>       }
>       virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
> +
> +    /*
> +     * To give persistent presence view of vCPUs to the guest, ACPI might need
> +     * to fake the presence of the vCPUs to the guest but keep them disabled.
> +     * This shall be used during the init of ACPI Hotplug state and hot-unplug
> +     */
> +     cs->acpi_persistent = true;
>   }
>   
>   static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b2201a98ee..dab572c9bd 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -425,6 +425,13 @@ struct CPUState {
>        * By default every CPUState is enabled as of now across all archs.
>        */
>       bool disabled;
> +    /*
> +     * On certain architectures, to give persistent view of the 'presence' of
> +     * vCPUs to the guest, ACPI might need to fake the 'presence' of the vCPUs
> +     * but keep them ACPI disabled to the guest. This is done by returning
> +     * _STA.PRES=True and _STA.Ena=False for the unplugged vCPUs in QEMU QoM.
> +     */
> +    bool acpi_persistent;
>       /* TODO Move common fields from CPUArchState here. */
>       int cpu_index;
>       int cluster_index;
> @@ -814,6 +821,19 @@ bool qemu_present_cpu(CPUState *cpu);
>    */
>   bool qemu_enabled_cpu(CPUState *cpu);
>   
> +/**
> + * qemu_persistent_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU state should always be reflected as *present* via ACPI
> + * to the Guest. By default, this is False on all architectures and has to be
> + * explicity set during initialization.
> + *
> + * Returns: True if it is ACPI 'persistent' CPU
> + *
> + */
> +bool qemu_persistent_cpu(CPUState *cpu);
> +
>   /**
>    * qemu_get_cpu_archid:
>    * @cpu_index: possible vCPU for which arch-id needs to be retreived

Thanks,
Gavin



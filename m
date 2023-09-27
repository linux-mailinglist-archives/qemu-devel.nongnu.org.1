Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A617AF8DA
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 05:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlLd3-000889-4x; Tue, 26 Sep 2023 23:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlLd1-00087w-Vh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 23:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlLcz-0002pn-2u
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 23:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695786859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq3sWa4cq7NOR9CzU3Z3ngaKlHFGpMjzimxp4rlP+BA=;
 b=GuK4RYffREiRxE8xfzRnzLlp+jLwALCa6+oGIlBQnLa75Zx8QOjxOeWeLxP8w2flr+Ii8p
 9Sam9bgc+WsGGNOGvyeYCbmmJk1bFA84qyFKbCvATJTHePvWdS6/kpgYsqzgULkWbUdUQr
 cPJrccaF/TBZlLr3jC0c6ibylde0dtI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-bhqBBuukMbuegvsH4PYNpg-1; Tue, 26 Sep 2023 23:54:17 -0400
X-MC-Unique: bhqBBuukMbuegvsH4PYNpg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-577f80e2385so13110191a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 20:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695786856; x=1696391656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wq3sWa4cq7NOR9CzU3Z3ngaKlHFGpMjzimxp4rlP+BA=;
 b=tbu1FZ1hDGXlysLN04BHwMUyFS1XJvc6J/m7PPQHg74ijQZoVbqqynyvsHIoXpyOht
 iQ4PPgmW+vYuF0f78CwKwJiRbPKVtzQ8VYMi2H52a81aIGpX2QnDZxTHkNXL25m2YWQL
 ES/VyAQf4/3z8PYvCRov0N8N3U4H2ZdHB59mc417vmR07KoV9j+ovHQ/9GAm+Zm2p31y
 Jst01u7H/a5Xb1UL7NYvHmSaBbCi3D8fM6hV5aHyFOSl7Ezcr1EfucVwDE6t3Hkh23Kl
 mSu9S42QF1oQ7nNEhlnajYiR2nJ/GpD0+NCiYW4LqaOtPrsd7Y1PHLVZuYxrqpjMHWl6
 byfQ==
X-Gm-Message-State: AOJu0YyCtem1RH+NMpqeRccsLO/Bh5x+N02QEq/4C39ofIMcX2uJCveE
 2di1dz9ILjZEjq2dqG9pocb15JMCMH08Lzu9OsklfeNk+ab4fRgRkk4UBRJ/rYDwPVLObtc1H21
 yG7qGt8B0Gp5HxTo=
X-Received: by 2002:a05:6a20:258e:b0:153:56b1:8417 with SMTP id
 k14-20020a056a20258e00b0015356b18417mr1073880pzd.21.1695786855943; 
 Tue, 26 Sep 2023 20:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq9umvd7DnW1ODQdnHLhGV+hyAwLuH5MOUzj1LQ/52PHOvZFkXgJ98gx0PSGMqvVN1tP80oQ==
X-Received: by 2002:a05:6a20:258e:b0:153:56b1:8417 with SMTP id
 k14-20020a056a20258e00b0015356b18417mr1073854pzd.21.1695786855573; 
 Tue, 26 Sep 2023 20:54:15 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170902ea0a00b001b895336435sm350672plg.21.2023.09.26.20.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 20:54:14 -0700 (PDT)
Message-ID: <44e4f955-ab51-92ca-8d65-e3a38d8d6657@redhat.com>
Date: Wed, 27 Sep 2023 13:54:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 02/37] cpus-common: Add common CPU utility for
 possible vCPUs
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
 <20230926100436.28284-3-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Adds various utility functions which might be required to fetch or check the
> state of the possible vCPUs. This also introduces concept of *disabled* vCPUs,
> which are part of the *possible* vCPUs but are not part of the *present* vCPU.
> This state shall be used during machine init time to check the presence of
> vcpus.
   ^^^^^

   vCPUs

> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   cpus-common.c         | 31 +++++++++++++++++++++++++
>   include/hw/core/cpu.h | 53 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/cpus-common.c b/cpus-common.c
> index 45c745ecf6..24c04199a1 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -24,6 +24,7 @@
>   #include "sysemu/cpus.h"
>   #include "qemu/lockable.h"
>   #include "trace/trace-root.h"
> +#include "hw/boards.h"
>   
>   QemuMutex qemu_cpu_list_lock;
>   static QemuCond exclusive_cond;
> @@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)
>       cpu_list_generation_id++;
>   }
>   
> +CPUState *qemu_get_possible_cpu(int index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
> +
> +    assert((index >= 0) && (index < possible_cpus->len));
> +
> +    return CPU(possible_cpus->cpus[index].cpu);
> +}
> +
> +bool qemu_present_cpu(CPUState *cpu)
> +{
> +    return cpu;
> +}
> +
> +bool qemu_enabled_cpu(CPUState *cpu)
> +{
> +    return cpu && !cpu->disabled;
> +}
> +

I do think it's a good idea to have wrappers to check for CPU's states since
these CPU states play important role in this series to support vCPU hotplug.
However, it would be nice to move them around into header file (include/hw/boards.h)
because all the checks are originated from ms->possible_cpus->cpus[]. It sounds
functions to a machine (board) instead of global scope. Besides, it would be
nice to have same input (index) for all functions. How about something like
below in include/hw/boards.h?

static inline  bool machine_has_possible_cpu(int index)
{
     MachineState *ms = MACHINE(qdev_get_machine());

     if (!ms || !ms->possible_cpus || index < 0 || index >= ms->possible_cus->len) {
         return false;
     }

     return true;
}

static inline bool machine_has_present_cpu(int index)
{
     MachineState *ms = MACHINE(qdev_get_machine());

     if (!machine_is_possible_cpu(index) ||
         !ms->possible_cpus->cpus[index].cpu) {
         return false;
     }

     return true;
}

static inline bool machine_has_enabled_cpu(int index)
{
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs;

     if (!machine_is_present_cpu(index)) {
         return false;
     }

     cs = CPU(ms->possible_cpus->cpus[index].cpu);
     return !cs->disabled
}

> +uint64_t qemu_get_cpu_archid(int cpu_index)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const CPUArchIdList *possible_cpus = ms->possible_cpus;
> +
> +    assert((cpu_index >= 0) && (cpu_index < possible_cpus->len));
> +
> +    return possible_cpus->cpus[cpu_index].arch_id;
> +}
> +

I think it's unnecessary to keep it since it's called for once by
hw/arm/virt-acpi-build.c::build_madt. The architectural ID can be
directly fetched from possible_cpus->cpus[i].arch_id. It's fine
to drop this function and fold the logic to the following patch.

[PATCH RFC V2 21/37] hw/arm: MADT Tbl change to size the guest with possible vCPUs


>   CPUState *qemu_get_cpu(int index)
>   {
>       CPUState *cpu;
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe87352..e5af79950c 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -413,6 +413,17 @@ struct CPUState {
>       SavedIOTLB saved_iotlb;
>   #endif
>   
> +    /*
> +     * Some architectures do not allow *presence* of vCPUs to be changed
> +     * after guest has booted using information specified by VMM/firmware
> +     * via ACPI MADT at the boot time. Thus to enable vCPU hotplug on these
> +     * architectures possible vCPU can have CPUState object in 'disabled'
> +     * state or can also not have CPUState object at all. This is possible
> +     * when vCPU Hotplug is supported and vCPUs are 'yet-to-be-plugged' in
> +     * the QOM or have been hot-unplugged.
> +     * By default every CPUState is enabled as of now across all archs.
> +     */
> +    bool disabled;
>       /* TODO Move common fields from CPUArchState here. */
>       int cpu_index;
>       int cluster_index;

I guess the comments can be simplified a bit. How about something like below?

     /*
      * In order to support vCPU hotplug on architectures like aarch64,
      * the vCPU states fall into possible, present or enabled. This field
      * is added to distinguish present and enabled vCPUs. By default, all
      * vCPUs are present and enabled.
      */

> @@ -770,6 +781,48 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
>    */
>   CPUState *qemu_get_cpu(int index);
>   
> +/**
> + * qemu_get_possible_cpu:
> + * @index: The CPUState@cpu_index value of the CPU to obtain.
> + *         Input index MUST be in range [0, Max Possible CPUs)
> + *
> + * If CPUState object exists,then it gets a CPU matching
> + * @index in the possible CPU array.
> + *
> + * Returns: The possible CPU or %NULL if CPU does not exist.
> + */
> +CPUState *qemu_get_possible_cpu(int index);
> +
> +/**
> + * qemu_present_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU is amongst the present possible vcpus.
> + *
> + * Returns: True if it is present possible vCPU else false
> + */
> +bool qemu_present_cpu(CPUState *cpu);
> +
> +/**
> + * qemu_enabled_cpu:
> + * @cpu: The vCPU to check
> + *
> + * Checks if the vCPU is enabled.
> + *
> + * Returns: True if it is 'enabled' else false
> + */
> +bool qemu_enabled_cpu(CPUState *cpu);
> +
> +/**
> + * qemu_get_cpu_archid:
> + * @cpu_index: possible vCPU for which arch-id needs to be retreived
> + *
> + * Fetches the vCPU arch-id from the present possible vCPUs.
> + *
> + * Returns: arch-id of the possible vCPU
> + */
> +uint64_t qemu_get_cpu_archid(int cpu_index);
> +

All these descriptive stuff isn't needed after the functions are moved to
include/hw/boards.h, and qemu_get_cpu_archid() is dropped.

>   /**
>    * cpu_exists:
>    * @id: Guest-exposed CPU ID to lookup.

Thanks,
Gavin



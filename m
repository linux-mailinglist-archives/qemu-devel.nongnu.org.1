Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D727B28F6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 01:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm0fs-0003SW-BR; Thu, 28 Sep 2023 19:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0fq-0003RU-GE
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0fo-0005HG-Jc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695944639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuwLTdg1sfZ1K7ruViCiCHKBdoLfvHZLC2UTKKQmN0Y=;
 b=NgeySsCIrRC+tJBcXN0SGAGtz3p1snzFsTgONzFpqTi8MBmxVA501lz90TDYoJU5Hh/yfu
 lFGiw8jmht4weuEx/ax80Bz4v4Gl/okNvsZw4Da2JVHVlHYU0FXZ/gCGr5cBmNlBYEcGUh
 uX2h1Gwlexsk5EtAoMprmoovk6gZq4g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-fK7fzLwKOGO1VzmZNNPslw-1; Thu, 28 Sep 2023 19:43:58 -0400
X-MC-Unique: fK7fzLwKOGO1VzmZNNPslw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2775a7f3803so12065549a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695944637; x=1696549437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AuwLTdg1sfZ1K7ruViCiCHKBdoLfvHZLC2UTKKQmN0Y=;
 b=vDfyH9vUdVhk4MpQ1ZZIoWWwfgUrkBFsew77w+LBH22CpKa2OyzLNkN11Miu1RPmq3
 GcmXnfRgTdDW2dGN5rFmbW+GwvNljHR4QTCgM3rnBkyyoC2QmIq42lZGUGk1dZeFKYWV
 ZvMnFNYWI0tL7+NWVIua9gX0lvVYJsRnTAk8RS+EYTmUcCCQkcdpYjlw0xWUBWQ9Rhki
 mN6/kn4t0RrAqJHSJx/T7nAKTCbafeaIzPnB23om/5lRQBo6j399DDAFViyf6yLBrTkh
 HP52Ext9YPN/HgVYTpi3Sm9izTYi5mqGvS+LbAlQYCrKH1XScIXhLzgZ7ul6c8095DEL
 n5Qw==
X-Gm-Message-State: AOJu0YwP7c9U52ejqBdv5Q4t1+NhWHqL/k24OVqPyu9UbUZCnPzSfkAy
 guM4rbWPqauDDiAiDHnQM+WKo0Ql3Z62Ze1QEkHSNPcfQ8dRqVEwoPu7L7Vp87yd/WQbJ5KhRxD
 URro4jm7Y6jkv+TY=
X-Received: by 2002:a17:90b:1d04:b0:269:85d:2aef with SMTP id
 on4-20020a17090b1d0400b00269085d2aefmr2595716pjb.20.1695944636913; 
 Thu, 28 Sep 2023 16:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF9WXiEim2GDMPvsNE0WG9eqlBuUJJhRdw0Q7ZN0o+GyscBqH1ggA/S63MPD4X+YtnRvz2kQ==
X-Received: by 2002:a17:90b:1d04:b0:269:85d:2aef with SMTP id
 on4-20020a17090b1d0400b00269085d2aefmr2595704pjb.20.1695944636531; 
 Thu, 28 Sep 2023 16:43:56 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a17090a498c00b0026b3ed37ddcsm102607pjh.32.2023.09.28.16.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 16:43:55 -0700 (PDT)
Message-ID: <eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com>
Date: Fri, 29 Sep 2023 09:43:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 21/37] hw/arm: MADT Tbl change to size the guest
 with possible vCPUs
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
 <20230926100436.28284-22-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-22-salil.mehta@huawei.com>
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

On 9/26/23 20:04, Salil Mehta wrote:
> Changes required during building of MADT Table by QEMU to accomodate disabled
> possible vCPUs. This info shall be used by the guest kernel to size up its
> resources during boot time. This pre-sizing of the guest kernel done on
> possible vCPUs will facilitate hotplug of the disabled vCPUs.
> 
> This change also caters ACPI MADT GIC CPU Interface flag related changes
> recently introduced in the UEFI ACPI 6.5 Specification which allows deferred
> virtual CPU online'ing in the Guest Kernel.
> 
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d27df5030e..cbccd2ca2d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -700,6 +700,29 @@ static void build_append_gicr(GArray *table_data, uint64_t base, uint32_t size)
>       build_append_int_noprefix(table_data, size, 4); /* Discovery Range Length */
>   }
>   
> +static uint32_t virt_acpi_get_gicc_flags(CPUState *cpu)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +
> +    /* can only exist in 'enabled' state */
> +    if (!mc->has_hotpluggable_cpus) {
> +        return 1;
> +    }
> +
> +    /*
> +     * ARM GIC CPU Interface can be 'online-capable' or 'enabled' at boot
> +     * We MUST set 'online-capable' Bit for all hotpluggable CPUs except the
                                        ^^^
                                        bit
> +     * first/boot CPU. Cold-booted CPUs without 'Id' can also be unplugged.
> +     * Though as-of-now this is only used as a debugging feature.
> +     *
> +     *   UEFI ACPI Specification 6.5
> +     *   Section: 5.2.12.14. GIC CPU Interface (GICC) Structure
> +     *   Table:   5.37 GICC CPU Interface Flags
> +     *   Link: https://uefi.org/specs/ACPI/6.5
> +     */
> +    return cpu && !cpu->cpu_index ? 1 : (1 << 3);
> +}
> +

I don't understand how a cold-booted CPU can be hot removed if it doesn't
have a ID? Besides, how cpu->cpu_index is zero for the first cold-booted
CPU?

>   static void
>   build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
> @@ -726,12 +749,13 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       build_append_int_noprefix(table_data, vms->gic_version, 1);
>       build_append_int_noprefix(table_data, 0, 3);   /* Reserved */
>   
> -    for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
> -        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
> +    for (i = 0; i < MACHINE(vms)->smp.max_cpus; i++) {
> +        CPUState *cpu = qemu_get_possible_cpu(i);
>           uint64_t physical_base_address = 0, gich = 0, gicv = 0;
>           uint32_t vgic_interrupt = vms->virt ? PPI(ARCH_GIC_MAINT_IRQ) : 0;
> -        uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
> -                                             PPI(VIRTUAL_PMU_IRQ) : 0;
> +        uint32_t pmu_interrupt = vms->pmu ? PPI(VIRTUAL_PMU_IRQ) : 0;
> +        uint32_t flags = virt_acpi_get_gicc_flags(cpu);
> +        uint64_t mpidr = qemu_get_cpu_archid(i);
>   

qemu_get_cpu_archid() can be dropped since it's called for once. MPIDR
can be fetched from ms->possible_cpus->cpus[i].arch_id, which has been
initialized pre-hand.

>           if (vms->gic_version == VIRT_GIC_VERSION_2) {
>               physical_base_address = memmap[VIRT_GIC_CPU].base;
> @@ -746,7 +770,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           build_append_int_noprefix(table_data, i, 4);    /* GIC ID */
>           build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID */
>           /* Flags */
> -        build_append_int_noprefix(table_data, 1, 4);    /* Enabled */
> +        build_append_int_noprefix(table_data, flags, 4);
>           /* Parking Protocol Version */
>           build_append_int_noprefix(table_data, 0, 4);
>           /* Performance Interrupt GSIV */
> @@ -760,7 +784,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           build_append_int_noprefix(table_data, vgic_interrupt, 4);
>           build_append_int_noprefix(table_data, 0, 8);    /* GICR Base Address*/
>           /* MPIDR */
> -        build_append_int_noprefix(table_data, armcpu->mp_affinity, 8);
> +        build_append_int_noprefix(table_data, mpidr, 8);
>           /* Processor Power Efficiency Class */
>           build_append_int_noprefix(table_data, 0, 1);
>           /* Reserved */

Thanks,
Gavin



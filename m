Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE397BF352
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 08:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq6XT-0005Qv-Ni; Tue, 10 Oct 2023 02:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq6XM-0005Pt-3V
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq6XG-00070i-HX
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696920483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSEF2R7FcrUdJ1Ey0+Y2ay8NczyGf+w6MNePPZbfwA8=;
 b=H/uhBKVsK7eAA5nK0o+dNg3v/iwoLkZuEGdKVPU774rAt6rIUKXWCyZ2iozJMEnyN40Zwk
 5MMyTBjZsXDBbpSQbE9D6jC49KarUZQJyB2TK4PhA8JKqleg6jB8g48sSuGsKoXzaf0wKC
 YXkqVtC1th6niaB+yqWzc2UC2E2fqo8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-YY2k-OGIPHKxFI_GAFKCwg-1; Tue, 10 Oct 2023 02:46:56 -0400
X-MC-Unique: YY2k-OGIPHKxFI_GAFKCwg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-27ce812ebecso139084a91.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 23:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696920415; x=1697525215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSEF2R7FcrUdJ1Ey0+Y2ay8NczyGf+w6MNePPZbfwA8=;
 b=JfKexzqZVDTOdnpng87FKK/aIkslEZ29b6cdpI1fT7VAToRHKTLBz0EbvFzIPjegok
 XhtW4b4XuSPjKDGDl6ukpd8+MG6DmEsTVsxhdWrpihZCpndBgCqqW7+DEA5a/+11URWo
 o5tlFj4LPq0U1U4xrn0JoX5C+E3lbYXCYUO5Qt2vKlb1r0YfpXcrvnlYbzcA2XEhNrgG
 B0PUIMIIRmFQlIGoCMGH9Z0WxvA+GO0EN5OKJunEx86Ku5UEuVXqyY/OQs2C+YAPhDyj
 sCkW1jix0p3Acyu3LB6roR4oya34WiGRR1Zd/yaDIHkzEn+/Q4BUN+w1mXZ5tTSTLqeR
 w2WA==
X-Gm-Message-State: AOJu0Yx+1wOMCFUXuZAuIHisAX3qZA3wh8rN4h4LFTdMJjQ87p2LJFVS
 YvDef+2NekfvDHYnwYU5RTaqPOfcjKMgunK1Zmojpf3izVzuPYDAi2xKQKRk68MEhZgm6Gjw2Ma
 P/iXzYz8Cps8ZhZQ=
X-Received: by 2002:a05:6a00:2e92:b0:692:b3d4:e6c3 with SMTP id
 fd18-20020a056a002e9200b00692b3d4e6c3mr18875533pfb.0.1696920414889; 
 Mon, 09 Oct 2023 23:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr1PDymJ35XPQmZ/1yJ5/bxT8tXF2o7szaM6qkPT2lHFbMYYPZTGFcuOb4dlQUrdN3kpdfeg==
X-Received: by 2002:a05:6a00:2e92:b0:692:b3d4:e6c3 with SMTP id
 fd18-20020a056a002e9200b00692b3d4e6c3mr18875502pfb.0.1696920414475; 
 Mon, 09 Oct 2023 23:46:54 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 r5-20020aa78b85000000b00690bd3c0723sm7658466pfd.99.2023.10.09.23.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 23:46:53 -0700 (PDT)
Message-ID: <3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com>
Date: Tue, 10 Oct 2023 14:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 03/37] hw/arm/virt: Move setting of common CPU
 properties in a function
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-4-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230926100436.28284-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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



On 9/26/23 18:04, Salil Mehta via wrote:
> Factor out CPU properties code common for {hot,cold}-plugged CPUs. This allows
> code reuse.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c         | 220 ++++++++++++++++++++++++++----------------
>   include/hw/arm/virt.h |   4 +
>   2 files changed, 140 insertions(+), 84 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 57fe97c242..0eb6bf5a18 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2018,16 +2018,130 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>       }
>   }
>   
> +static void virt_cpu_set_properties(Object *cpuobj, const CPUArchId *cpu_slot,
> +                                    Error **errp)
> +{

Hi Salil,

This patch seems break the code, the virt_cpu_set_properties() function 
being defined but not used in this patch, so those original code in the 
machvirt_init() just not work.

We should use this function in the machvirt_init().

> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    Error *local_err = NULL;
> +    VirtMachineClass *vmc;
> +
> +    vmc = VIRT_MACHINE_GET_CLASS(ms);
> +
> +    /* now, set the cpu object property values */
> +    numa_cpu_pre_plug(cpu_slot, DEVICE(cpuobj), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    object_property_set_int(cpuobj, "mp-affinity", cpu_slot->arch_id, NULL);
> +
> +    if (!vms->secure) {
> +        object_property_set_bool(cpuobj, "has_el3", false, NULL);
> +    }
> +
> +    if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> +        object_property_set_bool(cpuobj, "has_el2", false, NULL);
> +    }
> +
> +    if (vmc->kvm_no_adjvtime &&
> +        object_property_find(cpuobj, "kvm-no-adjvtime")) {
> +        object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> +    }
> +
> +    if (vmc->no_kvm_steal_time &&
> +        object_property_find(cpuobj, "kvm-steal-time")) {
> +        object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> +    }
> +
> +    if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> +        object_property_set_bool(cpuobj, "pmu", false, NULL);
> +    }
> +
> +    if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> +        object_property_set_bool(cpuobj, "lpa2", false, NULL);
> +    }
> +
> +    if (object_property_find(cpuobj, "reset-cbar")) {
> +        object_property_set_int(cpuobj, "reset-cbar",
> +                                vms->memmap[VIRT_CPUPERIPHS].base,
> +                                &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    /* link already initialized {secure,tag}-memory regions to this cpu */
> +    object_property_set_link(cpuobj, "memory", OBJECT(vms->sysmem), &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (vms->secure) {
> +        object_property_set_link(cpuobj, "secure-memory",
> +                                 OBJECT(vms->secure_sysmem), &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    if (vms->mte) {
> +        if (!object_property_find(cpuobj, "tag-memory")) {
> +            error_setg(&local_err, "MTE requested, but not supported "
> +                       "by the guest CPU");
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +
> +        object_property_set_link(cpuobj, "tag-memory", OBJECT(vms->tag_sysmem),
> +                                 &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        if (vms->secure) {
> +            object_property_set_link(cpuobj, "secure-tag-memory",
> +                                     OBJECT(vms->secure_tag_sysmem),
> +                                     &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * RFC: Question: this must only be called for the hotplugged cpus. For the
> +     * cold booted secondary cpus this is being taken care in arm_load_kernel()
> +     * in boot.c. Perhaps we should remove that code now?
> +     */
> +    if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
> +        object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
> +                                NULL);
> +
> +        /* Secondary CPUs start in PSCI powered-down state */
> +        if (CPU(cpuobj)->cpu_index > 0) {
> +            object_property_set_bool(cpuobj, "start-powered-off", true, NULL);
> +        }
> +    }

Besides, if this patch is just factor out the code, we could move the 
check psci_conduit to later patch, and keep this patch clean.

Thanks,
Shaoqin

> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +    return;
> +}
> +
>   static void machvirt_init(MachineState *machine)
>   {
>       VirtMachineState *vms = VIRT_MACHINE(machine);
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       const CPUArchIdList *possible_cpus;
> -    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *secure_tag_sysmem = NULL;
>       MemoryRegion *secure_sysmem = NULL;
>       MemoryRegion *tag_sysmem = NULL;
> -    MemoryRegion *secure_tag_sysmem = NULL;
> +    MemoryRegion *sysmem;
>       int n, virt_max_cpus;
>       bool firmware_loaded;
>       bool aarch64 = true;
> @@ -2071,6 +2185,8 @@ static void machvirt_init(MachineState *machine)
>        */
>       finalize_gic_version(vms);
>   
> +    sysmem = vms->sysmem = get_system_memory();
> +
>       if (vms->secure) {
>           /*
>            * The Secure view of the world is the same as the NonSecure,
> @@ -2078,7 +2194,7 @@ static void machvirt_init(MachineState *machine)
>            * containing the system memory at low priority; any secure-only
>            * devices go in at higher priority and take precedence.
>            */
> -        secure_sysmem = g_new(MemoryRegion, 1);
> +        secure_sysmem = vms->secure_sysmem = g_new(MemoryRegion, 1);
>           memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>                              UINT64_MAX);
>           memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> @@ -2151,6 +2267,23 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    if (vms->mte) {
> +        /* Create the memory region only once, but link to all cpus later */
> +        tag_sysmem = vms->tag_sysmem = g_new(MemoryRegion, 1);
> +        memory_region_init(tag_sysmem, OBJECT(machine),
> +                           "tag-memory", UINT64_MAX / 32);
> +
> +        if (vms->secure) {
> +            secure_tag_sysmem = vms->secure_tag_sysmem = g_new(MemoryRegion, 1);
> +            memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                               "secure-tag-memory", UINT64_MAX / 32);
> +
> +            /* As with ram, secure-tag takes precedence over tag.  */
> +            memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> +                                                tag_sysmem, -1);
> +        }
> +    }
> +
>       create_fdt(vms);
>   
>       assert(possible_cpus->len == max_cpus);
> @@ -2163,15 +2296,10 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           cpuobj = object_new(possible_cpus->cpus[n].type);
> -        object_property_set_int(cpuobj, "mp-affinity",
> -                                possible_cpus->cpus[n].arch_id, NULL);
>   
>           cs = CPU(cpuobj);
>           cs->cpu_index = n;
>   
> -        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
> -                          &error_fatal);
> -
>           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>           object_property_set_int(cpuobj, "socket-id",
>                                   virt_get_socket_id(machine, n), NULL);
> @@ -2182,82 +2310,6 @@ static void machvirt_init(MachineState *machine)
>           object_property_set_int(cpuobj, "thread-id",
>                                   virt_get_thread_id(machine, n), NULL);
>   
> -        if (!vms->secure) {
> -            object_property_set_bool(cpuobj, "has_el3", false, NULL);
> -        }
> -
> -        if (!vms->virt && object_property_find(cpuobj, "has_el2")) {
> -            object_property_set_bool(cpuobj, "has_el2", false, NULL);
> -        }
> -
> -        if (vmc->kvm_no_adjvtime &&
> -            object_property_find(cpuobj, "kvm-no-adjvtime")) {
> -            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
> -        }
> -
> -        if (vmc->no_kvm_steal_time &&
> -            object_property_find(cpuobj, "kvm-steal-time")) {
> -            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
> -        }
> -
> -        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
> -            object_property_set_bool(cpuobj, "pmu", false, NULL);
> -        }
> -
> -        if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
> -            object_property_set_bool(cpuobj, "lpa2", false, NULL);
> -        }
> -
> -        if (object_property_find(cpuobj, "reset-cbar")) {
> -            object_property_set_int(cpuobj, "reset-cbar",
> -                                    vms->memmap[VIRT_CPUPERIPHS].base,
> -                                    &error_abort);
> -        }
> -
> -        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
> -                                 &error_abort);
> -        if (vms->secure) {
> -            object_property_set_link(cpuobj, "secure-memory",
> -                                     OBJECT(secure_sysmem), &error_abort);
> -        }
> -
> -        if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus. */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> -                    exit(1);
> -                }
> -
> -                tag_sysmem = g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> -                if (vms->secure) {
> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                       "secure-tag-memory", UINT64_MAX / 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> -                                                        tag_sysmem, -1);
> -                }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> -            }
> -        }
> -
>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>           object_unref(cpuobj);
>       }
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index e1ddbea96b..13163adb07 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -148,6 +148,10 @@ struct VirtMachineState {
>       DeviceState *platform_bus_dev;
>       FWCfgState *fw_cfg;
>       PFlashCFI01 *flash[2];
> +    MemoryRegion *sysmem;
> +    MemoryRegion *secure_sysmem;
> +    MemoryRegion *tag_sysmem;
> +    MemoryRegion *secure_tag_sysmem;
>       bool secure;
>       bool highmem;
>       bool highmem_compact;

-- 
Shaoqin



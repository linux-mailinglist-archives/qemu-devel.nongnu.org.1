Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB77AFB1A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:30:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlO2o-0004oh-PA; Wed, 27 Sep 2023 02:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlO2l-0004oC-Lc
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlO2j-0001Bv-7N
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695796142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGMroqcas17+dzFrnVMzgCnmOm44Cm6AUINHfIIrNr8=;
 b=BJBFJTgAPAO+RBx39lwSpz3W73sZeYFM3v5wRNDWXkRcQgi+tmmXXqnzBjnuOzD32PNiXW
 t475ZsTUHuhUokM6QTPfp/qmdqJWvEFYinh6HCGOH0SYBmDmdx6EzBtHL6zqxCdQEFejfv
 FVd+xJKy8Dmfbbsp3XWoinv7TO8axrA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-E6yTbZLCP8ylC4JgkfD6Ig-1; Wed, 27 Sep 2023 02:29:00 -0400
X-MC-Unique: E6yTbZLCP8ylC4JgkfD6Ig-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-570096f51acso11841311a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695796139; x=1696400939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGMroqcas17+dzFrnVMzgCnmOm44Cm6AUINHfIIrNr8=;
 b=RElN6sd5PDSadWyWXvJOkcaXh3jR6a3byBW3oNBSNVfIAf9ecPXom9xvMi6H3z/Pnt
 qBnh+EKAJ1/M76LbWSmZ+pWcfS2ns3A1p1Gplvyb7ZdAOKY3ZYYt9hzPj2bMHVHgKBr8
 WKelIxynLiv5GLp5XkfN0eqPditkzSVqR11nI7Vd6jOff2tATu25bM5K411Ae45NUWiH
 Xz+aZdmopyRWG9MXn/v9Axclnm8lr04OBtfhHGtIdd1LOguW0g5uQ92u7EWTAS4poq79
 2VqEniUJhoRFCt+bhxVmJ+lMFt7w0BLZfWirt/fYE+5fPjneZfG7v48I4moJt20ImchN
 KnMQ==
X-Gm-Message-State: AOJu0YzidGNPcbhFJYLa34Gs2cthnZtNVGTR0X13dSf9JJnM+6INai4D
 D/kPbPiVeeGQ0CEfZk0MH4n5lUdPTNFguTxsiPa6tRoMaSBBK4wlEqQh83/FfAjW0am9IrMW9TC
 BNAKJvUB7+L7/eic=
X-Received: by 2002:a05:6a20:72a4:b0:15a:6733:24e2 with SMTP id
 o36-20020a056a2072a400b0015a673324e2mr7774986pzk.25.1695796139455; 
 Tue, 26 Sep 2023 23:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzQy1sTyYSxh4Loj3VlfzRgJZzp2T91HrNgcZR3EopoVp1SOiPXRd9Z0uhUTCjCgRdEBs65w==
X-Received: by 2002:a05:6a20:72a4:b0:15a:6733:24e2 with SMTP id
 o36-20020a056a2072a400b0015a673324e2mr7774946pzk.25.1695796139004; 
 Tue, 26 Sep 2023 23:28:59 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a637f44000000b005637030d00csm10554537pgn.30.2023.09.26.23.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 23:28:58 -0700 (PDT)
Message-ID: <1c5fa24c-6bf3-750f-4f22-087e4a9311af@redhat.com>
Date: Wed, 27 Sep 2023 16:28:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
 change common to vCPU {cold|hot}-plug
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
 <20230926100436.28284-5-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-5-salil.mehta@huawei.com>
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
> Refactor and introduce the common logic required during the initialization of
> both cold and hot plugged vCPUs. Also initialize the *disabled* state of the
> vCPUs which shall be used further during init phases of various other components
> like GIC, PMU, ACPI etc as part of the virt machine initialization.
> 
> KVM vCPUs corresponding to unplugged/yet-to-be-plugged QOM CPUs are kept in
> powered-off state in the KVM Host and do not run the guest code. Plugged vCPUs
> are also kept in powered-off state but vCPU threads exist and is kept sleeping.
> 
> TBD:
> For the cold booted vCPUs, this change also exists in the arm_load_kernel()
> in boot.c but for the hotplugged CPUs this change should still remain part of
> the pre-plug phase. We are duplicating the powering-off of the cold booted CPUs.
> Shall we remove the duplicate change from boot.c?
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Reported-by: Gavin Shan <gavin.shan@redhat.com>
> [GS: pointed the assertion due to wrong range check]
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c      | 149 ++++++++++++++++++++++++++++++++++++++++-----
>   target/arm/cpu.c   |   7 +++
>   target/arm/cpu64.c |  14 +++++
>   3 files changed, 156 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0eb6bf5a18..3668ad27ec 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -221,6 +221,7 @@ static const char *valid_cpus[] = {
>       ARM_CPU_TYPE_NAME("max"),
>   };
>   
> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid);
>   static int virt_get_socket_id(const MachineState *ms, int cpu_index);
>   static int virt_get_cluster_id(const MachineState *ms, int cpu_index);
>   static int virt_get_core_id(const MachineState *ms, int cpu_index);
> @@ -2154,6 +2155,14 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> +    finalize_gic_version(vms);
> +    if (tcg_enabled() || hvf_enabled() || qtest_enabled() ||
> +        (vms->gic_version < VIRT_GIC_VERSION_3)) {
> +        machine->smp.max_cpus = smp_cpus;
> +        mc->has_hotpluggable_cpus = false;
> +        warn_report("cpu hotplug feature has been disabled");
> +    }
> +

Comments needed here to explain why @mc->has_hotpluggable_cpus is set to false.
I guess it's something related to TODO list, mentioned in the cover letter.

>       possible_cpus = mc->possible_cpu_arch_ids(machine);
>   
>       /*
> @@ -2180,11 +2189,6 @@ static void machvirt_init(MachineState *machine)
>           virt_set_memmap(vms, pa_bits);
>       }
>   
> -    /* We can probe only here because during property set
> -     * KVM is not available yet
> -     */
> -    finalize_gic_version(vms);
> -
>       sysmem = vms->sysmem = get_system_memory();
>   
>       if (vms->secure) {
> @@ -2289,17 +2293,9 @@ static void machvirt_init(MachineState *machine)
>       assert(possible_cpus->len == max_cpus);
>       for (n = 0; n < possible_cpus->len; n++) {
>           Object *cpuobj;
> -        CPUState *cs;
> -
> -        if (n >= smp_cpus) {
> -            break;
> -        }
>   
>           cpuobj = object_new(possible_cpus->cpus[n].type);
>   
> -        cs = CPU(cpuobj);
> -        cs->cpu_index = n;
> -
>           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>           object_property_set_int(cpuobj, "socket-id",
>                                   virt_get_socket_id(machine, n), NULL);
> @@ -2804,6 +2800,50 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>       return ms->possible_cpus;
>   }
>   
> +static CPUArchId *virt_find_cpu_slot(MachineState *ms, int vcpuid)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(ms);
> +    CPUArchId *found_cpu;
> +    uint64_t mp_affinity;
> +
> +    assert(vcpuid >= 0 && vcpuid < ms->possible_cpus->len);
> +
> +    /*
> +     * RFC: Question:
> +     * TBD: Should mp-affinity be treated as MPIDR?
> +     */
> +    mp_affinity = virt_cpu_mp_affinity(vms, vcpuid);
> +    found_cpu = &ms->possible_cpus->cpus[vcpuid];
> +
> +    assert(found_cpu->arch_id == mp_affinity);
> +
> +    /*
> +     * RFC: Question:
> +     * Slot-id is the index where vCPU with certain arch-id(=mpidr/ap-affinity)
> +     * is plugged. For Host KVM, MPIDR for vCPU is derived using vcpu-id.
> +     * As I understand, MPIDR and vcpu-id are property of vCPU but slot-id is
> +     * more related to machine? Current code assumes slot-id and vcpu-id are
> +     * same i.e. meaning of slot is bit vague.
> +     *
> +     * Q1: Is there any requirement to clearly represent slot and dissociate it
> +     *     from vcpu-id?
> +     * Q2: Should we make MPIDR within host KVM user configurable?
> +     *
> +     *          +----+----+----+----+----+----+----+----+
> +     * MPIDR    |||  Res  |   Aff2  |   Aff1  |  Aff0   |
> +     *          +----+----+----+----+----+----+----+----+
> +     *                     \         \         \   |    |
> +     *                      \   8bit  \   8bit  \  |4bit|
> +     *                       \<------->\<------->\ |<-->|
> +     *                        \         \         \|    |
> +     *          +----+----+----+----+----+----+----+----+
> +     * VCPU-ID  |  Byte4  |  Byte2  |  Byte1  |  Byte0  |
> +     *          +----+----+----+----+----+----+----+----+
> +     */
> +
> +    return found_cpu;
> +}
> +

MPIDR[31] is set to 0b1, looking at linux/arch/arm64/kvm/sys_regs.c::reset_mpidr().

I think this function can be renamed to virt_get_cpu_slot(ms, index), better to
reflect its intention. I had same concerns why cs->cpu_index can't be reused
as MPIDR, but it's out of scope for this series. It maybe something to be improved
afterwards.

- cs->cpu_index is passed to ioctl(KVM_CREATE_VCPU). On the host, it's translated
   to MPIDR as you outlined in above comments.

- cs->cpu_index is translated to ms->possible_cpus->cpus[i].arch_id, which will
   be exposed to guest kernel through MDAT GIC structures

- In guest kernel, CPU0's hardware ID is read from MPIDR in linux/arch/arm64/kernel/setup.c::smp_setup_processor_id().
   Other CPU's hardware ID is fetched from MDAT GIC structure.

So I think we probably just need a function to translate cs->cpu_index to
MPIDR, to mimic what's done in linux/arch/arm64/sys_reg.c::reset_mpidr(). In
this way, the hardware IDs originating from MPIDR and MADT GIC structure
will be exactly same.


>   static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                    Error **errp)
>   {
> @@ -2847,6 +2887,81 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                            dev, &error_abort);
>   }
>   
> +static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                              Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    ARMCPU *cpu = ARM_CPU(dev);
> +    CPUState *cs = CPU(dev);
> +    CPUArchId *cpu_slot;
> +    int32_t min_cpuid = 0;
> +    int32_t max_cpuid;
> +
> +    /* sanity check the cpu */
> +    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> +        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> +                   ms->cpu_type);
> +        return;
> +    }
> +
> +    if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> +        error_setg(errp, "Invalid thread-id %u specified, correct range 0:%u",
> +                   cpu->thread_id, ms->smp.threads - 1);
> +        return;
> +    }
> +
> +    max_cpuid = ms->possible_cpus->len - 1;
> +    if (!dev->hotplugged) {
> +        min_cpuid = vms->acpi_dev ? ms->smp.cpus : 0;
> +        max_cpuid = vms->acpi_dev ? max_cpuid : ms->smp.cpus - 1;
> +    }
> +

I don't understand how the range is figured out. cpu->core_id should
be in range [0, ms->smp.cores). With your code, the following scenario
becomes invalid incorrectly?

-cpu host -smp maxcpus=4,cpus=1,sockets=4,clusters=1,cores=1,threads=1
(qemu) device_add host,id=cpu1,socket-id=1,cluster-id=0,core-id=2,thread-id=0

> +    if ((cpu->core_id < min_cpuid) || (cpu->core_id > max_cpuid)) {
> +        error_setg(errp, "Invalid core-id %d specified, correct range %d:%d",
> +                   cpu->core_id, min_cpuid, max_cpuid);
> +        return;
> +    }
> +
> +    if ((cpu->cluster_id < 0) || (cpu->cluster_id >= ms->smp.clusters)) {
> +        error_setg(errp, "Invalid cluster-id %u specified, correct range 0:%u",
> +                   cpu->cluster_id, ms->smp.clusters - 1);
> +        return;
> +    }
> +
> +    if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> +        error_setg(errp, "Invalid socket-id %u specified, correct range 0:%u",
> +                   cpu->socket_id, ms->smp.sockets - 1);
> +        return;
> +    }
> +
> +    cs->cpu_index = virt_get_cpu_id_from_cpu_topo(ms, dev);
> +
> +    cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
> +    if (qemu_present_cpu(CPU(cpu_slot->cpu))) {
> +        error_setg(errp, "cpu(id%d=%d:%d:%d:%d) with arch-id %" PRIu64 " exist",
> +                   cs->cpu_index, cpu->socket_id, cpu->cluster_id, cpu->core_id,
> +                   cpu->thread_id, cpu_slot->arch_id);
> +        return;
> +    }
> +    virt_cpu_set_properties(OBJECT(cs), cpu_slot, errp);
> +}
> +
> +static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                          Error **errp)
> +{
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    CPUState *cs = CPU(dev);
> +    CPUArchId *cpu_slot;
> +
> +    /* insert the cold/hot-plugged vcpu in the slot */
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

May be:

        /* CPU becomes present */

> +    cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
> +    cpu_slot->cpu = OBJECT(dev);
> +
> +    cs->disabled = false;
> +    return;
        ^^^^^^

        not needed.

May be worthy some comments like below, correlating to what's done in
aarch64_cpu_initfn():

        /* CPU becomes enabled after it's hot added */

> +}
> +
>   static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **errp)
>   {
> @@ -2888,6 +3003,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>           object_property_set_str(OBJECT(dev), "reserved-regions[0]",
>                                   resv_prop_str, errp);
>           g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        virt_cpu_pre_plug(hotplug_dev, dev, errp);
>       }
>   }
>   
> @@ -2909,6 +3026,8 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>           virt_memory_plug(hotplug_dev, dev, errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>           virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        virt_cpu_plug(hotplug_dev, dev, errp);
>       }
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> @@ -2993,7 +3112,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       if (device_is_dynamic_sysbus(mc, dev) ||
>           object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>           object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>           return HOTPLUG_HANDLER(machine);
>       }
>       return NULL;
> @@ -3070,6 +3190,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>   #endif
>       mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>       mc->kvm_type = virt_kvm_type;
> +    mc->has_hotpluggable_cpus = true;
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>       hc->pre_plug = virt_machine_device_pre_plug_cb;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1376350416..3a2e7e64ee 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2332,6 +2332,12 @@ static const struct TCGCPUOps arm_tcg_ops = {
>   };
>   #endif /* CONFIG_TCG */
>   
> +static int64_t arm_cpu_get_arch_id(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    return cpu->mp_affinity;
> +}
> +
>   static void arm_cpu_class_init(ObjectClass *oc, void *data)
>   {
>       ARMCPUClass *acc = ARM_CPU_CLASS(oc);
> @@ -2350,6 +2356,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
>       cc->class_by_name = arm_cpu_class_by_name;
>       cc->has_work = arm_cpu_has_work;
>       cc->dump_state = arm_cpu_dump_state;
> +    cc->get_arch_id = arm_cpu_get_arch_id;
>       cc->set_pc = arm_cpu_set_pc;
>       cc->get_pc = arm_cpu_get_pc;
>       cc->gdb_read_register = arm_cpu_gdb_read_register;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 96158093cc..a660e3f483 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -739,6 +739,17 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
>       }
>   }
>   
> +static void aarch64_cpu_initfn(Object *obj)
> +{
> +    CPUState *cs = CPU(obj);
> +
> +    /*
> +     * we start every ARM64 vcpu as disabled possible vCPU. It needs to be
> +     * enabled explicitly
> +     */
> +    cs->disabled = true;
> +}
> +

The comments can be simplified to:

     /* The CPU state isn't enabled until it's hot added completely */

>   static void aarch64_cpu_finalizefn(Object *obj)
>   {
>   }
> @@ -751,7 +762,9 @@ static gchar *aarch64_gdb_arch_name(CPUState *cs)
>   static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
>   {
>       CPUClass *cc = CPU_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
>   
> +    dc->user_creatable = true;
>       cc->gdb_read_register = aarch64_cpu_gdb_read_register;
>       cc->gdb_write_register = aarch64_cpu_gdb_write_register;
>       cc->gdb_num_core_regs = 34;
> @@ -800,6 +813,7 @@ static const TypeInfo aarch64_cpu_type_info = {
>       .name = TYPE_AARCH64_CPU,
>       .parent = TYPE_ARM_CPU,
>       .instance_size = sizeof(ARMCPU),
> +    .instance_init = aarch64_cpu_initfn,
>       .instance_finalize = aarch64_cpu_finalizefn,
>       .abstract = true,
>       .class_size = sizeof(AArch64CPUClass),

I'm not sure if 'dc->user_creatable' can be set true here because
the ARMCPU objects aren't ready for hot added/removed at this point.
The hacks for GICv3 aren't included so far. I think a separate patch
may be needed in the last to enable the functionality?

Thanks,
Gavin



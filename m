Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B32766EA8
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNPu-00017S-F3; Fri, 28 Jul 2023 09:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNPp-00016b-7z
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNPl-00078a-Ri
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690550512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qi2QLAKFWX6NjE9LSS5QRdu7meHk5rElxWZz3uuetLM=;
 b=SFV+V+CA/9ukWTmndlgGinckLkPwycju+4NNXJ4cN1+TfvXXIamx3hleknmKDcZkl4Svuv
 nHKMlTNA37qZR2UgeBAoEGQmd7lVdqBCo7BwNnlvy0q03wrsC9XgEIvizEA9WPGML3D31z
 FzJu7nTVkyeHmU8V5Ffyy15enk+V0Z0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-wbk-qm3jPT6awppaV0exYA-1; Fri, 28 Jul 2023 09:21:50 -0400
X-MC-Unique: wbk-qm3jPT6awppaV0exYA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so134155666b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550509; x=1691155309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qi2QLAKFWX6NjE9LSS5QRdu7meHk5rElxWZz3uuetLM=;
 b=GYGQkpVAIX+Rvt9pRHl7MdBttbXcl6wdSfo/kugd2ool0gJ7EHeDz+UGefnk3aqKAt
 wCq09udqCga3Eu7szo6sW82c1i82gx12QiEfNe6yVlLNDjIAd/t3x4Z2AluLsjk9S7vQ
 N3e9Q4R1R1ugmsihMPvv0IU1vSCSfBC+letJ9rWTMnmMIigaEg7hywWCfvBLuBTympqV
 TxbvB/XSeROJHq8dlO8bKUVqyjbuEF/0c9L8lXL7TmEE0eDpfaTxv9/oCc+WKxyakP9N
 kIg6E7E6wOb8lv0a62zkb+yzpVer8WNMh1Gosn0hKbJA82y541S9h8mOhs8rAQohsqFj
 YpGw==
X-Gm-Message-State: ABy/qLZt0h33AKrUUgxK48ne8mlbRC45vc/6qCZKZ5yMq7ogqdbyoVad
 Kv/7Zi6Crkraw10VuXt1tVHfsIN7BEl4wecX1vQDZoktWdNZNvgc6DNcuaIIqWixB5Pm6PEfRzs
 7jw0mEw9MxohRwHQ=
X-Received: by 2002:a17:906:7a11:b0:99b:cb78:8537 with SMTP id
 d17-20020a1709067a1100b0099bcb788537mr2178060ejo.11.1690550509102; 
 Fri, 28 Jul 2023 06:21:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHst/P5Zuu+wylI8qJvFtbmq/38i/BpVd29Kyji4pTMxNKfVPt97uEmJzpVALX1+GppDNrrqQ==
X-Received: by 2002:a17:906:7a11:b0:99b:cb78:8537 with SMTP id
 d17-20020a1709067a1100b0099bcb788537mr2178035ejo.11.1690550508749; 
 Fri, 28 Jul 2023 06:21:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ci18-20020a170906c35200b0099bd682f317sm2027156ejb.206.2023.07.28.06.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:21:48 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:21:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 5/8] Adds basic CPU hot-(un)plug support for Loongarch
Message-ID: <20230728152147.010fb677@imammedo.users.ipa.redhat.com>
In-Reply-To: <e5b1c3347538e518b50d6eced570202d076bec72.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <e5b1c3347538e518b50d6eced570202d076bec72.1689837093.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 20 Jul 2023 15:15:10 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> 1.Add CPU topology related functions
> 2.Add CPU hot-plug related hook functions
> 3.Update the in-place CPU creation process at machine initialization

patch is to large, split it at least on those ^^ 3 parts,
which would do a single distinct thing.
After that it will be easier to review this.


Also looking at hw/loongarch/acpi-build.c
you have cpu_index =3D=3D arch_id =3D=3D core_id /according to comments/
and they are mixed/used interchangeably. which is confusing
at least. So clean it up first to use arch_id consistently

then a separate patches to introduce socket/core/thread support
with proper documentation/pointers to specs as to how arch_id
should be calculated.

And once that is ready, add hotplug on top of it.=20


>=20
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  hw/loongarch/virt.c         | 381 ++++++++++++++++++++++++++++++++++--
>  include/hw/loongarch/virt.h |  11 +-
>  target/loongarch/cpu.h      |   4 +
>  3 files changed, 382 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e19b042ce8..5919389f42 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -46,6 +46,9 @@
>  #include "hw/block/flash.h"
>  #include "qemu/error-report.h"
> =20
> +static int virt_get_socket_id(const MachineState *ms, int cpu_index);
> +static int virt_get_core_id(const MachineState *ms, int cpu_index);
> +static int virt_get_thread_id(const MachineState *ms, int cpu_index);
> =20
>  static void virt_flash_create(LoongArchMachineState *lams)
>  {
> @@ -447,12 +450,12 @@ static DeviceState *create_acpi_ged(DeviceState *pc=
h_pic, LoongArchMachineState
>  {
>      DeviceState *dev;
>      MachineState *ms =3D MACHINE(lams);
> -    uint32_t event =3D ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event =3D ACPI_GED_PWR_DOWN_EVT | ACPI_GED_CPU_HOTPLUG_EVT;
> =20
>      if (ms->ram_slots) {
>          event |=3D ACPI_GED_MEM_HOTPLUG_EVT;
>      }
> -    dev =3D qdev_new(TYPE_ACPI_GED);
> +    dev =3D qdev_new(TYPE_ACPI_GED_LOONGARCH);
>      qdev_prop_set_uint32(dev, "ged-event", event);
> =20
>      /* ged event */
> @@ -461,6 +464,7 @@ static DeviceState *create_acpi_ged(DeviceState *pch_=
pic, LoongArchMachineState
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, VIRT_GED_MEM_ADDR);
>      /* ged regs used for reset and power down */
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
> =20
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
>                         qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI=
_BASE));
> @@ -583,6 +587,7 @@ static void loongarch_irq_init(LoongArchMachineState =
*lams)
> =20
>      extioi =3D qdev_new(TYPE_LOONGARCH_EXTIOI);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> +    lams->extioi =3D extioi;
> =20
>      /*
>       * The connection of interrupts:
> @@ -624,11 +629,11 @@ static void loongarch_irq_init(LoongArchMachineStat=
e *lams)
>                                      sysbus_mmio_get_region(SYS_BUS_DEVIC=
E(ipi),
>                                      1));
>          /*
> -	 * extioi iocsr memory region
> -	 * only one extioi is added on loongarch virt machine
> -	 * external device interrupt can only be routed to cpu 0-3
> -	 */
> -	if (cpu < EXTIOI_CPUS)
> +         * extioi iocsr memory region
> +         * only one extioi is added on loongarch virt machine
> +         * external device interrupt can only be routed to cpu 0-3
> +         */
> +        if (cpu < EXTIOI_CPUS)
>              memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(ex=
tioi),
>                                  cpu));
> @@ -789,7 +794,6 @@ static void loongarch_init(MachineState *machine)
>      NodeInfo *numa_info =3D machine->numa_state->nodes;
>      int i;
>      hwaddr fdt_base;
> -    const CPUArchIdList *possible_cpus;
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      CPUState *cpu;
>      char *ramName =3D NULL;
> @@ -810,12 +814,40 @@ static void loongarch_init(MachineState *machine)
>      create_fdt(lams);
>      /* Init CPUs */
> =20
> -    possible_cpus =3D mc->possible_cpu_arch_ids(machine);
> -    for (i =3D 0; i < possible_cpus->len; i++) {
> -        cpu =3D cpu_create(machine->cpu_type);
> +    mc->possible_cpu_arch_ids(machine);
> +
> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> +        Object *cpuobj;
> +        cpuobj =3D object_new(machine->cpu_type);
> +
> +        cpu =3D CPU(cpuobj);

>          cpu->cpu_index =3D i;
I'd move this to foo_cpu_pre_plug()

> -        machine->possible_cpus->cpus[i].cpu =3D OBJECT(cpu);
and this to foo_cpu_plug()

> +
> +        object_property_set_int(cpuobj, "socket-id",
> +                                virt_get_socket_id(machine, i), NULL);
> +        object_property_set_int(cpuobj, "core-id",
> +                                virt_get_core_id(machine, i), NULL);
> +        object_property_set_int(cpuobj, "thread-id",
> +                                virt_get_thread_id(machine, i), NULL);

you don't need to calculate foo_ids here, they shall be calculated once at
the 1st time possible_cpu_arch_ids() are called and then reuse
CPUArchId.props here.
see x86_possible_cpu_arch_ids() for an example


> +        /*
> +         * The CPU in place at the time of machine startup will also ent=
er
> +         * the CPU hot-plug process when it is created, but at this time,
> +         * the GED device has not been created, resulting in exit in the=
 CPU
> +         * hot-plug process, which can avoid the incumbent CPU repeatedly
> +         * applying for resources.
> +         *
> +         * The interrupt resource of the in-place CPU will be requested =
at
> +         * the current function call loongarch_irq_init().
> +         *
> +         * The interrupt resource of the subsequently inserted CPU will =
be
> +         * requested in the CPU hot-plug process.
> +         */
> +        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> +        object_unref(cpuobj);
>      }
> +
> +    lams->boot_cpus =3D machine->smp.cpus;
> +
>      fdt_add_cpu_nodes(lams);
> =20
>      /* Node0 memory */
> @@ -986,11 +1018,107 @@ static void virt_mem_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
> =20
> +static int virt_get_cpu_id_from_cpu_topo(const MachineState *ms,
> +                                            DeviceState *dev)

name suggest it's topo->id helper,
then feed it topo arguments instead of dev.

> +{
> +    int cpu_index, sock_vcpu_num, core_vcpu_num;
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +
> +    /* calculate total logical cpus across socket/cluster/core */
> +    sock_vcpu_num =3D cpu->socket_id * (ms->smp.threads * ms->smp.cores);
> +    core_vcpu_num =3D cpu->core_id * ms->smp.threads;
> +
> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
> +    cpu_index =3D (sock_vcpu_num + core_vcpu_num) + cpu->thread_id;
> +
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return cpu_index;
> +}
> +
> +/* find cpu slot in machine->possible_cpus by core_id */
> +static CPUArchId *loongarch_find_cpu_slot(MachineState *ms, uint32_t cpu=
_index,
> +                                        int *idx)
> +{
> +    int index =3D cpu_index;
> +
> +    if (index >=3D ms->possible_cpus->len) {
> +        return NULL;
> +    }
> +    if (idx) {
> +        *idx =3D index;
> +    }
> +    return &ms->possible_cpus->cpus[index];
> +}
> +
> +static void loongarch_cpu_pre_plug(HotplugHandler *hotplug_dev,
> +                            DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(OBJECT(hotplug_dev));
> +    MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +    CPUState *cs =3D CPU(dev);
> +    CPUArchId *cpu_slot;
> +    Error *local_err =3D NULL;
> +
> +    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> +        error_setg(&local_err, "CPU hotplug not supported for this machi=
ne");
> +        goto out;
> +    }
> +
> +    /* sanity check the cpu */
> +    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> +        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s=
'",
> +                   ms->cpu_type);
> +        goto out;
> +    }
> +
> +    if ((cpu->thread_id < 0) || (cpu->thread_id >=3D ms->smp.threads)) {
> +        error_setg(&local_err,
> +                   "Invalid thread-id %u specified, must be in range 1:%=
u",
> +                   cpu->thread_id, ms->smp.threads - 1);
> +        goto out;
> +    }
> +
> +    if ((cpu->core_id < 0) || (cpu->core_id >=3D ms->smp.cores)) {
> +        error_setg(&local_err,
> +                   "Invalid core-id %u specified, must be in range 1:%u",
> +                   cpu->core_id, ms->smp.cores);
> +        goto out;
> +    }
> +
> +    if ((cpu->socket_id < 0) || (cpu->socket_id >=3D ms->smp.sockets)) {
> +        error_setg(&local_err,
> +                   "Invalid socket-id %u specified, must be in range 1:%=
u",
> +                   cpu->socket_id, ms->smp.sockets - 1);
> +        goto out;
> +    }

> +    cs->cpu_index =3D virt_get_cpu_id_from_cpu_topo(ms, dev);
> +
> +    cpu_slot =3D loongarch_find_cpu_slot(ms, cs->cpu_index, NULL);
> +    if (CPU(cpu_slot->cpu)) {
> +        error_setg(&local_err,
> +                   "cpu(id%d=3D%d:%d:%d) with arch-id %" PRIu64 " exists=
",
> +                   cs->cpu_index, cpu->socket_id, cpu->core_id,
> +                   cpu->thread_id, cpu_slot->arch_id);
> +        goto out;
> +    }
> +
> +    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
> +
> +    return ;
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **er=
rp)
>  {
>      if (memhp_type_supported(dev)) {
>          virt_mem_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
> +        loongarch_cpu_pre_plug(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -1004,11 +1132,45 @@ static void virt_mem_unplug_request(HotplugHandle=
r *hotplug_dev,
>                                     errp);
>  }
> =20
> +static void loongarch_cpu_unplug_request(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> +    LoongArchMachineState *lsms =3D LOONGARCH_MACHINE(machine);
> +    Error *local_err =3D NULL;
> +    HotplugHandlerClass *hhc;
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +    CPUState *cs =3D CPU(dev);
> +
> +    if (!lsms->acpi_ged) {
> +        error_setg(&local_err, "CPU hot unplug not supported without ACP=
I");
> +        goto out;
> +    }
> +
> +    if (cs->cpu_index =3D=3D 0) {
> +        error_setg(&local_err,
> +                   "hot-unplug of boot cpu(id%d=3D%d:%d:%d) not supporte=
d",
> +                   cs->cpu_index, cpu->socket_id,
> +                   cpu->core_id, cpu->thread_id);
> +        goto out;
> +    }
> +
> +
> +    hhc =3D HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
> +    hhc->unplug_request(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err=
);
> +
> +    return;
> + out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_unplug_request(HotplugHandler *hotplug_d=
ev,
>                                            DeviceState *dev, Error **errp)
>  {
>      if (memhp_type_supported(dev)) {
>          virt_mem_unplug_request(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
> +        loongarch_cpu_unplug_request(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -1022,11 +1184,93 @@ static void virt_mem_unplug(HotplugHandler *hotpl=
ug_dev,
>      qdev_unrealize(dev);
>  }
> =20
> +static void loongarch_cpu_destroy(MachineState *machine, LoongArchCPU *c=
pu)

I'd fold this into unplug handler, and the same for _cpu_create
you aren't destroying/creating CPU at this point but rather
wiring it up with other external to it components.

> +{
> +    LoongArchMachineState *lsms =3D LOONGARCH_MACHINE(machine);
> +    CPULoongArchState *env =3D &cpu->env;
> +    DeviceState *ipi =3D env->ipistate;
> +    CPUState *cs =3D CPU(cpu);
> +    unsigned int cpu_index =3D cs->cpu_index;
> +    DeviceState *extioi =3D lsms->extioi;
> +    int pin;
> +
> +    qemu_unregister_reset(reset_load_elf, DEVICE(cpu));
> +

> +    lsms->boot_cpus--;
> +    if (lsms->fw_cfg) {
> +        fw_cfg_modify_i16(lsms->fw_cfg, FW_CFG_NB_CPUS,
> +                          (uint16_t)lsms->boot_cpus);
> +    }
do you really need boot_cpus?
adding FWCFG variable is adding ABI, with potential to maintain it for a lo=
ng time

it seems that before this series you also had support for multiple CPUs
and didn't care about FWCFG, so quest is why it's being added now.=20

> +
> +    /* disconnect ipi irq to cpu irq */
> +    qdev_disconnect_gpio_out_named(ipi, NULL, 0);
> +    /* del IPI iocsr memory region */
> +    memory_region_del_subregion(&env->system_iocsr,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ip=
i),
> +                                0));
> +    memory_region_del_subregion(&env->system_iocsr,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ip=
i),
> +                                1));
> +
> +    env->ipistate =3D NULL;
> +    object_unparent(OBJECT(ipi));
> +
> +    /*
> +     * disconnect ext irq to the cpu irq
> +     * cpu_pin[9:2] <=3D intc_pin[7:0]
> +     */
> +    if (cpu_index < EXTIOI_CPUS) {
> +        for (pin =3D 0; pin < LS3A_INTC_IP; pin++) {
> +            qdev_disconnect_gpio_out_named(extioi, NULL, (cpu_index * 8 =
+ pin));
> +        }
> +    }
> +
> +    /*
> +     * del extioi iocsr memory region
> +     * only one extioi is added on loongarch virt machine
> +     * external device interrupt can only be routed to cpu 0-3
> +     */
> +    if (cpu_index < EXTIOI_CPUS)
> +        memory_region_del_subregion(&env->system_iocsr,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi=
),
> +                            cpu_index));
> +}
> +
> +static void loongarch_cpu_unplug(HotplugHandler *hotplug_dev,
> +                                DeviceState *dev, Error **errp)
> +{
> +    CPUArchId *found_cpu;
> +    HotplugHandlerClass *hhc;
> +    Error *local_err =3D NULL;
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +    MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> +    LoongArchMachineState *lsms =3D LOONGARCH_MACHINE(machine);
> +    CPUState *cs =3D CPU(dev);
> +
> +    hhc =3D HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
> +    hhc->unplug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
> +
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    loongarch_cpu_destroy(machine, cpu);
> +
> +    found_cpu =3D loongarch_find_cpu_slot(MACHINE(lsms), cs->cpu_index, =
NULL);
> +    found_cpu->cpu =3D NULL;
> +
> +    return;
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
>      if (memhp_type_supported(dev)) {
>          virt_mem_unplug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
> +        loongarch_cpu_unplug(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -1040,6 +1284,92 @@ static void virt_mem_plug(HotplugHandler *hotplug_=
dev,
>                           dev, &error_abort);
>  }
> =20
> +
> +static LoongArchCPU *loongarch_cpu_create(MachineState *machine,
> +                                LoongArchCPU *cpu, Error **errp)
> +{
> +    LoongArchMachineState *lsms =3D LOONGARCH_MACHINE(machine);
> +    CPUState *cs =3D CPU(cpu);
> +    unsigned int cpu_index =3D cs->cpu_index;
> +    DeviceState *cpudev =3D DEVICE(cpu);
> +    DeviceState *extioi =3D lsms->extioi;
> +    CPULoongArchState *env =3D &cpu->env;
> +    DeviceState *ipi;
> +    int pin;
> +
> +    qemu_register_reset(reset_load_elf, cpu);
> +
> +    lsms->boot_cpus++;
> +    if (lsms->fw_cfg) {
> +        fw_cfg_modify_i16(lsms->fw_cfg, FW_CFG_NB_CPUS,
> +                          (uint16_t)lsms->boot_cpus);
> +    }
> +
> +    ipi =3D qdev_new(TYPE_LOONGARCH_IPI);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), errp);
> +
> +    /* connect ipi irq to cpu irq */
> +    qdev_connect_gpio_out(ipi, 0, qdev_get_gpio_in(cpudev, IRQ_IPI));
> +    /* IPI iocsr memory region */
> +    memory_region_add_subregion(&env->system_iocsr, SMP_IPI_MAILBOX,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ip=
i),
> +                                0));
> +    memory_region_add_subregion(&env->system_iocsr, MAIL_SEND_ADDR,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ip=
i),
> +                                1));
> +    /*
> +     * extioi iocsr memory region
> +     * only one extioi is added on loongarch virt machine
> +     * external device interrupt can only be routed to cpu 0-3
> +     */
> +    if (cpu_index < EXTIOI_CPUS)
> +        memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi=
),
> +                            cpu_index));
> +    env->ipistate =3D ipi;
> +
> +    /*
> +     * connect ext irq to the cpu irq
> +     * cpu_pin[9:2] <=3D intc_pin[7:0]
> +     */
> +    if (cpu_index < EXTIOI_CPUS) {
> +        for (pin =3D 0; pin < LS3A_INTC_IP; pin++) {
> +            qdev_connect_gpio_out(extioi, (cpu_index * 8 + pin),
> +                                  qdev_get_gpio_in(cpudev, pin + 2));
> +        }
> +    }
> +
> +    return cpu;
> +}
> +
> +static void loongarch_cpu_plug(HotplugHandler *hotplug_dev,
> +                                DeviceState *dev, Error **errp)
> +{
> +    CPUArchId *found_cpu;
> +    HotplugHandlerClass *hhc;
> +    Error *local_err =3D NULL;
> +    MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> +    LoongArchMachineState *lsms =3D LOONGARCH_MACHINE(machine);
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +    CPUState *cs =3D CPU(dev);
> +
> +    if (lsms->acpi_ged) {
dont' you need CPUs if you don't have ged?
/is it possible that ged doesn't exists?/

> +        loongarch_cpu_create(machine, cpu, errp);
> +        hhc =3D HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
> +        hhc->plug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    found_cpu =3D loongarch_find_cpu_slot(MACHINE(lsms), cs->cpu_index, =
NULL);
> +    found_cpu->cpu =3D OBJECT(dev);
> +
> +    return;
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> @@ -1053,6 +1383,8 @@ static void loongarch_machine_device_plug_cb(Hotplu=
gHandler *hotplug_dev,
>          }
>      } else if (memhp_type_supported(dev)) {
>          virt_mem_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
> +        loongarch_cpu_plug(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -1062,16 +1394,39 @@ static HotplugHandler *virt_machine_get_hotplug_h=
andler(MachineState *machine,
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> =20
>      if (device_is_dynamic_sysbus(mc, dev) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
>          memhp_type_supported(dev)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;
>  }
> =20
> +static int virt_get_socket_id(const MachineState *ms, int cpu_index)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
> +}
> +
> +static int virt_get_core_id(const MachineState *ms, int cpu_index)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
> +}
> +
> +static int virt_get_thread_id(const MachineState *ms, int cpu_index)
> +{
> +    assert(cpu_index >=3D 0 && cpu_index < ms->possible_cpus->len);
> +
> +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
> +}
> +
>  static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  {
>      int n;
>      unsigned int max_cpus =3D ms->smp.max_cpus;
> +    unsigned int smp_threads =3D ms->smp.threads;
> =20
>      if (ms->possible_cpus) {
>          assert(ms->possible_cpus->len =3D=3D max_cpus);
> @@ -1082,6 +1437,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_=
ids(MachineState *ms)
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len =3D max_cpus;
>      for (n =3D 0; n < ms->possible_cpus->len; n++) {
> +        ms->possible_cpus->cpus[n].vcpus_count =3D smp_threads;
>          ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
>          ms->possible_cpus->cpus[n].arch_id =3D n;
> =20
> @@ -1125,6 +1481,7 @@ static void loongarch_class_init(ObjectClass *oc, v=
oid *data)
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> =20
> +    mc->has_hotpluggable_cpus =3D true;
>      mc->desc =3D "Loongson-3A5000 LS7A1000 machine";
>      mc->init =3D loongarch_init;
>      mc->default_ram_size =3D 1 * GiB;
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index f1659655c6..9ebdba676e 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -31,6 +31,7 @@
>  #define VIRT_GED_EVT_ADDR       0x100e0000
>  #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LE=
N)
>  #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_L=
EN)
> +#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_CPU_HOTPLUG_RE=
G_LEN)
> =20
>  struct LoongArchMachineState {
>      /*< private >*/
> @@ -42,7 +43,7 @@ struct LoongArchMachineState {
>      MemoryRegion bios;
>      bool         bios_loaded;
>      /* State for other subsystems/APIs: */
> -    FWCfgState  *fw_cfg;
> +    FWCfgState   *fw_cfg;
>      Notifier     machine_done;
>      Notifier     powerdown_notifier;
>      OnOffAuto    acpi;
> @@ -50,13 +51,19 @@ struct LoongArchMachineState {
>      char         *oem_table_id;
>      DeviceState  *acpi_ged;
>      int          fdt_size;
> -    DeviceState *platform_bus_dev;
> +    DeviceState  *platform_bus_dev;
>      PCIBus       *pci_bus;
>      PFlashCFI01  *flash;
> +    DeviceState  *extioi;
> +    unsigned int boot_cpus;
>  };
> =20
>  #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
>  OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
>  bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>  void loongarch_acpi_setup(LoongArchMachineState *lams);
> +void virt_madt_cpu_entry(int uid,
> +                         const CPUArchIdList *apic_ids, GArray *entry,
> +                         bool force_enabled);
> +
>  #endif
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ed04027af1..f4439c245f 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -367,6 +367,10 @@ struct ArchCPU {
>      CPUState parent_obj;
>      /*< public >*/
> =20
> +    int32_t socket_id;  /* socket-id of this VCPU */
> +    int32_t core_id;    /* core-id of this VCPU */
> +    int32_t thread_id;  /* thread-id of this VCPU */
> +    int32_t node_id;    /* NUMA node this CPU belongs to */
>      CPUNegativeOffsetState neg;
>      CPULoongArchState env;
>      QEMUTimer timer;



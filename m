Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1A9D5FE3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Nov 2024 14:46:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETyi-0008Gs-ML; Fri, 22 Nov 2024 08:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tETyf-0008Gb-U1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tETyd-0003kV-JF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732283138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TT29BLSU2TfD0mpYrxAddlSE1m/iXsN6PM6MFmVnwpw=;
 b=NVYx9vsN2LN/+RAgXY13WVgDW6kTgAmN1Xr12WUJbZYT/gCrbQPHAOs7wWjWC+im69py0G
 hOn/osdb3bazljT/Pln4K1ioKj515KTlMHZdERzyYP84T3Ko7CdqmncBXbwC7t6euDOeDj
 r7PDkYvaiF3ib2r9yp/7OrAQN9zTPhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-kMCoTki_M5qv-rLVQIgicQ-1; Fri, 22 Nov 2024 08:45:36 -0500
X-MC-Unique: kMCoTki_M5qv-rLVQIgicQ-1
X-Mimecast-MFC-AGG-ID: kMCoTki_M5qv-rLVQIgicQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso14355565e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 05:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283135; x=1732887935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TT29BLSU2TfD0mpYrxAddlSE1m/iXsN6PM6MFmVnwpw=;
 b=XCi2btDaagBOL1KSv9rhf6QZzuONm/bWhJ450LMsNwN4W/9hOAV9QoMGQCE/17Tpnd
 0GACZldDoba27N6mqRTbpDZDzADlskyKcTyHViHcYL08DGOhC+cDR4qGHLhFOG4HupJ4
 ikW6ZAV4H/+h/+RXLyG7loPGQl66r6v8UriS0zKLEGkO+a9i4eAqC8Hz52A175QW/eI5
 +NvEZ3UAdwd/6Bo3aJ+vWFFOn4f0X9kAkGLVU7lwCsvwkGDvMDpldmktwMGs5RYjQOev
 jZiF1lue6UyFLwnNuRFOeJ5Mj68SD/S/MBn9DB3ezc0AVBHFgUcN1l4yYBjj6uIKxM41
 OhPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7rWcZvhNUqrWZHa8H5w1IRjJHlLQC6FxbJEl2fiG/aLsoOWj9I2dB4TKU5AfKi4NRUB7JbLBwibnO@nongnu.org
X-Gm-Message-State: AOJu0YzpkIoFOyo+Wz9e0o+GQGrmIOnCkluE0uV7z4TThsdebGZ+IQ0b
 uDXTn+sg8RsGIn/s4SlkKmlQpMmdOduUBe4mUmUCRT9DMJD5PPWnxGJMagbOvDLKGJFyvK3+cof
 H9tnqQTKpanT/mrnjeay/M7830PxNskzEB2WT17MLfzKSrQmDRC3j
X-Gm-Gg: ASbGncsPcHKwX31q6fLjRevAOgZKP/YZCZeHd6mg28KT3wlQyM93hDqDygQDb+xhtAI
 s2MResINz9mduHsDaCKUTi7aHUph20xVnSJAJf/UO7jaVgzmK97zknKKbZCThy4boq2K/RGLNyX
 undlqh3awfRzPp8jzlyeU1eETKwBgFP4hgaA7dzIM5DcZSoYLWQNcmv8+RVlEmkKwKi+aczfBh7
 sNCtRM9YypH23eLlxxRjrqHl6vZz1czAU8M9lM4aXxRQweFsVoUJIUM7TVUyDNFklQEqPgVjB48
 c+kqzNTMdIFRZYwlJO22Eg==
X-Received: by 2002:a05:600c:3b93:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-433ce4256a7mr26035065e9.12.1732283135586; 
 Fri, 22 Nov 2024 05:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4SP4vcfoLZWBh3MuXygSgvfMq7g3+/TSPkZfRqC19VOmhRc+uedOrVdkUSh/O9+hswtQ77w==
X-Received: by 2002:a05:600c:3b93:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-433ce4256a7mr26034755e9.12.1732283135094; 
 Fri, 22 Nov 2024 05:45:35 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b0139b22sm94115375e9.0.2024.11.22.05.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 05:45:34 -0800 (PST)
Date: Fri, 22 Nov 2024 14:45:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/6] hw/loongarch/virt: Add generic function to init
 interrupt pin of CPU
Message-ID: <20241122144533.5ce77f6e@imammedo.users.ipa.redhat.com>
In-Reply-To: <b3a86101-faab-3db2-e049-d77ecf0cc27e@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
 <20241112021738.1952851-4-maobibo@loongson.cn>
 <20241118174346.23b6d2ee@imammedo.users.ipa.redhat.com>
 <b3a86101-faab-3db2-e049-d77ecf0cc27e@loongson.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 19 Nov 2024 18:02:54 +0800
bibo mao <maobibo@loongson.cn> wrote:

> On 2024/11/19 =E4=B8=8A=E5=8D=8812:43, Igor Mammedov wrote:
> > On Tue, 12 Nov 2024 10:17:35 +0800
> > Bibo Mao <maobibo@loongson.cn> wrote:
> >  =20
> >> Here generic function virt_init_cpu_irq() is added to init interrupt
> >> pin of CPU object, IPI and extioi interrupt controllers are connected
> >> to interrupt pin of CPU object.
> >>
> >> The generic function can be used to both cold-plug and hot-plug CPUs. =
=20
> >=20
> > this patch is heavily depends on cpu_index and specific order CPUs
> > are created. =20
> yes, that is actually one problem with heavy dependency, I will try to=20
> remove the dependency.
> >  =20
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   hw/loongarch/virt.c         | 78 ++++++++++++++++++++++++-----------=
--
> >>   include/hw/loongarch/virt.h |  2 +
> >>   2 files changed, 53 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> >> index b6b616d278..621380e2b3 100644
> >> --- a/hw/loongarch/virt.c
> >> +++ b/hw/loongarch/virt.c
> >> @@ -58,6 +58,20 @@ static bool virt_is_veiointc_enabled(LoongArchVirtM=
achineState *lvms)
> >>       return true;
> >>   }
> >>  =20
> >> +static CPUState *virt_get_cpu(MachineState *ms, int index)
> >> +{
> >> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >> +    const CPUArchIdList *possible_cpus;
> >> +
> >> +    /* Init CPUs */
> >> +    possible_cpus =3D mc->possible_cpu_arch_ids(ms);
> >> +    if (index < 0 || index >=3D possible_cpus->len) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    return possible_cpus->cpus[index].cpu;
> >> +} =20
> >=20
> > instead of adding this helper I'd suggest to try reusing
> > virt_find_cpu_slot() added in previous patch.
> >  =20
> >> +
> >>   static void virt_get_veiointc(Object *obj, Visitor *v, const char *n=
ame,
> >>                                 void *opaque, Error **errp)
> >>   {
> >> @@ -365,7 +379,7 @@ static void create_fdt(LoongArchVirtMachineState *=
lvms)
> >>   static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
> >>   {
> >>       int num;
> >> -    const MachineState *ms =3D MACHINE(lvms);
> >> +    MachineState *ms =3D MACHINE(lvms);
> >>       int smp_cpus =3D ms->smp.cpus;
> >>  =20
> >>       qemu_fdt_add_subnode(ms->fdt, "/cpus");
> >> @@ -375,7 +389,7 @@ static void fdt_add_cpu_nodes(const LoongArchVirtM=
achineState *lvms)
> >>       /* cpu nodes */
> >>       for (num =3D smp_cpus - 1; num >=3D 0; num--) { =20
> >=20
> > loops based on smp_cpus become broken as soon as you have
> >   '-smp x, -device your-cpu,...
> > since it doesn't take in account '-device' created CPUs.
> > You likely need to replace such loops to iterate over possible_cpus
> > (in a separate patch please) =20
> yes, will do. possible_cpus can be used and virt_get_cpu() is unnecessary.
>=20
> Interesting, I never create cpu like the method like this, will try this.
> '-smp x, -device your-cpu,...'

that's how target VM could be starred with if cpu were hotpluged on
migration source side.

'-smp x' basically shortcut to series of '-device cpu-foo',
with the only big difference is that the later is created after machine_init
while '-smp x' CPUs are created at machine_init time.

That's the reason to I'm pushing you to move all CPU wiring to plug handler=
s,
so eventually you would end up with only way of adding CPUs, regardless of
what creates them (-smp or -device/device_add)

Ideally/if possible you should be able to start VM with '-smp 0, -device cp=
u-foo'

> >     =20
> >>           char *nodename =3D g_strdup_printf("/cpus/cpu@%d", num);
> >> -        LoongArchCPU *cpu =3D LOONGARCH_CPU(qemu_get_cpu(num));
> >> +        LoongArchCPU *cpu =3D LOONGARCH_CPU(virt_get_cpu(ms, num));
> >>           CPUState *cs =3D CPU(cpu);
> >>  =20
> >>           qemu_fdt_add_subnode(ms->fdt, nodename);
> >> @@ -783,16 +797,42 @@ static void virt_devices_init(DeviceState *pch_p=
ic,
> >>       lvms->platform_bus_dev =3D create_platform_bus(pch_pic);
> >>   }
> >>  =20
> >> +static void virt_init_cpu_irq(MachineState *ms, CPUState *cs)
> >> +{
> >> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
> >> +    CPULoongArchState *env;
> >> +    LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(ms);
> >> +    int pin;
> >> +
> >> +    if (!lvms->ipi || !lvms->extioi) {
> >> +        return;
> >> +    }
> >> +
> >> +    env =3D &(cpu->env);
> >> +    env->address_space_iocsr =3D &lvms->as_iocsr;
> >> +    env->ipistate =3D lvms->ipi;
> >> +    /* connect ipi irq to cpu irq, logic cpu index used here */
> >> +    qdev_connect_gpio_out(lvms->ipi, cs->cpu_index, =20
> > I'd try to avoid using cpu_index (basically internal CPU detail) when
> > wiring components together. It would be better to implement this the way
> > the real hw does it. =20
> yes, will try to remove this and ipi device realize funciton. When ipi=20
> device is created, it will search possible_cpus and connect to interrupt=
=20
> pin of supported CPU.
>=20
> The real hw is same with Interrupt Pin method :(, and there is no=20
> apic-bus or Processor System Bus like x86.
>=20
> Regards
> Bibo Mao
> >=20
> >  =20
> >> +                              qdev_get_gpio_in(DEVICE(cs), IRQ_IPI));
> >> +
> >> +    /*
> >> +     * connect ext irq to the cpu irq
> >> +     * cpu_pin[9:2] <=3D intc_pin[7:0]
> >> +     */
> >> +    for (pin =3D 0; pin < LS3A_INTC_IP; pin++) {
> >> +        qdev_connect_gpio_out(lvms->extioi, cs->cpu_index * LS3A_INTC=
_IP + pin,
> >> +                              qdev_get_gpio_in(DEVICE(cs), pin + 2));
> >> +    }
> >> +}
> >> +
> >>   static void virt_irq_init(LoongArchVirtMachineState *lvms)
> >>   {
> >>       MachineState *ms =3D MACHINE(lvms);
> >> -    DeviceState *pch_pic, *pch_msi, *cpudev;
> >> +    DeviceState *pch_pic, *pch_msi;
> >>       DeviceState *ipi, *extioi;
> >>       SysBusDevice *d;
> >> -    LoongArchCPU *lacpu;
> >> -    CPULoongArchState *env;
> >>       CPUState *cpu_state;
> >> -    int cpu, pin, i, start, num;
> >> +    int cpu, i, start, num;
> >>       uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_=
msi_phandle;
> >>  =20
> >>       /*
> >> @@ -843,6 +883,7 @@ static void virt_irq_init(LoongArchVirtMachineStat=
e *lvms)
> >>       ipi =3D qdev_new(TYPE_LOONGARCH_IPI);
> >>       qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
> >>       sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
> >> +    lvms->ipi =3D ipi;
> >>  =20
> >>       /* IPI iocsr memory region */
> >>       memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
> >> @@ -853,18 +894,6 @@ static void virt_irq_init(LoongArchVirtMachineSta=
te *lvms)
> >>       /* Add cpu interrupt-controller */
> >>       fdt_add_cpuic_node(lvms, &cpuintc_phandle);
> >>  =20
> >> -    for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
> >> -        cpu_state =3D qemu_get_cpu(cpu);
> >> -        cpudev =3D DEVICE(cpu_state);
> >> -        lacpu =3D LOONGARCH_CPU(cpu_state);
> >> -        env =3D &(lacpu->env);
> >> -        env->address_space_iocsr =3D &lvms->as_iocsr;
> >> -
> >> -        /* connect ipi irq to cpu irq */
> >> -        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_=
IPI));
> >> -        env->ipistate =3D ipi;
> >> -    }
> >> -
> >>       /* Create EXTIOI device */
> >>       extioi =3D qdev_new(TYPE_LOONGARCH_EXTIOI);
> >>       qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
> >> @@ -872,6 +901,7 @@ static void virt_irq_init(LoongArchVirtMachineStat=
e *lvms)
> >>           qdev_prop_set_bit(extioi, "has-virtualization-extension", tr=
ue);
> >>       }
> >>       sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
> >> +    lvms->extioi =3D extioi;
> >>       memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
> >>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0=
));
> >>       if (virt_is_veiointc_enabled(lvms)) {
> >> @@ -879,16 +909,10 @@ static void virt_irq_init(LoongArchVirtMachineSt=
ate *lvms)
> >>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1=
));
> >>       }
> >>  =20
> >> -    /*
> >> -     * connect ext irq to the cpu irq
> >> -     * cpu_pin[9:2] <=3D intc_pin[7:0]
> >> -     */
> >> +    /* Connect irq to cpu, including ipi and extioi irqchip */
> >>       for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
> >> -        cpudev =3D DEVICE(qemu_get_cpu(cpu));
> >> -        for (pin =3D 0; pin < LS3A_INTC_IP; pin++) {
> >> -            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
> >> -                                  qdev_get_gpio_in(cpudev, pin + 2));
> >> -        }
> >> +        cpu_state =3D virt_get_cpu(ms, cpu);
> >> +        virt_init_cpu_irq(ms, cpu_state);
> >>       }
> >>  =20
> >>       /* Add Extend I/O Interrupt Controller node */
> >> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> >> index 9ba47793ef..260e6bd7cf 100644
> >> --- a/include/hw/loongarch/virt.h
> >> +++ b/include/hw/loongarch/virt.h
> >> @@ -60,6 +60,8 @@ struct LoongArchVirtMachineState {
> >>       MemoryRegion iocsr_mem;
> >>       AddressSpace as_iocsr;
> >>       struct loongarch_boot_info bootinfo;
> >> +    DeviceState *ipi;
> >> +    DeviceState *extioi;
> >>   };
> >>  =20
> >>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt") =20
>=20



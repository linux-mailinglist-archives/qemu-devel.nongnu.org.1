Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EC951A88
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Aug 2024 14:04:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCj1-0002TU-Id; Wed, 14 Aug 2024 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seCit-0002J8-Gk; Wed, 14 Aug 2024 08:03:28 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1seCih-0004cp-2c; Wed, 14 Aug 2024 08:03:27 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef248ab2aeso101994811fa.0; 
 Wed, 14 Aug 2024 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723636993; x=1724241793; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pLWlOhX7IA1D60QAMmJx/e3m5tenDd37UlQuuePJAH8=;
 b=lOdMBsWwf1qYEiDEK9lr2shN5ZP+mcwSRpUP1PVUKLStKz32iV+afvHySNJVJBhkhF
 /i+M+YAa+TvEE/Dj0T4wAUbuLTMlz2g6oTEdN58qfJjK1VxY+GhF1GnXMbCFWJLU/t3z
 jNCOz6GpGZ3xBbTaFPuK7JEc4VBQNOyC8qniLP/+W/J7An+QWCJoYiVG8SI5logezuOO
 o8I2Bp4AqafIGzgMEhOg03lS4CJzJqd6FdSFCptPwuXNU6TENAOt328rx6lywN8vchab
 sDrWy9CMuMdPlMrli4ZATe8N+WlYL+P7fg2g7EcB21YjkP10d+JcxOK2ZEzVnAeL3pg/
 /9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636993; x=1724241793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLWlOhX7IA1D60QAMmJx/e3m5tenDd37UlQuuePJAH8=;
 b=CPW5trNKoR3MnmpPY7mGzH11o3f8UA9++j/GWDajME7LmNPhC9xaiorGh2LeNxHK3/
 Ch6d4WacanLs8sr886EsYp/hVcPzZE9NQY8N7mpXxei1Y2GEyZMEStYT2WmFgc6IDJL5
 BgmWsAcHphI6qiFgmtOEPUOQ5kvqaaV5gsg4hnfuZrycto6YaXGAh201OMC1UaZyWJwb
 CB4HeIiyomjZCX9SA8gs3RVJDEMuaz3Bvo7v86m7EKgmNyEY8YzJ7sPJpdQ08Hr3lHqf
 sTnTpLJniSJ8uqankKZ7BbnXFsIrcxzmw6WXtPqGu6tpdCyVdqlCs2xV6xEzzHyR8MM5
 iY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxVs/JJke04lzdtDCt1svzSCPHILAqpV/veLkX0VQQgXvAbR10zRNYq9ym0Zgfzu17HdMRmTcvy5OfGlOASx8vvVgI
X-Gm-Message-State: AOJu0YxdVK1nDDtjXLYK7WOoT+tVhau43BHqm6lst6qBsrbGpMpYQfgx
 ySajdnvTBq3FD+oRwNVr9EjzUrcwB+dKRj8Du5rLjNz5sAcNRVN3
X-Google-Smtp-Source: AGHT+IFpGmYJLf5ZDi74BUV7AvcFD/4rB5wLJWAUAT0SVtzs0jlSIzfJAaZ9CKeogM3VI9No7by5Jw==
X-Received: by 2002:a2e:e09:0:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f3aa1df04emr17339101fa.14.1723636991778; 
 Wed, 14 Aug 2024 05:03:11 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f2920511d0sm14080291fa.113.2024.08.14.05.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 05:03:10 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:03:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v1 05/10] hw/arm: xenpvh: Break out a common PVH module
Message-ID: <Zryc_gna9c4XNX9c@zapote>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-6-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121720290.298534@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2408121720290.298534@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 12, 2024 at 06:47:51PM -0700, Stefano Stabellini wrote:
> On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Break out a common Xen PVH module in preparation for
> > adding a x86 Xen PVH Machine.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/arm/trace-events             |   5 -
> >  hw/arm/xen_arm.c                | 154 ++++++--------------------
> >  hw/xen/meson.build              |   1 +
> >  hw/xen/trace-events             |   4 +
> >  hw/xen/xen-pvh-common.c         | 185 ++++++++++++++++++++++++++++++++
> >  include/hw/xen/xen-pvh-common.h |  45 ++++++++
> >  6 files changed, 269 insertions(+), 125 deletions(-)
> >  create mode 100644 hw/xen/xen-pvh-common.c
> >  create mode 100644 include/hw/xen/xen-pvh-common.h
> > 
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index be6c8f720b..c64ad344bd 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -68,10 +68,5 @@ z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
> >  z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
> >  z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
> >  
> > -# xen_arm.c
> > -xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
> > -xen_init_ram(uint64_t machine_ram_size) "Initialized xen ram with size 0x%"PRIx64
> > -xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
> > -
> >  # bcm2838.c
> >  bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
> > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> > index ef8315969c..b8a5c09bdf 100644
> > --- a/hw/arm/xen_arm.c
> > +++ b/hw/arm/xen_arm.c
> > @@ -12,40 +12,25 @@
> >  #include "hw/irq.h"
> >  #include "hw/sysbus.h"
> >  #include "sysemu/block-backend.h"
> > -#include "sysemu/tpm_backend.h"
> >  #include "sysemu/sysemu.h"
> > -#include "hw/xen/xen-hvm-common.h"
> > +#include "hw/xen/xen-pvh-common.h"
> >  #include "sysemu/tpm.h"
> >  #include "hw/xen/arch_hvm.h"
> > -#include "trace.h"
> >  
> >  #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
> >  OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
> >  
> > -static const MemoryListener xen_memory_listener = {
> > -    .region_add = xen_region_add,
> > -    .region_del = xen_region_del,
> > -    .log_start = NULL,
> > -    .log_stop = NULL,
> > -    .log_sync = NULL,
> > -    .log_global_start = NULL,
> > -    .log_global_stop = NULL,
> > -    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
> > -};
> > -
> >  struct XenArmState {
> >      /*< private >*/
> >      MachineState parent;
> >  
> > -    XenIOState *state;
> > +    XenPVHCommonState pvh;
> >  
> >      struct {
> >          uint64_t tpm_base_addr;
> >      } cfg;
> >  };
> >  
> > -static MemoryRegion ram_lo, ram_hi;
> > -
> >  /*
> >   * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
> >   * repository.
> > @@ -57,64 +42,6 @@ static MemoryRegion ram_lo, ram_hi;
> >  #define NR_VIRTIO_MMIO_DEVICES   \
> >     (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
> >  
> > -static void xen_set_irq(void *opaque, int irq, int level)
> > -{
> > -    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
> > -        error_report("xendevicemodel_set_irq_level failed");
> > -    }
> > -}
> > -
> > -static void xen_create_virtio_mmio_devices(XenArmState *xam)
> > -{
> > -    int i;
> > -
> > -    for (i = 0; i < NR_VIRTIO_MMIO_DEVICES; i++) {
> > -        hwaddr base = GUEST_VIRTIO_MMIO_BASE + i * VIRTIO_MMIO_DEV_SIZE;
> > -        qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
> > -                                         GUEST_VIRTIO_MMIO_SPI_FIRST + i);
> > -
> > -        sysbus_create_simple("virtio-mmio", base, irq);
> > -
> > -        trace_xen_create_virtio_mmio_devices(i,
> > -                                             GUEST_VIRTIO_MMIO_SPI_FIRST + i,
> > -                                             base);
> > -    }
> > -}
> 
> There are 4 trivial functions in this file:
> 
> void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
> void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
>                          bool add)
> void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
> void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
> 
> Do you think it would make sense to move these too to xen-pvh-common.c ?


Yes, it would be nice to at least provide some sort of default
implementation for these that archs like x86 can override. I'll look
into it for v2.


> 
> 
> > -
> > -static void xen_init_ram(MachineState *machine)
> > -{
> > -    MemoryRegion *sysmem = get_system_memory();
> > -    ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
> > -
> > -    trace_xen_init_ram(machine->ram_size);
> > -    if (machine->ram_size <= GUEST_RAM0_SIZE) {
> > -        ram_size[0] = machine->ram_size;
> > -        ram_size[1] = 0;
> > -        block_len = GUEST_RAM0_BASE + ram_size[0];
> > -    } else {
> > -        ram_size[0] = GUEST_RAM0_SIZE;
> > -        ram_size[1] = machine->ram_size - GUEST_RAM0_SIZE;
> > -        block_len = GUEST_RAM1_BASE + ram_size[1];
> > -    }
> > -
> > -    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
> > -                           &error_fatal);
> > -
> > -    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &xen_memory,
> > -                             GUEST_RAM0_BASE, ram_size[0]);
> > -    memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
> > -    if (ram_size[1] > 0) {
> > -        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &xen_memory,
> > -                                 GUEST_RAM1_BASE, ram_size[1]);
> > -        memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
> > -    }
> > -
> > -    /* Setup support for grants.  */
> > -    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
> > -                           &error_fatal);
> > -    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
> > -}
> > -
> >  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
> >  {
> >      hw_error("Invalid ioreq type 0x%x\n", req->type);
> > @@ -135,55 +62,42 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
> >  {
> >  }
> >  
> > -#ifdef CONFIG_TPM
> > -static void xen_enable_tpm(XenArmState *xam)
> > -{
> > -    Error *errp = NULL;
> > -    DeviceState *dev;
> > -    SysBusDevice *busdev;
> > -
> > -    TPMBackend *be = qemu_find_tpm_be("tpm0");
> > -    if (be == NULL) {
> > -        error_report("Couldn't find tmp0 backend");
> > -        return;
> > -    }
> > -    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
> > -    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
> > -    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > -    busdev = SYS_BUS_DEVICE(dev);
> > -    sysbus_realize_and_unref(busdev, &error_fatal);
> > -    sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
> > -
> > -    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
> > -}
> > -#endif
> > -
> > -static void xen_arm_init(MachineState *machine)
> > +static void xen_arm_init(MachineState *ms)
> >  {
> > -    XenArmState *xam = XEN_ARM(machine);
> > -
> > -    xam->state =  g_new0(XenIOState, 1);
> > +    XenArmState *xam = XEN_ARM(ms);
> > +    const struct {
> > +        const char *name;
> > +        MemMapEntry map;
> > +    } map[] = {
> > +        { "ram-low", { GUEST_RAM0_BASE, GUEST_RAM0_SIZE } },
> > +        { "ram-high", { GUEST_RAM1_BASE, GUEST_RAM1_SIZE } },
> > +        { "virtio-mmio", { GUEST_VIRTIO_MMIO_BASE, VIRTIO_MMIO_DEV_SIZE } },
> > +        { "tpm", { xam->cfg.tpm_base_addr, 0x1000 } },
> > +    };
> > +    int i;
> >  
> > -    if (machine->ram_size == 0) {
> > -        warn_report("%s non-zero ram size not specified. QEMU machine started"
> > -                    " without IOREQ (no emulated devices including virtio)",
> > -                    MACHINE_CLASS(object_get_class(OBJECT(machine)))->desc);
> > -        return;
> > +    object_initialize_child(OBJECT(ms), "pvh", &xam->pvh, TYPE_XEN_PVH_COMMON);
> > +
> > +    object_property_set_int(OBJECT(&xam->pvh), "max-cpus", ms->smp.max_cpus,
> > +                            &error_abort);
> 
> Is ms->smp.max_cpus updated according to the QEMU command line option?
> If so, that would solve the problem of the static initialization of
> max_cpus to GUEST_MAX_VCPUS in xen_arm_machine_class_init.

Yes, it kind of solves it but I'll leave that discussion to the other
thread.

> 
> 
> > +    object_property_set_int(OBJECT(&xam->pvh), "ram-size", ms->ram_size,
> > +                            &error_abort);
> > +    object_property_set_int(OBJECT(&xam->pvh), "virtio-mmio-num",
> > +                            NR_VIRTIO_MMIO_DEVICES, &error_abort);
> > +    object_property_set_int(OBJECT(&xam->pvh), "virtio-mmio-irq-base",
> > +                            GUEST_VIRTIO_MMIO_SPI_FIRST, &error_abort);
> > +
> > +    for (i = 0; i < ARRAY_SIZE(map); i++) {
> > +        g_autofree char *base_name = g_strdup_printf("%s-base", map[i].name);
> > +        g_autofree char *size_name = g_strdup_printf("%s-size", map[i].name);
> > +
> > +        object_property_set_int(OBJECT(&xam->pvh), base_name, map[i].map.base,
> > +                                &error_abort);
> > +        object_property_set_int(OBJECT(&xam->pvh), size_name, map[i].map.size,
> > +                                &error_abort);
> >      }
> >  
> > -    xen_init_ram(machine);
> > -
> > -    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
> > -
> > -    xen_create_virtio_mmio_devices(xam);
> > -
> > -#ifdef CONFIG_TPM
> > -    if (xam->cfg.tpm_base_addr) {
> > -        xen_enable_tpm(xam);
> 
> Do you think it makes sense also to move xen_arm_get_tpm_base_addr and
> xen_arm_set_tpm_base_addr to xen-pvh-common.c ?
>

Yes, perhaps we should create an abstract PVH machine. We could probably
reuse more code between x86/ARM and future PVH support. I can have a
look at it for v2.

> 
> 
> > -    } else {
> > -        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
> > -    }
> > -#endif
> > +    sysbus_realize(SYS_BUS_DEVICE(&xam->pvh), &error_abort);
> >  }
> >  
> >  #ifdef CONFIG_TPM
> > diff --git a/hw/xen/meson.build b/hw/xen/meson.build
> > index d887fa9ba4..4a486e3673 100644
> > --- a/hw/xen/meson.build
> > +++ b/hw/xen/meson.build
> > @@ -15,6 +15,7 @@ xen_specific_ss = ss.source_set()
> >  xen_specific_ss.add(files(
> >    'xen-mapcache.c',
> >    'xen-hvm-common.c',
> > +  'xen-pvh-common.c',
> >  ))
> >  if have_xen_pci_passthrough
> >    xen_specific_ss.add(files(
> > diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> > index d1b27f6c11..a07fe41c6d 100644
> > --- a/hw/xen/trace-events
> > +++ b/hw/xen/trace-events
> > @@ -64,6 +64,10 @@ destroy_hvm_domain_cannot_acquire_handle(void) "Cannot acquire xenctrl handle"
> >  destroy_hvm_domain_failed_action(const char *action, int sts, char *errno_s) "xc_domain_shutdown failed to issue %s, sts %d, %s"
> >  destroy_hvm_domain_action(int xen_domid, const char *action) "Issued domain %d %s"
> >  
> > +# xen-pvh-common.c
> > +xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created virtio-mmio device %d: irq %d base 0x%"PRIx64
> > +xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%"PRIx64
> > +
> >  # xen-mapcache.c
> >  xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
> >  xen_remap_bucket(uint64_t index) "index 0x%"PRIx64
> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> > new file mode 100644
> > index 0000000000..0d368398d0
> > --- /dev/null
> > +++ b/hw/xen/xen-pvh-common.c
> > @@ -0,0 +1,185 @@
> > +/*
> > + * Common Xen PVH code.
> > + *
> > + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > +#include "hw/boards.h"
> > +#include "hw/irq.h"
> > +#include "hw/sysbus.h"
> > +#include "sysemu/sysemu.h"
> > +#include "sysemu/tpm.h"
> > +#include "sysemu/tpm_backend.h"
> > +#include "hw/xen/xen-pvh-common.h"
> > +#include "trace.h"
> > +
> > +static const MemoryListener xen_memory_listener = {
> > +    .region_add = xen_region_add,
> > +    .region_del = xen_region_del,
> > +    .log_start = NULL,
> > +    .log_stop = NULL,
> > +    .log_sync = NULL,
> > +    .log_global_start = NULL,
> > +    .log_global_stop = NULL,
> > +    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
> > +};
> > +
> > +static void xen_pvh_init_ram(XenPVHCommonState *s,
> > +                             MemoryRegion *sysmem)
> > +{
> > +    ram_addr_t block_len, ram_size[2];
> > +
> > +    if (s->cfg.ram_size <= s->cfg.ram_low.size) {
> > +        ram_size[0] = s->cfg.ram_size;
> > +        ram_size[1] = 0;
> > +        block_len = s->cfg.ram_low.base + ram_size[0];
> > +    } else {
> > +        ram_size[0] = s->cfg.ram_low.size;
> > +        ram_size[1] = s->cfg.ram_size - s->cfg.ram_low.size;
> > +        block_len = s->cfg.ram_high.base + ram_size[1];
> > +    }
> > +
> > +    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
> > +                           &error_fatal);
> > +
> > +    memory_region_init_alias(&s->ram.low, NULL, "xen.ram.lo", &xen_memory,
> > +                             s->cfg.ram_low.base, ram_size[0]);
> > +    memory_region_add_subregion(sysmem, s->cfg.ram_low.base, &s->ram.low);
> > +    if (ram_size[1] > 0) {
> > +        memory_region_init_alias(&s->ram.high, NULL, "xen.ram.hi", &xen_memory,
> > +                                 s->cfg.ram_high.base, ram_size[1]);
> > +        memory_region_add_subregion(sysmem, s->cfg.ram_high.base, &s->ram.high);
> > +    }
> > +
> > +    /* Setup support for grants.  */
> > +    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
> > +                           &error_fatal);
> > +    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
> > +}
> > +
> > +static void xen_set_irq(void *opaque, int irq, int level)
> > +{
> > +    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
> > +        error_report("xendevicemodel_set_irq_level failed");
> > +    }
> > +}
> > +
> > +static void xen_create_virtio_mmio_devices(XenPVHCommonState *s)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < s->cfg.virtio_mmio_num; i++) {
> > +        hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
> > +        qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
> > +                                         s->cfg.virtio_mmio_irq_base + i);
> > +
> > +        sysbus_create_simple("virtio-mmio", base, irq);
> > +
> > +        trace_xen_create_virtio_mmio_devices(i,
> > +                                             s->cfg.virtio_mmio_irq_base + i,
> > +                                             base);
> > +    }
> > +}
> > +
> > +#ifdef CONFIG_TPM
> > +static void xen_enable_tpm(XenPVHCommonState *s)
> > +{
> > +    Error *errp = NULL;
> > +    DeviceState *dev;
> > +    SysBusDevice *busdev;
> > +
> > +    TPMBackend *be = qemu_find_tpm_be("tpm0");
> > +    if (be == NULL) {
> > +        error_report("Couldn't find tmp0 backend");
> > +        return;
> > +    }
> > +    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
> > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
> > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > +    busdev = SYS_BUS_DEVICE(dev);
> > +    sysbus_realize_and_unref(busdev, &error_fatal);
> > +    sysbus_mmio_map(busdev, 0, s->cfg.tpm.base);
> > +
> > +    trace_xen_enable_tpm(s->cfg.tpm.base);
> > +}
> > +#endif
> > +
> > +static void xen_pvh_realize(DeviceState *dev, Error **errp)
> > +{
> > +    XenPVHCommonState *s = XEN_PVH_COMMON(dev);
> > +    MemoryRegion *sysmem = get_system_memory();
> > +
> > +    if (s->cfg.ram_size == 0) {
> > +        /* FIXME: Prefix with object path and consider bailing out.  */
> 
> I am not sure about these two FIXME
> 
> 
> > +        warn_report("non-zero ram size not specified. QEMU machine started"
> > +                    " without IOREQ (no emulated devices including virtio)");
> 
> Also the warn message has a double negative?


Yeah, I forgot to fix these up before posting. Will fix for v2.


> 
> 
> > +        return;
> > +    }
> > +
> > +    if (s->cfg.max_cpus == 0) {
> > +        /* FIXME: Prefix with object path and bail out.  */
> > +        warn_report("max-cpus not specified. QEMU machine started");
> > +        return;
> > +    }
> > +
> > +    xen_pvh_init_ram(s, sysmem);
> > +    xen_register_ioreq(&s->ioreq, s->cfg.max_cpus, &xen_memory_listener);
> > +
> > +    if (s->cfg.virtio_mmio_num) {
> > +        xen_create_virtio_mmio_devices(s);
> > +    }
> > +
> > +#ifdef CONFIG_TPM
> > +    if (s->cfg.tpm.base) {
> > +        xen_enable_tpm(s);
> > +    } else {
> > +        warn_report("tpm-base-addr is not provided. TPM will not be enabled");
> > +    }
> > +#endif
> > +}
> > +
> > +#define DEFINE_PROP_MEMMAP(n, f) \
> > +    DEFINE_PROP_UINT64(n "-base", XenPVHCommonState, cfg.f.base, 0), \
> > +    DEFINE_PROP_UINT64(n "-size", XenPVHCommonState, cfg.f.size, 0)
> > +
> > +static Property xen_pvh_properties[] = {
> > +    DEFINE_PROP_UINT32("max-cpus", XenPVHCommonState, cfg.max_cpus, 0),
> > +    DEFINE_PROP_UINT64("ram-size", XenPVHCommonState, cfg.ram_size, 0),
> > +    DEFINE_PROP_MEMMAP("ram-low", ram_low),
> > +    DEFINE_PROP_MEMMAP("ram-high", ram_high),
> > +    DEFINE_PROP_MEMMAP("virtio-mmio", virtio_mmio),
> > +    DEFINE_PROP_MEMMAP("tpm", tpm),
> > +    DEFINE_PROP_UINT32("virtio-mmio-num", XenPVHCommonState,
> > +                       cfg.virtio_mmio_num, 0),
> > +    DEFINE_PROP_UINT32("virtio-mmio-irq-base", XenPVHCommonState,
> > +                       cfg.virtio_mmio_irq_base, 0),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static void xen_pvh_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->realize = xen_pvh_realize;
> > +    device_class_set_props(dc, xen_pvh_properties);
> > +    /* No VMSD since we haven't got any top-level SoC state to save.  */
> > +}
> > +
> > +static const TypeInfo xen_pvh_info = {
> > +    .name = TYPE_XEN_PVH_COMMON,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(XenPVHCommonState),
> > +    .class_init = xen_pvh_class_init,
> > +};
> > +
> > +static void xen_pvh_register_types(void)
> > +{
> > +    type_register_static(&xen_pvh_info);
> > +}
> > +
> > +type_init(xen_pvh_register_types);
> > diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
> > new file mode 100644
> > index 0000000000..e958b441fd
> > --- /dev/null
> > +++ b/include/hw/xen/xen-pvh-common.h
> > @@ -0,0 +1,45 @@
> > +/*
> > + * QEMU Xen PVH machine - common code.
> > + *
> > + * Copyright (c) 2024 Advanced Micro Devices, Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef XEN_PVH_COMMON_H__
> > +#define XEN_PVH_COMMON_H__
> > +
> > +#include <assert.h>
> > +#include "hw/sysbus.h"
> > +#include "hw/hw.h"
> > +#include "hw/xen/xen-hvm-common.h"
> > +#include "hw/pci-host/gpex.h"
> > +
> > +#define TYPE_XEN_PVH_COMMON "xen-pvh-common"
> > +OBJECT_DECLARE_SIMPLE_TYPE(XenPVHCommonState, XEN_PVH_COMMON)
> > +
> > +typedef struct XenPVHCommonState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    XenIOState ioreq;
> > +
> > +    struct {
> > +        MemoryRegion low;
> > +        MemoryRegion high;
> > +    } ram;
> > +
> > +    struct {
> > +        uint64_t ram_size;
> > +        uint32_t max_cpus;
> > +        uint32_t virtio_mmio_num;
> > +        uint32_t virtio_mmio_irq_base;
> > +        struct {
> > +            uint64_t base;
> > +            uint64_t size;
> > +        } ram_low, ram_high,
> > +          virtio_mmio,
> > +          tpm;
> > +    } cfg;
> > +} XenPVHCommonState;
> > +#endif
> > -- 
> > 2.43.0
> > 


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2478CAE36
	for <lists+qemu-devel@lfdr.de>; Tue, 21 May 2024 14:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Obq-0002d8-2J; Tue, 21 May 2024 08:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s9Obm-0002cG-Tq
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:28:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s9Obj-00019e-J6
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:28:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f4472561f1so376647b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716294522; x=1716899322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RlGMH7HApAT32muLjrdXbw7G6jhA/1xR8pytZxcdLsY=;
 b=bOsrHBedY5S1Eg/1RsLWZ/tCx+26s4Wdlm2YghrJy/LXGBr4TqXKCHEKcGYaTC9SUW
 SFZ28SmWHgGLK+ieNnGOKSa1YdCA/C4RVuLYO63xbxVi/4cc8HkbT9LeKwBG+fnOen2y
 dma06OUavAn3nwTjyYIk7wHp9ygGn88/0Ve769D3xBCrM6uX1lC0fcpuo+4qN6I2LogJ
 CVn6dDfT4JskaqBFJMuhAIIN2bqVzmXxc0uC5CZ0p80jh3iO6m2YL/XF+N7ISU3cV0Bw
 DCVOZQdByiMl2bxMP8SfyyJnFe2LKgUjq+uvV6+TocOGI4DCbEP8/riWhGxsYGMQDTJU
 r7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294522; x=1716899322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RlGMH7HApAT32muLjrdXbw7G6jhA/1xR8pytZxcdLsY=;
 b=G/lg08OcMSL5x73gnjb9KsDOPGf2MAL874vIxJGf/aRxkAzsQkqwm669T2ktjFLJUt
 lWQKcB/FkVCu6c5XG/XtsSLC/LGa4E71kMBLe9+CO3CrYIXQGwSep7zmMcC7MbVl8Bw4
 egP/+3rRmkDhpS73L9H8sCIwH70i+MWymtvi0ESHz0JDHPNJvdP/aXaHQ4B1uya6DwJM
 GDxETXGaSIc3VGwnSEHHK1/5W01NXAcxDLEYels/ig8ah1HTy58i+QrbmVYI5uzhss73
 0QROULhEqAyVeE0uAdCJFFXOQzuxUCtTVJHDaheug39+fWxPVruQuohBoBWUT9kOJP3g
 HWxQ==
X-Gm-Message-State: AOJu0YxltwZHIkdhPnita9NYpabuf8Drjw8vgY5LPbhVU6syCUseacn7
 5eQt7vIuTQnYI5Kkn1VGy78ws1uJqrxJXyUKH6oW+7FG1B4EzK24UEPWDeRExo4=
X-Google-Smtp-Source: AGHT+IFPW4dGbnK1nvavIK5GCL8I6rkna9fo1bDseeAh9Gr4iKl929jDpCxUDayfxzvKjj4/Qkb8SQ==
X-Received: by 2002:a05:6a20:9498:b0:1af:a456:671c with SMTP id
 adf61e73a8af0-1afde1978dbmr40850654637.40.1716294521899; 
 Tue, 21 May 2024 05:28:41 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-63a917264d6sm17932352a12.73.2024.05.21.05.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:28:41 -0700 (PDT)
Message-ID: <d46c1b11-3079-4d2d-98fa-d281caf2244d@ventanamicro.com>
Date: Tue, 21 May 2024 09:28:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] hw/riscv: add RISC-V IOMMU base emulation
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Sebastien Boeuf <seb@rivosinc.com>, Sunil V L <sunilvl@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-4-dbarboza@ventanamicro.com>
 <CANzO1D35eYan8axod37tAg88r=qg4Jt0CVTvO+0AiwRLbbV64A@mail.gmail.com>
 <09dc2e36-741d-44de-aac8-4ed2495eaeb1@ventanamicro.com>
 <abd1e74a-8d74-4ef9-b917-ce1a3c8e6af9@ventanamicro.com>
 <CAE_xrPhNhxWGT1_MvUJ9Jecz5obRc5tpdk9u_BW57uqC_G1uBA@mail.gmail.com>
 <4de35d60-d605-47e6-87fe-0ed7c1793069@ventanamicro.com>
 <CAE_xrPgME8jCaEuW-yDK-3kzLu66MCMfppt3dpRO5jQOGH9heg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAE_xrPgME8jCaEuW-yDK-3kzLu66MCMfppt3dpRO5jQOGH9heg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 5/21/24 07:52, Frank Chang wrote:
> Hi Daniel,
> 
> On Tue, May 21, 2024 at 12:17 AM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> 
>     Hi Frank,
> 
>     On 5/16/24 04:13, Frank Chang wrote:
>      > On Mon, May 13, 2024 at 8:37 PM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com> <mailto:dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>> wrote:
>      >
>      >     Hi Frank,
>      >
>      >
>      >     On 5/8/24 08:15, Daniel Henrique Barboza wrote:
>      >      > Hi Frank,
>      >      >
>      >      > I'll reply with that I've done so far. Still missing some stuff:
>      >      >
>      >      > On 5/2/24 08:37, Frank Chang wrote:
>      >      >> Hi Daniel,
>      >      >>
>      >      >> Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com> <mailto:dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>> 於 2024年3月8日 週五 上午12:04寫道：
>      >      >>>
>      >      >>> From: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com> <mailto:tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>>
>      >      >>>
>      >      >>> The RISC-V IOMMU specification is now ratified as-per the RISC-V
>      >      >>> international process. The latest frozen specifcation can be found
>      >      >>> at:
>      >      >>>
>      >      >>> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf <https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf> <https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf <https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf>>
>      >      >>>
>      >      >>> Add the foundation of the device emulation for RISC-V IOMMU, which
>      >      >>> includes an IOMMU that has no capabilities but MSI interrupt support and
>      >      >>> fault queue interfaces. We'll add add more features incrementally in the
>      >      >>> next patches.
>      >      >>>
>      >      >>> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com <mailto:seb@rivosinc.com> <mailto:seb@rivosinc.com <mailto:seb@rivosinc.com>>>
>      >      >>> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com <mailto:seb@rivosinc.com> <mailto:seb@rivosinc.com <mailto:seb@rivosinc.com>>>
>      >      >>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com> <mailto:tjeznach@rivosinc.com <mailto:tjeznach@rivosinc.com>>>
>      >      >>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com> <mailto:dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>>
>      >      >>> ---
>      >      >>>   hw/riscv/Kconfig         |    4 +
>      >
>      >     (...)
>      >
>      >      >>> +
>      >      >>> +    s->iommus.le_next = NULL;
>      >      >>> +    s->iommus.le_prev = NULL;
>      >      >>> +    QLIST_INIT(&s->spaces);
>      >      >>> +    qemu_cond_init(&s->core_cond);
>      >      >>> +    qemu_mutex_init(&s->core_lock);
>      >      >>> +    qemu_spin_init(&s->regs_lock);
>      >      >>> +    qemu_thread_create(&s->core_proc, "riscv-iommu-core",
>      >      >>> +        riscv_iommu_core_proc, s, QEMU_THREAD_JOINABLE);
>      >      >>
>      >      >> In our experience, using QEMU thread increases the latency of command
>      >      >> queue processing,
>      >      >> which leads to the potential IOMMU fence timeout in the Linux driver
>      >      >> when using IOMMU with KVM,
>      >      >> e.g. booting the guest Linux.
>      >      >>
>      >      >> Is it possible to remove the thread from the IOMMU just like ARM, AMD,
>      >      >> and Intel IOMMU models?
>      >      >
>      >      > Interesting. We've been using this emulation internally in Ventana, with
>      >      > KVM and VFIO, and didn't experience this issue. Drew is on CC and can talk
>      >      > more about it.
>      >      >
>      >      > That said, I don't mind this change, assuming it's feasible to make it for this
>      >      > first version.  I'll need to check it how other IOMMUs are doing it.
>      >
>      >
>      >     I removed the threading and it seems to be working fine without it. I'll commit this
>      >     change for v3.
>      >
>      >      >
>      >      >
>      >      >
>      >      >>
>      >      >>> +}
>      >      >>> +
>      >      >
>      >      > (...)
>      >      >
>      >      >>> +
>      >      >>> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>      >      >>> +{
>      >      >>> +    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
>      >      >>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>      >      >>> +    AddressSpace *as = NULL;
>      >      >>> +
>      >      >>> +    if (pdev && pci_is_iommu(pdev)) {
>      >      >>> +        return s->target_as;
>      >      >>> +    }
>      >      >>> +
>      >      >>> +    /* Find first registered IOMMU device */
>      >      >>> +    while (s->iommus.le_prev) {
>      >      >>> +        s = *(s->iommus.le_prev);
>      >      >>> +    }
>      >      >>> +
>      >      >>> +    /* Find first matching IOMMU */
>      >      >>> +    while (s != NULL && as == NULL) {
>      >      >>> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
>      >      >>
>      >      >> For pci_bus_num(),
>      >      >> riscv_iommu_find_as() can be called at the very early stage
>      >      >> where software has no chance to enumerate the bus numbers.
>      >
>      >     I investigated and this doesn't seem to be a problem. This function is called at the
>      >     last step of the realize() steps of both riscv_iommu_pci_realize() and
>      >     riscv_iommu_sys_realize(), and by that time the pci_bus_num() is already assigned.
>      >     Other iommus use pci_bus_num() into their own get_address_space() callbacks like
>      >     this too.
>      >
>      >
>      > Hi Daniel,
>      >
>      > IIUC, pci_bus_num() by default is assigned to pcibus_num():
>      >
>      > static int pcibus_num(PCIBus *bus)
>      > {
>      >      if (pci_bus_is_root(bus)) {
>      >          return 0; /* pci host bridge */
>      >      }
>      >      return bus->parent_dev->config[PCI_SECONDARY_BUS];
>      > }
>      >
>      > If the bus is not the root bus, it tries to read the bus' parent device's
>      > secondary bus number (PCI_SECONDARY_BUS) field in the PCI configuration space.
>      > This field should be programmable by the SW during PCIe enumeration.
>      > But I don't think SW has a chance to be executed before riscv_iommu_sys_realize() is called,
>      > since it's pretty early before CPU's execution unless RISC-V IOMMU is hot-plugged.
>      > Even if RISC-V IOMMU is hot-plugged, I think riscv_iommu_sys_realize() is still called
>      > before SW aware of the existence of IOMMU on the PCI topology tree.
>      >
>      > Do you think this matches your observation?
> 
>     It does. You have a good point on how the pcibus_num() can vary if SW wants to
>     change the PCI_SECONDARY_BUS and the IOMMU isn't in a root bus. Note that this
>     will not happen with the existing riscv-iommu-pci device as it is now, since it
>     has code to prevent the device to be attached to non-pci root buses, but there's
>     no restrictions in the riscv-iommu-sys device.
> 
> 
> Thanks for the explanation.
> 
> Do you know where this limitation is from?
> Is it in this patchset or it's somewhere else in the Linux RISC-V IOMMU driver?

I don't know. I know that the riscv-iommu spec does not impose these restrictions, so
I assume that this is a design choice from Tomasz when designing both the first
QEMU impl and the Linux driver.


> 
> BTW, for the case like DesignWare PCIe host controller [1],
> we cannot connect RISC-V IOMMU to the root bus ("pcie") [2]
> because it already has a child bus ("dw-pcie") connecting to it [3].
> 
> If we try to connect RISC-V IOMMU to the root bus ("pcie"),
> it can't be discovered by Linux PCIe driver as a PCIe Downstream Port
> normally leads to a Link with only Device 0 on it.
> 
> PCIe spec 6.0, section 7.3.1 stats:
> "Downstream Ports that do not have ARI Forwarding enabled must associate
> only Device 0 with the device attached to the Logical Bus representing the Link
> from the Port."
> 
> The PCI slot scan is early returned in the Linux PCIe driver [4][5].
> 
> Do you think it's possible to remove this limitation?

I'm pretty sure it is. It's only a matter of how much code and effort we're
willing to put into it.

For this initial impl I believe we can live with this restriction. We will enable more
use cases as we go along on both Linux and QEMU.


Thanks,

Daniel



> 
> [1] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c <https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c>
> [2] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L695 <https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L695>
> [3] https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L409 <https://github.com/qemu/qemu/blob/master/hw/pci-host/designware.c#L409>
> [4] https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2674 <https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2674>
> [5] https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2652 <https://github.com/torvalds/linux/blob/master/drivers/pci/probe.c#L2652>
> 
> Regards,
> Frank Chang
> 
> 
>     And speaking on riscv-iommu-bus, the current device we have in this series is too
>     bare bones, without an actual use case for it (e.g. code to add it in the 'virt'
>     machine), but it's getting in the way nevertheless.
> 
>     I'll remove the riscv-iommu-sys device from v3 and re-introduce it in a later
>     revision or as a follow up series. Sunil has a handful of patches that add the
>     riscv-iommu-sys device in the 'virt' machine and the proper ACPI support for it [1],
>     and I intend to use them as a base. We'll then need some minor adjustments in the
>     existing code to make it fully functional like we're doing with riscv-iommu-pci.
> 
> 
>     Thanks,
> 
>     Daniel
> 
> 
>     [1] https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/ <https://github.com/vlsunil/qemu/commits/acpi_rimt_poc_v1/>
>      >
>      > Regards,
>      > Frank Chang
>      >
>      >
>      >
>      >     Thanks,
>      >
>      >
>      >     Daniel
>      >
>      >
>      >      >
>      >      > I'll see how other IOMMUs are handling their iommu_find_as()
>      >      >
>      >      >
>      >      > Thanks,
>      >      >
>      >      >
>      >      > Daniel
>      >      >
>      >      >
>      >      >>
>      >      >>
>      >      >>
>      >      >>
>      >      >>> +        s = s->iommus.le_next;
>      >      >>> +    }
>      >      >>> +
>      >      >>> +    return as ? as : &address_space_memory;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static const PCIIOMMUOps riscv_iommu_ops = {
>      >      >>> +    .get_address_space = riscv_iommu_find_as,
>      >      >>> +};
>      >      >>> +
>      >      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>      >      >>> +        Error **errp)
>      >      >>> +{
>      >      >>> +    if (bus->iommu_ops &&
>      >      >>> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
>      >      >>> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
>      >      >>> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
>      >      >>> +        QLIST_INSERT_AFTER(last, iommu, iommus);
>      >      >>> +    } else if (bus->iommu_ops == NULL) {
>      >      >>> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
>      >      >>> +    } else {
>      >      >>> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>      >      >>> +            pci_bus_num(bus));
>      >      >>> +    }
>      >      >>> +}
>      >      >>> +
>      >      >>> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
>      >      >>> +    MemTxAttrs attrs)
>      >      >>> +{
>      >      >>> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
>      >      >>> +{
>      >      >>> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
>      >      >>> +    return 1 << as->iommu->pasid_bits;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
>      >      >>> +{
>      >      >>> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>      >      >>> +
>      >      >>> +    imrc->translate = riscv_iommu_memory_region_translate;
>      >      >>> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
>      >      >>> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
>      >      >>> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static const TypeInfo riscv_iommu_memory_region_info = {
>      >      >>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>      >      >>> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
>      >      >>> +    .class_init = riscv_iommu_memory_region_init,
>      >      >>> +};
>      >      >>> +
>      >      >>> +static void riscv_iommu_register_mr_types(void)
>      >      >>> +{
>      >      >>> +    type_register_static(&riscv_iommu_memory_region_info);
>      >      >>> +    type_register_static(&riscv_iommu_info);
>      >      >>> +}
>      >      >>> +
>      >      >>> +type_init(riscv_iommu_register_mr_types);
>      >      >>> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
>      >      >>> new file mode 100644
>      >      >>> index 0000000000..6f740de690
>      >      >>> --- /dev/null
>      >      >>> +++ b/hw/riscv/riscv-iommu.h
>      >      >>> @@ -0,0 +1,141 @@
>      >      >>> +/*
>      >      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>      >      >>> + *
>      >      >>> + * Copyright (C) 2022-2023 Rivos Inc.
>      >      >>> + *
>      >      >>> + * This program is free software; you can redistribute it and/or modify
>      >      >>> + * it under the terms of the GNU General Public License as published by
>      >      >>> + * the Free Software Foundation; either version 2 of the License.
>      >      >>> + *
>      >      >>> + * This program is distributed in the hope that it will be useful,
>      >      >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      >      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>      >      >>> + * GNU General Public License for more details.
>      >      >>> + *
>      >      >>> + * You should have received a copy of the GNU General Public License along
>      >      >>> + * with this program; if not, see <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/> <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>>.
>      >      >>> + */
>      >      >>> +
>      >      >>> +#ifndef HW_RISCV_IOMMU_STATE_H
>      >      >>> +#define HW_RISCV_IOMMU_STATE_H
>      >      >>> +
>      >      >>> +#include "qemu/osdep.h"
>      >      >>> +#include "qom/object.h"
>      >      >>> +
>      >      >>> +#include "hw/riscv/iommu.h"
>      >      >>> +
>      >      >>> +struct RISCVIOMMUState {
>      >      >>> +    /*< private >*/
>      >      >>> +    DeviceState parent_obj;
>      >      >>> +
>      >      >>> +    /*< public >*/
>      >      >>> +    uint32_t version;     /* Reported interface version number */
>      >      >>> +    uint32_t pasid_bits;  /* process identifier width */
>      >      >>> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>      >      >>> +
>      >      >>> +    uint64_t cap;         /* IOMMU supported capabilities */
>      >      >>> +    uint64_t fctl;        /* IOMMU enabled features */
>      >      >>> +
>      >      >>> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
>      >      >>> +    bool enable_msi;      /* Enable MSI remapping */
>      >      >>> +
>      >      >>> +    /* IOMMU Internal State */
>      >      >>> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
>      >      >>> +
>      >      >>> +    dma_addr_t cq_addr;   /* Command queue base physical address */
>      >      >>> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
>      >      >>> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
>      >      >>> +
>      >      >>> +    uint32_t cq_mask;     /* Command queue index bit mask */
>      >      >>> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
>      >      >>> +    uint32_t pq_mask;     /* Page request queue index bit mask */
>      >      >>> +
>      >      >>> +    /* interrupt notifier */
>      >      >>> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>      >      >>> +
>      >      >>> +    /* IOMMU State Machine */
>      >      >>> +    QemuThread core_proc; /* Background processing thread */
>      >      >>> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
>      >      >>> +    QemuCond core_cond;   /* Background processing wake up signal */
>      >      >>> +    unsigned core_exec;   /* Processing thread execution actions */
>      >      >>> +
>      >      >>> +    /* IOMMU target address space */
>      >      >>> +    AddressSpace *target_as;
>      >      >>> +    MemoryRegion *target_mr;
>      >      >>> +
>      >      >>> +    /* MSI / MRIF access trap */
>      >      >>> +    AddressSpace trap_as;
>      >      >>> +    MemoryRegion trap_mr;
>      >      >>> +
>      >      >>> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
>      >      >>> +
>      >      >>> +    /* MMIO Hardware Interface */
>      >      >>> +    MemoryRegion regs_mr;
>      >      >>> +    QemuSpin regs_lock;
>      >      >>> +    uint8_t *regs_rw;  /* register state (user write) */
>      >      >>> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
>      >      >>> +    uint8_t *regs_ro;  /* read-only mask */
>      >      >>> +
>      >      >>> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
>      >      >>> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>      >      >>> +};
>      >      >>> +
>      >      >>> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>      >      >>> +         Error **errp);
>      >      >>> +
>      >      >>> +/* private helpers */
>      >      >>> +
>      >      >>> +/* Register helper functions */
>      >      >>> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx, uint32_t set, uint32_t clr)
>      >      >>> +{
>      >      >>> +    uint32_t val;
>      >      >>> +    qemu_spin_lock(&s->regs_lock);
>      >      >>> +    val = ldl_le_p(s->regs_rw + idx);
>      >      >>> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
>      >      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >      >>> +    return val;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx, uint32_t set)
>      >      >>> +{
>      >      >>> +    qemu_spin_lock(&s->regs_lock);
>      >      >>> +    stl_le_p(s->regs_rw + idx, set);
>      >      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >      >>> +}
>      >      >>> +
>      >      >>> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx)
>      >      >>> +{
>      >      >>> +    return ldl_le_p(s->regs_rw + idx);
>      >      >>> +}
>      >      >>> +
>      >      >>> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx, uint64_t set, uint64_t clr)
>      >      >>> +{
>      >      >>> +    uint64_t val;
>      >      >>> +    qemu_spin_lock(&s->regs_lock);
>      >      >>> +    val = ldq_le_p(s->regs_rw + idx);
>      >      >>> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
>      >      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >      >>> +    return val;
>      >      >>> +}
>      >      >>> +
>      >      >>> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx, uint64_t set)
>      >      >>> +{
>      >      >>> +    qemu_spin_lock(&s->regs_lock);
>      >      >>> +    stq_le_p(s->regs_rw + idx, set);
>      >      >>> +    qemu_spin_unlock(&s->regs_lock);
>      >      >>> +}
>      >      >>> +
>      >      >>> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
>      >      >>> +    unsigned idx)
>      >      >>> +{
>      >      >>> +    return ldq_le_p(s->regs_rw + idx);
>      >      >>> +}
>      >      >>> +
>      >      >>> +
>      >      >>> +
>      >      >>> +#endif
>      >      >>> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
>      >      >>> new file mode 100644
>      >      >>> index 0000000000..42a97caffa
>      >      >>> --- /dev/null
>      >      >>> +++ b/hw/riscv/trace-events
>      >      >>> @@ -0,0 +1,11 @@
>      >      >>> +# See documentation at docs/devel/tracing.rst
>      >      >>> +
>      >      >>> +# riscv-iommu.c
>      >      >>> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
>      >      >>> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
>      >      >>> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
>      >      >>> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
>      >      >>> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
>      >      >>> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
>      >      >>> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
>      >      >>> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
>      >      >>> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
>      >      >>> new file mode 100644
>      >      >>> index 0000000000..b88504b750
>      >      >>> --- /dev/null
>      >      >>> +++ b/hw/riscv/trace.h
>      >      >>> @@ -0,0 +1,2 @@
>      >      >>> +#include "trace/trace-hw_riscv.h"
>      >      >>> +
>      >      >>> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
>      >      >>> new file mode 100644
>      >      >>> index 0000000000..403b365893
>      >      >>> --- /dev/null
>      >      >>> +++ b/include/hw/riscv/iommu.h
>      >      >>> @@ -0,0 +1,36 @@
>      >      >>> +/*
>      >      >>> + * QEMU emulation of an RISC-V IOMMU (Ziommu)
>      >      >>> + *
>      >      >>> + * Copyright (C) 2022-2023 Rivos Inc.
>      >      >>> + *
>      >      >>> + * This program is free software; you can redistribute it and/or modify
>      >      >>> + * it under the terms of the GNU General Public License as published by
>      >      >>> + * the Free Software Foundation; either version 2 of the License.
>      >      >>> + *
>      >      >>> + * This program is distributed in the hope that it will be useful,
>      >      >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>      >      >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>      >      >>> + * GNU General Public License for more details.
>      >      >>> + *
>      >      >>> + * You should have received a copy of the GNU General Public License along
>      >      >>> + * with this program; if not, see <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/> <http://www.gnu.org/licenses/ <http://www.gnu.org/licenses/>>>.
>      >      >>> + */
>      >      >>> +
>      >      >>> +#ifndef HW_RISCV_IOMMU_H
>      >      >>> +#define HW_RISCV_IOMMU_H
>      >      >>> +
>      >      >>> +#include "qemu/osdep.h"
>      >      >>> +#include "qom/object.h"
>      >      >>> +
>      >      >>> +#define TYPE_RISCV_IOMMU "riscv-iommu"
>      >      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
>      >      >>> +typedef struct RISCVIOMMUState RISCVIOMMUState;
>      >      >>> +
>      >      >>> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
>      >      >>> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>      >      >>> +
>      >      >>> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
>      >      >>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>      >      >>> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
>      >      >>> +
>      >      >>> +#endif
>      >      >>> diff --git a/meson.build b/meson.build
>      >      >>> index c59ca496f2..75e56f3282 100644
>      >      >>> --- a/meson.build
>      >      >>> +++ b/meson.build
>      >      >>> @@ -3361,6 +3361,7 @@ if have_system
>      >      >>>       'hw/rdma',
>      >      >>>       'hw/rdma/vmw',
>      >      >>>       'hw/rtc',
>      >      >>> +    'hw/riscv',
>      >      >>>       'hw/s390x',
>      >      >>>       'hw/scsi',
>      >      >>>       'hw/sd',
>      >      >>> --
>      >      >>> 2.43.2
>      >      >>>
>      >      >>>
>      >
> 


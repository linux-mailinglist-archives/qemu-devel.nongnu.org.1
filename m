Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B67547F296B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:56:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NTq-0008P0-GO; Tue, 21 Nov 2023 04:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1r5NTS-0008Oj-PT; Tue, 21 Nov 2023 04:55:18 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1r5NTM-0000Pd-Uz; Tue, 21 Nov 2023 04:55:18 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AL9siWg049756;
 Tue, 21 Nov 2023 17:54:44 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 21 Nov 2023
 17:54:40 +0800
Date: Tue, 21 Nov 2023 17:54:35 +0800
To: Alistair Francis <alistair23@gmail.com>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <edgar.iglesias@gmail.com>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <in.meng@windriver.com>,
 <liweiwei@iscas.ac.cn>, <dbarboza@ventanamicro.com>,
 <hiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>,
 <peterx@redhat.com>, <david@redhat.com>
Subject: Re: [PATCH v3 4/4] hw/riscv/virt: Add IOPMP support
Message-ID: <ZVx+W7B46Il3ru/D@ethan84-VirtualBox>
References: <20231114094705.109146-1-ethan84@andestech.com>
 <20231114094705.109146-5-ethan84@andestech.com>
 <CAKmqyKNTcec+QLPLyWRtF4k5DQzNEK_aVmJY28fUGgXTrvWcyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNTcec+QLPLyWRtF4k5DQzNEK_aVmJY28fUGgXTrvWcyw@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3AL9siWg049756
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 21, 2023 at 03:22:18PM +1000, Alistair Francis wrote:
> On Tue, Nov 14, 2023 at 7:48 PM Ethan Chen via <qemu-devel@nongnu.org> wrote:
> >
> > - Add 'iopmp=on' option to enable a iopmp device and a dma device
> >  connect to the iopmp device
> > - Add 'iopmp_cascade=on' option to enable iopmp cascading.
> 
> Can we document these in docs/system/riscv/virt.rst
> 
> Alistair

Sure. I will document these.

Thanks,
Ethan Chen

> 
> >
> > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > ---
> >  hw/riscv/Kconfig        |  2 ++
> >  hw/riscv/virt.c         | 72 +++++++++++++++++++++++++++++++++++++++--
> >  include/hw/riscv/virt.h | 10 +++++-
> >  3 files changed, 81 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index b6a5eb4452..c30a104aa4 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -45,6 +45,8 @@ config RISCV_VIRT
> >      select FW_CFG_DMA
> >      select PLATFORM_BUS
> >      select ACPI
> > +    select ATCDMAC300
> > +    select RISCV_IOPMP
> >
> >  config SHAKTI_C
> >      bool
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index c7fc97e273..3e23ee3afc 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -53,6 +53,8 @@
> >  #include "hw/display/ramfb.h"
> >  #include "hw/acpi/aml-build.h"
> >  #include "qapi/qapi-visit-common.h"
> > +#include "hw/misc/riscv_iopmp.h"
> > +#include "hw/dma/atcdmac300.h"
> >
> >  /*
> >   * The virt machine physical address space used by some of the devices
> > @@ -97,6 +99,9 @@ static const MemMapEntry virt_memmap[] = {
> >      [VIRT_UART0] =        { 0x10000000,         0x100 },
> >      [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
> >      [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
> > +    [VIRT_IOPMP] =        { 0x10200000,      0x100000 },
> > +    [VIRT_IOPMP2] =       { 0x10300000,      0x100000 },
> > +    [VIRT_DMAC] =         { 0x10400000,      0x100000 },
> >      [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
> >      [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
> >      [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> > @@ -1527,13 +1532,33 @@ static void virt_machine_init(MachineState *machine)
> >
> >      create_platform_bus(s, mmio_irqchip);
> >
> > -    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> > -        0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
> > +    serial_mm_init(system_memory, memmap[VIRT_UART0].base + 0x20,
> > +        0x2, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 38400,
> >          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> >
> >      sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
> >          qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
> >
> > +    /* DMAC */
> > +    DeviceState *dmac_dev = atcdmac300_create("atcdmac300",
> > +        memmap[VIRT_DMAC].base, memmap[VIRT_DMAC].size,
> > +        qdev_get_gpio_in(DEVICE(mmio_irqchip), DMAC_IRQ));
> > +
> > +    if (s->have_iopmp) {
> > +        /* IOPMP */
> > +        DeviceState *iopmp_dev = iopmp_create(memmap[VIRT_IOPMP].base,
> > +            qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP_IRQ));
> > +        /* DMA with IOPMP */
> > +        atcdmac300_connect_iopmp(dmac_dev, &(IOPMP(iopmp_dev)->iopmp_as),
> > +            (StreamSink *)&(IOPMP(iopmp_dev)->transaction_info_sink), 0);
> > +        if (s->have_iopmp_cascade) {
> > +            DeviceState *iopmp_dev2 = iopmp_create(memmap[VIRT_IOPMP2].base,
> > +                qdev_get_gpio_in(DEVICE(mmio_irqchip), IOPMP2_IRQ));
> > +            cascade_iopmp(iopmp_dev, iopmp_dev2);
> > +        }
> > +    }
> > +
> > +
> >      for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
> >          /* Map legacy -drive if=pflash to machine properties */
> >          pflash_cfi01_legacy_drive(s->flash[i],
> > @@ -1628,6 +1653,35 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
> >      s->have_aclint = value;
> >  }
> >
> > +static bool virt_get_iopmp(Object *obj, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    return s->have_iopmp;
> > +}
> > +
> > +static void virt_set_iopmp(Object *obj, bool value, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    s->have_iopmp = value;
> > +}
> > +
> > +static bool virt_get_iopmp_cascade(Object *obj, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    return s->have_iopmp_cascade;
> > +}
> > +
> > +static void virt_set_iopmp_cascade(Object *obj, bool value, Error **errp)
> > +{
> > +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> > +
> > +    s->have_iopmp_cascade = value;
> > +}
> > +
> > +
> >  bool virt_is_acpi_enabled(RISCVVirtState *s)
> >  {
> >      return s->acpi != ON_OFF_AUTO_OFF;
> > @@ -1730,6 +1784,20 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
> >                                NULL, NULL);
> >      object_class_property_set_description(oc, "acpi",
> >                                            "Enable ACPI");
> > +
> > +    object_class_property_add_bool(oc, "iopmp", virt_get_iopmp,
> > +                                   virt_set_iopmp);
> > +    object_class_property_set_description(oc, "iopmp",
> > +                                          "Set on/off to enable/disable "
> > +                                          "iopmp device");
> > +
> > +    object_class_property_add_bool(oc, "iopmp-cascade",
> > +                                   virt_get_iopmp_cascade,
> > +                                   virt_set_iopmp_cascade);
> > +    object_class_property_set_description(oc, "iopmp-cascade",
> > +                                          "Set on/off to enable/disable "
> > +                                          "iopmp2 device which is cascaded by "
> > +                                          "iopmp1 device");
> >  }
> >
> >  static const TypeInfo virt_machine_typeinfo = {
> > diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> > index e5c474b26e..5fa2944d29 100644
> > --- a/include/hw/riscv/virt.h
> > +++ b/include/hw/riscv/virt.h
> > @@ -54,6 +54,8 @@ struct RISCVVirtState {
> >
> >      int fdt_size;
> >      bool have_aclint;
> > +    bool have_iopmp;
> > +    bool have_iopmp_cascade;
> >      RISCVVirtAIAType aia_type;
> >      int aia_guests;
> >      char *oem_id;
> > @@ -82,12 +84,18 @@ enum {
> >      VIRT_PCIE_MMIO,
> >      VIRT_PCIE_PIO,
> >      VIRT_PLATFORM_BUS,
> > -    VIRT_PCIE_ECAM
> > +    VIRT_PCIE_ECAM,
> > +    VIRT_IOPMP,
> > +    VIRT_IOPMP2,
> > +    VIRT_DMAC,
> >  };
> >
> >  enum {
> >      UART0_IRQ = 10,
> >      RTC_IRQ = 11,
> > +    DMAC_IRQ = 12,
> > +    IOPMP_IRQ = 13,
> > +    IOPMP2_IRQ = 14,
> >      VIRTIO_IRQ = 1, /* 1 to 8 */
> >      VIRTIO_COUNT = 8,
> >      PCIE_IRQ = 0x20, /* 32 to 35 */
> > --
> > 2.34.1
> >
> >


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1250B82DB0C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:09:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNde-0001he-Qt; Mon, 15 Jan 2024 09:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNdc-0001hT-HE
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:08:28 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNdY-00070C-UF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:08:28 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5592d72edecso1361327a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705327703; x=1705932503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vpEHxY1OHhxdVeBHb/ROFNkza4a7PLaFZHlTrM9dBOI=;
 b=KM45U/zLHIV9R+VjBps90HEY/ECXegqlO3O1YUq42scMrzV+GwJxhURRcbGivh2g7M
 Tvkq436XiLS4f5X22Q2FREasumlLQIox142TmdXBsGO2RoimXPl6P0PDew0hTrXkKQ8r
 0XsFCNme05WIkjFJh71TIM8JJ4YV1m9Mgp+PSBmJYYRRlaFbmTZKwDlIvi0vyiA0mC3D
 fGlDJ4B/HbIMCCy5mMafFMHOynyvH8QiYYgkwL1vxJfvvdoof5J3zypfF43K2W+6JjWA
 QNla3bx68056n7kQUKdAiSjVZe9VdL/W12/bH560EaTBCjLMTSuz2eHTa69b3QSJkS4K
 FR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705327703; x=1705932503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vpEHxY1OHhxdVeBHb/ROFNkza4a7PLaFZHlTrM9dBOI=;
 b=T+CeZs/fqapNuzGUG5S9KWeFVyJhNjV+QiafdUgL5/aDutQ2OYO3CB1+joUB7yu1M/
 nkKgfOKdm1nSsckanzUSTVJUJts4fKkgrFLJRHdSXSXiy+x1+hBU3a98HlNFTr/YxJMB
 QrFAPYGEw1m/0JR9yH4sQ5LFSBeTr4dDsnAL16q2YJ9i8AQ7wAfRl/tA9toA3eqEL61C
 NLnhhaUVHyOlCBODqTdRbB4OSdemK0kQI+K9uIe2FuXdi9DOICXn/iE3XEBY3emHJqcP
 R1Cvcu6sdTHVgK7AufrShuleJ+84DSeL/IMujEh7QeN0nPBuhsKMrlOEDIn6jUMnM/5h
 H7gw==
X-Gm-Message-State: AOJu0YyWH1zNchMkinUkAacieaARreFMLMJchz69mJCzlDWIHRfNK/ee
 dCGQJKC6eES9NqCs4Mnm1jK9SAbE7x9pS7rY/mBZH+1mX4i02g==
X-Google-Smtp-Source: AGHT+IHOt73Fcb9RFgdd7vOmNqeTvRcK8mgQ7vEz+TqrJQilYSiLK+QC/EAGxJnxaILOaf/5uT/pbcuUS9B3pOBNpP0=
X-Received: by 2002:a05:6402:387:b0:558:3687:884 with SMTP id
 o7-20020a056402038700b0055836870884mr2920661edv.50.1705327702801; Mon, 15 Jan
 2024 06:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-16-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-16-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:08:11 +0000
Message-ID: <CAFEAcA-BjdtTrNowo9eHJvz8M0PXX15EfpXoRdxwGXV+ADToug@mail.gmail.com>
Subject: Re: [PATCH v4 15/45] Add BCM2838 PCIE host
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

(I've cc'd our PCI subsystem maintainers, because I'm not really
confident in reviewing a PCI controller model. Marcel, Michael:
this is one of 3 patches adding the pcie controller for the raspberry
pi 4 SoC. You can find the relevant patches also here:
https://patchew.org/QEMU/20231208023145.1385775-1-sergey.kambalin@auriga.com
/20231208023145.1385775-15-sergey.kambalin@auriga.com/
(link is to patch 14, the PCIE patches are 14 and 15, plus 16
is the one that wires up the controller into the SoC).

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_pcie.c         | 216 +++++++++++++++++++++++++++++++++-
>  include/hw/arm/bcm2838_pcie.h |  22 ++++
>  2 files changed, 236 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
> index 3b4373c6a6..75146d6c2e 100644
> --- a/hw/arm/bcm2838_pcie.c
> +++ b/hw/arm/bcm2838_pcie.c
> @@ -12,11 +12,222 @@
>  #include "hw/irq.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
> -#include "qemu/module.h"
>  #include "hw/arm/bcm2838_pcie.h"
>  #include "trace.h"
>
> +/*
> + * RC host part
> + */
> +
> +static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
> +                                       unsigned size) {
> +    hwaddr mmcfg_addr;
> +    uint64_t value = ~0;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
> +    uint8_t *root_regs = s->root_port.regs;
> +    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
> +                                     - PCIE_CONFIG_SPACE_SIZE);
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        value = pci_host_config_read_common(root_pci_dev, offset,
> +                                            PCIE_CONFIG_SPACE_SIZE, size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = *cfg_idx
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);
> +            break;
> +        default:
> +            memcpy(&value, root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +
> +    trace_bcm2838_pcie_host_read(size, offset, value);
> +    return value;
> +}
> +
> +static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
> +                                    uint64_t value, unsigned size) {
> +    hwaddr mmcfg_addr;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
> +    uint8_t *root_regs = s->root_port.regs;
> +    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
> +                                     - PCIE_CONFIG_SPACE_SIZE);
> +
> +    trace_bcm2838_pcie_host_write(size, offset, value);
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        pci_host_config_write_common(root_pci_dev, offset,
> +                                     PCIE_CONFIG_SPACE_SIZE, value, size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = *cfg_idx
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            pcie_hb->mmio.ops->write(opaque, mmcfg_addr, value, size);
> +            break;
> +        default:
> +            memcpy(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, &value, size);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2838_pcie_host_ops = {
> +    .read = bcm2838_pcie_host_read,
> +    .write = bcm2838_pcie_host_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {.max_access_size = sizeof(uint64_t)},
> +};

I'm not super familiar with how QEMU models PCI controllers,
but I'm not sure this handling of the root port config registers
is right. On other controllers it looks like the
root config reads and writes are handled by setting the
PCIDeviceClass::config_read and PCIDevice::config_write
methods.

> +
> +int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi)
> +{
> +    if (index >= BCM2838_PCIE_NUM_IRQS) {
> +        return -EINVAL;
> +    }
> +
> +    s->irq_num[index] = spi;
> +    return 0;
> +}
> +
> +static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
> +{
> +    BCM2838PcieHostState *s = opaque;
> +
> +    qemu_set_irq(s->irq[irq_num], level);
> +}
> +
> +static PCIINTxRoute bcm2838_pcie_host_route_intx_pin_to_irq(void *opaque,
> +                                                            int pin)
> +{
> +    PCIINTxRoute route;
> +    BCM2838PcieHostState *s = opaque;
> +
> +    route.irq = s->irq_num[pin];
> +    route.mode = route.irq < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED;
> +
> +    return route;
> +}
> +
> +static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
> +{
> +    return pin;
> +}
> +
> +static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    int i;
> +
> +    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
> +                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->cfg_regs);
> +
> +    /*
> +     * The MemoryRegions io_mmio and io_ioport that we pass to
> +     * pci_register_root_bus() are not the same as the MemoryRegions
> +     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
> +     * The difference is in the behavior of accesses to addresses where no PCI
> +     * device has been mapped.
> +     *
> +     * io_mmio and io_ioport are the underlying PCI view of the PCI address
> +     * space, and when a PCI device does a bus master access to a bad address
> +     * this is reported back to it as a transaction failure.
> +     *
> +     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
> +     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
> +     * not mandated properly by the PCI spec but expected by the majority of
> +     * PCI-using guest software, including Linux.

Isn't the important thing here not what guest software thinks, but
what the actual hardware in this bcm2838 SoC implements ?

> +     *
> +     * We implement it in the PCIe host controller, by providing the *_window
> +     * MRs, which are containers with io ops that implement the 'background'
> +     * behavior and which hold the real PCI MRs as sub-regions.
> +     */
> +    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
> +    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
> +                       64 * 1024);
> +
> +    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_mmio_window", UINT64_MAX);
> +    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
> +    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
> +    sysbus_init_mmio(sbd, &s->io_mmio_window);
> +    sysbus_init_mmio(sbd, &s->io_ioport_window);
> +
> +    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +        s->irq_num[i] = -1;
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
> +                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
> +                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
> +                                     TYPE_PCIE_BUS);
> +    pci_bus_set_route_irq_fn(pci->bus, bcm2838_pcie_host_route_intx_pin_to_irq);
> +    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
> +}
> +
> +static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
> +                                                   PCIBus *rootbus)
> +{
> +    return "0000:00";
> +}
> +
> +static void bcm2838_pcie_host_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> +
> +    hc->root_bus_path = bcm2838_pcie_host_root_bus_path;
> +    dc->realize = bcm2838_pcie_host_realize;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->fw_name = "pci";
> +}
> +
> +static void bcm2838_pcie_host_initfn(Object *obj)
> +{
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
> +    BCM2838PcieRootState *root = &s->root_port;
> +
> +    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
> +    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> +    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
> +}
> +
> +static const TypeInfo bcm2838_pcie_host_info = {
> +    .name       = TYPE_BCM2838_PCIE_HOST,
> +    .parent     = TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size = sizeof(BCM2838PcieHostState),
> +    .instance_init = bcm2838_pcie_host_initfn,
> +    .class_init = bcm2838_pcie_host_class_init,
> +};
> +
>  /*
>   * RC root part (D0:F0)
>   */
> @@ -69,6 +280,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
>  static void bcm2838_pcie_register(void)
>  {
>      type_register_static(&bcm2838_pcie_root_info);
> +    type_register_static(&bcm2838_pcie_host_info);
>  }
>
>  type_init(bcm2838_pcie_register)
> diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
> index 39828f817f..58c3a0efe7 100644
> --- a/include/hw/arm/bcm2838_pcie.h
> +++ b/include/hw/arm/bcm2838_pcie.h
> @@ -16,6 +16,9 @@
>  #include "hw/pci/pcie_port.h"
>  #include "qom/object.h"
>
> +#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
> +OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
> +
>  #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
>  OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
>                      BCM2838_PCIE_ROOT)
> @@ -50,4 +53,23 @@ struct BCM2838PcieRootClass {
>  };
>
>
> +struct BCM2838PcieHostState {
> +    /*< private >*/
> +    PCIExpressHost parent_obj;
> +
> +    /*< public >*/
> +    BCM2838PcieRootState root_port;
> +
> +    MemoryRegion cfg_regs;
> +    MemoryRegion io_ioport;
> +    MemoryRegion io_mmio;
> +    MemoryRegion io_ioport_window;
> +    MemoryRegion io_mmio_window;
> +
> +    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
> +    int irq_num[BCM2838_PCIE_NUM_IRQS];
> +};
> +
> +int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi);
> +
>  #endif /* BCM2838_PCIE_H */
> --
> 2.34.1

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36416B12110
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 17:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKXL-00077b-8V; Fri, 25 Jul 2025 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufKXG-00076a-H4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:40:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufKXA-00017t-89
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:40:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpX8W6Ywsz6L4wj;
 Fri, 25 Jul 2025 23:38:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CBE8F1400C8;
 Fri, 25 Jul 2025 23:40:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 17:40:15 +0200
Date: Fri, 25 Jul 2025 16:40:13 +0100
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/2] pci-host/cxl: Support creation of a new CXL
 Host Bridge
Message-ID: <20250725164013.00006430@huawei.com>
In-Reply-To: <20250617040649.81303-3-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
 <20250617040649.81303-3-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 17 Jun 2025 12:06:49 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
> independent CXL host bridge which combined GPEX features (ECAM, MMIO
> windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original PCIe host topology on some platforms. In the previous, the
> pxb-cxl-host with any CXL root ports and CXL endpoint devices would
> share the resources (like BDF, MMIO space) of the original pcie
> domain, but it would cause some platforms like sbsa-ref are unable to
> support the original number of PCIe devices. The new type provides a
> solution to resolve the problem.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
A few trivial things inline.  To me this looks fine but it needs more
eyes, particularly form PCI folk on whether anything is missing for the
host bridge.

> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 35c0415242..05c772bcf4 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -74,6 +74,10 @@ config PCI_POWERNV
>      select MSI_NONBROKEN
>      select PCIE_PORT
>  
> +config CXL_HOST_BRIDGE
> +    bool
> +    select PCI_EXPRESS
> +
>  config REMOTE_PCIHOST
>      bool
>  
> diff --git a/hw/pci-host/cxl.c b/hw/pci-host/cxl.c
> new file mode 100644
> index 0000000000..74c8c83314
> --- /dev/null
> +++ b/hw/pci-host/cxl.c
> @@ -0,0 +1,152 @@
> +/*
> + * QEMU CXL Host Bridge Emulation
> + *
> + * Copyright (C) 2025, Phytium Technology Co, Ltd. All rights reserved.
> + *
> + * Based on gpex.c
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci-host/cxl_host_bridge.h"
> +
> +static void cxl_host_set_irq(void *opaque, int irq_num, int level)
> +{
> +    CXLHostBridge *host = opaque;
> +
> +    qemu_set_irq(host->irq[irq_num], level);
> +}
> +
> +int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi)
> +{
> +    if (index >= PCI_NUM_PINS) {
> +        return -EINVAL;
> +    }
> +
> +    host->irq_num[index] = gsi;
> +    return 0;
> +}
> +
> +static PCIINTxRoute cxl_host_route_intx_pin_to_irq(void *opaque, int pin)
> +{
> +    PCIINTxRoute route;
> +    CXLHostBridge *host = opaque;
> +    int gsi = host->irq_num[pin];
> +
> +    route.irq = gsi;
> +    if (gsi < 0) {
> +        route.mode = PCI_INTX_DISABLED;
> +    } else {
> +        route.mode = PCI_INTX_ENABLED;
> +    }
> +
> +    return route;
    CXLHostBridge *host = opaque;
    int gsi = host->irq_num[pin];
    PCIINTxRoute route = {
       .irq = gsi,
       .mode = gsi < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED,
    }

    return route;

perhaps?  Or maybe not worth bothering.

    
> +}

> +static void cxl_host_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    CXLHostBridge *host = CXL_HOST(dev);
> +    CXLComponentState *cxl_cstate = &host->cxl_cstate;
> +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +    PCIBus *cxlbus;
> +    int i;
> +
> +    cxl_host_reset(host);
> +    cxl_component_register_block_init(OBJECT(dev), cxl_cstate, TYPE_CXL_HOST);
> +    sysbus_init_mmio(sbd, mr);
> +
> +    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
> +    sysbus_init_mmio(sbd, &pex->mmio);
> +
> +    memory_region_init(&host->io_mmio, OBJECT(host), "cxl_host_mmio",
> +                        UINT64_MAX);
> +
> +    memory_region_init_io(&host->io_mmio_window, OBJECT(host),
> +                              &unassigned_io_ops, OBJECT(host),

Odd code alignment.  The & should be under the &
Check for other instances of this.

> +                              "cxl_host_mmio_window", UINT64_MAX);
> +
> +    memory_region_add_subregion(&host->io_mmio_window, 0, &host->io_mmio);
> +    sysbus_init_mmio(sbd, &host->io_mmio_window);
> +
> +    /* ioport window init, 64K is the legacy size in x86 */
> +    memory_region_init(&host->io_ioport, OBJECT(host), "cxl_host_ioport",
> +                        64 * 1024);
> +
> +    memory_region_init_io(&host->io_ioport_window, OBJECT(host),
> +                              &unassigned_io_ops, OBJECT(host),
> +                              "cxl_host_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&host->io_ioport_window, 0, &host->io_ioport);
> +    sysbus_init_mmio(sbd, &host->io_ioport_window);
> +
> +    /* PCIe host bridge use 4 legacy IRQ lines */
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        sysbus_init_irq(sbd, &host->irq[i]);
> +        host->irq_num[i] = -1;
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "cxlhost.0", cxl_host_set_irq,
> +                                 pci_swizzle_map_irq_fn, host, &host->io_mmio,
> +                                 &host->io_ioport, 0, 4, TYPE_CXL_BUS);
> +    cxlbus = pci->bus;
> +    cxlbus->flags |= PCI_BUS_CXL;
As cxlbus is only used for flags, why not simply
    pci->bus->flags |= PCI_BUS_CXL;

and drop the local variable. Or... 

> +
> +    pci_bus_set_route_irq_fn(pci->bus, cxl_host_route_intx_pin_to_irq);

Use cxlbus here instead of pci->bus giving a second user.

> +}


> diff --git a/include/hw/pci-host/cxl_host_bridge.h b/include/hw/pci-host/cxl_host_bridge.h
> new file mode 100644
> index 0000000000..833e460f01
> --- /dev/null
> +++ b/include/hw/pci-host/cxl_host_bridge.h
> @@ -0,0 +1,23 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hw/cxl/cxl.h"
> +#include "hw/irq.h"
> +#include "hw/pci/pcie_host.h"

We should follow approx include what you use principles.
So need the header for MemoryRegion as well here.
"system/memory.h" seems to be most likely choice for that.


> +
> +typedef struct CXLHostBridge {
> +    PCIExpressHost parent_obj;
> +
> +    CXLComponentState cxl_cstate;
> +
> +    MemoryRegion io_ioport;

I'm not sure the io_ prefix is adding much given this is all in
an CXLHostBridge object?

> +    MemoryRegion io_mmio;
> +    MemoryRegion io_ioport_window;
> +    MemoryRegion io_mmio_window;
> +    qemu_irq irq[PCI_NUM_PINS];
> +    int irq_num[PCI_NUM_PINS];
> +} CXLHostBridge;
> +
> +int cxl_host_set_irq_num(CXLHostBridge *host, int index, int gsi);
> +void cxl_host_hook_up_registers(CXLState *cxl_state, CXLHostBridge *host);



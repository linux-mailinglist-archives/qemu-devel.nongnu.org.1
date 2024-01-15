Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDDE82DABD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:59:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNTH-0004x4-G6; Mon, 15 Jan 2024 08:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNTF-0004wS-2h
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:57:45 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNTC-0005GA-TD
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:57:44 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5571e662b93so7239420a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705327061; x=1705931861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e6qYCrAe9nVGnSjObJJp0SR2VvyBm9bax6wthmVPZM4=;
 b=dFSIfhAYUlvZBP2ba9ru+nqs08xrgo1I3e46sHyfm6euj5nomGHW38bSWkw//QEnWo
 baHXBG0tpvfWKOLNlVyG8c8QWSSrQFQK0G4iTsMzxFFXC5Wj7vl0gvT9MwaPHlB7UmL2
 1TIuG6ukuj2Aprd5VWPvIQ2wx6/mkQ1BlKKsO0uRx0YOQQpeh+mFqwLCW7oJBOIfK1WI
 C1W+VFCm28NN1VFmN3Pew6mhz5ppaHHOFFgBNIsV5WVDP3vedQDSpRW5YJP1j2xSicyB
 L0L99mepEgyxIAYc4/d7wdYyBCbkaBMM5LvyW/OwSSaYY8e0E5S++g4iYINvjqNOMu53
 YzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705327061; x=1705931861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6qYCrAe9nVGnSjObJJp0SR2VvyBm9bax6wthmVPZM4=;
 b=obCSTpNEcC8mmKcqK7uZjgDUV5sBERteEY74fu3Q+uKE2C5clZuhi4yEEPNzwkAcp+
 3K3UHVxMYGTtpVBGkWO1/mE8OAyq3DVYU33jg9aEVrdom6waD+kjDNzJPUGMV1eG8dGy
 aRoxRXNYzdF4oOtKuqoKwNYPLxuJdm6L+ulAMRaDPQYf2A0eiuluGnwp/jemTaiz+2tQ
 zTt75/8WcKw+UPJYDT1mojX/wFhcjxGlgZZEl6qnW/PVwXPmLtB3CB8J6DSpHYkpsv4R
 h5H0KeHUZ9x4YWF/TCgCBm6JQ4txSTD3MDm5Cmg9/S/OC6ZTC7DIqE8EGGR1H9SVo005
 Ci7A==
X-Gm-Message-State: AOJu0YynXVt8No0gqGFMkvu95LSsccXgaEwzs61x+lw4CES9Vl8fI5oR
 jtMjXE255TwXu0LIzXglxodXSG4DdKm/kY/6hMjgsbjCfjDSYg==
X-Google-Smtp-Source: AGHT+IE8fe2RPJw19ApaFFt7XAJUEFsa8BZHNf25q2/DadloreD90omGfUBECxY/Dn1F1QU1W8q6PlurNA/CxBLyDo0=
X-Received: by 2002:a05:6402:430d:b0:559:4b6e:adb1 with SMTP id
 m13-20020a056402430d00b005594b6eadb1mr973723edc.76.1705327061078; Mon, 15 Jan
 2024 05:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-15-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-15-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 13:57:29 +0000
Message-ID: <CAFEAcA_6pyFqosj7fjFPpWASZKj19k0gKs+9SttuvOMD9itY6w@mail.gmail.com>
Subject: Re: [PATCH v4 14/45] Add BCM2838 PCIE Root Complex
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 8 Dec 2023 at 02:40, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_pcie.c         | 74 +++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build            |  5 ++-
>  hw/arm/trace-events           |  4 ++
>  include/hw/arm/bcm2838_pcie.h | 53 +++++++++++++++++++++++++
>  4 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/bcm2838_pcie.c
>  create mode 100644 include/hw/arm/bcm2838_pcie.h
>
> diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
> new file mode 100644
> index 0000000000..3b4373c6a6
> --- /dev/null
> +++ b/hw/arm/bcm2838_pcie.c
> @@ -0,0 +1,74 @@
> +/*
> + * BCM2838 PCIe Root Complex emulation
> + *
> + * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/irq.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +#include "hw/arm/bcm2838_pcie.h"
> +#include "trace.h"
> +
> +/*
> + * RC root part (D0:F0)
> + */
> +
> +static void bcm2838_pcie_root_reg_reset(PCIDevice *dev)
> +{
> +    BCM2838PcieRootState *s = BCM2838_PCIE_ROOT(dev);
> +    memset(s->regs, 0xFF, sizeof(s->regs));
> +}
> +
> +static void bcm2838_pcie_root_realize(PCIDevice *dev, Error **errp) {
> +    bcm2838_pcie_root_reg_reset(dev);

Realize methods shouldn't call reset, that should be
handled automatically.

> +}
> +
> +static void bcm2838_pcie_root_init(Object *obj)
> +{
> +    PCIBridge *br = PCI_BRIDGE(obj);
> +    br->bus_name = "pcie.1";
> +}
> +
> +static void bcm2838_pcie_root_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
> +    BCM2838PcieRootClass *brpc = BCM2838_PCIE_ROOT_CLASS(class);
> +
> +    dc->desc = "BCM2711 PCIe Bridge";
> +    /*
> +     * PCI-facing part of the host bridge, not usable without the host-facing
> +     * part, which can't be device_add'ed.
> +     */
> +    dc->user_creatable = false;
> +    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
> +    k->device_id = BCM2838_PCIE_DEVICE_ID;
> +    k->revision = BCM2838_PCIE_REVISION;
> +    brpc->parent_obj.exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
> +    brpc->parent_obj.aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
> +    brpc->parent_realize = k->realize;
> +    k->realize = bcm2838_pcie_root_realize;

This seems to not have anything that sets up a reset
handler. (See hw/pci-host/pnv_phb.c:pnv_phb_root_port_class_init()
for an example of a root port with a reset handler.)

> +}
> +
> +static const TypeInfo bcm2838_pcie_root_info = {
> +    .name = TYPE_BCM2838_PCIE_ROOT,
> +    .parent = TYPE_PCIE_ROOT_PORT,
> +    .instance_size = sizeof(BCM2838PcieRootState),
> +    .instance_init = bcm2838_pcie_root_init,
> +    .class_init = bcm2838_pcie_root_class_init,
> +};
> +
> +static void bcm2838_pcie_register(void)
> +{
> +    type_register_static(&bcm2838_pcie_root_info);
> +}
> +
> +type_init(bcm2838_pcie_register)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 27e6797de2..b26ed13c6f 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -39,7 +39,10 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
>  arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
>  arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
>  arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
> -arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
> +arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files(
> +  'bcm2838.c',
> +  'bcm2838_pcie.c',
> +  'raspi4b.c'))
>  arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
>  arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
>  arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 4f0167e638..6cfab31539 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,5 +55,9 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
>
> +# bcm2838_pcie.c
> +bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
> +bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
> +

These trace events aren't used in this patch, so should presumably be
in the following patch.

>  # bcm2838.c
>  bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
> diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
> new file mode 100644
> index 0000000000..39828f817f
> --- /dev/null
> +++ b/include/hw/arm/bcm2838_pcie.h
> @@ -0,0 +1,53 @@
> +/*
> + * BCM2838 PCIe Root Complex emulation
> + *
> + * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef BCM2838_PCIE_H
> +#define BCM2838_PCIE_H
> +
> +#include "exec/hwaddr.h"
> +#include "hw/sysbus.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie_host.h"
> +#include "hw/pci/pcie_port.h"
> +#include "qom/object.h"
> +
> +#define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
> +OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
> +                    BCM2838_PCIE_ROOT)
> +
> +#define BCM2838_PCIE_VENDOR_ID      0x14E4
> +#define BCM2838_PCIE_DEVICE_ID      0x2711
> +#define BCM2838_PCIE_REVISION       20
> +
> +#define BCM2838_PCIE_REGS_SIZE      0x9310
> +#define BCM2838_PCIE_NUM_IRQS       4
> +
> +#define BCM2838_PCIE_EXP_CAP_OFFSET 0xAC
> +#define BCM2838_PCIE_AER_CAP_OFFSET 0x100
> +
> +#define BCM2838_PCIE_EXT_CFG_DATA   0x8000
> +#define BCM2838_PCIE_EXT_CFG_INDEX  0x9000
> +
> +struct BCM2838PcieRootState {
> +    /*< private >*/
> +    PCIESlot parent_obj;
> +
> +    /*< public >*/
> +    uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
> +};
> +
> +struct BCM2838PcieRootClass {
> +    /*< private >*/
> +    PCIERootPortClass parent_obj;
> +
> +    /*< public >*/
> +    void (*parent_realize)(PCIDevice *dev, Error **errp);
> +};
> +
> +
> +#endif /* BCM2838_PCIE_H */
> --
> 2.34.1

thanks
-- PMM


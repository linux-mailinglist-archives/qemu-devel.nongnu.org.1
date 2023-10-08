Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 859EB7BCC89
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpN42-0003hv-8l; Sun, 08 Oct 2023 02:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN3z-0003gM-El; Sun, 08 Oct 2023 02:14:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN3x-0004U7-Bu; Sun, 08 Oct 2023 02:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jOVmbOS9X6FNEf0s8AEr5LmIc1ydRiIPy8DG5hcc1Qw=; b=CRpNF3FKdTsE76tPPK8uTvtIvQ
 w8d3Ov28vOmn+AJEgeiRuMCXGI0vKh0g0RO+i3JLXpwwbzzKQr9LqsiKPB+JEfYjBjDssbgeDZqgL
 jGQwA9zu/B0+1Jya1FmQGdEBeDamDMuhohVE6KHf9v0zE70+kyUrs77A5ym/l0/Hr3VUvt/qL9vjM
 p7U1dB764IP7CFVt3FqIOEwTc/qzjYu6nwP1LZWoyrEDr3YpUGniTXev0fE6KEEaPQZN9nxlLsiYj
 1SWZhhPMDfUH+cqodm9tnYCWiufHWVVW2mS5r0W81Fr2ouZjMa9+rlPSAtuBXjFO/GvQWNI6K+oAR
 OGaCnlJA2L1x2zt6scRqUBYl/UMYlzWurXv3G2D960dtCRf3aFoyqu1u3CaJU5QbmvY3O4OFlXfyb
 teOdyQO8T//KpOtzhKaISWQ3ZXs9f4XkbMmgTbHdoPZREMoMebHk1gcrMZ0UhzDdRGZLH26a6UdHT
 VhKKjg7C4eR8RSwthLWElWX8PHDkg+mex/UCLXJoGXFLgFXJqVi1yTpgDgV+Ch0JR54mUIAa/cNei
 CnNpm4KQ3hz6S0IyZjsBrj5J/8UsmbFNLh73pZ+cs/BIB7yfuu+gPIthVoATE3IhmONks/ZBWGTFI
 uaxkdu2TqBimk/7FyM4+eOM+BQPoIQUCfZD4XcYh4=;
Received: from [2a00:23c4:8baf:fd00:4803:92c1:9dc8:9255]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN3g-0006GW-1Y; Sun, 08 Oct 2023 07:14:36 +0100
Message-ID: <29142019-2a88-4621-8767-58668113d8c7@ilande.co.uk>
Date: Sun, 8 Oct 2023 07:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <90adfa92df7bf760059924a92deebcd6b32e7f37.1696542537.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:4803:92c1:9dc8:9255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/3] hw/pci-host: Add emulation of Mai Logic Articia S
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 05/10/2023 23:13, BALATON Zoltan wrote:

> The Articia S is a generic chipset supporting several different CPUs
> that were used on some PPC boards. This is a minimal emulation of the
> parts needed for emulating the AmigaOne board.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/Kconfig           |   5 +
>   hw/pci-host/articia.c         | 266 ++++++++++++++++++++++++++++++++++
>   hw/pci-host/meson.build       |   2 +
>   include/hw/pci-host/articia.h |  17 +++
>   4 files changed, 290 insertions(+)
>   create mode 100644 hw/pci-host/articia.c
>   create mode 100644 include/hw/pci-host/articia.h
> 
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index a07070eddf..33014c80a4 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -73,6 +73,11 @@ config SH_PCI
>       bool
>       select PCI
>   
> +config ARTICIA
> +    bool
> +    select PCI
> +    select I8259
> +
>   config MV64361
>       bool
>       select PCI
> diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
> new file mode 100644
> index 0000000000..80558e1c47
> --- /dev/null
> +++ b/hw/pci-host/articia.c
> @@ -0,0 +1,266 @@
> +/*
> + * Mai Logic Articia S emulation
> + *
> + * Copyright (c) 2023 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/irq.h"
> +#include "hw/i2c/bitbang_i2c.h"
> +#include "hw/intc/i8259.h"
> +#include "hw/pci-host/articia.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaState, ARTICIA)
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(ArticiaHostState, ARTICIA_PCI_HOST)
> +struct ArticiaHostState {
> +    PCIDevice parent_obj;
> +
> +    ArticiaState *as;
> +};
> +
> +/* TYPE_ARTICIA */
> +
> +struct ArticiaState {
> +    PCIHostState parent_obj;
> +
> +    qemu_irq irq[PCI_NUM_PINS];
> +    MemoryRegion io;
> +    MemoryRegion mem;
> +    MemoryRegion reg;
> +
> +    bitbang_i2c_interface smbus;
> +    uint32_t gpio; /* bits 0-7 in, 8-15 out, 16-23 direction (0 in, 1 out) */
> +    hwaddr gpio_base;
> +    MemoryRegion gpio_reg;
> +};

These types above should be in the header file and not in the C file, as per our 
current QOM guidelines.

> +static uint64_t articia_gpio_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +
> +    return (s->gpio >> (addr * 8)) & 0xff;
> +}
> +
> +static void articia_gpio_write(void *opaque, hwaddr addr, uint64_t val,
> +                               unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +    uint32_t sh = addr * 8;
> +
> +    if (addr == 0) {
> +        /* in bits read only? */
> +        return;
> +    }
> +
> +    if ((s->gpio & (0xff << sh)) != (val & 0xff) << sh) {
> +        s->gpio &= ~(0xff << sh | 0xff);
> +        s->gpio |= (val & 0xff) << sh;
> +        s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SDA,
> +                                   s->gpio & BIT(16) ?
> +                                   !!(s->gpio & BIT(8)) : 1);
> +        if ((s->gpio & BIT(17))) {
> +            s->gpio &= ~BIT(0);
> +            s->gpio |= bitbang_i2c_set(&s->smbus, BITBANG_I2C_SCL,
> +                                       !!(s->gpio & BIT(9)));
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps articia_gpio_ops = {
> +    .read = articia_gpio_read,
> +    .write = articia_gpio_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 1,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static uint64_t articia_reg_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +    uint64_t ret = UINT_MAX;
> +
> +    switch (addr) {
> +    case 0xc00cf8:
> +        ret = pci_host_conf_le_ops.read(PCI_HOST_BRIDGE(s), 0, size);
> +        break;
> +    case 0xe00cfc ... 0xe00cff:
> +        ret = pci_host_data_le_ops.read(PCI_HOST_BRIDGE(s), addr - 0xe00cfc, size);
> +        break;
> +    case 0xf00000:
> +        ret = pic_read_irq(isa_pic);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register read 0x%"
> +                      HWADDR_PRIx " %d\n", __func__, addr, size);
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static void articia_reg_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned int size)
> +{
> +    ArticiaState *s = opaque;
> +
> +    switch (addr) {
> +    case 0xc00cf8:
> +        pci_host_conf_le_ops.write(PCI_HOST_BRIDGE(s), 0, val, size);
> +        break;
> +    case 0xe00cfc ... 0xe00cff:
> +        pci_host_data_le_ops.write(PCI_HOST_BRIDGE(s), addr, val, size);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register write 0x%"
> +                      HWADDR_PRIx " %d <- %"PRIx64"\n", __func__, addr, size, val);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps articia_reg_ops = {
> +    .read = articia_reg_read,
> +    .write = articia_reg_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void articia_pcihost_set_irq(void *opaque, int n, int level)
> +{
> +    ArticiaState *s = opaque;
> +    qemu_set_irq(s->irq[n], level);
> +}
> +
> +static void articia_realize(DeviceState *dev, Error **errp)
> +{
> +    ArticiaState *s = ARTICIA(dev);
> +    PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +    PCIDevice *pdev;
> +
> +    bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
> +    memory_region_init_io(&s->gpio_reg, OBJECT(s), &articia_gpio_ops, s,
> +                          TYPE_ARTICIA, 4);
> +
> +    memory_region_init(&s->mem, OBJECT(dev), "pci-mem", UINT64_MAX);
> +    memory_region_init(&s->io, OBJECT(dev), "pci-io", 0xc00000);
> +    memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
> +                          TYPE_ARTICIA, 0x1000000);
> +    memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
> +
> +    /* devfn_min is 8 that matches first PCI slot in AmigaOne */
> +    h->bus = pci_register_root_bus(dev, NULL, articia_pcihost_set_irq,
> +                                   pci_swizzle_map_irq_fn, dev, &s->mem,
> +                                   &s->io, PCI_DEVFN(8, 0), 4, TYPE_PCI_BUS);
> +    pdev = pci_create_simple_multifunction(h->bus, PCI_DEVFN(0, 0),
> +                                           TYPE_ARTICIA_PCI_HOST);
> +    ARTICIA_PCI_HOST(pdev)->as = s;
> +    pci_create_simple(h->bus, PCI_DEVFN(0, 1), TYPE_ARTICIA_PCI_BRIDGE);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->reg);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mem);
> +    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
> +}
> +
> +static void articia_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = articia_realize;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +}
> +
> +/* TYPE_ARTICIA_PCI_HOST */
> +
> +static void articia_pci_host_cfg_write(PCIDevice *d, uint32_t addr,
> +                                       uint32_t val, int len)
> +{
> +    ArticiaState *s = ARTICIA_PCI_HOST(d)->as;
> +
> +    pci_default_write_config(d, addr, val, len);
> +    switch (addr) {
> +    case 0x40:
> +        s->gpio_base = val;
> +        break;
> +    case 0x44:
> +        if (val != 0x11) {
> +            /* FIXME what do the bits actually mean? */
> +            break;
> +        }
> +        if (memory_region_is_mapped(&s->gpio_reg)) {
> +            memory_region_del_subregion(&s->io, &s->gpio_reg);
> +        }
> +        memory_region_add_subregion(&s->io, s->gpio_base + 0x38, &s->gpio_reg);
> +        break;
> +    }
> +}
> +
> +static void articia_pci_host_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->config_write = articia_pci_host_cfg_write;
> +    k->vendor_id = 0x10cc;
> +    k->device_id = 0x0660;
> +    k->class_id = PCI_CLASS_BRIDGE_HOST;
> +    /*
> +     * PCI-facing part of the host bridge,
> +     * not usable without the host-facing part
> +     */
> +    dc->user_creatable = false;
> +}
> +
> +/* TYPE_ARTICIA_PCI_BRIDGE */
> +
> +static void articia_pci_bridge_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->vendor_id = 0x10cc;
> +    k->device_id = 0x0661;
> +    k->class_id = PCI_CLASS_BRIDGE_HOST;
> +    /*
> +     * PCI-facing part of the host bridge,
> +     * not usable without the host-facing part
> +     */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo articia_types[] = {
> +    {
> +        .name          = TYPE_ARTICIA,
> +        .parent        = TYPE_PCI_HOST_BRIDGE,
> +        .instance_size = sizeof(ArticiaState),
> +        .class_init    = articia_class_init,
> +    },
> +    {
> +        .name          = TYPE_ARTICIA_PCI_HOST,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(ArticiaHostState),
> +        .class_init    = articia_pci_host_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +              { },
> +        },
> +    },
> +    {
> +        .name          = TYPE_ARTICIA_PCI_BRIDGE,
> +        .parent        = TYPE_PCI_DEVICE,
> +        .instance_size = sizeof(PCIDevice),
> +        .class_init    = articia_pci_bridge_class_init,
> +        .interfaces = (InterfaceInfo[]) {
> +              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +              { },
> +        },
> +    },
> +};
> +
> +DEFINE_TYPES(articia_types)
> diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
> index 64eada76fe..40de48eb7f 100644
> --- a/hw/pci-host/meson.build
> +++ b/hw/pci-host/meson.build
> @@ -20,6 +20,8 @@ pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
>   pci_ss.add(when: 'CONFIG_UNIN_PCI', if_true: files('uninorth.c'))
>   # PowerPC E500 boards
>   pci_ss.add(when: 'CONFIG_PPCE500_PCI', if_true: files('ppce500.c'))
> +# AmigaOne
> +pci_ss.add(when: 'CONFIG_ARTICIA', if_true: files('articia.c'))
>   # Pegasos2
>   pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
>   
> diff --git a/include/hw/pci-host/articia.h b/include/hw/pci-host/articia.h
> new file mode 100644
> index 0000000000..529c240274
> --- /dev/null
> +++ b/include/hw/pci-host/articia.h
> @@ -0,0 +1,17 @@
> +/*
> + * Mai Logic Articia S emulation
> + *
> + * Copyright (c) 2023 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + *
> + */
> +
> +#ifndef ARTICIA_H
> +#define ARTICIA_H
> +
> +#define TYPE_ARTICIA "articia"
> +#define TYPE_ARTICIA_PCI_HOST "articia-pci-host"
> +#define TYPE_ARTICIA_PCI_BRIDGE "articia-pci-bridge"
> +
> +#endif


ATB,

Mark.



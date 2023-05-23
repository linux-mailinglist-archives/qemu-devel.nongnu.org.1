Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DA70D003
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 03:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1GPi-0002Cw-FK; Mon, 22 May 2023 21:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1GPe-0002CL-Ao; Mon, 22 May 2023 21:02:06 -0400
Received: from m12.mail.163.com ([220.181.12.216])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1GPa-00087D-Ad; Mon, 22 May 2023 21:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=IzSo0DDfBUlHTYGQg+WbfFbhQ6vLAaU0RXr3sssDE1o=;
 b=XcYnlGQqJdElQKJs641SFEPsTyLh75qkJdbWwl0nUGWnyzxv8Gm0fYxT/sbEwT
 KETC4GeWD52RJf9LSE/sq8xhqLUo4V4kYo9WoSqPo1v0vYB3xRP75hKZnS7iJWvt
 hsOUn1qogi3dxTtnxpMB5ufbI0EqKx/RSAQ+dFVfvKiSg=
Received: from [172.21.25.67] (unknown [218.201.129.19])
 by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wBX3o53EGxkOUR6AQ--.3227S2; 
 Tue, 23 May 2023 09:01:44 +0800 (CST)
Message-ID: <048d313b-135e-c265-0657-600d74c10eb0@163.com>
Date: Tue, 23 May 2023 09:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/11] hw: arm: allwinner-r40: Add emac and gmac support
Content-Language: en-US
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-9-qianfanguijin@163.com>
 <CAPan3WrCDAvfoUnc5jhjyvheiQnASE-oLcbDqQ8OGnHPQ7xmPg@mail.gmail.com>
From: qianfan <qianfanguijin@163.com>
In-Reply-To: <CAPan3WrCDAvfoUnc5jhjyvheiQnASE-oLcbDqQ8OGnHPQ7xmPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBX3o53EGxkOUR6AQ--.3227S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFW5Kr4rtFWfXFyrWFyfZwb_yoWxuw18pF
 s8K3sYgrWFga4UAr4kKws3Jryftw10krnrKF1SkF4xJF1DXr1kXr42ya13GFy5Grs7Ga1a
 vrZ3WF4Sgan7K3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUhLnUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXB547VXl6rKcKwAAsI
Received-SPF: pass client-ip=220.181.12.216;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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



在 2023/5/16 3:58, Niek Linnenbank 写道:
> Hi Qianfan,
>
> On Wed, May 10, 2023 at 12:30 PM <qianfanguijin@163.com> wrote:
>
>     From: qianfan Zhao <qianfanguijin@163.com>
>
>     R40 has two ethernet controllers named as emac and gmac. The emac is
>     compatibled with A10, and the GMAC is compatibled with H3.
>
>     Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>     ---
>      hw/arm/allwinner-r40.c         | 50
>     ++++++++++++++++++++++++++++++++--
>      hw/arm/bananapi_m2u.c          |  3 ++
>      include/hw/arm/allwinner-r40.h |  6 ++++
>      3 files changed, 57 insertions(+), 2 deletions(-)
>
>     diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
>     index b148c56449..c018ad231a 100644
>     --- a/hw/arm/allwinner-r40.c
>     +++ b/hw/arm/allwinner-r40.c
>     @@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] = {
>          [AW_R40_DEV_SRAM_A2]    = 0x00004000,
>          [AW_R40_DEV_SRAM_A3]    = 0x00008000,
>          [AW_R40_DEV_SRAM_A4]    = 0x0000b400,
>     +    [AW_R40_DEV_EMAC]       = 0x01c0b000,
>          [AW_R40_DEV_MMC0]       = 0x01c0f000,
>          [AW_R40_DEV_MMC1]       = 0x01c10000,
>          [AW_R40_DEV_MMC2]       = 0x01c11000,
>     @@ -54,6 +55,7 @@ const hwaddr allwinner_r40_memmap[] = {
>          [AW_R40_DEV_UART6]      = 0x01c29800,
>          [AW_R40_DEV_UART7]      = 0x01c29c00,
>          [AW_R40_DEV_TWI0]       = 0x01c2ac00,
>     +    [AW_R40_DEV_GMAC]       = 0x01c50000,
>          [AW_R40_DEV_DRAMCOM]    = 0x01c62000,
>          [AW_R40_DEV_DRAMCTL]    = 0x01c63000,
>          [AW_R40_DEV_DRAMPHY]    = 0x01c65000,
>     @@ -82,7 +84,6 @@ static struct AwR40Unimplemented
>     r40_unimplemented[] = {
>          { "spi1",       0x01c06000, 4 * KiB },
>          { "cs0",        0x01c09000, 4 * KiB },
>          { "keymem",     0x01c0a000, 4 * KiB },
>     -    { "emac",       0x01c0b000, 4 * KiB },
>          { "usb0-otg",   0x01c13000, 4 * KiB },
>          { "usb0-host",  0x01c14000, 4 * KiB },
>          { "crypto",     0x01c15000, 4 * KiB },
>     @@ -131,7 +132,6 @@ static struct AwR40Unimplemented
>     r40_unimplemented[] = {
>          { "tvd2",       0x01c33000, 4 * KiB },
>          { "tvd3",       0x01c34000, 4 * KiB },
>          { "gpu",        0x01c40000, 64 * KiB },
>     -    { "gmac",       0x01c50000, 64 * KiB },
>          { "hstmr",      0x01c60000, 4 * KiB },
>          { "tcon-top",   0x01c70000, 4 * KiB },
>          { "lcd0",       0x01c71000, 4 * KiB },
>     @@ -180,6 +180,8 @@ enum {
>          AW_R40_GIC_SPI_MMC1      = 33,
>          AW_R40_GIC_SPI_MMC2      = 34,
>          AW_R40_GIC_SPI_MMC3      = 35,
>     +    AW_R40_GIC_SPI_EMAC      = 55,
>     +    AW_R40_GIC_SPI_GMAC      = 85,
>      };
>
>      /* Allwinner R40 general constants */
>     @@ -276,6 +278,11 @@ static void allwinner_r40_init(Object *obj)
>
>          object_initialize_child(obj, "twi0", &s->i2c0,
>     TYPE_AW_I2C_SUN6I);
>
>     +    object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
>     +    object_initialize_child(obj, "gmac", &s->gmac,
>     TYPE_AW_SUN8I_EMAC);
>     +    object_property_add_alias(obj, "gmac-phy-addr",
>     +                              OBJECT(&s->gmac), "phy-addr");
>     +
>          object_initialize_child(obj, "dramc", &s->dramc,
>     TYPE_AW_R40_DRAMC);
>          object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
>                                   "ram-addr");
>     @@ -285,6 +292,7 @@ static void allwinner_r40_init(Object *obj)
>
>      static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>      {
>     +    const char *r40_nic_models[] = { "gmac", "emac", NULL };
>          AwR40State *s = AW_R40(dev);
>          unsigned i;
>
>     @@ -442,6 +450,44 @@ static void allwinner_r40_realize(DeviceState
>     *dev, Error **errp)
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
>                          s->memmap[AW_R40_DEV_DRAMPHY]);
>
>     +    /* nic support gmac and emac */
>     +    for (int i = 0; i < ARRAY_SIZE(r40_nic_models) - 1; i++) {
>     +        NICInfo *nic = &nd_table[i];
>     +
>     +        if (!nic->used) {
>     +            continue;
>     +        }
>
>
> Could you please clarify the lines below here? I'm not seeing the 
> function call 'qemu_show_nic_models()' in any of the other machines / 
> soc implementations.
>
> Also, if you intend to catch a possible input error here, probably its 
> best to log/print the error for the user before calling exit()?
This is useful if the user don't known nic model names. Can running this 
command for a helper message:

$ qemu-system-arm -M bpim2u -net nic,model=help
Unable to init server: Could not connect: Connection refused
Available NIC models:
gmac
emac
>
>     +        if (qemu_show_nic_models(nic->model, r40_nic_models)) {
>     +            exit(0);
>
>     +        }
>     +
>     +        switch (qemu_find_nic_model(nic, r40_nic_models,
>     r40_nic_models[0])) {
>     +        case 0: /* gmac */
>     + qdev_set_nic_properties(DEVICE(&s->gmac), nic);
>     +            break;
>     +        case 1: /* emac */
>     + qdev_set_nic_properties(DEVICE(&s->emac), nic);
>     +            break;
>     +        default:
>     +            exit(1);
>     +            break;
>     +        }
>     +    }
>     +
>     +    /* GMAC */
>     +    object_property_set_link(OBJECT(&s->gmac), "dma-memory",
>     +  OBJECT(get_system_memory()), &error_fatal);
>     +    sysbus_realize(SYS_BUS_DEVICE(&s->gmac), &error_fatal);
>     +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gmac), 0,
>     s->memmap[AW_R40_DEV_GMAC]);
>     +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gmac), 0,
>     +  qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_GMAC));
>     +
>     +    /* EMAC */
>     +    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
>     +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0,
>     s->memmap[AW_R40_DEV_EMAC]);
>     +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
>     +  qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
>     +
>          /* Unimplemented devices */
>          for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
>      create_unimplemented_device(r40_unimplemented[i].device_name,
>     diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
>     index 20a4550c68..74121d8966 100644
>     --- a/hw/arm/bananapi_m2u.c
>     +++ b/hw/arm/bananapi_m2u.c
>     @@ -92,6 +92,9 @@ static void bpim2u_init(MachineState *machine)
>          object_property_set_int(OBJECT(r40), "ram-size",
>                                  r40->ram_size, &error_abort);
>
>     +    /* GMAC PHY */
>     +    object_property_set_uint(OBJECT(r40), "gmac-phy-addr", 1,
>     &error_abort);
>     +
>          /* Mark R40 object realized */
>          qdev_realize(DEVICE(r40), NULL, &error_abort);
>
>     diff --git a/include/hw/arm/allwinner-r40.h
>     b/include/hw/arm/allwinner-r40.h
>     index 8243e8903b..5f2d08489e 100644
>     --- a/include/hw/arm/allwinner-r40.h
>     +++ b/include/hw/arm/allwinner-r40.h
>     @@ -28,6 +28,8 @@
>      #include "hw/misc/allwinner-r40-ccu.h"
>      #include "hw/misc/allwinner-r40-dramc.h"
>      #include "hw/i2c/allwinner-i2c.h"
>     +#include "hw/net/allwinner_emac.h"
>     +#include "hw/net/allwinner-sun8i-emac.h"
>      #include "target/arm/cpu.h"
>      #include "sysemu/block-backend.h"
>
>     @@ -36,6 +38,7 @@ enum {
>          AW_R40_DEV_SRAM_A2,
>          AW_R40_DEV_SRAM_A3,
>          AW_R40_DEV_SRAM_A4,
>     +    AW_R40_DEV_EMAC,
>          AW_R40_DEV_MMC0,
>          AW_R40_DEV_MMC1,
>          AW_R40_DEV_MMC2,
>     @@ -51,6 +54,7 @@ enum {
>          AW_R40_DEV_UART6,
>          AW_R40_DEV_UART7,
>          AW_R40_DEV_TWI0,
>     +    AW_R40_DEV_GMAC,
>          AW_R40_DEV_GIC_DIST,
>          AW_R40_DEV_GIC_CPU,
>          AW_R40_DEV_GIC_HYP,
>     @@ -103,6 +107,8 @@ struct AwR40State {
>          AwR40ClockCtlState ccu;
>          AwR40DramCtlState dramc;
>          AWI2CState i2c0;
>     +    AwEmacState emac;
>     +    AwSun8iEmacState gmac;
>          GICState gic;
>          MemoryRegion sram_a1;
>          MemoryRegion sram_a2;
>     -- 
>     2.25.1
>
>
> Regards,
> Niek
> -- 
> Niek Linnenbank
>



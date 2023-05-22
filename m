Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE070CBE4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 23:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1CfA-00075o-9a; Mon, 22 May 2023 17:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1Cez-000740-Td; Mon, 22 May 2023 17:01:43 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1Cex-0002sA-RX; Mon, 22 May 2023 17:01:41 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2af20198f20so52197191fa.0; 
 Mon, 22 May 2023 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684789297; x=1687381297;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3roqq8/YdF4w+YsjL2h/vQAbTjtxxl1tkfpwgkRMPi4=;
 b=Z4SzFmwTuP6ueAVeYaRCTVakpszSa5nkoSO1V8OpcgUbqoC+byzYn9y+F4yUWYVhEf
 acVRv9IYzs79pkNNlJWoZ5rNr28JXTqxCjzRelm+XPYEEKYbOBSLicx9+T3VpDIQea+h
 hJ+KGENNssQdSPT41b3D84y4OyHnqGH8mbB5YuzfoDt4v6hkfPW6QTdcCE9sfryDhBRk
 veYPAb+vv1OjYNgLHw2KeUA7Cki7uW8jsgXjSj4aBJg3d8cXNGevs3rn3X9iOR4l8A9V
 PzHytmL5WtoSqBqmGMEn/GoWuW0AOrn1ZxhD/sdlxgx03/L6x/QJVCxWDBd1PEbiklSx
 ZzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684789297; x=1687381297;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3roqq8/YdF4w+YsjL2h/vQAbTjtxxl1tkfpwgkRMPi4=;
 b=V3PLOvyakpHUOXTAIb10WX6u2sK7UUO/S83gduMUd7VKAr2PvJ/N0W/aADgdRM0Qds
 ULfUPaLJ/CsBOIj9JMa072DrHCvF9JApbE/CV1uxnYGTpF217g2Cl/l3oQkKwGuYc9OT
 EyMtMKEwehhadZFBe5ZdWsoRnirrGpV1ZTpxmqL4mBbWZ8IFmk2Gra8z5ZHps94Tr/gX
 uLPlwmhNpXrqFOvMIfCe/4+bhOXWtSW/T0GDzHNcH+bUje2Ca8dASzbltZ63IUtXm8Bh
 TaMGzJV0Zd4E5EBfC5AUSDfM6IJKgayU+1GfyAC8ZFwAo2OCBFb7T5wFXWVvZJGDDAYt
 /1iw==
X-Gm-Message-State: AC+VfDxFC/kKvqZwc1fmE+iCAwii70XWlOx7LeytouVlwaMLszsghzja
 pveFYiDrN3uh1MljbsFpNcQ=
X-Google-Smtp-Source: ACHHUZ6vO97BY/MbmclWS65BIrAXHbWltjbvxcsCn4r1XsOz6xMv+19Oh1Sx4IAsZ0Fx0xAEVDkcrw==
X-Received: by 2002:a2e:7a12:0:b0:2ac:8e5a:1054 with SMTP id
 v18-20020a2e7a12000000b002ac8e5a1054mr4384879ljc.0.1684789296235; 
 Mon, 22 May 2023 14:01:36 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a2e3512000000b002aa3ad9014asm1282247ljz.54.2023.05.22.14.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 14:01:35 -0700 (PDT)
Date: Mon, 22 May 2023 23:01:34 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Subject: Re: [QEMU][PATCH v5 3/4] xlnx-versal: Connect Xilinx VERSAL CANFD
 controllers
Message-ID: <20230522210133.GA29905@fralle-msi>
References: <20230519203658.21211-2-vikram.garhwal@amd.com>
 <20230519203658.21211-4-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203658.21211-4-vikram.garhwal@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01, USER_IN_WHITELIST=-100,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On [2023 May 19] Fri 13:36:57, Vikram Garhwal wrote:
> Connect CANFD0 and CANFD1 on the Versal-virt machine and update xlnx-versal-virt
> document with CANFD command line examples.
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 31 ++++++++++++++++
>  hw/arm/xlnx-versal-virt.c            | 53 ++++++++++++++++++++++++++++
>  hw/arm/xlnx-versal.c                 | 37 +++++++++++++++++++
>  include/hw/arm/xlnx-versal.h         | 12 +++++++
>  4 files changed, 133 insertions(+)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index 92ad10d2da..d2d1b26692 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -34,6 +34,7 @@ Implemented devices:
>  - DDR memory
>  - BBRAM (36 bytes of Battery-backed RAM)
>  - eFUSE (3072 bytes of one-time field-programmable bit array)
> +- 2 CANFDs
>  
>  QEMU does not yet model any other devices, including the PL and the AI Engine.
>  
> @@ -224,3 +225,33 @@ To use a different index value, N, from default of 1, add:
>  
>    Better yet, do not use actual product data when running guest image
>    on this Xilinx Versal Virt board.
> +
> +Using CANFDs for Versal Virt
> +""""""""""""""""""""""""""""
> +Versal CANFD controller is developed based on SocketCAN and QEMU CAN bus
> +implementation. Bus connection and socketCAN connection for each CAN module
> +can be set through command lines.
> +
> +To connect both CANFD0 and CANFD1 on the same bus:
> +
> +.. code-block:: bash
> +
> +    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
> +
> +To connect CANFD0 and CANFD1 to separate buses:
> +
> +.. code-block:: bash
> +
> +    -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
> +    -machine canbus0=canbus0 -machine canbus1=canbus1
> +
> +The SocketCAN interface can connect to a Physical or a Virtual CAN interfaces on
> +the host machine. Please check this document to learn about CAN interface on
> +Linux: docs/system/devices/can.rst
> +
> +To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
> +
> +.. code-block:: bash
> +
> +    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
> +    -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 668a9d65a4..1ee2b8697f 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -40,9 +40,11 @@ struct VersalVirt {
>          uint32_t clk_25Mhz;
>          uint32_t usb;
>          uint32_t dwc;
> +        uint32_t canfd[2];
>      } phandle;
>      struct arm_boot_info binfo;
>  
> +    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
>      struct {
>          bool secure;
>      } cfg;
> @@ -235,6 +237,38 @@ static void fdt_add_uart_nodes(VersalVirt *s)
>      }
>  }
>  
> +static void fdt_add_canfd_nodes(VersalVirt *s)
> +{
> +    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
> +    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
> +    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
> +    const char clocknames[] = "can_clk\0s_axi_aclk";
> +    int i;
> +
> +    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
> +    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> +        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
> +        qemu_fdt_add_subnode(s->fdt, name);
> +
> +        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
> +        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
> +
> +        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
> +        qemu_fdt_setprop(s->fdt, name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, addrs[i], 2, size[i]);
> +        qemu_fdt_setprop_string(s->fdt, name, "compatible",
> +                                "xlnx,canfd-2.0");
> +
> +        g_free(name);
> +    }
> +}
> +
>  static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
>                                       uint32_t phandle)
>  {
> @@ -639,12 +673,17 @@ static void versal_virt_init(MachineState *machine)
>                              TYPE_XLNX_VERSAL);
>      object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
>                               &error_abort);
> +    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>  
>      fdt_create(s);
>      create_virtio_regions(s);
>      fdt_add_gem_nodes(s);
>      fdt_add_uart_nodes(s);
> +    fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
> @@ -712,6 +751,20 @@ static void versal_virt_init(MachineState *machine)
>  
>  static void versal_virt_machine_instance_init(Object *obj)
>  {
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    /*
> +     * User can set canbus0 and canbus1 properties to can-bus object and connect
> +     * to socketcan(optional) interface via command line.
> +     */
> +    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[0],
> +                             object_property_allow_set_link,
> +                             0);
> +    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
> +                             (Object **)&s->canbus[1],
> +                             object_property_allow_set_link,
> +                             0);
>  }
>  
>  static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 69b1b99e93..1594dd6c5c 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -184,6 +184,38 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
>      }
>  }
>  
> +static void versal_create_canfds(Versal *s, qemu_irq *pic)
> +{
> +    int i;
> +    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
> +    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
> +
> +    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
> +        char *name = g_strdup_printf("canfd%d", i);
> +        SysBusDevice *sbd;
> +        MemoryRegion *mr;
> +
> +        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
> +                                TYPE_XILINX_CANFD);
> +        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
> +
> +        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
> +                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
> +
> +        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
> +                                 OBJECT(s->lpd.iou.canbus[i]),
> +                                 &error_abort);
> +
> +        sysbus_realize(sbd, &error_fatal);
> +
> +        mr = sysbus_mmio_get_region(sbd, 0);
> +        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> +
> +        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
> +        g_free(name);
> +    }
> +}
> +
>  static void versal_create_usbs(Versal *s, qemu_irq *pic)
>  {
>      DeviceState *dev;
> @@ -718,6 +750,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
>      versal_create_uarts(s, pic);
> +    versal_create_canfds(s, pic);
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
> @@ -757,6 +790,10 @@ static void versal_init(Object *obj)
>  static Property versal_properties[] = {
>      DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
> +    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
> +                      TYPE_CAN_BUS, CanBusState *),
> +    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
> +                      TYPE_CAN_BUS, CanBusState *),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index b6786e9832..39ee31185c 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -31,6 +31,7 @@
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
> +#include "hw/net/xlnx-versal-canfd.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
> @@ -43,6 +44,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
>  #define XLNX_VERSAL_NR_SDS     2
>  #define XLNX_VERSAL_NR_XRAM    4
>  #define XLNX_VERSAL_NR_IRQS    192
> +#define XLNX_VERSAL_NR_CANFD   2
> +#define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
>  
>  struct Versal {
>      /*< private >*/
> @@ -73,6 +76,8 @@ struct Versal {
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
> +            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> +            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
>          } iou;
>  
>          /* Real-time Processing Unit.  */
> @@ -133,6 +138,8 @@ struct Versal {
>  #define VERSAL_CRL_IRQ             10
>  #define VERSAL_UART0_IRQ_0         18
>  #define VERSAL_UART1_IRQ_0         19
> +#define VERSAL_CANFD0_IRQ_0        20
> +#define VERSAL_CANFD1_IRQ_0        21
>  #define VERSAL_USB0_IRQ_0          22
>  #define VERSAL_GEM0_IRQ_0          56
>  #define VERSAL_GEM0_WAKE_IRQ_0     57
> @@ -163,6 +170,11 @@ struct Versal {
>  #define MM_UART1                    0xff010000U
>  #define MM_UART1_SIZE               0x10000
>  
> +#define MM_CANFD0                   0xff060000U
> +#define MM_CANFD0_SIZE              0x10000
> +#define MM_CANFD1                   0xff070000U
> +#define MM_CANFD1_SIZE              0x10000
> +
>  #define MM_GEM0                     0xff0c0000U
>  #define MM_GEM0_SIZE                0x10000
>  #define MM_GEM1                     0xff0d0000U
> -- 
> 2.17.1
> 


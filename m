Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE9718B25
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SPJ-0001s4-IZ; Wed, 31 May 2023 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SPG-0001o5-Qn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:26:54 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SPF-0001OW-2v
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:26:54 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MnJZ4-1qTZxW0HMC-00jLrz; Wed, 31 May 2023 22:26:50 +0200
Message-ID: <d979be57-bb54-881c-875d-ba8d54a84550@vivier.eu>
Date: Wed, 31 May 2023 22:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/23] q800: move GLUE device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-9-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z7y0bYmYFK19eh5WND92NP/fIx6wYeIWE0qmkj+sRWAnTChpIGM
 Ce0nOO9sDUiXkpWPtAv8hVKzGFKqOVkJZGQiPBfPyCcKPyEK6QoYpm9OT7m6kqIOYiI/184
 SiCviiSJdMvVBvKAxaHUxktJ47qYgoXJRBT66dDvDfHF7nXyA9Z5J/ZCBibDeO7BgvE6EWm
 YpPxJEMJGy6JrMYWeEnIg==
UI-OutboundReport: notjunk:1;M01:P0:s0wV6RZnkVk=;QTmqxOaJ9QbIjG+A03zSnGEjE/K
 /D5Va+ILbrLSMwBI1EzcKIJ6oyyPZPgRAkBTDWqzz/EHOtj6xRYMh145m51I/7Ry5I+x9JbtR
 yS9NwqRwIo+BWx5rH4dHAqNHuULLQcD+JRZiogK1MnkyJuA+fpwLCDdxjk1aTg6KNLwPDvDix
 hQ5FfZMFZdU/yNEhxb+UAeJga/Rr3qVYML0NfbcBAKE6p7C8ArAnkVIubtjdkKFaNfQatfRDG
 WbJBiCY6O3QAi3n7CXx31IhPKcBf2wqqWZL3M7fbUmav2XC0ZLqf6RhzC+yTySf9F8dm5tBcv
 EfE6lfZwJ7kRmzff1gnBiBt01jcb/xrH5e7OrrbnuHLHJr4nTE+PRazHT+OKGk5QFiLg4+I7Q
 0vPpFRN8/vpP4tmK72TPcJRsQGEodMjYNSKAbXycsLQx3WySJMCcmiDJ7IZ6Mcz094xM6LQkh
 iwgiWzdOv8WBrvISCRNw4IwOeJsOs369iT6lOVCrNSOcAT2/rp8kE7DUIKaPR/B2bnzRFL3Rx
 nq3inATjvcLtHExgQEamEUwgRWRHyPd79131U9+0FqFDYc0OQIBZsxo2FGrKHPu7MePA4n00M
 ZzvP5gkQTr4EtIKY+HsliHm+VWNe3FH0M5w70AqsrcdGnp1u/lWg+SlBvSQlhHodqY/G2EIRb
 Y5WOaf5Jn3Skbmv4SxUGlwZxgKV3QK4UvcKvBnQ22g==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> Also change the instantiation of the GLUE device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 24 ++++++++++++++----------
>   include/hw/m68k/q800.h |  3 +++
>   2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 1d9dad60b3..7bd8e795d2 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -158,7 +158,6 @@ static void q800_machine_init(MachineState *machine)
>       SysBusDevice *sysbus;
>       BusState *adb_bus;
>       NubusBus *nubus;
> -    DeviceState *glue;
>       DriveInfo *dinfo;
>       uint8_t rng_seed[32];
>   
> @@ -195,10 +194,10 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* IRQ Glue */
> -    glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
> +    object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
> +    object_property_set_link(OBJECT(&m->glue), "cpu", OBJECT(&m->cpu),
>                                &error_abort);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
>   
>       /* VIA 1 */
>       via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
> @@ -209,10 +208,12 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(via1_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 1, VIA_BASE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA1));
> +    sysbus_connect_irq(sysbus, 0,
> +                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
>       /* A/UX mode */
>       qdev_connect_gpio_out(via1_dev, 0,
> -                          qdev_get_gpio_in_named(glue, "auxmode", 0));
> +                          qdev_get_gpio_in_named(DEVICE(&m->glue),
> +                                                 "auxmode", 0));
>   
>       adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
>       dev = qdev_new(TYPE_ADB_KEYBOARD);
> @@ -225,7 +226,8 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(via2_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA2));
> +    sysbus_connect_irq(sysbus, 0,
> +                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA2));
>   
>       /* MACSONIC */
>   
> @@ -258,7 +260,8 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 0, SONIC_BASE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_SONIC));
> +    sysbus_connect_irq(sysbus, 0,
> +                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
>   
>       memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
>                              SONIC_PROM_SIZE, &error_fatal);
> @@ -295,7 +298,8 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
>       sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
>       qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
> -                          qdev_get_gpio_in(glue, GLUE_IRQ_IN_ESCC));
> +                          qdev_get_gpio_in(DEVICE(&m->glue),
> +                                           GLUE_IRQ_IN_ESCC));
>       sysbus_mmio_map(sysbus, 0, SCC_BASE);
>   
>       /* SCSI */
> @@ -350,7 +354,7 @@ static void q800_machine_init(MachineState *machine)
>        * Since the framebuffer in slot 0x9 uses a separate IRQ, wire the unused
>        * IRQ via GLUE for use by SONIC Ethernet in classic mode
>        */
> -    qdev_connect_gpio_out(glue, GLUE_IRQ_NUBUS_9,
> +    qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
>                             qdev_get_gpio_in_named(via2_dev, "nubus-irq",
>                                                    VIA2_NUBUS_IRQ_9));
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 3e41f0e297..8e1bb0735d 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -23,6 +23,8 @@
>   #ifndef HW_Q800_H
>   #define HW_Q800_H
>   
> +#include "hw/m68k/q800-glue.h"
> +
>   /*
>    * The main Q800 machine
>    */
> @@ -32,6 +34,7 @@ struct Q800MachineState {
>   
>       M68kCPU cpu;
>       MemoryRegion rom;
> +    GLUEState glue;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



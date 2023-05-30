Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78794715CEC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xOQ-0006BX-4J; Tue, 30 May 2023 07:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xON-0006Az-56
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:19:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xOL-0004Ng-F7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:19:54 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MaIGB-1pXjes48Un-00WG1j; Tue, 30 May 2023 13:19:52 +0200
Message-ID: <6be4803f-2dd4-d042-f609-d42bf01ae218@vivier.eu>
Date: Tue, 30 May 2023 13:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/30] q800: move GLUE device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-7-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qfkwTvJz2Nlspjo/w3vaiRz3bve8HzHZfXW93OzoLkbWURcAnyA
 eCMTdKwdJcQ4pgjvImNEqMM6KRSVWjxXH/4j2i7jfc0WCX1sGCo66UxB9qfH5YcRKj63gSk
 SyNFYTCZRtbA5eeyoykFPUQwy3c/IT7b4jNGvPLjKNesv8Nq9VXHHkPUt3wfYsfOe/v+Enl
 vMbv+86Tgez31NXk8SmWQ==
UI-OutboundReport: notjunk:1;M01:P0:L5uDdkFinIc=;/m8mstu+Dacgof4dnSI1oaf9G3d
 VTscinq8nRbtyvppDdpEBnPvbU2bxTSOvOPsrPE6lLT7JrEuTmqtakYzLNuxXroG9hzpVy86x
 yZKYcAl3gOHoxRcvjn9fJbd42agkgHaNz5gKoCGurFcRdbZ8O+93A1rXbMMpR8WZZsnCqg3p+
 9Zoi7OuinipGNh9JOxTo1k2rSvvSdW3gMiTNLAiQA+pQCrWFUrX/GEYAHxBg7eriI6GJ99N13
 wE+UqM4fKOHuKjEaC5foa9eozSFfJgMI2uIu7Pv6nPlMSPXrjVmc44roOAdYP6N09WIs0l2mh
 TT3e2cYPv6wWNlIxoY9xLNDnBpmOF3RHhyG0H2jr57dBSyzRkjlXRYyRj0QNnLMKKaFPVYPCL
 L4mTFqUyqehEw/s0/gywFSjEZOhQrahuZpOBt/U7g29wjT+LppilIFTc3cox4tqjQD4ljdRoD
 VjJ2FDsj+ewuUHq8AdeI+cB2k+v9uvlH+4eaXcmrz1N1HkThid5lCPnu1vgHkKkKiMGy85XBX
 pq9CuXVMfJZ36RrD6hgD2psYrLE6fhrOWNtdT2ff9vMY7bIv9wK9/sL/ihRuis8E6ExGPgOIb
 k4vZcEpKCjyWZXCb0NdNuJbt0FUs/dmGypdww4ILjdZJav8x9szrmpcSQkWKs1Fbt97kKSJyz
 iLjvhkM5ptDgBENuSsGr6BHJVcZjVf6qwNDTDvvfog==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 20 ++++++++++----------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 6a000ceb75..c22a98d616 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -392,7 +392,6 @@ static void q800_machine_init(MachineState *machine)
>       SysBusDevice *sysbus;
>       BusState *adb_bus;
>       NubusBus *nubus;
> -    DeviceState *glue;
>       DriveInfo *dinfo;
>       uint8_t rng_seed[32];
>   
> @@ -427,9 +426,10 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* IRQ Glue */
> -    glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(m->cpu), &error_abort);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
> +    m->glue = qdev_new(TYPE_GLUE);
> +    object_property_set_link(OBJECT(m->glue), "cpu", OBJECT(m->cpu),
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(m->glue), &error_fatal);
>   
>       /* VIA 1 */
>       via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
> @@ -440,10 +440,10 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(via1_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 1, VIA_BASE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA1));
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA1));
>       /* A/UX mode */
>       qdev_connect_gpio_out(via1_dev, 0,
> -                          qdev_get_gpio_in_named(glue, "auxmode", 0));
> +                          qdev_get_gpio_in_named(m->glue, "auxmode", 0));
>   
>       adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
>       dev = qdev_new(TYPE_ADB_KEYBOARD);
> @@ -456,7 +456,7 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(via2_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA2));
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA2));
>   
>       /* MACSONIC */
>   
> @@ -489,7 +489,7 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 0, SONIC_BASE);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_SONIC));
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_SONIC));
>   
>       memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
>                              SONIC_PROM_SIZE, &error_fatal);
> @@ -526,7 +526,7 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
>       sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
>       qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
> -                          qdev_get_gpio_in(glue, GLUE_IRQ_IN_ESCC));
> +                          qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_ESCC));
>       sysbus_mmio_map(sysbus, 0, SCC_BASE);
>   
>       /* SCSI */
> @@ -581,7 +581,7 @@ static void q800_machine_init(MachineState *machine)
>        * Since the framebuffer in slot 0x9 uses a separate IRQ, wire the unused
>        * IRQ via GLUE for use by SONIC Ethernet in classic mode
>        */
> -    qdev_connect_gpio_out(glue, GLUE_IRQ_NUBUS_9,
> +    qdev_connect_gpio_out(m->glue, GLUE_IRQ_NUBUS_9,
>                             qdev_get_gpio_in_named(via2_dev, "nubus-irq",
>                                                    VIA2_NUBUS_IRQ_9));
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 2f3c720b8d..de02af53be 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -32,6 +32,7 @@ struct Q800MachineState {
>   
>       M68kCPU *cpu;
>       MemoryRegion rom;
> +    DeviceState *glue;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



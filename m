Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4AF718B2A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:29:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SRE-0006Uv-JH; Wed, 31 May 2023 16:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SRD-0006NH-8s
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SRB-0001lt-FH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:54 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYeZB-1pYsyG3FcR-00VgRx; Wed, 31 May 2023 22:28:51 +0200
Message-ID: <ebe5c548-af36-c935-38cb-4e7b6cfba205@vivier.eu>
Date: Wed, 31 May 2023 22:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/23] q800: move VIA1 device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-12-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0yVurcEd6J68YZemFLuv+NsqbJqej7ytThYaNIk4vmrPnxGItf3
 bJZAnO5ZdPzHv1n4biVrNoxZZvJs0qFUfavA9c1h/DDSWtPTFWwSXxC705ipf1V2oPz2kpX
 rEPGqRcRmNqMNZeBkIdcSV24rro03YSbbZrhIdvZr3KaH0g1cm6qUl6UIu/2lqMjeNfl5v/
 O7bOX63Td2f8TX77IKKtw==
UI-OutboundReport: notjunk:1;M01:P0:yufgTi90rt0=;Qv1+fFMDfFqx8A6mVEN6oeNfOrk
 Q2bQjEGEmRHhDxg6BN0Hz9vfT52gIjTcIjAVtSTRkYQBM/nzJS0x2+KSt0dzT7RWYzhaIrf99
 UxuEmn6x1keUeJKy2BizSXHfFu3pPu+WIvJLreqlMcrOvEgOJZRg9cez90TmXIRc6LfNFsH0P
 kl0aAqxI1ZecISGDR3+NM5cc6cO0uDCtNpTv76lBvqrPB+ueF7gVK4uP6dvGY+EbG9f3sGeME
 ZZp2U9a6n/FWdU7ePLVcwafxjtWfBCCC527pciebCdm4v4Td+5W0QMPeJREU3vHcQNkPos8ce
 pqFstJpuJ3+NJR3JyqVOKdc/iM+q/W8LjkTcgYRpaTGVULdrNKT3KWsYifVzUK0jVSQlYcWwh
 n8CwPMWq1qtg+tGeZR6GNq8dVlCozRBHfpxH3Zy9Mro3OCcTU934zZpgNE42fnY6vKgHHwmr1
 2YQUVR6/l1qi2JWVgVb503Of3uGzbaUdZ/yffBA6MuXFOI8b27LPVdZ2Yt6exeWLxUGLWPFfE
 RBhhP0HouzGmlrPwFoa9RnVDKri91UputPwZEgFqjCY1fJp13IyvIkteIBfOWB+XCSDAIDbHK
 S4mqQrgwPnIFO+tBWFW5EgMsaRNu1JObQOKApiOQQyjWQh3JYZAqBy/RmRrERxqGDeM+Z1Wj0
 xg9xUp6LOPNsRKF6n1b0v94ti7YpTBSIxsm6TTf7zQ==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> Also change the instantiation of the VIA1 device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 16 +++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 785a67b0a9..65947ba580 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -212,7 +212,7 @@ static void q800_machine_init(MachineState *machine)
>       hwaddr parameters_base;
>       CPUState *cs;
>       DeviceState *dev;
> -    DeviceState *via1_dev, *via2_dev;
> +    DeviceState *via2_dev;
>       DeviceState *escc_orgate;
>       SysBusESPState *sysbus_esp;
>       ESPState *esp;
> @@ -261,23 +261,25 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
>   
>       /* VIA 1 */
> -    via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
> +    object_initialize_child(OBJECT(machine), "via1", &m->via1,
> +                            TYPE_MOS6522_Q800_VIA1);
>       dinfo = drive_get(IF_MTD, 0, 0);
>       if (dinfo) {
> -        qdev_prop_set_drive(via1_dev, "drive", blk_by_legacy_dinfo(dinfo));
> +        qdev_prop_set_drive(DEVICE(&m->via1), "drive",
> +                            blk_by_legacy_dinfo(dinfo));
>       }
> -    sysbus = SYS_BUS_DEVICE(via1_dev);
> -    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus = SYS_BUS_DEVICE(&m->via1);
> +    sysbus_realize(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE,
>                                   sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
>       /* A/UX mode */
> -    qdev_connect_gpio_out(via1_dev, 0,
> +    qdev_connect_gpio_out(DEVICE(&m->via1), 0,
>                             qdev_get_gpio_in_named(DEVICE(&m->glue),
>                                                    "auxmode", 0));
>   
> -    adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
> +    adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
>       dev = qdev_new(TYPE_ADB_KEYBOARD);
>       qdev_realize_and_unref(dev, adb_bus, &error_fatal);
>       dev = qdev_new(TYPE_ADB_MOUSE);
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 81598af627..a7e03b3d28 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -24,6 +24,7 @@
>   #define HW_Q800_H
>   
>   #include "hw/m68k/q800-glue.h"
> +#include "hw/misc/mac_via.h"
>   
>   /*
>    * The main Q800 machine
> @@ -35,6 +36,7 @@ struct Q800MachineState {
>       M68kCPU cpu;
>       MemoryRegion rom;
>       GLUEState glue;
> +    MOS6522Q800VIA1State via1;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



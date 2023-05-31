Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A84718B3B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SV2-0003nR-LI; Wed, 31 May 2023 16:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SV1-0003jK-7X
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:32:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SUz-0002U9-3i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:32:50 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MhTt7-1qYJH22PDP-00efRI; Wed, 31 May 2023 22:32:47 +0200
Message-ID: <9174478a-f0a0-a806-a2a0-4614e3abd56d@vivier.eu>
Date: Wed, 31 May 2023 22:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 16/23] q800: move escc_orgate device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-17-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-17-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XwqALFpt1llDPK4+KmDCvl6lnbUJZ9XnusETiGF6lk00PZKKIg4
 01tMHeQXkEV9wgz8WRDut8qSw1bbHceQgx3SPk4dTDUMHMsf4UyE8BS6xGpD0mEvZZ10pmR
 OnpCej/kGJfQZ1xHSMzbiSeb8zPcLuCL0AV55uf7gVwcdLdv10N5cXJZZBVzDnHa3UnUh5J
 Zu6CAy4VjG/AHapHplpWg==
UI-OutboundReport: notjunk:1;M01:P0:K86C011aGxU=;l/8v41JHLm7qMYzh6ivg726P38O
 hNMhR1Hozg+NYK7uU1NOGeqNXek0VMdNLcYO3AYmwMeYtpds2R/Tt3lPI84I0HvdrsXzEAfSo
 TXR8LILyeosX2//ahqR9ljK/TOjTOObA1YpUgw/ogSMRhQ/qsE2BzRmbWb8IMXrYMX0wfDaYj
 Xg/LCglfnUVDVwto/JHxkqs4W+9AlrhRlkZJfhioS/Oe7EmBUC9D+PYIm/l1HCPK7cB+aRlFs
 MVGcqrzTuAI9BhrIASrnShS9ZmRzYnaNmFGDfWAcUBcCwi/bt6Wt9nMrTZTnAxKVDa2LU+ZcL
 IAHcbPI7rQS1fKoVHVgxLg7eRvqT+wpBH09q2x3PWWk+aPXMK1/erl57PZvoQmXBxx0rwN3qI
 LTPCRsS0mGAEksJGjWrkxtDF1p6lJ4hsG4y4G7Zeqgq0XOuE+VDXtg58ExIA93xL971wAx3bI
 L+JjjsiN64+FCqe3TFU3iMUIJNBLdvGbPGAGWFIFSrI3ODLDIp6KE0+Qr0E6cafbL2RXF1J0Y
 P9Xff0m0AiUsLYwFZjjpscmLuHLRl/08tWFlHBKzXgfy+ZzhKgTjI1gJvna3+hezSM2YM0Uz8
 cvJAZv+s/QKhFhelxnM5/Z1k8lwmio0XTytgaVRMop21PtuwSriYK7xIcDXYtglU1vMNIFjDg
 JsSGarby75Q5UYhQ/UuxSEPB2VaKOI+FKlNBqz5oWA==
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
> Also change the instantiation of the escc_orgate device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 16 +++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ac92daf190..6f54677e5f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
>       hwaddr parameters_base;
>       CPUState *cs;
>       DeviceState *dev;
> -    DeviceState *escc_orgate;
>       SysBusESPState *sysbus_esp;
>       ESPState *esp;
>       SysBusDevice *sysbus;
> @@ -362,12 +361,15 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_realize(sysbus, &error_fatal);
>   
>       /* Logically OR both its IRQs together */
> -    escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> -    object_property_set_int(OBJECT(escc_orgate), "num-lines", 2, &error_fatal);
> -    qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
> -    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
> -    qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
> +    object_initialize_child(OBJECT(machine), "escc_orgate", &m->escc_orgate,
> +                            TYPE_OR_IRQ);
> +    object_property_set_int(OBJECT(&m->escc_orgate), "num-lines", 2,
> +                            &error_fatal);
> +    dev = DEVICE(&m->escc_orgate);
> +    qdev_realize(dev, NULL, &error_fatal);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(dev, 0));
> +    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(dev, 1));
> +    qdev_connect_gpio_out(dev, 0,
>                             qdev_get_gpio_in(DEVICE(&m->glue),
>                                              GLUE_IRQ_IN_ESCC));
>       memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index d03603fe02..f9af314ee1 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -27,6 +27,7 @@
>   #include "hw/misc/mac_via.h"
>   #include "hw/net/dp8393x.h"
>   #include "hw/char/escc.h"
> +#include "hw/or-irq.h"
>   
>   /*
>    * The main Q800 machine
> @@ -42,6 +43,7 @@ struct Q800MachineState {
>       MOS6522Q800VIA2State via2;
>       dp8393xState dp8393x;
>       ESCCState escc;
> +    OrIRQState escc_orgate;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



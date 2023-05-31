Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B6718B2B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SRq-0007gq-HP; Wed, 31 May 2023 16:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SRm-0007en-BC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:29:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SRi-0001ow-6M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:29:29 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MJEpp-1poIF51spX-00KkTg; Wed, 31 May 2023 22:29:24 +0200
Message-ID: <366e497e-fc99-07b9-7095-c2428bc6c8e6@vivier.eu>
Date: Wed, 31 May 2023 22:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/23] q800: move VIA2 device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-13-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5itiprl43VrI+KlWmDauFfRLFsdgnAI7O1psCvb0tSAyqxMaq+1
 hP4CZ5tO2bPuiLgvUCNhyvVrfToVlhb+dEUdz1zI1gqDbVubGk5Vb54Qh0md+dGXjPLnKDb
 x2swCN05m7phYmgYpBLaPT02JAYHOQnNF61yLze9nOhT86QoS8TgsHTa92tMzJkuV2/ZOq6
 SdkuIsbWGP3GhcoFAJ/Hw==
UI-OutboundReport: notjunk:1;M01:P0:jgZN9wOgVSs=;3wlG9/AlcF6BjZC2icbt6OylOgJ
 x0/Om/pqoYfbEZyEnQzi+Crt6TTaPUj826RAn8goUCI3HCeAjxTmy6b3xDO/nCU1ZCCTMI+sv
 7+7PENr+wGPNFUtzp0yTIWVUZIkjfdEx6wqKB47Z3Q/cZ8heakCawHk7eaRi9PP885SuMRkCz
 PhXcIHsie9aQdSyuzcuJ5TZqncaeyp4+Ow+ZG19R+ItRiDLN/IwsQfuqa9aGicIdfEL8V49WS
 n6z4S8i35kJSJTOcLQXsmzIlnv7ulZKhiO2GNdTUqVPd05p68PmfSVSLxtmwMmy+WbsWR39sb
 AeRPk8/3ydEx2z/JBtcjeO4JZmUg9etHJsto6lEXMvocXjLbgkZlcI0P21tqRB7B2hDX/9Owc
 9GpJ9+TDTghBJCaC7cDKlZEeCmdjevpLdJ93g2kJcPT5jB5wsgZvrPQZ/ZCNyz27m025pcc3j
 /LE9ODLLGsy5UjyPY71Z5dnCwmyowx71BP29nnvp1fwsEUVzNr7UnQBUHdZVlzKEy5RP8E1Ju
 KZWqMsaF8pMux24aR/g8t20emme/JG7GKnvEtWw8ivzBgcz6JuJxFu9wNjnRwm27aifTG1L1W
 Ed7jNykFPZkqcHymlYcj12wqBjN3si0CsoB99qGmj+2wypV8Ygq8TUHHVt9xXA3RZDflMhRx8
 ZY9kOoHvPfwA+a7znBRrmolMn4jkUcvYPKR58uq4dQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
> Also change the instantiation of the VIA2 device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 27 ++++++++++++++++-----------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 65947ba580..53d6308a7a 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
>       hwaddr parameters_base;
>       CPUState *cs;
>       DeviceState *dev;
> -    DeviceState *via2_dev;
>       DeviceState *escc_orgate;
>       SysBusESPState *sysbus_esp;
>       ESPState *esp;
> @@ -286,9 +285,10 @@ static void q800_machine_init(MachineState *machine)
>       qdev_realize_and_unref(dev, adb_bus, &error_fatal);
>   
>       /* VIA 2 */
> -    via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
> -    sysbus = SYS_BUS_DEVICE(via2_dev);
> -    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    object_initialize_child(OBJECT(machine), "via2", &m->via2,
> +                            TYPE_MOS6522_Q800_VIA2);
> +    sysbus = SYS_BUS_DEVICE(&m->via2);
> +    sysbus_realize(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
>                                   sysbus_mmio_get_region(sysbus, 1));
>       sysbus_connect_irq(sysbus, 0,
> @@ -383,10 +383,14 @@ static void q800_machine_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       /* SCSI and SCSI data IRQs are negative edge triggered */
> -    sysbus_connect_irq(sysbus, 0, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
> -                                                  VIA2_IRQ_SCSI_BIT)));
> -    sysbus_connect_irq(sysbus, 1, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
> -                                                  VIA2_IRQ_SCSI_DATA_BIT)));
> +    sysbus_connect_irq(sysbus, 0,
> +                       qemu_irq_invert(
> +                           qdev_get_gpio_in(DEVICE(&m->via2),
> +                                                   VIA2_IRQ_SCSI_BIT)));
> +    sysbus_connect_irq(sysbus, 1,
> +                       qemu_irq_invert(
> +                           qdev_get_gpio_in(DEVICE(&m->via2),
> +                                                   VIA2_IRQ_SCSI_DATA_BIT)));
>       memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
>                                   sysbus_mmio_get_region(sysbus, 0));
>       memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
> @@ -412,11 +416,12 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
>                       MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
>       qdev_connect_gpio_out(dev, 9,
> -                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
> +                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
>                             VIA2_NUBUS_IRQ_INTVIDEO));
>       for (i = 1; i < VIA2_NUBUS_IRQ_NB; i++) {
>           qdev_connect_gpio_out(dev, 9 + i,
> -                              qdev_get_gpio_in_named(via2_dev, "nubus-irq",
> +                              qdev_get_gpio_in_named(DEVICE(&m->via2),
> +                                                     "nubus-irq",
>                                                        VIA2_NUBUS_IRQ_9 + i));
>       }
>   
> @@ -425,7 +430,7 @@ static void q800_machine_init(MachineState *machine)
>        * IRQ via GLUE for use by SONIC Ethernet in classic mode
>        */
>       qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
> -                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
> +                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
>                                                    VIA2_NUBUS_IRQ_9));
>   
>       nubus = &NUBUS_BRIDGE(dev)->bus;
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index a7e03b3d28..ba3aa45513 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -37,6 +37,7 @@ struct Q800MachineState {
>       MemoryRegion rom;
>       GLUEState glue;
>       MOS6522Q800VIA1State via1;
> +    MOS6522Q800VIA2State via2;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



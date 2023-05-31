Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 035B3718B3D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SVe-0004na-3G; Wed, 31 May 2023 16:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SVb-0004my-Kj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:33:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SVa-0002X7-4H
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:33:27 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MRBWU-1phRTM2d3E-00N97J; Wed, 31 May 2023 22:33:24 +0200
Message-ID: <5adc8edb-bcbc-ea2f-bc55-3321b5cd98a9@vivier.eu>
Date: Wed, 31 May 2023 22:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 18/23] q800: move SWIM device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-19-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fXn2R0POP5fx/y4Tw7u6nk3yla0DCARHw2oIdWY+D3VkalRbomK
 P8ertVIcdAdTGSExN76aN6SuJywEezk82KhfypM1CEEpYP9Ye+ID3ahm9Bb6ZUQzYh9HHrA
 QXrbO/NvWn87KZ8N89tNVM75wLLVyHEoqpbO4gnJ61csPC7Nb0PuSqfMpppitApdHSps1CY
 rnpDlC/rO2Gi8xVCYZUTw==
UI-OutboundReport: notjunk:1;M01:P0:0W4ekhf/3mM=;aj0Kp2R0K9iHA/dNuNMd96mgIPi
 3CIVa9YduGYZchCX1QOC+ZceVkuvVnMj1FIaMMBXhEGVg0I8GWnaR6DgIMLn6VolZovIxt+Q+
 t5VcDNOYhCZkkQERwjuoYbXGRiQQMy6NA0IQE3aNR9RIemUsZX0EEJU7ww0a7aqWV7iCOObLb
 9sB92gvk3ZoZBmIY8z9m3tWbb3y8aFIm3/09wEMbQlCT8tVnO/QNNWXfyb4I9+LmIi2xC4PUj
 hQcbQFWkxUCjq3KE/IfBlRJDCQQNNA4CNx9NDSl7IjOceNb218+TMDbZKzX703rkJFV9+8k46
 fM+JxUnqf+UyhmcPK0K3QwY5G2s/rZ/YksbBbZ9ensDet4/VGorQ72RcXnZb3uxNIyBylPCVN
 x8zZQkHdz7hmUl/la2m9ek1+D3kiz20s0M9+VJf6N2mc4jzfAIY0zB+ZUHtrDjclx6/gK9TET
 8G6kqNXKEhlRzGgi0bTToBut3n30BNszPU1VQwLKUX5F0dgxOSLh3HkNzBgZRusLnHfW0GXq4
 cm1efwcI16ZME5BqaUlrT6OXDKPC05xY8N3GunOwYIFULaVlHh5HeTP9/yX/v8EAlLbD6B41X
 oE0XBFQLPEwR6xktV52rPK5pwiPtguX/Vf+GRpmgTTtIcwzOj4BZ7cUZMLwp0N9hFg7WorRnM
 BCTFttpBWI7hmXVtdzQb5qszThgiBhh1XQ6KxqpbgQ==
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
> Also change the instantiation of the SWIM device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 8 +++++---
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index befef5f822..f85ccf83af 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -407,10 +407,12 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* SWIM floppy controller */
>   
> -    dev = qdev_new(TYPE_SWIM);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    object_initialize_child(OBJECT(machine), "swim", &m->swim,
> +                            TYPE_SWIM);
> +    sysbus = SYS_BUS_DEVICE(&m->swim);
> +    sysbus_realize(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
> -                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> +                                sysbus_mmio_get_region(sysbus, 0));
>   
>       /* NuBus */
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index ba76aa37f2..ce8dbcd68f 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -29,6 +29,7 @@
>   #include "hw/char/escc.h"
>   #include "hw/or-irq.h"
>   #include "hw/scsi/esp.h"
> +#include "hw/block/swim.h"
>   
>   /*
>    * The main Q800 machine
> @@ -46,6 +47,7 @@ struct Q800MachineState {
>       ESCCState escc;
>       OrIRQState escc_orgate;
>       SysBusESPState esp;
> +    Swim swim;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



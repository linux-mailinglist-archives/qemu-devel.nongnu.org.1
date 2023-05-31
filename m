Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D928718B37
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4STX-0000c5-Ua; Wed, 31 May 2023 16:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4STN-0000Qc-VB
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:31:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4STI-0002Cf-TL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:31:09 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLyzP-1pmeda23Pt-00HwAa; Wed, 31 May 2023 22:31:03 +0200
Message-ID: <afba2dcc-464e-5997-8efa-52dda9904297@vivier.eu>
Date: Wed, 31 May 2023 22:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/23] q800: move dp8393x device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-15-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jdq4VXtG+y3Hx9Rjzzp+FU2i+aH7yvGpJEEkR9sWbORvZjKLoYr
 j+D967OxQnMq5F9A4+mlg/909reHVR/21x0uIK0HnSwuh18Ba5XpQEZGQdqIY58vswOEPoI
 AhNfqLEEIQCD2sM/VrGgqzdiF4+Y+rFl/StM6Qs4SxadVL2hGu+sYEmRAiBxcb+o8QZPStL
 Wjz7dNFM/GV1KwlOIHvuA==
UI-OutboundReport: notjunk:1;M01:P0:mihl7BgNGIA=;wtY6HxpKorceUo4DajKFV5xPCgP
 6hhnOtCyPqT4OS9OyCDkrdlHXHT3gThqEq35exTI46LBUcu8GqJaHwpAlEyX1bBC/xndtgzNo
 YPCUj2WOEC10IlE9jZvrMKImdI1kCq9T4u233NDsj7C4/Ld7NqKLNZgYNMFhcC5N2KBk0Az0r
 2o4gn55AcEsM6NOv6fpIWM+dSNDs9t52eytBBnGRUNl1VAVD15jV1wQI4plHgynIFwcTjkrFn
 1gAo0yWeH+VWKYRYjSmxxeAh6HaD+uQwdbWg9zsNQvfk5Jh6zyPUroK90jO8v/mmc3ipAqyE3
 R9G6+p47+DEUxzekMQ2ELoEZJL4IyPq489AAEhDBP4bQDux78x1nVFf6MvBjVMecZXYZRntpN
 X21xMSDGWwWtcNIOimm4QowVfNMynrwUMueTB/PXO4dFwaKD5KnrF+AfuSLl8IEteAf+YtfXg
 X4CfNivD1O511deD1vaOr6Nb8R8W0eivTwJUSIv2Xg1y2hEorv8HVQ1GmT1Smr+ZGnnJVIfc7
 vYrapfiWQKAQ5sMMI0iBfGYEqE5b5t8ZbSohyKNctRHxgxPPLCaw3fmHqJROOCMlvETwE67fL
 1Hxn+bOXPcc4YxKvarE0azQBUMbUwKrZZY48hlxdlU+NwPI/dfvBMwHpZTXj2amWoaR74CNNw
 llOnlB3fVjcs6+Aqsr3k9a1tjWH99SBdo35IbPtjmA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Also change the instantiation of the dp8393x device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Jason Wang <jasowang@redhat.com>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 53d6308a7a..e25f6f1373 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -316,14 +316,16 @@ static void q800_machine_init(MachineState *machine)
>       nd_table[0].macaddr.a[1] = 0x00;
>       nd_table[0].macaddr.a[2] = 0x07;
>   
> -    dev = qdev_new("dp8393x");
> +    object_initialize_child(OBJECT(machine), "dp8393x", &m->dp8393x,
> +                            TYPE_DP8393X);
> +    dev = DEVICE(&m->dp8393x);
>       qdev_set_nic_properties(dev, &nd_table[0]);
>       qdev_prop_set_uint8(dev, "it_shift", 2);
>       qdev_prop_set_bit(dev, "big_endian", true);
>       object_property_set_link(OBJECT(dev), "dma_mr",
>                                OBJECT(get_system_memory()), &error_abort);
>       sysbus = SYS_BUS_DEVICE(dev);
> -    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus_realize(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, SONIC_BASE - IO_BASE,
>                                   sysbus_mmio_get_region(sysbus, 0));
>       sysbus_connect_irq(sysbus, 0,
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index ba3aa45513..82964cfea1 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -25,6 +25,7 @@
>   
>   #include "hw/m68k/q800-glue.h"
>   #include "hw/misc/mac_via.h"
> +#include "hw/net/dp8393x.h"
>   
>   /*
>    * The main Q800 machine
> @@ -38,6 +39,7 @@ struct Q800MachineState {
>       GLUEState glue;
>       MOS6522Q800VIA1State via1;
>       MOS6522Q800VIA2State via2;
> +    dp8393xState dp8393x;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



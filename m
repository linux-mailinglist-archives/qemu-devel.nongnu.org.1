Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64D718B38
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SUF-0001um-1W; Wed, 31 May 2023 16:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SUC-0001o3-NO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:32:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SUB-0002ML-2l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:32:00 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6LIF-1qAgmi1YpV-016gAd; Wed, 31 May 2023 22:31:57 +0200
Message-ID: <e408dda3-060a-7f35-b525-72dfc3d4d0ac@vivier.eu>
Date: Wed, 31 May 2023 22:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/23] q800: move ESCC device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-16-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:itWlY6E23OF7QHI9GnSCoxMeuKNkCdESUG+h9lt+SzqpMwTwlzE
 TXPhhapg61/txjcfITxtXIvVtZZdB1Ig0mLSY8F/aEeaquLv4nb0N75ZRhcFFCMFSjqYQ/4
 AfeLMUGG6gGXcwzSc+qtqeQ51Jpelr9Wn7E2igpnlNUqWEsHYGnaTW4c7nZScj/Fp4Md4/S
 0VB3384Ukq3mybar1yGsg==
UI-OutboundReport: notjunk:1;M01:P0:Ai+wA6fiFDY=;QFEG6h17Bg8dY6mEtjYUoqhgLQJ
 IbDT9DmWlNBK6KI3P5SNNHGGaNwGaWM8RUMJIMzn/rW8brnZgY5hBu6RK9+BKddq3PWHN4/7v
 JQIlPS24YtcP+Md4B0CRUIOnCDDZLIv08xpNnlstCNzQOEsOKmSoluYr1piBdaP1VXyKwNkjI
 EoxSLQeL/06Ln8l5tIGDWywb6Ah2+x2MROOIDExC6eaJfcq3zD+m5oXZhDNd3rivQORC03jK+
 P9nLuUr7aT2TCu7pqNUTT79I/6quf4sbafUkEuMHMxsVR5yYCyDUJ7gYWpBLFRgyO3flnNRZ8
 ADZh8ncYZC2oOPUD0LVzs9sEAPpxED11zXPt1M896e0qTb4w79LoGH43TD2yzjwaDqBQmJCD6
 /MefNKFNdJy5eLkbWAT/Ki9zDGwkqe8gdm4JzShqgatM1gxAN4alH/wApKwyVh6IhbM1TwHeG
 ApvW6BUlg0AykZ+uPiyAcfXHwDVCvRwD6YQiprTss6j0K8u0GPsOYEaL9mbYRvLxP6ZeE3gKx
 pyM6VxZw9scxOtcVsCbxTojZ9X03iBv8/HDn4LsscIP0GhGNiFRvOu70XkYl+TUS2A1lsq+l+
 8dVhDtdDEE3bHdM/rcmxXR1jhKMp9qj5KlhbIrI7B/Glbh8U/i7ueuKNrRfp6FcAcM81zTiB9
 xmMLJx0S6v7sYhCECNAqkd0ic6iyvKLorChnEjtiyQ==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
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
> Also change the instantiation of the ESCC device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index e25f6f1373..ac92daf190 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -347,7 +347,9 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* SCC */
>   
> -    dev = qdev_new(TYPE_ESCC);
> +    object_initialize_child(OBJECT(machine), "escc", &m->escc,
> +                            TYPE_ESCC);
> +    dev = DEVICE(&m->escc);
>       qdev_prop_set_uint32(dev, "disabled", 0);
>       qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
>       qdev_prop_set_uint32(dev, "it_shift", 1);
> @@ -357,7 +359,7 @@ static void q800_machine_init(MachineState *machine)
>       qdev_prop_set_uint32(dev, "chnBtype", 0);
>       qdev_prop_set_uint32(dev, "chnAtype", 0);
>       sysbus = SYS_BUS_DEVICE(dev);
> -    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus_realize(sysbus, &error_fatal);
>   
>       /* Logically OR both its IRQs together */
>       escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 82964cfea1..d03603fe02 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -26,6 +26,7 @@
>   #include "hw/m68k/q800-glue.h"
>   #include "hw/misc/mac_via.h"
>   #include "hw/net/dp8393x.h"
> +#include "hw/char/escc.h"
>   
>   /*
>    * The main Q800 machine
> @@ -40,6 +41,7 @@ struct Q800MachineState {
>       MOS6522Q800VIA1State via1;
>       MOS6522Q800VIA2State via2;
>       dp8393xState dp8393x;
> +    ESCCState escc;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



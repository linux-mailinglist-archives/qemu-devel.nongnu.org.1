Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7D718B3C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SVO-0004dT-9B; Wed, 31 May 2023 16:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SVK-0004ct-Vt
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:33:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SVJ-0002VE-Cv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:33:10 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOzjW-1pjdL52YKC-00PPPf; Wed, 31 May 2023 22:33:07 +0200
Message-ID: <3a1aa97e-b8c2-9df0-07a1-49c82eaefa66@vivier.eu>
Date: Wed, 31 May 2023 22:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 17/23] q800: move ESP device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-18-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-18-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8HD23duVoiUBfGFP1ogxJVmfnw3wvLCkWY3l2FPKxD2PISuAtYI
 TjBE0aAl5p8Zmj0wV9zdZmNj/8N6o8qPrJYS4Z/zUEHux00g9FJ1BLtSwRcQNwdb2iy+0UR
 7PXuRA+Rbgb6rve2wQWjDdN8c8WSI42BtkMkVxYza2y7s/04K5FoZ5RgnPITBM2uWOJg5z1
 5TrEEeQ7vAkMXk/dJZRqw==
UI-OutboundReport: notjunk:1;M01:P0:5pHin9C2trQ=;h7QGv4h5yGF6LUKnEs9yWdnl/ll
 5ZCRa9U6I1DsPZJpCbfS7xgctfrZw9cghcMnihwkZt2acOtQYJPSeaP2BCwd2X1DFlDGf5tIf
 jc6rL0FABFdlSdDCplrQi2d6edus7X15DaR73VVnUf2Dkb6bw5uOUJ6/DC+hv8/qG8rfeOMH/
 gFJ7pVXNLQj8l60XrCma9b3SS07+R75lYNWQt3VVUbBhsWL0sOq9lqYL1wRh9lSEXH7hpLA+o
 Qh+3sY6/GfGQ5BlAw/k4WTxBJ58wfI/WQ2myOx/3JOH7czppdp+ArdQSX+0PcxWL7uzRNz0f8
 1bmSicj31pcxkYU4QmkzmoYhy000SS9uPvKqaDHHmkk622eOGra/NS+c6PJqDrsjTECfK5M8x
 AGopyA8xzO1utMs6R62w0CoozxlyNH2sAbHn1FHFJK/88HO+BpKlmImLEq2TerPCDLrywthAD
 kq1JjXSNVzXsF9f82xfU/6D2ribTmBmyoslMTqh+uKMyvQ3QKUROr+LvNNxcj41vSZcJUMxsm
 WJsuuowScSi2+GiIILngd+RtiV60dY0BIchDe1xdSkLolFyzDo3sj4nZSeB63UAKhVkxGL8dr
 4wDp3uv/Ot6l/ftS79K8b5txlhdi9k2fCctxFno8QfoJeOjTPgk6s6pREJjqhQ/CA4sOxbkGm
 XB8yQdGS4iYK8XgabRm0GcexfoW8RvGZRsvhn1fogw==
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
> Also change the instantiation of the ESP device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 9 +++++----
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 6f54677e5f..befef5f822 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -377,8 +377,9 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* SCSI */
>   
> -    dev = qdev_new(TYPE_SYSBUS_ESP);
> -    sysbus_esp = SYSBUS_ESP(dev);
> +    object_initialize_child(OBJECT(machine), "esp", &m->esp,
> +                            TYPE_SYSBUS_ESP);
> +    sysbus_esp = SYSBUS_ESP(&m->esp);
>       esp = &sysbus_esp->esp;
>       esp->dma_memory_read = NULL;
>       esp->dma_memory_write = NULL;
> @@ -386,8 +387,8 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_esp->it_shift = 4;
>       esp->dma_enabled = 1;
>   
> -    sysbus = SYS_BUS_DEVICE(dev);
> -    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    sysbus = SYS_BUS_DEVICE(&m->esp);
> +    sysbus_realize(sysbus, &error_fatal);
>       /* SCSI and SCSI data IRQs are negative edge triggered */
>       sysbus_connect_irq(sysbus, 0,
>                          qemu_irq_invert(
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index f9af314ee1..ba76aa37f2 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -28,6 +28,7 @@
>   #include "hw/net/dp8393x.h"
>   #include "hw/char/escc.h"
>   #include "hw/or-irq.h"
> +#include "hw/scsi/esp.h"
>   
>   /*
>    * The main Q800 machine
> @@ -44,6 +45,7 @@ struct Q800MachineState {
>       dp8393xState dp8393x;
>       ESCCState escc;
>       OrIRQState escc_orgate;
> +    SysBusESPState esp;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



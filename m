Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59947718B44
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:36:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SXW-0006GS-1W; Wed, 31 May 2023 16:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SXM-0006FZ-Rp
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:35:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SXL-0002j6-3l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:35:16 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mjjvp-1qW3461dCl-00lBRR; Wed, 31 May 2023 22:35:13 +0200
Message-ID: <8b0be4eb-8084-6a3c-0574-6b12e45d7d49@vivier.eu>
Date: Wed, 31 May 2023 22:35:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 21/23] q800: move macfb device to Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mBk5lPC05Uu/bCF7ejifrpKc27oEXTEu7EtVriEf1SeXpXYHoz8
 lR9kqPiR6qUff1XPS9m25dvktJzapWDaYAFtcM/bGmdNQbK+n9rsRrw0bOYXafCit24QSHG
 48+uelXetNHN3KX9J5+W4TUyMqZPyB2oQW8v3y0TSEBFxR0otjkFe63L7pZ9+8idCg5kydY
 H853mXnc+KOB0Avv8xFlw==
UI-OutboundReport: notjunk:1;M01:P0:yBIrnFb4QqU=;7O4ZacPYvkyZOEdSFd0/df7oKZd
 8F9d+cJja+D1Fu776Xro3c66tMnif9Hcuq4i2plVZNE3G+h2SUx66i6z1yZq5uuMvhZkfVcoh
 WxiDQ8VJppxB1KyS4wb1iuHNkRzxgDlCnk8wMuxLTVUSDEc08Xhhy3053bTS0Ib3e0KcD0VFE
 9ot8gl1QNA3Owzma5UHoP9nKXWtxNpQAtGirSJZN3hLQUHF9OBPtyvIVtYO8i4bRUqh2QPcpy
 80yUNExx3/mBGDuMr1iBivJ0DSg0Op9/vRJ81qPbjFQZyp4MwqWL/QgLM4dQ5mC3R04d1LpvY
 7qcCYHm8yiG9W6uyoW7rjroddilHx1Cm6il/EYgSHvr2zMViEYDDeHpVLmXBQULC/wrkUmbPg
 sThqpm3Ou+PKShWB3JjY/YoraMG1HcXf+WwOVAuSdR3urGNigR17I63tuOSM6EjTPEKiQGMG6
 Gx6fRhPcSLGpNdfJXqV/JciMyr1SuuaS44zLlLaikM0z7oZXnnn6aOgVgGnF/pjH56+IoQKDj
 NM/+fBcq5zhfqvuNKM83mZVoaSZl9reFsRBK0wC2ZR/oH9BdRaAV5gbBOoSFFiSTjXYUM57fe
 ESFVh6RiXW6O6dYYJ+V/lvrJlpG4g/8Dh0eE/KPUDd7evB2vZSvbCur89okYZP0c+JwuzVRWC
 m7EIViuY+VXwC1hj0HWoiircOLvQGhTYMyY/vcrsAQ==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
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
> Also change the instantiation of the macfb device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 946cb09e30..0e7451e77a 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -449,7 +449,9 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* framebuffer in nubus slot #9 */
>   
> -    dev = qdev_new(TYPE_NUBUS_MACFB);
> +    object_initialize_child(OBJECT(machine), "macfb", &m->macfb,
> +                            TYPE_NUBUS_MACFB);
> +    dev = DEVICE(&m->macfb);
>       qdev_prop_set_uint32(dev, "slot", 9);
>       qdev_prop_set_uint32(dev, "width", graphic_width);
>       qdev_prop_set_uint32(dev, "height", graphic_height);
> @@ -459,7 +461,7 @@ static void q800_machine_init(MachineState *machine)
>       } else {
>           qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
>       }
> -    qdev_realize_and_unref(dev, BUS(nubus), &error_fatal);
> +    qdev_realize(dev, BUS(nubus), &error_fatal);
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 3f3e87b3dc..48d2443d74 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -31,6 +31,7 @@
>   #include "hw/scsi/esp.h"
>   #include "hw/block/swim.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
> +#include "hw/display/macfb.h"
>   
>   /*
>    * The main Q800 machine
> @@ -50,6 +51,7 @@ struct Q800MachineState {
>       SysBusESPState esp;
>       Swim swim;
>       MacNubusBridge mac_nubus_bridge;
> +    MacfbNubusState macfb;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA6715CD5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xKg-0002zB-3s; Tue, 30 May 2023 07:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xKc-0002yk-CV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:16:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xKa-0002zm-J8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:16:02 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MryOx-1qOSpn1jXB-00nwzh; Tue, 30 May 2023 13:15:58 +0200
Message-ID: <564541b2-c33d-0fea-11c0-fc2bf4d28244@vivier.eu>
Date: Tue, 30 May 2023 13:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/30] q800: introduce Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-3-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zjEqZXj3XIoUyCG8KvBtUt8CAaU0mWPsqLc3W9NZ2yUTuJnOZXi
 aF7ZaKikR1yUmxIf94hNWRy+vxHiFLQBrl5SeMp/wbh48o/h69yd4e41N62AHkGjQikKwVk
 4W565RiFyPvQyV1FOuwh+bvgj/ZUevUyzV1+L+3QIoKwG0c9jrIDiXMXAciRgnix7HfFk+n
 qmWULYbQLPm6qvA0ixKMA==
UI-OutboundReport: notjunk:1;M01:P0:NcuPsQ2+NQg=;BzxGlw1Qi1CX3N8W6SRoaQPp5Eo
 42VBFSvYbyqkdWjL963D74EMyVoRZEZa2fR24hlKHsJVRk4Kkpbftf2+3agsUnBS9V2u33Oar
 MUhErGm2sMj02mfD65YNCkV30rbIUmSE9gw+9SFrUcyBiiLCb6e8ZDMk62WhjrWGBYd0k00TF
 gvw74TYOPt1MwuvF0mjibwpSsHaPuMi61YreDZMC+FojLHT1LZl40HM9Daw6W2bqQImAr/ey3
 IvZXYyA3CX8s1Wr6ue65eyAWY+d6pcKv9Jw6qAO5O82jUdtMo2s8pX3ohSggqwnp1qiunMGsY
 YAg5i62HvTvIYNrX4Ss+QxUgFOoy5usDropL1vzUiRMpPxmYleL1MhR7XkXWiwLr8tBpycOOl
 VKvoQdRR/b8cUHDprIBWMzl9kYCFiVuCDOyAbWK/AX1qrMZFv0CRkbwxqHyiA2IyGJadKNSZ6
 cM8XSifQPr0DLGtVd+wST24wipcswUJk+RQkSLNy0ZhE8vYzXe8LjrItXzDhaH3iQwKqyo1MN
 Su2YjUBQWEy48FkIxS1XQfd64xn3n6UIcpYSO4eHaalc0FFsBg+kbPi7zrNWNux8IYHVm04XK
 yCANY44tXT79MNzXSQ8MQPhQlAiSRytvo6rJdPa9+/x0v7wQDgQqfhuHgzq2PL7QsfDmPZ9Lq
 gmFRp+q6riHHkKD7ajY3AW+BIzct5Q1mAB5wpVH72w==
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> This provides an overall container and owner for Machine-related objects such
> as MemoryRegions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   MAINTAINERS            |  1 +
>   hw/m68k/q800.c         |  2 ++
>   include/hw/m68k/q800.h | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+)
>   create mode 100644 include/hw/m68k/q800.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c93ab0ee5..86a1b88863 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1234,6 +1234,7 @@ F: include/hw/misc/mac_via.h
>   F: include/hw/nubus/*
>   F: include/hw/display/macfb.h
>   F: include/hw/block/swim.h
> +F: include/hw/m68k/q800.h
>   
>   virt
>   M: Laurent Vivier <laurent@vivier.eu>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 1aead224e2..bdccd93c7f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -38,6 +38,7 @@
>   #include "standard-headers/asm-m68k/bootinfo.h"
>   #include "standard-headers/asm-m68k/bootinfo-mac.h"
>   #include "bootinfo.h"
> +#include "hw/m68k/q800.h"
>   #include "hw/misc/mac_via.h"
>   #include "hw/input/adb.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
> @@ -748,6 +749,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>   static const TypeInfo q800_machine_typeinfo = {
>       .name       = MACHINE_TYPE_NAME("q800"),
>       .parent     = TYPE_MACHINE,
> +    .instance_size = sizeof(Q800MachineState),
>       .class_init = q800_machine_class_init,
>   };
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> new file mode 100644
> index 0000000000..560fd6f93d
> --- /dev/null
> +++ b/include/hw/m68k/q800.h
> @@ -0,0 +1,37 @@
> +/*
> + * QEMU Motorla 680x0 Macintosh hardware System Emulator
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_Q800_H
> +#define HW_Q800_H
> +
> +/*
> + * The main Q800 machine
> + */
> +
> +struct Q800MachineState {
> +    MachineState parent_obj;
> +};
> +
> +#define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
> +OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, q800, Q800_MACHINE, MachineState)
> +
> +#endif

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



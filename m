Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62AC817E46
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 00:55:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNRI-0007a4-F5; Mon, 18 Dec 2023 18:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNRG-0007ZY-8A; Mon, 18 Dec 2023 18:54:22 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNRE-0005lN-9W; Mon, 18 Dec 2023 18:54:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3932275A4BF;
 Tue, 19 Dec 2023 00:54:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wsT9Jz5r_Weu; Tue, 19 Dec 2023 00:54:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 495F375A406; Tue, 19 Dec 2023 00:54:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 46F01756094;
 Tue, 19 Dec 2023 00:54:15 +0100 (CET)
Date: Tue, 19 Dec 2023 00:54:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 01/12] hw/block/fdc-isa: Free struct FDCtrl from
 PortioList
In-Reply-To: <20231218185114.119736-2-shentey@gmail.com>
Message-ID: <b49be117-e38f-4c20-6d24-491b7d499642@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-2-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 18 Dec 2023, Bernhard Beschow wrote:
> FDCtrl::portio_list isn't used inside FDCtrl context but only inside
> FDCtrlISABus context, so more it there.

"more" -> "move", you have the same typo in several other commit messages. 
Not sure I like the C++ism FDCtrl::portio_list and would write out "The 
portio_list field of FDCtrl" instead but not a big deal. Also the subject 
could say "Move portio_list from FDCtrl to FDCtrlISABus" which is less 
ambiguous than using free that's ususally associated with freeing memory.
Otherwise

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/block/fdc-internal.h | 2 --
> hw/block/fdc-isa.c      | 4 +++-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
> index 036392e9fc..fef2bfbbf5 100644
> --- a/hw/block/fdc-internal.h
> +++ b/hw/block/fdc-internal.h
> @@ -26,7 +26,6 @@
> #define HW_BLOCK_FDC_INTERNAL_H
>
> #include "exec/memory.h"
> -#include "exec/ioport.h"
> #include "hw/block/block.h"
> #include "hw/block/fdc.h"
> #include "qapi/qapi-types-block.h"
> @@ -140,7 +139,6 @@ struct FDCtrl {
>     /* Timers state */
>     uint8_t timer0;
>     uint8_t timer1;
> -    PortioList portio_list;
> };
>
> extern const FDFormat fd_formats[];
> diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
> index 7ec075e470..b4c92b40b3 100644
> --- a/hw/block/fdc-isa.c
> +++ b/hw/block/fdc-isa.c
> @@ -42,6 +42,7 @@
> #include "sysemu/block-backend.h"
> #include "sysemu/blockdev.h"
> #include "sysemu/sysemu.h"
> +#include "exec/ioport.h"
> #include "qemu/log.h"
> #include "qemu/main-loop.h"
> #include "qemu/module.h"
> @@ -60,6 +61,7 @@ struct FDCtrlISABus {
>     uint32_t irq;
>     uint32_t dma;
>     struct FDCtrl state;
> +    PortioList portio_list;
>     int32_t bootindexA;
>     int32_t bootindexB;
> };
> @@ -91,7 +93,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
>     FDCtrl *fdctrl = &isa->state;
>     Error *err = NULL;
>
> -    isa_register_portio_list(isadev, &fdctrl->portio_list,
> +    isa_register_portio_list(isadev, &isa->portio_list,
>                              isa->iobase, fdc_portio_list, fdctrl,
>                              "fdc");
>
>


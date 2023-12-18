Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC2817E47
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 00:56:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNSl-0008JZ-Ay; Mon, 18 Dec 2023 18:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNSf-0008EZ-UW; Mon, 18 Dec 2023 18:55:49 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNSd-00066Q-DR; Mon, 18 Dec 2023 18:55:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9E5DB75A4BF;
 Tue, 19 Dec 2023 00:55:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id t5hi1Xbfw0b4; Tue, 19 Dec 2023 00:55:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B16EB75A406; Tue, 19 Dec 2023 00:55:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AF7CF756094;
 Tue, 19 Dec 2023 00:55:40 +0100 (CET)
Date: Tue, 19 Dec 2023 00:55:40 +0100 (CET)
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
Subject: Re: [PATCH v2 02/12] hw/block/fdc-sysbus: Free struct FDCtrl from
 MemoryRegion
In-Reply-To: <20231218185114.119736-3-shentey@gmail.com>
Message-ID: <36503e51-cd87-e80f-b9e5-faecbd19d03e@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
> FDCtrl::iomem isn't used inside FDCtrl context but only inside FDCtrlSysBus
> context, so more it there.

Same comments as for patch 1 otherwise

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/block/fdc-internal.h | 2 --
> hw/block/fdc-sysbus.c   | 6 ++++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
> index fef2bfbbf5..e219623dc7 100644
> --- a/hw/block/fdc-internal.h
> +++ b/hw/block/fdc-internal.h
> @@ -25,7 +25,6 @@
> #ifndef HW_BLOCK_FDC_INTERNAL_H
> #define HW_BLOCK_FDC_INTERNAL_H
>
> -#include "exec/memory.h"
> #include "hw/block/block.h"
> #include "hw/block/fdc.h"
> #include "qapi/qapi-types-block.h"
> @@ -91,7 +90,6 @@ typedef struct FDrive {
> } FDrive;
>
> struct FDCtrl {
> -    MemoryRegion iomem;
>     qemu_irq irq;
>     /* Controller state */
>     QEMUTimer *result_timer;
> diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
> index 86ea51d003..e197b97262 100644
> --- a/hw/block/fdc-sysbus.c
> +++ b/hw/block/fdc-sysbus.c
> @@ -26,6 +26,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "qom/object.h"
> +#include "exec/memory.h"
> #include "hw/sysbus.h"
> #include "hw/block/fdc.h"
> #include "migration/vmstate.h"
> @@ -52,6 +53,7 @@ struct FDCtrlSysBus {
>     /*< public >*/
>
>     struct FDCtrl state;
> +    MemoryRegion iomem;
> };
>
> static uint64_t fdctrl_read_mem(void *opaque, hwaddr reg, unsigned ize)
> @@ -146,11 +148,11 @@ static void sysbus_fdc_common_instance_init(Object *obj)
>
>     qdev_set_legacy_instance_id(dev, 0 /* io */, 2); /* FIXME */
>
> -    memory_region_init_io(&fdctrl->iomem, obj,
> +    memory_region_init_io(&sys->iomem, obj,
>                           sbdc->use_strict_io ? &fdctrl_mem_strict_ops
>                                               : &fdctrl_mem_ops,
>                           fdctrl, "fdc", 0x08);
> -    sysbus_init_mmio(sbd, &fdctrl->iomem);
> +    sysbus_init_mmio(sbd, &sys->iomem);
>
>     sysbus_init_irq(sbd, &fdctrl->irq);
>     qdev_init_gpio_in(dev, fdctrl_handle_tc, 1);
>


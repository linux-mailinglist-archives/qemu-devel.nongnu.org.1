Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98E817E57
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 01:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNYe-0002XH-8K; Mon, 18 Dec 2023 19:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNYY-0002WW-09; Mon, 18 Dec 2023 19:01:55 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNYK-0006wE-Pm; Mon, 18 Dec 2023 19:01:53 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 17B7375A4BF;
 Tue, 19 Dec 2023 01:01:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GHhDkfgTMe3p; Tue, 19 Dec 2023 01:01:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2855275A406; Tue, 19 Dec 2023 01:01:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 26119756094;
 Tue, 19 Dec 2023 01:01:34 +0100 (CET)
Date: Tue, 19 Dec 2023 01:01:34 +0100 (CET)
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
Subject: Re: [PATCH v2 04/12] hw/char/parallel: Free struct ParallelState
 from PortioList
In-Reply-To: <20231218185114.119736-5-shentey@gmail.com>
Message-ID: <dbb6af24-9aa0-bf40-38fe-74fec945ab05@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-5-shentey@gmail.com>
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
> ParallelState::portio_list isn't used inside ParallelState context but only
> inside ISAParallelState context, so more it there.

Same comments as for patch 1 otherwise

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/char/parallel-isa.h | 2 ++
> include/hw/char/parallel.h     | 2 --
> hw/char/parallel.c             | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
> index d24ccecf05..3b783bd08d 100644
> --- a/include/hw/char/parallel-isa.h
> +++ b/include/hw/char/parallel-isa.h
> @@ -12,6 +12,7 @@
>
> #include "parallel.h"
>
> +#include "exec/ioport.h"
> #include "hw/isa/isa.h"
> #include "qom/object.h"
>
> @@ -25,6 +26,7 @@ struct ISAParallelState {
>     uint32_t iobase;
>     uint32_t isairq;
>     ParallelState state;
> +    PortioList portio_list;
> };
>
> #endif /* HW_PARALLEL_ISA_H */
> diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
> index 7b5a309a03..cfb97cc7cc 100644
> --- a/include/hw/char/parallel.h
> +++ b/include/hw/char/parallel.h
> @@ -1,7 +1,6 @@
> #ifndef HW_PARALLEL_H
> #define HW_PARALLEL_H
>
> -#include "exec/ioport.h"
> #include "exec/memory.h"
> #include "hw/isa/isa.h"
> #include "hw/irq.h"
> @@ -22,7 +21,6 @@ typedef struct ParallelState {
>     uint32_t last_read_offset; /* For debugging */
>     /* Memory-mapped interface */
>     int it_shift;
> -    PortioList portio_list;
> } ParallelState;
>
> void parallel_hds_isa_init(ISABus *bus, int n);
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 147c900f0d..c1747cbb75 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -532,7 +532,7 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>         s->status = dummy;
>     }
>
> -    isa_register_portio_list(isadev, &s->portio_list, base,
> +    isa_register_portio_list(isadev, &isa->portio_list, base,
>                              (s->hw_driver
>                               ? &isa_parallel_portio_hw_list[0]
>                               : &isa_parallel_portio_sw_list[0]),
>


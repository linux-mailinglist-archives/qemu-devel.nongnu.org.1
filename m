Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B77BC72B208
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 15:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8KvY-0005Xl-7e; Sun, 11 Jun 2023 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8KvT-0005XA-Jf; Sun, 11 Jun 2023 09:16:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8KvR-0001sC-8C; Sun, 11 Jun 2023 09:16:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D474A746335;
 Sun, 11 Jun 2023 15:15:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D15C74632B; Sun, 11 Jun 2023 15:15:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 97506745720;
 Sun, 11 Jun 2023 15:15:58 +0200 (CEST)
Date: Sun, 11 Jun 2023 15:15:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-trivial@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] hw/char/parallel-isa: Export struct ISAParallelState
In-Reply-To: <20230611110008.32638-3-shentey@gmail.com>
Message-ID: <229b5f39-2a3e-e47b-5269-9ae2c43492ae@eik.bme.hu>
References: <20230611110008.32638-1-shentey@gmail.com>
 <20230611110008.32638-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Sun, 11 Jun 2023, Bernhard Beschow wrote:
> Allows the struct to be embedded directly into device models without additional
> allocation.
>
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Patches missing SoB, checkpatch should have cought this.

I don't see any of the machines or device models actually embedding 
ISAParallelState or ParallelState so don't know what this patch is trying 
to achieve. Please post the whole series with the patches that this is a 
preparation for so we can se where this leads.

Regards,
BALATON Zoltan

> ---
> include/hw/char/parallel-isa.h | 46 ++++++++++++++++++++++++++++++++++
> include/hw/char/parallel.h     |  2 --
> hw/char/parallel-isa.c         |  1 +
> hw/char/parallel.c             | 12 +--------
> hw/i386/pc_piix.c              |  2 +-
> hw/i386/pc_q35.c               |  2 +-
> hw/isa/isa-superio.c           |  1 +
> hw/sparc64/sun4u.c             |  2 +-
> 8 files changed, 52 insertions(+), 16 deletions(-)
> create mode 100644 include/hw/char/parallel-isa.h
>
> diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
> new file mode 100644
> index 0000000000..27bdacf1a3
> --- /dev/null
> +++ b/include/hw/char/parallel-isa.h
> @@ -0,0 +1,46 @@
> +/*
> + * QEMU ISA Parallel PORT emulation
> + *
> + * Copyright (c) 2003-2005 Fabrice Bellard
> + * Copyright (c) 2007 Marko Kohtala
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
> +#ifndef HW_PARALLEL_ISA_H
> +#define HW_PARALLEL_ISA_H
> +
> +#include "parallel.h"
> +
> +#include "hw/isa/isa.h"
> +#include "qom/object.h"
> +
> +#define TYPE_ISA_PARALLEL "isa-parallel"
> +OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
> +
> +struct ISAParallelState {
> +    ISADevice parent_obj;
> +
> +    uint32_t index;
> +    uint32_t iobase;
> +    uint32_t isairq;
> +    ParallelState state;
> +};
> +
> +#endif /* HW_PARALLEL_ISA_H */
> diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
> index 9f76edca81..7b5a309a03 100644
> --- a/include/hw/char/parallel.h
> +++ b/include/hw/char/parallel.h
> @@ -25,8 +25,6 @@ typedef struct ParallelState {
>     PortioList portio_list;
> } ParallelState;
>
> -#define TYPE_ISA_PARALLEL "isa-parallel"
> -
> void parallel_hds_isa_init(ISABus *bus, int n);
>
> bool parallel_mm_init(MemoryRegion *address_space,
> diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
> index 547ae69304..ab0f879998 100644
> --- a/hw/char/parallel-isa.c
> +++ b/hw/char/parallel-isa.c
> @@ -13,6 +13,7 @@
> #include "sysemu/sysemu.h"
> #include "hw/isa/isa.h"
> #include "hw/qdev-properties.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/char/parallel.h"
> #include "qapi/error.h"
>
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index e75fc5019d..147c900f0d 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -31,6 +31,7 @@
> #include "hw/qdev-properties.h"
> #include "hw/qdev-properties-system.h"
> #include "migration/vmstate.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/char/parallel.h"
> #include "sysemu/reset.h"
> #include "sysemu/sysemu.h"
> @@ -73,17 +74,6 @@
>
> #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
>
> -OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
> -
> -struct ISAParallelState {
> -    ISADevice parent_obj;
> -
> -    uint32_t index;
> -    uint32_t iobase;
> -    uint32_t isairq;
> -    ParallelState state;
> -};
> -
> static void parallel_update_irq(ParallelState *s)
> {
>     if (s->irq_pending)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 42af03dbb4..44146e6ff5 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -26,7 +26,7 @@
> #include CONFIG_DEVICES
>
> #include "qemu/units.h"
> -#include "hw/char/parallel.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/dma/i8257.h"
> #include "hw/loader.h"
> #include "hw/i386/x86.h"
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6155427e48..a9a59ed42b 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -30,7 +30,7 @@
>
> #include "qemu/osdep.h"
> #include "qemu/units.h"
> -#include "hw/char/parallel.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/loader.h"
> #include "hw/i2c/smbus_eeprom.h"
> #include "hw/rtc/mc146818rtc.h"
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 9292ec3bcf..7dbfc374da 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -21,6 +21,7 @@
> #include "hw/isa/superio.h"
> #include "hw/qdev-properties.h"
> #include "hw/input/i8042.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/char/serial.h"
> #include "trace.h"
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index e2858a0331..29e9b6cc26 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -35,7 +35,7 @@
> #include "hw/qdev-properties.h"
> #include "hw/pci-host/sabre.h"
> #include "hw/char/serial.h"
> -#include "hw/char/parallel.h"
> +#include "hw/char/parallel-isa.h"
> #include "hw/rtc/m48t59.h"
> #include "migration/vmstate.h"
> #include "hw/input/i8042.h"
>


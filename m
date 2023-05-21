Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27E70AE1F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iPe-0001UX-PB; Sun, 21 May 2023 08:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0iPc-0001TK-Dp; Sun, 21 May 2023 08:43:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0iPX-0003yx-Px; Sun, 21 May 2023 08:43:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C02677457E7;
 Sun, 21 May 2023 14:43:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6EB08745706; Sun, 21 May 2023 14:43:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6A6FB7456E3;
 Sun, 21 May 2023 14:43:37 +0200 (CEST)
Date: Sun, 21 May 2023 14:43:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 4/6] hw/char/parallel: Export ParallelState
In-Reply-To: <20230521123049.312349-5-shentey@gmail.com>
Message-ID: <77413450-244e-287b-ad21-e57cb5e2abf5@eik.bme.hu>
References: <20230521123049.312349-1-shentey@gmail.com>
 <20230521123049.312349-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Sun, 21 May 2023, Bernhard Beschow wrote:
> Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL.

This may need a better commit message. It's not a precondition per coding 
standards I think just a preference for allowing embedding the device in 
other devices but otherwise unnecessary. Or at least fix the typo 
"exporing" -> exporting.

Regards,
BALATON Zoltan

> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> include/hw/char/parallel.h | 44 ++++++++++++++++++++++++++++++++++++++
> hw/char/parallel.c         | 42 ------------------------------------
> 2 files changed, 44 insertions(+), 42 deletions(-)
>
> diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
> index 0a23c0f57e..2d4907c1fe 100644
> --- a/include/hw/char/parallel.h
> +++ b/include/hw/char/parallel.h
> @@ -1,9 +1,53 @@
> #ifndef HW_PARALLEL_H
> #define HW_PARALLEL_H
>
> +#include "exec/ioport.h"
> +#include "exec/memory.h"
> #include "hw/isa/isa.h"
> +#include "hw/irq.h"
> +#include "chardev/char-fe.h"
> #include "chardev/char.h"
>
> +/*
> + * These are the definitions for the Printer Status Register
> + */
> +#define PARA_STS_BUSY   0x80    /* Busy complement */
> +#define PARA_STS_ACK    0x40    /* Acknowledge */
> +#define PARA_STS_PAPER  0x20    /* Out of paper */
> +#define PARA_STS_ONLINE 0x10    /* Online */
> +#define PARA_STS_ERROR  0x08    /* Error complement */
> +#define PARA_STS_TMOUT  0x01    /* EPP timeout */
> +
> +/*
> + * These are the definitions for the Printer Control Register
> + */
> +#define PARA_CTR_DIR    0x20    /* Direction (1=read, 0=write) */
> +#define PARA_CTR_INTEN  0x10    /* IRQ Enable */
> +#define PARA_CTR_SELECT 0x08    /* Select In complement */
> +#define PARA_CTR_INIT   0x04    /* Initialize Printer complement */
> +#define PARA_CTR_AUTOLF 0x02    /* Auto linefeed complement */
> +#define PARA_CTR_STROBE 0x01    /* Strobe complement */
> +
> +#define PARA_CTR_SIGNAL (PARA_CTR_SELECT | PARA_CTR_INIT | PARA_CTR_AUTOLF \
> +                         | PARA_CTR_STROBE)
> +
> +typedef struct ParallelState {
> +    MemoryRegion iomem;
> +    uint8_t dataw;
> +    uint8_t datar;
> +    uint8_t status;
> +    uint8_t control;
> +    qemu_irq irq;
> +    int irq_pending;
> +    CharBackend chr;
> +    int hw_driver;
> +    int epp_timeout;
> +    uint32_t last_read_offset; /* For debugging */
> +    /* Memory-mapped interface */
> +    int it_shift;
> +    PortioList portio_list;
> +} ParallelState;
> +
> void parallel_hds_isa_init(ISABus *bus, int n);
>
> bool parallel_mm_init(MemoryRegion *address_space,
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index af551e7864..522301f43a 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -27,10 +27,7 @@
> #include "qapi/error.h"
> #include "qemu/module.h"
> #include "chardev/char-parallel.h"
> -#include "chardev/char-fe.h"
> #include "hw/acpi/acpi_aml_interface.h"
> -#include "hw/irq.h"
> -#include "hw/isa/isa.h"
> #include "hw/qdev-properties.h"
> #include "hw/qdev-properties-system.h"
> #include "migration/vmstate.h"
> @@ -54,45 +51,6 @@
> #define PARA_REG_EPP_ADDR 3
> #define PARA_REG_EPP_DATA 4
>
> -/*
> - * These are the definitions for the Printer Status Register
> - */
> -#define PARA_STS_BUSY   0x80    /* Busy complement */
> -#define PARA_STS_ACK    0x40    /* Acknowledge */
> -#define PARA_STS_PAPER  0x20    /* Out of paper */
> -#define PARA_STS_ONLINE 0x10    /* Online */
> -#define PARA_STS_ERROR  0x08    /* Error complement */
> -#define PARA_STS_TMOUT  0x01    /* EPP timeout */
> -
> -/*
> - * These are the definitions for the Printer Control Register
> - */
> -#define PARA_CTR_DIR    0x20    /* Direction (1=read, 0=write) */
> -#define PARA_CTR_INTEN  0x10    /* IRQ Enable */
> -#define PARA_CTR_SELECT 0x08    /* Select In complement */
> -#define PARA_CTR_INIT   0x04    /* Initialize Printer complement */
> -#define PARA_CTR_AUTOLF 0x02    /* Auto linefeed complement */
> -#define PARA_CTR_STROBE 0x01    /* Strobe complement */
> -
> -#define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
> -
> -typedef struct ParallelState {
> -    MemoryRegion iomem;
> -    uint8_t dataw;
> -    uint8_t datar;
> -    uint8_t status;
> -    uint8_t control;
> -    qemu_irq irq;
> -    int irq_pending;
> -    CharBackend chr;
> -    int hw_driver;
> -    int epp_timeout;
> -    uint32_t last_read_offset; /* For debugging */
> -    /* Memory-mapped interface */
> -    int it_shift;
> -    PortioList portio_list;
> -} ParallelState;
> -
> #define TYPE_ISA_PARALLEL "isa-parallel"
> OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
>
>


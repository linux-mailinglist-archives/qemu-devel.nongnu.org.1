Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AE70AE70
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0khU-00061z-7I; Sun, 21 May 2023 11:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0khQ-00060q-VP; Sun, 21 May 2023 11:10:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0khO-000799-VQ; Sun, 21 May 2023 11:10:20 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F233B7466FF;
 Sun, 21 May 2023 17:09:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B81DE746392; Sun, 21 May 2023 17:09:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B5D8574634B;
 Sun, 21 May 2023 17:09:49 +0200 (CEST)
Date: Sun, 21 May 2023 17:09:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/6] hw/ide/via: Wire up IDE legacy interrupts in host
 device
In-Reply-To: <20230521111534.207973-3-shentey@gmail.com>
Message-ID: <c494dd45-4fef-858f-c26d-5dfa56d6ec29@eik.bme.hu>
References: <20230521111534.207973-1-shentey@gmail.com>
 <20230521111534.207973-3-shentey@gmail.com>
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
> Resolves circular depencency between IDE function and south bridge.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/ide/via.c      | 6 ++++--
> hw/isa/vt82c686.c | 5 +++++
> 2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 177baea9a7..0caae52276 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -31,6 +31,7 @@
> #include "sysemu/dma.h"
> #include "hw/isa/vt82c686.h"
> #include "hw/ide/pci.h"
> +#include "hw/irq.h"
> #include "trace.h"
>
> static uint64_t bmdma_read(void *opaque, hwaddr addr,
> @@ -104,7 +105,8 @@ static void bmdma_setup_bar(PCIIDEState *d)
>
> static void via_ide_set_irq(void *opaque, int n, int level)
> {
> -    PCIDevice *d = PCI_DEVICE(opaque);
> +    PCIIDEState *s = opaque;
> +    PCIDevice *d = PCI_DEVICE(s);

These are the same structure so can be cast into each other but for 
consistency it's better to also change

qdev_init_gpio_in(ds, via_ide_set_irq, ARRAY_SIZE(d->bus));

to pass the PCIIDEState so d instead of ds in via_ide_realize().

Regards,
BALATON Zoltan

>     if (level) {
>         d->config[0x70 + n * 8] |= 0x80;
> @@ -112,7 +114,7 @@ static void via_ide_set_irq(void *opaque, int n, int level)
>         d->config[0x70 + n * 8] &= ~0x80;
>     }
>
> -    via_isa_set_irq(pci_get_function_0(d), 14 + n, level);
> +    qemu_set_irq(s->isa_irq[n], level);
> }
>
> static void via_ide_reset(DeviceState *dev)
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index ca89119ce0..8016c71315 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -692,6 +692,10 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
>     if (!qdev_realize(DEVICE(&s->ide), BUS(pci_bus), errp)) {
>         return;
>     }
> +    for (i = 0; i < 2; i++) {
> +        qdev_connect_gpio_out_named(DEVICE(&s->ide), "isa-irq", i,
> +                                    s->isa_irqs_in[14 + i]);
> +    }
>
>     /* Functions 2-3: USB Ports */
>     for (i = 0; i < ARRAY_SIZE(s->uhci); i++) {
> @@ -814,6 +818,7 @@ static void vt8231_isa_reset(DeviceState *dev)
>                  PCI_COMMAND_MASTER | PCI_COMMAND_SPECIAL);
>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_DEVSEL_MEDIUM);
>
> +    pci_conf[0x4c] = 0x04; /* IDE interrupt Routing */
>     pci_conf[0x58] = 0x40; /* Miscellaneous Control 0 */
>     pci_conf[0x67] = 0x08; /* Fast IR Config */
>     pci_conf[0x6b] = 0x01; /* Fast IR I/O Base */
>


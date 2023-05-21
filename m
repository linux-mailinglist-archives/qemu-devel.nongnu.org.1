Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D870AE92
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kyH-0006zB-G4; Sun, 21 May 2023 11:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0kyE-0006yY-6p; Sun, 21 May 2023 11:27:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0kyB-0001Ul-IV; Sun, 21 May 2023 11:27:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C07C674634B;
 Sun, 21 May 2023 17:27:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8A7C37462DB; Sun, 21 May 2023 17:27:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 889CD7457E7;
 Sun, 21 May 2023 17:27:37 +0200 (CEST)
Date: Sun, 21 May 2023 17:27:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/6] hw/ide/via: Wire up IDE legacy interrupts in host
 device
In-Reply-To: <c494dd45-4fef-858f-c26d-5dfa56d6ec29@eik.bme.hu>
Message-ID: <1486b877-3aef-7771-2612-e06034645e68@eik.bme.hu>
References: <20230521111534.207973-1-shentey@gmail.com>
 <20230521111534.207973-3-shentey@gmail.com>
 <c494dd45-4fef-858f-c26d-5dfa56d6ec29@eik.bme.hu>
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

On Sun, 21 May 2023, BALATON Zoltan wrote:
> On Sun, 21 May 2023, Bernhard Beschow wrote:
>> Resolves circular depencency between IDE function and south bridge.
>> 
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ide/via.c      | 6 ++++--
>> hw/isa/vt82c686.c | 5 +++++
>> 2 files changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index 177baea9a7..0caae52276 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -31,6 +31,7 @@
>> #include "sysemu/dma.h"
>> #include "hw/isa/vt82c686.h"
>> #include "hw/ide/pci.h"
>> +#include "hw/irq.h"
>> #include "trace.h"
>> 
>> static uint64_t bmdma_read(void *opaque, hwaddr addr,
>> @@ -104,7 +105,8 @@ static void bmdma_setup_bar(PCIIDEState *d)
>> 
>> static void via_ide_set_irq(void *opaque, int n, int level)
>> {
>> -    PCIDevice *d = PCI_DEVICE(opaque);
>> +    PCIIDEState *s = opaque;
>> +    PCIDevice *d = PCI_DEVICE(s);
>
> These are the same structure so can be cast into each other but for 
> consistency it's better to also change
>
> qdev_init_gpio_in(ds, via_ide_set_irq, ARRAY_SIZE(d->bus));
>
> to pass the PCIIDEState so d instead of ds in via_ide_realize().

Ignore this. That function takes a DeviceState and seems no separate 
argument for the opaque pointer so no change is needed.

Regards,
BALATON Zoltan


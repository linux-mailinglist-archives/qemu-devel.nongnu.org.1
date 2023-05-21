Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89B70AE89
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 17:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kul-0005no-K5; Sun, 21 May 2023 11:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0kue-0005k1-UE; Sun, 21 May 2023 11:24:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0kud-0000uZ-3F; Sun, 21 May 2023 11:24:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4500B745712;
 Sun, 21 May 2023 17:23:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0FF3F745706; Sun, 21 May 2023 17:23:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0DD9A7456E3;
 Sun, 21 May 2023 17:23:56 +0200 (CEST)
Date: Sun, 21 May 2023 17:23:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 6/6] hw/ide/piix: Move registration of VMStateDescription
 to DeviceClass
In-Reply-To: <20230521111534.207973-7-shentey@gmail.com>
Message-ID: <c147aa70-daeb-dd6b-8ea8-715866c98e66@eik.bme.hu>
References: <20230521111534.207973-1-shentey@gmail.com>
 <20230521111534.207973-7-shentey@gmail.com>
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
> The modern, declarative way to set up VM state handling is to assign to
> DeviceClass::vmsd attribute.
>
> There shouldn't be any change in behavior since dc->vmsd causes
> vmstate_register_with_alias_id() to be called on the instance during
> the instance init phase. vmstate_register() was also called during the
> instance init phase which forwards to vmstate_register_with_alias_id()
> internally. Checking the migration schema before and after this patch confirms:
>
> before:
>> qemu-system-x86_64 -S
>> qemu > migrate -d exec:cat>before.mig
>
> after:
>> qemu-system-x86_64 -S
>> qemu > migrate -d exec:cat>after.mig
>
>> analyze-migration.py -d desc -f before.mig > before.json
>> analyze-migration.py -d desc -f after.mig > after.json
>> diff before.json after.json
> -> empty

Missing Signed-off-by line.

Regards,
BALATON Zoltah

> ---
> hw/ide/piix.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 47e0b474c3..151f206046 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -28,7 +28,6 @@
>  */
>
> #include "qemu/osdep.h"
> -#include "migration/vmstate.h"
> #include "qapi/error.h"
> #include "hw/pci/pci.h"
> #include "hw/ide/piix.h"
> @@ -159,8 +158,6 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
>     bmdma_setup_bar(d);
>     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>
> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> -
>     for (unsigned i = 0; i < 2; i++) {
>         if (!pci_piix_init_bus(d, i, errp)) {
>             return;
> @@ -186,6 +183,7 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
>     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>
>     dc->reset = piix_ide_reset;
> +    dc->vmsd = &vmstate_ide_pci;
>     k->realize = pci_piix_ide_realize;
>     k->exit = pci_piix_ide_exitfn;
>     k->vendor_id = PCI_VENDOR_ID_INTEL;
> @@ -208,6 +206,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
>     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>
>     dc->reset = piix_ide_reset;
> +    dc->vmsd = &vmstate_ide_pci;
>     k->realize = pci_piix_ide_realize;
>     k->exit = pci_piix_ide_exitfn;
>     k->vendor_id = PCI_VENDOR_ID_INTEL;
>



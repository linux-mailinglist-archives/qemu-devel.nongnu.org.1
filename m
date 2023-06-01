Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49542719C18
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hOC-0002O3-Pw; Thu, 01 Jun 2023 08:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hOA-0002L2-4X; Thu, 01 Jun 2023 08:26:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hO8-0001Iw-BY; Thu, 01 Jun 2023 08:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XjebpvKdCmosHLZZ/q4ifLbxq6eCYwbT+mgk90aja7A=; b=M4qVzlOUe2dcq383yo39wo4MSH
 Bee7RG50prWSrFF9sl/NpgbO/HvhzRDjZbHnpxGy/f7T2akC2fSp7b2pseHM0jphAPW4KFXfpsVcj
 UHpdklc1RM2YlvUiaulQX7HDPOD7G5NyJaEJzxp+o8FgEgcxek+oJrZyqoM6eh7j3L17bSZLVBalW
 OXvx0SmWkWPka3aPZ43/n0WvJrGqidHZFixsmqoCAUV8T8f+PKcaNl1zCe1Rv7Q3l4KORwzPj8kR8
 BAvbidocS6YNaE38SE/EkwFaEFsysKz0+3oisYaJlZYFUcQ3Py2C1zSMhpLpd+jPG13ZN1/XkxGR+
 Me/IwLuYjYXtWHSjfzkU5GpI7iWPm5Rl12DFl3rY2cUGGH+k3JLvH39AYktf3/7a3jvCgkzrVYglD
 W3lbUXyklJYQX5VggAmzL+HVhGTOHMddS05wPySlRO8MVv1088kuvpo/Vc4k9SCh1iDv1KZVcaAsC
 qzs7d6cPyRuEnaK/mX4tw1RXf77c/gJE0tgZRCY2qcqmYRglFD7STuWF8XAm+LCDn6PQE4WHoL0CM
 TtYINaxYOiuy2vYPY8T4gGPKyGRAYFx1z62qa31IKhk6JVr4EpTA8dCEDSngOVX+Y0dgbdQbaStnc
 dcPbfqg/jg1MJEpsL6WUoAsQ2kVptLVo6F2Eu19Ng=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hNq-0006BW-5x; Thu, 01 Jun 2023 13:26:30 +0100
Message-ID: <61c5b391-aaf1-dc60-6480-6361b9d7e8b6@ilande.co.uk>
Date: Thu, 1 Jun 2023 13:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230531211043.41724-1-shentey@gmail.com>
 <20230531211043.41724-8-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230531211043.41724-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 7/7] hw/ide/piix: Move registration of
 VMStateDescription to DeviceClass
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 22:10, Bernhard Beschow wrote:

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
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/piix.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 47e0b474c3..151f206046 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -28,7 +28,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "migration/vmstate.h"
>   #include "qapi/error.h"
>   #include "hw/pci/pci.h"
>   #include "hw/ide/piix.h"
> @@ -159,8 +158,6 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
>       bmdma_setup_bar(d);
>       pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>   
> -    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
> -
>       for (unsigned i = 0; i < 2; i++) {
>           if (!pci_piix_init_bus(d, i, errp)) {
>               return;
> @@ -186,6 +183,7 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
>       dc->reset = piix_ide_reset;
> +    dc->vmsd = &vmstate_ide_pci;
>       k->realize = pci_piix_ide_realize;
>       k->exit = pci_piix_ide_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_INTEL;
> @@ -208,6 +206,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>   
>       dc->reset = piix_ide_reset;
> +    dc->vmsd = &vmstate_ide_pci;
>       k->realize = pci_piix_ide_realize;
>       k->exit = pci_piix_ide_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_INTEL;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.



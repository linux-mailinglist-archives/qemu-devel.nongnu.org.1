Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7B7D5E8F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 01:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvQUH-0003Gk-MH; Tue, 24 Oct 2023 19:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvQUE-0003Cr-MI; Tue, 24 Oct 2023 19:06:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvQU4-0006Ns-M2; Tue, 24 Oct 2023 19:06:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A578875606C;
 Wed, 25 Oct 2023 01:06:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6E8AF756066; Wed, 25 Oct 2023 01:06:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6C9067456A7;
 Wed, 25 Oct 2023 01:06:43 +0200 (CEST)
Date: Wed, 25 Oct 2023 01:06:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v2 2/3] ide/via: don't attempt to set default BAR addresses
In-Reply-To: <20231024224056.842607-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <725f3192-cfcc-40a8-f185-c566c88eca4e@eik.bme.hu>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 24 Oct 2023, Mark Cave-Ayland wrote:
> The via-ide device currently attempts to set the default BAR addresses to the
> values shown in the datasheet, but this doesn't work for 2 reasons: firstly
> BARS 1-4 do not set the bottom 2 bits to PCI_BASE_ADDRESS_SPACE_IO, and
> secondly the initial PCI bus reset clears the values of all PCI device BARs
> after the device itself has been reset.
>
> Remove the setting of the default BAR addresses from via_ide_reset() to ensure
> there is no doubt that these values are never exposed to the guest.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>

this was taken from my original patch so I could also add R-b but being in 
two tags already is enough so let others listed if they want :-)

Regards,
BALATON Zoltan

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ide/via.c | 5 -----
> 1 file changed, 5 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..87b134083a 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
>     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>                  PCI_STATUS_DEVSEL_MEDIUM);
>
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>     pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>
>     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F37CFD41
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUKk-0000D1-MR; Thu, 19 Oct 2023 10:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtUKd-0008RL-UI; Thu, 19 Oct 2023 10:49:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtUKb-0004gh-Aw; Thu, 19 Oct 2023 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mTZh42gBu9PiaUAQ9IMgdlrfa7mUBT2QnywSD4ZJ7eE=; b=XMW6BW+mDYZSRBf5f6ixIL9Lja
 bFkBKUSgJQTJhcVZPeCx6ZeLmrIw+s9mXPO+Dlyf02RrJ1AU8TcKYJdaZElkdmuAGkYZoYVqLDcY7
 fGfWaiVsvgKfoWMR3xB+ssb7P3sZk555RbL+NDVmmH6890qDuf7Zdg7C5ACa4w5JYcnDr/nez9jGL
 fL5vuL3pVgZG7UsgbJKudwd9O2KBIl7EnFlhuyw2IKSPtq9PesyzekyMxyzR+FA42KmOhMgeSROxt
 r/kq48qM0gTRFfA9P28EDe0tmxk8wDoWtSjyNg2MMBdi7SEooPaKn5cXgKmMyJygPKeMYBLWSufhE
 h3Zy6HDwX8F3hQDR6LKEMPvuP+7cO1wAItaIpWKMDVGLmt5NP1N+/laFw2avoIp8MFbqMisTVOIUp
 LjmO3hXOcRdWl3NeSRA0zCMrFNQniONt0/umugzjvsb/C3kv0RSzkND6LQHg40dhiHaiyyRb/fz3U
 UMF7pwM54q87cFDkE2iya5bLfY4aG49Ia4Bxd2naa8vUXEcb17hqW4kJGJnLn+eZJzjVLLrnp3BOq
 s7FQg5xDi3r0UAWmBp10wOPqIswobufEryi3wkcv+ZKkD9rMdBu+2VDGk0I/ho//hTnKYS/nHnM9A
 w4F7uFVqZGIl8x8KY7/sXBQ3Qd8rIfEw3DFLveDi4=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtUKO-0007iu-Oh; Thu, 19 Oct 2023 15:48:52 +0100
Message-ID: <e546b970-5a06-4e23-a91f-5e912a0e539f@ilande.co.uk>
Date: Thu, 19 Oct 2023 15:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1697661160.git.balaton@eik.bme.hu>
 <4095e01f4596e77a478759161ae736f0c398600a.1697661160.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <4095e01f4596e77a478759161ae736f0c398600a.1697661160.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 1/4] via-ide: Fix legacy mode emulation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 18/10/2023 21:42, BALATON Zoltan wrote:

> The initial value for BARs were set in reset method for emulating
> legacy mode at start but this does not work because PCI code resets
> BARs after calling device reset method. Remove this ineffective
> default to avoid confusion.
> 
> Instead move setting the BARs to a callback on writing the PCI config
> regsiter that sets legacy mode (which firmwares needing this mode seem
> to do). This does not fully emulate what the data sheet says (which is
> not very clear on this) but it implements enough to allow both modes
> as used by firmwares and guests on machines we emulate.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/via.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..5a1fe38fb8 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -28,6 +28,7 @@
>   #include "hw/pci/pci.h"
>   #include "migration/vmstate.h"
>   #include "qemu/module.h"
> +#include "qemu/range.h"
>   #include "sysemu/dma.h"
>   #include "hw/isa/vt82c686.h"
>   #include "hw/ide/pci.h"
> @@ -132,11 +133,6 @@ static void via_ide_reset(DeviceState *dev)
>       pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>                    PCI_STATUS_DEVSEL_MEDIUM);
>   
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
> -    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
>       pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
>   
>       /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
> @@ -159,6 +155,42 @@ static void via_ide_reset(DeviceState *dev)
>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>   }
>   
> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
> +                              uint32_t val, int len)
> +{
> +    pci_default_write_config(pd, addr, val, len);
> +    /*
> +     * Bits 0 and 2 of the PCI programming interface register are documented to
> +     * select between legacy and native mode for the two IDE channels. when the
> +     * guest selects legacy mode we reset the PCI BARs to legacy ports which is
> +     * their default value. We don't care about setting each channel separately
> +     * as no guest is known to do or need that. But only do this when BARs are
> +     * unset when writing this register as logs from real hardware show that
> +     * setting legacy mode after BARs were set will still use ports set by BARs
> +     * not ISA ports (Linux on pegasos2 does this after firmware set native
> +     * mode and programmed BARs). If 0x8a is written after reset without
> +     * setting BARs then we want legacy ports (this is done by the AmigaOne
> +     * firmware). We can't set these in via_ide_reset() because PCI code clears
> +     * BARs after calling device reset method.
> +     */
> +    if (range_covers_byte(addr, len, PCI_CLASS_PROG) &&
> +        pd->config[PCI_CLASS_PROG] == 0x8a &&
> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
> +        PCI_BASE_ADDRESS_SPACE_IO) {
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f4
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x374
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        /* BMIBA: 20-23h */
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +    }
> +}
> +
>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>   {
>       PCIIDEState *d = PCI_IDE(dev);
> @@ -221,6 +253,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>       /* Reason: only works as function of VIA southbridge */
>       dc->user_creatable = false;
>   
> +    k->config_write = via_ide_cfg_write;
>       k->realize = via_ide_realize;
>       k->exit = via_ide_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_VIA;

As promised I've posted an updated version of the proposed patch which better matches 
the hardware (and is also less invasive to hw/ide/via.c) at 
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg06416.html.


ATB,

Mark.



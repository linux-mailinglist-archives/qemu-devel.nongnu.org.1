Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 766837BCC88
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpN31-00037G-HI; Sun, 08 Oct 2023 02:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN30-00036l-8V; Sun, 08 Oct 2023 02:13:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN2y-0004DN-2B; Sun, 08 Oct 2023 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dLug/4cI8lItuCgbp6c8bCgCHMRsN8n5vKycFVr8nUQ=; b=c1Zez8gzarDyBHJ4SUytnLAS/+
 p+Nd1E/byETPowbuLcid4MKSYGzjcnKl04ryiyMhVKvLM34qR0BkCsvrM/NctO+VPSa94opFnuMQo
 UlfeBrGt06ztDEn8Ns7d8DT1VGyACkzg0KQ5l9Y2bAnQILSphjdRh+90CZYRUBZf5Z6RvaSpXpTFh
 40pNPDOdoe0W6sRnPYG+En3auqz0l/RWDodvHFAxWz7jGhX+JxEkotF//Sr2YyAGKXcuGiA7nw1V0
 AJtl3Zfz61AF5BDb+eoGxCGxGglBdL2B5SBmhR+klcy8BlkVyd0rcfYcbsV3VNsiIDnpIGuuJjyfK
 WOX5hbd0+UtMsIYmeIe+DM8eWL/4jzx42tggtMisDEZshNkf1v3icqGufjhHiRYTDc4olvlPcXra/
 txl+ZP8Sfas2xXcHOhYJ2i7BgO9gI8RMZgdvA06CLDT1gG7tCsUXqdPweYcPe+SjclgtGgX8+vIj2
 hvhWNPd4Dxpjmll5vHtFmvqg0gtHZO5YBKqL223W5Msz3vwRjlmPnr8jJAhQWZx/55VElpHiX0LqD
 DVO60Vef81+7de5clh/rqjzxhVtk4rJoLUCPUFHFADdsXiLcl7trbG1G9XtoUZ9rVC0XrGLCWHKM9
 QwNq3Q0LwT9Suisjo8AdbCoRZzDySV8VsmwFMDOAU=;
Received: from [2a00:23c4:8baf:fd00:4803:92c1:9dc8:9255]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qpN2c-0006GW-MY; Sun, 08 Oct 2023 07:13:30 +0100
Message-ID: <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
Date: Sun, 8 Oct 2023 07:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
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
In-Reply-To: <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:4803:92c1:9dc8:9255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
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

On 05/10/2023 23:13, BALATON Zoltan wrote:

> The initial value for BARs were set in reset method for emulating
> legacy mode at start but this does not work because PCI code resets
> BARs after calling device reset method.

This is certainly something I've noticed when testing previous versions of the VIA 
patches. Perhaps it's worth a separate thread to the PCI devs?

> Additionally the values
> written to BARs were also wrong.

I don't believe this is correct: according to the datasheet the values on reset are 
the ones given in the current reset code, so even if the reset function is overridden 
at a later data during PCI bus reset, I would leave these for now since it is a 
different issue.

> Move setting the BARs to a callback on writing the PCI config regsiter
> that sets the compatibility mode (which firmwares needing this mode
> seem to do) and fix their values to program it to use legacy port
> numbers. As noted in a comment, we only do this when the BARs were
> unset before, because logs from real machine show this is how real
> chip works, even if it contradicts the data sheet which is not very
> clear about this.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ide/via.c | 35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..8186190207 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
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
> @@ -159,6 +154,35 @@ static void via_ide_reset(DeviceState *dev)
>       pci_set_long(pci_conf + 0xc0, 0x00020001);
>   }
>   
> +static void via_ide_cfg_write(PCIDevice *pd, uint32_t addr,
> +                              uint32_t val, int len)
> +{
> +    pci_default_write_config(pd, addr, val, len);
> +    /*
> +     * Only set BARs if they are unset. Logs from real hardware show that
> +     * writing class_prog to enable compatibility mode after BARs were set
> +     * (possibly by firmware) it will use ports set by BARs not ISA ports
> +     * (e.g. pegasos2 Linux does this and calls it non-100% native mode).

Can you remind me again where the references are to non-100% native mode? The only 
thing I can find in Linux is 
https://github.com/torvalds/linux/blob/master/arch/powerpc/platforms/chrp/pci.c#L360 
but that simply forces a switch to legacy mode, with no mention of "non-100% native 
mode".

> +     * But if 0x8a is written after reset without setting BARs then we want
> +     * legacy ports (this is done by AmigaOne firmware for example).
> +     */

What should happen here is that writing 0x8a should *always* switch to legacy mode, 
so the BARs are unused...

> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
> +        pci_get_long(pd->config + PCI_BASE_ADDRESS_0) ==
> +        PCI_BASE_ADDRESS_SPACE_IO) {
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_0, 0x1f0
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_1, 0x3f6
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_2, 0x170
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_3, 0x376
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +        /* BMIBA: 20-23h */
> +        pci_set_long(pd->config + PCI_BASE_ADDRESS_4, 0xcc00
> +                     | PCI_BASE_ADDRESS_SPACE_IO);
> +    }
> +}

... but what you're doing here is effectively forcing the PCI BARs to the legacy 
addresses. The reason we know this is because that is why you have the off-by-2 error 
in BARs 1 and 3.

I could live with this approach for now if you're willing to adjust the comments 
accordingly clarifying that forcing the PCI BARs to the legacy addresses is a hack to 
be replaced in future with proper legacy ioports. At some point I will revive my PoC 
series on top of Bernhard's last series that implements this properly.

>   static void via_ide_realize(PCIDevice *dev, Error **errp)
>   {
>       PCIIDEState *d = PCI_IDE(dev);
> @@ -221,6 +245,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>       /* Reason: only works as function of VIA southbridge */
>       dc->user_creatable = false;
>   
> +    k->config_write = via_ide_cfg_write;
>       k->realize = via_ide_realize;
>       k->exit = via_ide_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_VIA;


ATB,

Mark.



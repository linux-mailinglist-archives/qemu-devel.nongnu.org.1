Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56B7C9958
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1jb-0004St-GW; Sun, 15 Oct 2023 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1jI-0003qp-J0; Sun, 15 Oct 2023 10:04:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1jG-0007zk-9y; Sun, 15 Oct 2023 10:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ACPThqNBf5uWQfXuWQhWKQ7Kr7UZQSTKdnHHK2jKJs=; b=WvOPKhmPHqmLTHCS5s04dsPZtE
 QeEYe7X6wwT7f8PG9fczQIFzksc5g885cSNBmxAMj4DoBdEL/3+Vqoyb6ZqtRW3xw7LBHTdOKT/Kh
 pFqxWuj53QDv8E/gmSvFye0EVAI4d3w/DEIl+ACBI6BQjXNl1hiT76SNxKKvnQYkKqn0HJVzhdz4W
 ig6moX/9Eol9Ok8SpbnYqKT0swLLAFO6APe5ewEp494qNMhaCImN5QEtbLvN7abNByAL9UJw5jd4T
 HOR5oZej7W+gvgureU5PC2xfbknv6ldumAkTugwn7D9xwbeRyT2ilVWIEzXmRV/s8IQYqLXKmF+OG
 Aan6O2VAU/Ga2JE44J/IOX5q/LYbUQoFDPLRawGYiSjsHB44k3xDrJ4cS/cGe+xSBX8yBS4PHC5Z0
 pDUTZHhXTElxX6hhaxN9blsWvt/G5gEM1Q6xewl5g9p9ZM00hGdk3AqJ8LlGNSPs+1rBB05vs2w55
 DeEcJTtQu6uOZS5gxBLAkIZ8PtnukeqOhfj6v/IgQYAMpVqGje3Y9yWR/dWZdFVlfsumiOW3wP/X8
 eKKGxRimfJkqiPO2ttHlB6Zepfb0KgWSaZE0YxNwBZjwaTlssjf9lJ/YpJQwnV1Q3EC2UiS3QfNW7
 68SzYF6ilvuixr3LQZ70X6H6RxSLj+7kBzrqp+N7M=;
Received: from [2a00:23c4:8baf:fd00:5a49:1ad5:2df1:f854]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qs1j6-0005zw-1w; Sun, 15 Oct 2023 15:04:20 +0100
Message-ID: <ad77e177-68d7-41ba-a6aa-4992901c3234@ilande.co.uk>
Date: Sun, 15 Oct 2023 15:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1697311794.git.balaton@eik.bme.hu>
 <fa36d172b87b46cd72011def14afb15b1e0d4572.1697311794.git.balaton@eik.bme.hu>
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
In-Reply-To: <fa36d172b87b46cd72011def14afb15b1e0d4572.1697311794.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:fd00:5a49:1ad5:2df1:f854
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 1/3] via-ide: Fix legacy mode emulation
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

On 14/10/2023 20:37, BALATON Zoltan wrote:

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
>   hw/ide/via.c | 41 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index fff23803a6..ca9a3b8f49 100644
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
> @@ -159,6 +154,41 @@ static void via_ide_reset(DeviceState *dev)
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
> +     * as no guest is known to do or need that. Also only do this when BARs are
> +     * unset when writing this register as logs from real hardware show that
> +     * setting legacy mode after BARs were set will still use ports set by BARs
> +     * not ISA ports (e.g. pegasos2 Linux does this after firmware set native
> +     * mode and programmed BARs). But if 0x8a is written righr after reset
> +     * without setting BARs then we want legacy ports (this is done by the
> +     * AmigaOne firmware). We can't set these in via_ide_reset() because PCI
> +     * code clears BARs after calling device reset method.
> +     */
> +    if (addr == PCI_CLASS_PROG && val == 0x8a &&
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
> @@ -221,6 +251,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>       /* Reason: only works as function of VIA southbridge */
>       dc->user_creatable = false;
>   
> +    k->config_write = via_ide_cfg_write;
>       k->realize = via_ide_realize;
>       k->exit = via_ide_exitfn;
>       k->vendor_id = PCI_VENDOR_ID_VIA;

Just posting the references to the v2 thread with the portio_list*() PoC explaining 
how this better models real hardware and how it forms the basis of future 
improvements so it can be found against v3 in Patchew:

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04448.html
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04449.html


ATB,

Mark.



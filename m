Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1260BB86C74
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 21:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKgC-0001OK-S1; Thu, 18 Sep 2025 15:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKg5-0001N3-Jh; Thu, 18 Sep 2025 15:52:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKg3-00077l-CN; Thu, 18 Sep 2025 15:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=52Dp6fS6t4QiReIjzX/ch/+RBHalSkw9EP2by5bkJ48=; b=VtR+r2zYL9ONPAaXOtQ3Yp+nFd
 mcCtOfk94HUh+I+y2XXZrwe1GuGHwR9WAPb6XIu7f18zJMSMxo8uJXn/+o6ThKHVrNbo9UxsQJ6KD
 0qQfWSyqqdy7U9FDHn5YHiZBwi+qpGhT45jX1H+XzXhoNJKzv+mxeiVvu7y6fljd33vIzwjBu9yhu
 P5+KYSyHg82oFlLrK+UiT6q9TvGDPk6rf7I5K3MkQI4lYcI6tlws6qSpmq7aEJv9jw+d8rYQJZr5f
 6iWx5qEfPw+gBgGS4kqVuuCr8aC5y8XmbI7OjqVOJQ3osmKXoJN49+B7APitt+dVsucWLYWcNDQao
 JN7/z2pa/Vrp38xT6GD9XBRbmKD/Xfp7cGQEhN80/WEKRbVO07zXQNs4ccy0/x6ef4F3eI7rLsqC0
 54GMFZqwKkxYfXe/J7jUVpXusOzP9g3ybVMQnVlfZN4UNMO5qDzEeoOLjnUBV1AWy+yxt16Q4Pe0k
 EqyLWZthzk7pmsjGlowG7hhZ5lIeprDwNCfVJPRUDf6DQYYKtVfTxSs5GIFg8hHqMCD6jXg1AdKUz
 mKo/05bDMqZ45g62SOCRHqW04mUwlJvdTOlfziKtIsXocYdU6uiu6HY1DUFJF5Cuo34SBl5bKLLK4
 w1Mwk6bp/klKWgaeewY/VeUqiCCWarD3+7Rqi60Tw=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKe1-0006UQ-3W; Thu, 18 Sep 2025 20:50:17 +0100
Message-ID: <fa60c6a1-8ab8-4fd9-b04b-9e06a4ee3b73@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <b5b4558125e2408ded29f7cdc306011358829044.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <b5b4558125e2408ded29f7cdc306011358829044.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 08/14] hw/pci-host/raven: Use correct parameter in
 direct access ops
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

On 18/09/2025 19:50, BALATON Zoltan wrote:

> Instead of passing unneeded enclosing objects to the config direct
> access ops that only need the bus we can pass that directly thus
> simplifying the functions.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/raven.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index d7a0bde382..2057a1869f 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -65,16 +65,16 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>   static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
>                                 unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
> +    PCIBus *hbus = opaque;
> +
> +    pci_data_write(hbus, raven_idsel_to_addr(addr), val, size);
>   }
>   
>   static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
>   {
> -    PREPPCIState *s = opaque;
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
> +    PCIBus *hbus = opaque;
> +
> +    return pci_data_read(hbus, raven_idsel_to_addr(addr), size);
>   }
>   
>   static const MemoryRegionOps raven_mmcfg_ops = {
> @@ -233,7 +233,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
> -    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
> +    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
>                             "pci-mmcfg", 0x00400000);
>       memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);

I find this confusing as a reviewer since the general expectation is that the device 
is passed as the opaque for the memory region rather than the bus. What is the reason 
for trying to change an existing convention here?

You could simplify what is there by dropping the PREPPCIState reference and simply doing:

   static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
   {
      PCIHostState *phb = PCI_HOST_BRIDGE(opaque);
      return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
   }

etc.


ATB,

Mark.



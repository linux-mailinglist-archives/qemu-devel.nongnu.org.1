Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FEB86BC8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Sep 2025 21:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKXn-0006Ts-Ss; Thu, 18 Sep 2025 15:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKXl-0006Te-K3; Thu, 18 Sep 2025 15:43:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKXj-0005Wx-P1; Thu, 18 Sep 2025 15:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=T08usq3jL6lv8gdOD8m6fY4Q7JuUtg13cFGSH3vLfAI=; b=fKqBUNdGeN9Pf41jtnGPV5bwar
 nYx8gwULDUZ72MZZCipylj9bmx046Hh3jgxTsY6iUjFxXmrkCq0ikXqsWTZPxDcg0f1FSxZR8I14X
 3tgPhKTH+T2y1zLSPY0nnMNIV1QLSPRnOsBszWU/8I0yXMWpOSSuVSBxWW/f/qsWjKXMcexCRS74h
 UN8H2IZJ2uZM5Lt6OhdjTzDPBxOPA1QWltTT+AMXFkqDsDLjeDGjqio0OVCN/ffkdRn+m/0RvOtwt
 uavB5elb27N7cYY7SEUYJn/RLdsD3MANOl9kHbrljpCpTGfbVvtpGofr1/RRoc/JL6mBr9LTpVvX1
 YLh7EYk16QxtdgxVJQDpdiMvXR83x+neOq4YGMRdPd9NoYl/xcw2Zv9gGkFxUX1cPKJOe++hQdWEr
 pXpvarzhv3CTiEjJTlbO1zqqDVX+u0323Xryl6nJRBHT7jAcDzplsFtzlsNOo87mb7lpSQexYFVH4
 t5FkTxu0bTG0HbFFVgEiQNmY0Vr1Rct7QjWIZtmtoGFZgRUrOLh2gMan9QzdNbx/yaz1ktl+XZL/7
 yGa8SgDHuFEVZdYJnJQj3otZf6D+gNRBG5BZvNAhzX7NdCD/mzcKrFF7/Kquor8Pgj1DfPsf1QRYX
 ZlFohofG5jMH3GY4hKseBmvoUfxjRDsdzdGIUiwPk=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKVf-0006Px-3s; Thu, 18 Sep 2025 20:41:43 +0100
Message-ID: <b2dbac9c-60a0-41f8-8359-426557e87cff@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <2d0d90d16bb02cb9c0606ca8690cf22d296f982c.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <2d0d90d16bb02cb9c0606ca8690cf22d296f982c.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 06/14] hw/pci-host/raven: Simplify direct config access
 address decoding
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

> Use ctz instead of an open coded version and rename function to better
> show what it does.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index a400a22df3..66dab28a29 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -57,16 +57,9 @@ struct PREPPCIState {
>   
>   #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
>   
> -static inline uint32_t raven_pci_io_config(hwaddr addr)
> +static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>   {
> -    int i;
> -
> -    for (i = 0; i < 11; i++) {
> -        if ((addr & (1 << (11 + i))) != 0) {
> -            break;
> -        }
> -    }
> -    return (addr & 0x7ff) |  (i << 11);
> +    return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
>   }

This looks like a good rework of the logic.

>   static void raven_pci_io_write(void *opaque, hwaddr addr,
> @@ -74,7 +67,7 @@ static void raven_pci_io_write(void *opaque, hwaddr addr,
>   {
>       PREPPCIState *s = opaque;
>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    pci_data_write(phb->bus, raven_pci_io_config(addr), val, size);
> +    pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
>   }
>   
>   static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
> @@ -82,7 +75,7 @@ static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
>   {
>       PREPPCIState *s = opaque;
>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -    return pci_data_read(phb->bus, raven_pci_io_config(addr), size);
> +    return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
>   }
>   
>   static const MemoryRegionOps raven_pci_io_ops = {

It's a bit confusing during review that pci_data_read()/pci_data_write() access 
config space, but that's unrelated to this patch.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.



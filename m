Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBC7CCD88
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqN3-0002Gh-SN; Tue, 17 Oct 2023 16:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqN1-00028t-2o; Tue, 17 Oct 2023 16:08:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqMw-0005h2-8U; Tue, 17 Oct 2023 16:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4bob5xp8m6D+L0/MJDAMMYdtvp5G3z1DGCqJtPgibQo=; b=pwQUwX7XOklasLnjA+iQXhygVU
 RGUQv6qQUdJZuWOeIXbPizMysqxcIKkul3lkYXUEKSdfmAO5PjsjKT9Lq/g8T8Ib8yq4RR1TwNyiS
 9N+05qX/nqj5ozX+ngt0O5RWQb79TJ+YLXSvvyqo3EB5EOrdo+cndWSvBMHc5eu3PndSfQQsMC6be
 fu2HubH2sFPARXJBPYACIWcB785/ouc5FQM4ggOyMhMBh/3BHaW0Q1MbrMxS0o4Nv0ReQegVdi7cf
 WiJSBIF9OEfdLDqAnU5ONB0p21EdI6pcjL361rAfLCYiSrGridijBnsGUErSMLuif+CcoaQELulzI
 zWotMWWEK0vlYYHUb9c5pRTYLLEMafl2u4W2oNXkQ/u77af7q/2/kl0MhZElt03KMtwExux0hmQGC
 BHKeY0chNYnZslM1xMXW9WpBlt+B6W78FCHxqaTNApFr1Goh5CnD2leGbLFsqmTasioaTjK9l15ok
 2lJJ75n04HBfg1W36TdKpD7UaZAGFL9YivLh34JEbbyyw/nGYUy40aZX8ewmcsFgZ8J0qSns2d8Xb
 lXFvYmbkdkIayWl7wx9fMfU9vULCdmMaVrjYWYu1eb8uMack87CJ7FMAyM9axjXU06FVCP6s8jiyB
 LiEpJrDwSF0fextCwJRSAIEG0kjUOz0IJ3UET5tOU=;
Received: from [2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqMk-0001am-MZ; Tue, 17 Oct 2023 21:08:38 +0100
Message-ID: <72ab4b46-2152-4de3-b971-b31ea9d89bf1@ilande.co.uk>
Date: Tue, 17 Oct 2023 21:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231017135058.44247-1-philmd@linaro.org>
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
In-Reply-To: <20231017135058.44247-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/audio/pcspk: Inline pcspk_init()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/10/2023 14:50, Philippe Mathieu-Daudé wrote:

> pcspk_init() is a legacy init function, inline and remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/audio/pcspk.h | 10 ----------
>   hw/i386/pc.c             |  3 ++-
>   hw/isa/i82378.c          |  5 ++++-
>   hw/mips/jazz.c           |  5 ++++-
>   4 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
> index 9506179587..6be75a6b86 100644
> --- a/include/hw/audio/pcspk.h
> +++ b/include/hw/audio/pcspk.h
> @@ -25,16 +25,6 @@
>   #ifndef HW_PCSPK_H
>   #define HW_PCSPK_H
>   
> -#include "hw/isa/isa.h"
> -#include "hw/qdev-properties.h"
> -#include "qapi/error.h"
> -
>   #define TYPE_PC_SPEAKER "isa-pcspk"
>   
> -static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
> -{
> -    object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
> -    isa_realize_and_unref(isadev, bus, &error_fatal);
> -}
> -
>   #endif /* HW_PCSPK_H */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb3854d1d0..3d0b53a583 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1283,7 +1283,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>               /* connect PIT to output control line of the HPET */
>               qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
>           }
> -        pcspk_init(pcms->pcspk, isa_bus, pit);
> +        object_property_set_link(OBJECT(pcms->pcspk), "pit", OBJECT(pit), NULL);
> +        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
>       }
>   
>       /* Super I/O */
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index 63e0857208..9474bf994c 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>       uint8_t *pci_conf;
>       ISABus *isabus;
>       ISADevice *pit;
> +    ISADevice *pcspk;
>   
>       pci_conf = pci->config;
>       pci_set_word(pci_conf + PCI_COMMAND,
> @@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>       pit = i8254_pit_init(isabus, 0x40, 0, NULL);
>   
>       /* speaker */
> -    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
> +    pcspk = isa_new(TYPE_PC_SPEAKER);
> +    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), NULL);
> +    isa_realize_and_unref(pcspk, isabus, &error_fatal);
>   
>       /* 2 82C37 (dma) */
>       isa_create_simple(isabus, "i82374");
> diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
> index c32d2b0b0a..aac851747c 100644
> --- a/hw/mips/jazz.c
> +++ b/hw/mips/jazz.c
> @@ -177,6 +177,7 @@ static void mips_jazz_init(MachineState *machine,
>       SysBusDevice *sysbus;
>       ISABus *isa_bus;
>       ISADevice *pit;
> +    ISADevice *pcspk;
>       DriveInfo *fds[MAX_FD];
>       MemoryRegion *bios = g_new(MemoryRegion, 1);
>       MemoryRegion *bios2 = g_new(MemoryRegion, 1);
> @@ -279,7 +280,9 @@ static void mips_jazz_init(MachineState *machine,
>       isa_bus_register_input_irqs(isa_bus, i8259);
>       i8257_dma_init(isa_bus, 0);
>       pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
> +    pcspk = isa_new(TYPE_PC_SPEAKER);
> +    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), NULL);
> +    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
>   
>       /* Video card */
>       switch (jazz_model) {

Possibly you might want to pass errp instead of NULL for the last parameter of 
object_property_set_link() in i82378_realize()? But regardless:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.



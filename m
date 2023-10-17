Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E57CCDD0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqXq-0005qp-42; Tue, 17 Oct 2023 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqXf-0005qC-DD; Tue, 17 Oct 2023 16:19:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqXc-0007ek-GW; Tue, 17 Oct 2023 16:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MoGJhypJbxYDEbtsO0lFIp4N8mE/+C9nGXjsBVNXXvQ=; b=yN3exXxi59uDkK1xwJo1utECzF
 MJMLAtl+/bq8QK+LF1uf+SO2Cz1/Cp9O8GntlkKKUbfxqZ3QVEmMR5p5BaPSoXYU2fUs4S5cqB3l6
 o18gvoLQkRz7HPAArAtNap/DHKgoqY9KC6mROdgCPUFgMqDujE9EEsz5AcaJhirmr+bcIJibBSygI
 r5mkBe+PKAMbc3OIv1VYIjL+HtiRIAZw5Ubmi8EiNqdwEhWXzs4rxp4CMeWcuCZpj5ePHgYGqP+lx
 JPoCAfZHvQUN7PsfM9MVoeiztXhp/aWm7r3PaqoYHjdSffqYLjJ4QcJpOL7qWR65XmG8erklZR4kF
 wbyozLMcWlEMW92js2VfkKyCKmTD/y5C+pF/BgBrhlw+ZHkm5LUpzhQbq3hfOAvY65Z8BWJXj+vxw
 //ybfOlGeNn0i212apwPd8lYC9e7hMFgMVGCFRYSyPzNBUPFGvNClRoMDzViWjXi1jTGYOPc0/dQE
 0e1AzXldz7dhPDHCvqFD9w184yhz0DPDzXrbHIuGTCGVn8KTgC3+fC4GGra7QHoX+SPwrEeV/O7RZ
 UwdDduNuIij0owAduIIoTkMpZiBbqk6SxMnH6E87whp2wjXjKnhSnj4+TmCY1HNjH7VtN+3QtxVxg
 Ixw9Z44RpqZ1qATQhucetH3Kl7URO2I07PP9VTsMw=;
Received: from [2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qsqXQ-0001mw-W7; Tue, 17 Oct 2023 21:19:40 +0100
Message-ID: <7c5c11d5-1b7e-47b8-9cfb-0315041c14b7@ilande.co.uk>
Date: Tue, 17 Oct 2023 21:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-8-philmd@linaro.org>
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
In-Reply-To: <20231017140150.44995-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:3200:407d:a65c:9fb4:b9b4
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 7/7] hw/usb: Declare link using static DEFINE_PROP_LINK()
 macro
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

On 17/10/2023 15:01, Philippe Mathieu-Daudé wrote:

> Pull the 'dma' property to the core XHCI type, declare
> its link statically using DEFINE_PROP_LINK().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/usb/hcd-xhci-sysbus.c | 4 ----
>   hw/usb/hcd-xhci.c        | 2 ++
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
> index faf57b4797..15983d0b96 100644
> --- a/hw/usb/hcd-xhci-sysbus.c
> +++ b/hw/usb/hcd-xhci-sysbus.c
> @@ -60,10 +60,6 @@ static void xhci_sysbus_instance_init(Object *obj)
>       object_initialize_child(obj, "xhci-core", &s->xhci, TYPE_XHCI);
>       qdev_alias_all_properties(DEVICE(&s->xhci), obj);
>   
> -    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
> -                             (Object **)&s->xhci.dma_mr,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_STRONG);
>       s->xhci.intr_update = NULL;
>       s->xhci.intr_raise = xhci_sysbus_intr_raise;
>   }
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 4b60114207..012a6f3644 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3638,6 +3638,8 @@ static Property xhci_properties[] = {
>       DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
>       DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
>                        DeviceState *),
> +    DEFINE_PROP_LINK("dma", XHCIState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
>   };

I'm slightly unsure about this one: does pulling the "dma" property into the core 
type cause any issues if the property is left unset for any non-sysbus xhci users?


ATB,

Mark.



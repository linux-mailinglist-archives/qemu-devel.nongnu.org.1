Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00639746C7F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbql-0004O3-9l; Tue, 04 Jul 2023 04:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbqh-0004NC-UN
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:57:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbqe-000634-2v
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:57:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso46028405e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688461040; x=1691053040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1pS3TwpcCyyDeZg6a+3fZj823CZPp/NOuhCb5QU8jUs=;
 b=E/wBkhhIXibc/r2r6suJzfpwaCeiP3m4XL3AFC1XZcDmpcb4JoeQ6aVdFaGfRDrTQS
 WBOo0uwgSIjHhoDoiSFOE5c4/2BKvjEIz0oT7tG5fyS6XWR8TGVpndsgiLex+xBi2f3j
 D0uOiQ7BvtuouCuYlf0uTptDSPWep0AHljmW5AP+KAtE3su2UDElyll7nVbVOU6eS/rs
 SkzvUGA7mJwW2rvgymzrrYGMtN77yevg8xifjF/cmDc1hoHm+q+NkvZkYbUs/54DiKBh
 XDMRcHbsO4HY4uzapiegj7E986g3R9EX6DjcmIURZ6vXffTZJn40iyg71ej5k3J4CzQW
 ioog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688461040; x=1691053040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pS3TwpcCyyDeZg6a+3fZj823CZPp/NOuhCb5QU8jUs=;
 b=fvsCeIYyoZb/62UxxIRcRkd27UDTkHRJQlqNnGWKrIYS3gQCh+5H0yFynsuVlSAKIr
 YG4cuYeD7z3YD4320EiGcv9z2vIbuj2fI8q8xeTQu9kXzNQ9qb3iwKVsOK16F7PNEkKr
 MChcOGwS4AjTGoPqXT11dgmd+5ICVD/PTG4BQ4GCdxSfg7OmD232ujp9atYqAsNR7PnT
 34I75STXrQk+pCXhNXsLKqIiOBF6dO8BQ+gfeoyhIuFuPoPgFlxghUYqEv+KgMrkMDTm
 fuvyyVJA4pEjebyVkiTSF9IrA0/lfLd5w8REtuayTGZ/K3Twh/6I4RGzPKiw3KzCn9ee
 WxRg==
X-Gm-Message-State: ABy/qLYfHMhj5cvvr9c0Kr1BGuwT9fnMnnGv1h3xJMPJjXG6AkVc6Pge
 vNLtWKSJ/MpXobpZmkQiHh7EHA==
X-Google-Smtp-Source: APBJJlFstrPpkOE9UCO2VQY5L4F/I3a6HGOKuqQvF5tWKEFlZ7KKFsS4WSE4JZVbG3z8qV0Au6Apog==
X-Received: by 2002:a7b:c40d:0:b0:3fb:df34:176e with SMTP id
 k13-20020a7bc40d000000b003fbdf34176emr1684588wmi.31.1688461040638; 
 Tue, 04 Jul 2023 01:57:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a5d4407000000b003143cdc5949sm2032428wrq.9.2023.07.04.01.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:57:20 -0700 (PDT)
Message-ID: <9058d248-1fe5-f47b-30ab-0ef3bcbef5cf@linaro.org>
Date: Tue, 4 Jul 2023 10:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 10/13] ppc4xx_pci: Add define for ppc4xx-host-bridge type
 name
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <eecc7ae1c5f576f74c1b919e8d7f798fc8a7e6ac.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <eecc7ae1c5f576f74c1b919e8d7f798fc8a7e6ac.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> Add a QOM type name define for ppc4xx-host-bridge in the common header
> and replace direct use of the string name with the constant.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_pcix.c    | 3 ++-
>   hw/ppc/ppc4xx_pci.c     | 4 ++--
>   include/hw/ppc/ppc4xx.h | 1 +
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index f10f93c533..dfec25ac83 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -495,7 +495,8 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>                            ppc440_pcix_map_irq, &s->irq, &s->busmem,
>                            get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
>   
> -    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
> +    s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
> +                               TYPE_PPC4xx_HOST_BRIDGE);
>   
>       memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MAX);
>       memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index fbdf8266d8..6652119008 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -333,7 +333,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
>                                 TYPE_PCI_BUS);
>       h->bus = b;
>   
> -    pci_create_simple(b, 0, "ppc4xx-host-bridge");
> +    pci_create_simple(b, 0, TYPE_PPC4xx_HOST_BRIDGE);
>   
>       /* XXX split into 2 memory regions, one for config space, one for regs */
>       memory_region_init(&s->container, OBJECT(s), "pci-container", PCI_ALL_SIZE);
> @@ -367,7 +367,7 @@ static void ppc4xx_host_bridge_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo ppc4xx_host_bridge_info = {
> -    .name          = "ppc4xx-host-bridge",
> +    .name          = TYPE_PPC4xx_HOST_BRIDGE,
>       .parent        = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(PCIDevice),
>       .class_init    = ppc4xx_host_bridge_class_init,
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index e053b9751b..766d575e86 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -29,6 +29,7 @@
>   #include "exec/memory.h"
>   #include "hw/sysbus.h"
>   
> +#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"

This is the function #0 of the host bridge, maybe:

#define TYPE_PPC4xx_HOST_BRIDGE_FN0 "ppc4xx-pci-host-bridge-fn0"

>   #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>   



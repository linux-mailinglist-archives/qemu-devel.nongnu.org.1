Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77A74A4F9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVfa-0000k0-FW; Thu, 06 Jul 2023 16:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfQ-0000jL-6L; Thu, 06 Jul 2023 16:33:33 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfN-0004bV-GJ; Thu, 06 Jul 2023 16:33:31 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b0138963ffso1182106fac.0; 
 Thu, 06 Jul 2023 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688675607; x=1691267607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=11UR/PX+6bl3+x6pDXwAFcVjGYp6eh7aP4o8L4G1uXg=;
 b=VQ44XR2rvOCm8hKwHvsuqba39hoSLalZsmTxuGpms9WmGqSZGpN1B+ryuhjApxQXU4
 hQ8p6gU2YZfGmYWRRYCGuSJy9PJRtoqSapwarxh0joD3P3v4Sj93xe6bplmK/ur6EXbY
 h7b/4tNHx+9So0cCbxkT9cEFz71JmNtRpwPjWGUV7DyIk+d+HJVsVhF/fpeUdqVBWY9z
 Py1FSfEh2MnH/VCGxJoA2lZFHT5691/G3744WdTz7ffqysiHO1JGxbP6hrkBIKuH52bk
 +gteE8FDAPku3kevBAb8HDyeIDtYgSsRbopm9Hykva+uDxv9U3xFpm93d/bzH0BimMPR
 5Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688675607; x=1691267607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=11UR/PX+6bl3+x6pDXwAFcVjGYp6eh7aP4o8L4G1uXg=;
 b=BPm+LxO5nWXpWutrbBUf2/yUa9z1mCI9BOF+vWlz6uFZ2nDS7JtZrkhfsTZj3oulny
 twi6aNZ17TfksJoTnZJrsC1o55Ij8KlPj/pRErxWWUkW8TVPTGT0lC27uK7u6oac6/Zc
 L22ZGw37JeLGUx7k9mT2UXmtSK4EI8nIxxWON67KUlMCE0TcXIj+ec3Wfq/bHNLsMbe6
 GILOtkYkpXp+Bm8CDGQaWpxkVU7LeunxYKpyBIVOllh7rvbqaNtahuw93BDTBbJZX4CF
 oJGPzc7r3AMFZ8lIV00TVdVAp2UywypY7IXBT9S3l6banntW5pLhKskvGY0ojcWE+qXC
 s+Eg==
X-Gm-Message-State: ABy/qLaxTrmSyB/w5IXln0nuVPFFtFx2FpzrpBDZ/PBfP4SqekCxJX7E
 Nmg6XrWj9zaxyJ9FvMwskfU=
X-Google-Smtp-Source: APBJJlGfEscUflbh8Ikyppwr/O73I6LHzhU4799Aa6lR9i1ifZY9DKFmnA1E78frkY2rIDyzeoACjw==
X-Received: by 2002:a05:6870:c1d2:b0:1b0:3cd4:76d5 with SMTP id
 i18-20020a056870c1d200b001b03cd476d5mr3506839oad.37.1688675606684; 
 Thu, 06 Jul 2023 13:33:26 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 zf41-20020a0568716aa900b001807f020a39sm1093163oab.12.2023.07.06.13.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 13:33:26 -0700 (PDT)
Message-ID: <a5716042-3cc0-2cb4-d35e-d29377bdf8d5@gmail.com>
Date: Thu, 6 Jul 2023 17:33:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v3 2/4] ppc4xx_pci: Rename QOM type name define
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: philmd@linaro.org
References: <cover.1688641673.git.balaton@eik.bme.hu>
 <c59c28ef440633dbd1de0bda0a93b7862ef91104.1688641673.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <c59c28ef440633dbd1de0bda0a93b7862ef91104.1688641673.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 7/6/23 08:16, BALATON Zoltan wrote:
> Rename the TYPE_PPC4xx_PCI_HOST_BRIDGE define and its string value to
> match each other and other similar types and to avoid confusion with
> "ppc4xx-host-bridge" type defined in same file.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

I struggled a bit to understand what's to gain with this change, but it makes
more sense when we consider the changes made in the next patch (where a
TYPE_PPC4xx_HOST_BRIDGE macro is introduced to match the "ppc4xx-host-bridge"
name).

I also understand the comments Phil made in version 1. We have several QOM names
that are too similar ("ppc4xx-pci-host", "ppc4xx-host-bridge" in the next patch,
"ppc440-pcix-host" in patch 4), all of them being PCI host bridges. I am uncertain
whether renaming the QOM name of these devices to make them less similar is worth
it.

Matching the macro names with the actual QOM name is a step in the right direction
though.


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>




>   hw/ppc/ppc440_bamboo.c  | 3 +--
>   hw/ppc/ppc4xx_pci.c     | 6 +++---
>   include/hw/ppc/ppc4xx.h | 2 +-
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f061b8cf3b..45f409c838 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -205,8 +205,7 @@ static void bamboo_init(MachineState *machine)
>       ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
>   
>       /* PCI */
> -    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST_BRIDGE,
> -                                PPC440EP_PCI_CONFIG,
> +    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
>                                   qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
> index 1d4a50fa7c..fbdf8266d8 100644
> --- a/hw/ppc/ppc4xx_pci.c
> +++ b/hw/ppc/ppc4xx_pci.c
> @@ -46,7 +46,7 @@ struct PCITargetMap {
>       uint32_t la;
>   };
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST_BRIDGE)
> +OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST)
>   
>   #define PPC4xx_PCI_NR_PMMS 3
>   #define PPC4xx_PCI_NR_PTMS 2
> @@ -321,7 +321,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
>       int i;
>   
>       h = PCI_HOST_BRIDGE(dev);
> -    s = PPC4xx_PCI_HOST_BRIDGE(dev);
> +    s = PPC4xx_PCI_HOST(dev);
>   
>       for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
>           sysbus_init_irq(sbd, &s->irq[i]);
> @@ -386,7 +386,7 @@ static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo ppc4xx_pcihost_info = {
> -    .name          = TYPE_PPC4xx_PCI_HOST_BRIDGE,
> +    .name          = TYPE_PPC4xx_PCI_HOST,
>       .parent        = TYPE_PCI_HOST_BRIDGE,
>       .instance_size = sizeof(PPC4xxPCIState),
>       .class_init    = ppc4xx_pcihost_class_init,
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 39ca602442..e053b9751b 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -29,7 +29,7 @@
>   #include "exec/memory.h"
>   #include "hw/sysbus.h"
>   
> -#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
> +#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>   
>   /*


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E974A4F5
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVff-0000ku-PQ; Thu, 06 Jul 2023 16:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfd-0000kb-NV; Thu, 06 Jul 2023 16:33:45 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfc-0004gS-4t; Thu, 06 Jul 2023 16:33:45 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a36803f667so1484161b6e.0; 
 Thu, 06 Jul 2023 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688675622; x=1691267622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ic7DtW4fmWxO57QvC2rdq4deWRXW3QwGLgB2khp+jvA=;
 b=ZEgLwIGzQBJGCC/C31eaf4vsyj7yol88UiK2JuTF+Lb1Gr+m9xrA9CG5LuAQvS5g71
 hIrFrlmEsE/f6l8O13dtkNV8BoJYxBrgE2vNd7NbzFlBOW7kmRfLyHwptiqJqN5zVS2K
 07JfLEgY+MQStzHPCb16k1f6SHcarBRUABcRgXX4l91RJNb/mQGs4+OvPDIV9Tt/FV8+
 DAyyvoTvUvwt2Sc653OUZleFXnBnvYegdDJkwyfnQyZh2YSF+2UIuSgFDabcKPG7nYW9
 OlhGE9LYJzLYRzo0xPo9EPmzNgDhpjQpvhPRTQ33CyNGHzC2uocpnt4jyVeMSdbC4Eqf
 yJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688675622; x=1691267622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ic7DtW4fmWxO57QvC2rdq4deWRXW3QwGLgB2khp+jvA=;
 b=PSR0pxqXzR4nFnu/GoowC+ypYA7qXzNgaDnLZVRonPXMyTzYId76tEHrnaVn4BecQy
 QYGut6M63XlqUmK6XXWCtroy6qs1+kjbwZa7ETZixDpHk4CzdCgrHBJmNivB4LaUhv7R
 AhSHyJp5ItTyS0Ek0tYY8tYrGHiRCq0vyTB2kNsJDIj1Dby82RPGbdeP5YPuXnAJVn0v
 tNQNr5GDMRdM7ZvN0/XesmHcF+l/2Cy4WnB2VG9usOpn9Bc3qxk4YXW/B+FfQ0Hfhuw2
 PE/n9JCfzcdfpoPJiPS/lElyNor+IAKF/RdFXnZIBWSkpo1ZnFE/CNC65P4SlydYn4xL
 MVqw==
X-Gm-Message-State: ABy/qLZeoO4Mysr68EVfNEOBVKdYMfNVHBgUaJldSP6ltZfG3hwsrpL0
 1encPkuTgswsIRu8Pqq4G7xcTlDQlTw=
X-Google-Smtp-Source: APBJJlGX8efVr8i1yvl1cdXOhpGkfjgk3ctYDhzbxmEcytqQUvCV5MpLhE0EyNXfaQHVsYg09ZMD7A==
X-Received: by 2002:a05:6808:2a04:b0:3a1:de65:8403 with SMTP id
 ez4-20020a0568082a0400b003a1de658403mr1478260oib.1.1688675622594; 
 Thu, 06 Jul 2023 13:33:42 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 w26-20020a056808091a00b003a375c11aa5sm1032161oih.30.2023.07.06.13.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 13:33:42 -0700 (PDT)
Message-ID: <b0d27bf9-ae13-134f-85df-83378e576339@gmail.com>
Date: Thu, 6 Jul 2023 17:33:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v3 3/4] ppc4xx_pci: Add define for
 ppc4xx-host-bridge type name
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: philmd@linaro.org
References: <cover.1688641673.git.balaton@eik.bme.hu>
 <f6e2956b3a09ee481b970ef7873b374c846ba0a8.1688641673.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <f6e2956b3a09ee481b970ef7873b374c846ba0a8.1688641673.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x233.google.com
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
> Add a QOM type name define for ppc4xx-host-bridge in the common header
> and replace direct use of the string name with the constant.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   hw/ppc/ppc440_pcix.c    | 3 ++-
>   hw/ppc/ppc4xx_pci.c     | 4 ++--
>   include/hw/ppc/ppc4xx.h | 1 +
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index 54286cfef4..9321ca0abd 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -498,7 +498,8 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>                            ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
>                            PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
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
>   #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>   


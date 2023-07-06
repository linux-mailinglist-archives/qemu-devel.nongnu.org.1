Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF374A4F8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVfr-0000n2-9s; Thu, 06 Jul 2023 16:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfo-0000mT-Oy; Thu, 06 Jul 2023 16:33:56 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVfn-0004kk-4H; Thu, 06 Jul 2023 16:33:56 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b74e2d8c98so1032402a34.2; 
 Thu, 06 Jul 2023 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688675633; x=1691267633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6ySMC9LHc5fuzhnsO6dsNxDTz/udZBSDMxcB//l7f4=;
 b=cBdV/amPpgZ84y/SVfSZHz1hpiFwcCd8HlW6Qo1afmhKkDXu9WNvrN1Ubeec+bY/lX
 NZ9goRnIq+NcxhhAEYWAXfWY313cRx6aj4QSOiqtmTIO6N+ro1AMmmH3cwif1aJgT4md
 LyWoJMfvMZnK6kn5MZdgj7Jmr8K8H86djV5mn0mm82Xmgt4SrfnuGvsy8j42DXXvZcgV
 iyBYBerz/MwAcyPS6Kndx7blpuTu3vCKZpILpDpeVhmFaO/Qmi2R1hxYD2vDi02bEPwn
 S4Tf3ztYUiDvdsCGIhgkM53KDND7o4UJIRq0q1dH9eG+2JXD3tDNmxPSP31RPDk7VTHw
 NhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688675633; x=1691267633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6ySMC9LHc5fuzhnsO6dsNxDTz/udZBSDMxcB//l7f4=;
 b=MrVCFjgTsUbOHtC/zkuhiRG7RsSTtwnWQfEhvWc9MtBJLtueVgIFutyO42VBQHH3J4
 w4PewhGqkP3P2ZF7ELhkyNi2skXxjV5hujedY7cVv783md0QkDBupJWiYaTZMLapu9h/
 iDKSY2sZfMHQybfPzftfyCUWZo0Q6RAX5fIVDWipBbc+lngkqzPh4bpyx/NuggnwGGyq
 +YfwHqSAhHvwK5V+KgsznLBB4/seRbl+iJlDh7HLCfS87aCZn+QlCO3PbBtBQiaaHuSq
 1eTbY3APthrsSW//1MR0C4ps1sbAAk0OKOAknVOLxpmxnzIhIryebm4ZFXB5WPOfGBem
 V5Tg==
X-Gm-Message-State: ABy/qLapREmkLbdy/fz2xOygURqPJWDniMDwycBhOZcWCf7abYiL1j81
 8pcrGQJ9Pbx4S3dYQ9lZsAI=
X-Google-Smtp-Source: APBJJlE+0ljvgrsPgvMeNjjW4DAypK2cGLe+xZxgLH8RR4m3nPwmDZSx8/wAO9PVa71xsFPhvb1P3g==
X-Received: by 2002:a9d:734d:0:b0:6b7:4a86:f038 with SMTP id
 l13-20020a9d734d000000b006b74a86f038mr2836312otk.15.1688675633442; 
 Thu, 06 Jul 2023 13:33:53 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 g23-20020a9d6497000000b006b58e0ef27esm1036249otl.39.2023.07.06.13.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 13:33:53 -0700 (PDT)
Message-ID: <e0b5c630-8312-bec0-459e-517f06eb65fb@gmail.com>
Date: Thu, 6 Jul 2023 17:33:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v3 4/4] ppc440_pcix: Rename QOM type define abd
 move it to common header
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: philmd@linaro.org
References: <cover.1688641673.git.balaton@eik.bme.hu>
 <1a1c3fe4b120f345d1005ad7ceca4500783691f7.1688641673.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <1a1c3fe4b120f345d1005ad7ceca4500783691f7.1688641673.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
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
> Rename TYPE_PPC440_PCIX_HOST_BRIDGE to better match its string value,
> move it to common header and use it also in sam460ex to replace hard
> coded type name.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   hw/ppc/ppc440_pcix.c    | 9 ++++-----
>   hw/ppc/sam460ex.c       | 2 +-
>   include/hw/ppc/ppc4xx.h | 1 +
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index 9321ca0abd..672090de94 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -45,8 +45,7 @@ struct PLBInMap {
>       MemoryRegion mr;
>   };
>   
> -#define TYPE_PPC440_PCIX_HOST_BRIDGE "ppc440-pcix-host"
> -OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST_BRIDGE)
> +OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
>   
>   #define PPC440_PCIX_NR_POMS 3
>   #define PPC440_PCIX_NR_PIMS 3
> @@ -399,7 +398,7 @@ static const MemoryRegionOps pci_reg_ops = {
>   
>   static void ppc440_pcix_reset(DeviceState *dev)
>   {
> -    struct PPC440PCIXState *s = PPC440_PCIX_HOST_BRIDGE(dev);
> +    struct PPC440PCIXState *s = PPC440_PCIX_HOST(dev);
>       int i;
>   
>       for (i = 0; i < PPC440_PCIX_NR_POMS; i++) {
> @@ -489,7 +488,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>       PCIHostState *h;
>   
>       h = PCI_HOST_BRIDGE(dev);
> -    s = PPC440_PCIX_HOST_BRIDGE(dev);
> +    s = PPC440_PCIX_HOST(dev);
>   
>       sysbus_init_irq(sbd, &s->irq);
>       memory_region_init(&s->busmem, OBJECT(dev), "pci-mem", UINT64_MAX);
> @@ -529,7 +528,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo ppc440_pcix_info = {
> -    .name          = TYPE_PPC440_PCIX_HOST_BRIDGE,
> +    .name          = TYPE_PPC440_PCIX_HOST,
>       .parent        = TYPE_PCI_HOST_BRIDGE,
>       .instance_size = sizeof(PPC440PCIXState),
>       .class_init    = ppc440_pcix_class_init,
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 7da38bd58e..1e615b8d35 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -438,7 +438,7 @@ static void sam460ex_init(MachineState *machine)
>   
>       /* PCI bus */
>       /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
> -    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
> +    dev = sysbus_create_simple(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
>                                  qdev_get_gpio_in(uic[1], 0));
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, 0xc08000000);
>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 766d575e86..ea7740239b 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -31,6 +31,7 @@
>   
>   #define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
>   #define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
> +#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
>   #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
>   
>   /*


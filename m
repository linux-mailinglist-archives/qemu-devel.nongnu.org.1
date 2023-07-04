Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21604746C83
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbrd-0005At-BN; Tue, 04 Jul 2023 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbrb-0005AE-My
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:58:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbra-0006Bi-1G
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:58:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso50825755e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688461100; x=1691053100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5o3QlwOODQBOXkDWXjM5mtrapiGLdCZs8bRD22a/ek=;
 b=KBJqcrZZQTBzwwsGU5IPdVGQ9C1cywpam86ZqLOzWomIc9Mqlg5ZiS09ZXOKVtEoXy
 3mObGF54+4dP+3TD+LAuVUvAqR1hHnv7nFt2tLuF9oGyGF79mMgEGuPcwiRaFNxnLVJG
 QN5FDCr1UZQDwznBvjC7wYQ6baxrz6o2+ibeVnudWs3n+w0RJHERYhg6yMhSuIm0dwzQ
 CRTaAyV1OQRJ3pScnENQAsQA3VG3AhVX2aqtjHLNkr+nXtFHlijoB+kAbKN0IlnMWx2/
 11ocDZsijaAV2pZsTJl/zI2Ab4d/LJO2nL6JV/Syn570wBHGa0fewik4UcjRe7cXy/Qq
 Q04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688461100; x=1691053100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5o3QlwOODQBOXkDWXjM5mtrapiGLdCZs8bRD22a/ek=;
 b=IeLScJzOY261fi/VbOBnrpby15jlIDgEBbc+B+19vabU5/3qQaLnvJnVzC2BgKQMQe
 j/cb9XjaU9L9Sf5AIj9dnqtBSeKY3Zl2qTnGMRZdgHx2sHbwxYGOP2f7EyPDdMyqc71c
 3UmIuLrBAtmobstNjzMK4L7ccI7fIR8XVJoQvN8KQMaZez64/qeFo/Px39hnXJeFuDxe
 sSAtOQAR6f66GMWx7CKbKg7VXi2iGSn3yj7Wgs63+G39xciBG5jzyAC0bW4lJqKppSr/
 FGJcJUiNHR3bPeFNECAeHF7e+OeFSX2kdW/OkSa+n7oPpkc9rZn4KiOlVeA2vx+3QmCL
 qi5g==
X-Gm-Message-State: AC+VfDyPuCe4+GNuFm+O98/+QfJQ43FNWbFybF927JOx8LAjNXTp1o7G
 gW4YR0mrPzOUa1dNbIJKbFxzvqUHctXeLWinw7PeUQ==
X-Google-Smtp-Source: ACHHUZ7z9wbx5/8QPLtxvKtINlG73Cy13YwN2TuhhIiLbSqca1A6viwFZ2lMNeY4P/izMUeDuaVoTw==
X-Received: by 2002:a05:600c:215:b0:3f9:c8b2:dfbd with SMTP id
 21-20020a05600c021500b003f9c8b2dfbdmr10065159wmi.19.1688461100033; 
 Tue, 04 Jul 2023 01:58:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm15284965wml.15.2023.07.04.01.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:58:19 -0700 (PDT)
Message-ID: <71e24f1a-fc0f-c922-d18a-d52a2fa16e06@linaro.org>
Date: Tue, 4 Jul 2023 10:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 11/13] ppc440_pcix: Rename QOM type define abd move it to
 common header
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <e674bbedc437fa486f7e9690be14f1015bf54e88.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e674bbedc437fa486f7e9690be14f1015bf54e88.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> Rename TYPE_PPC440_PCIX_HOST_BRIDGE to better match its string value,
> move it to common header and use it also in sam460ex to replace hard
> coded type name.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_pcix.c    | 9 ++++-----
>   hw/ppc/sam460ex.c       | 2 +-
>   include/hw/ppc/ppc4xx.h | 1 +
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index dfec25ac83..adfecf1e76 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -44,8 +44,7 @@ struct PLBInMap {
>       MemoryRegion mr;
>   };
>   
> -#define TYPE_PPC440_PCIX_HOST_BRIDGE "ppc440-pcix-host"
> -OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST_BRIDGE)
> +OBJECT_DECLARE_SIMPLE_TYPE(PPC440PCIXState, PPC440_PCIX_HOST)
>   
>   #define PPC440_PCIX_NR_POMS 3
>   #define PPC440_PCIX_NR_PIMS 3
> @@ -397,7 +396,7 @@ static const MemoryRegionOps pci_reg_ops = {
>   
>   static void ppc440_pcix_reset(DeviceState *dev)
>   {
> -    struct PPC440PCIXState *s = PPC440_PCIX_HOST_BRIDGE(dev);
> +    struct PPC440PCIXState *s = PPC440_PCIX_HOST(dev);
>       int i;
>   
>       for (i = 0; i < PPC440_PCIX_NR_POMS; i++) {
> @@ -487,7 +486,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>       PCIHostState *h;
>   
>       h = PCI_HOST_BRIDGE(dev);
> -    s = PPC440_PCIX_HOST_BRIDGE(dev);
> +    s = PPC440_PCIX_HOST(dev);
>   
>       sysbus_init_irq(sbd, &s->irq);
>       memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
> @@ -525,7 +524,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo ppc440_pcix_info = {
> -    .name          = TYPE_PPC440_PCIX_HOST_BRIDGE,
> +    .name          = TYPE_PPC440_PCIX_HOST,
>       .parent        = TYPE_PCI_HOST_BRIDGE,
>       .instance_size = sizeof(PPC440PCIXState),
>       .class_init    = ppc440_pcix_class_init,
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index d446cfc37b..8d0e551d14 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -439,7 +439,7 @@ static void sam460ex_init(MachineState *machine)
>   
>       /* PCI bus */
>       /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
> -    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
> +    dev = sysbus_create_simple(TYPE_PPC440_PCIX_HOST, 0xc0ec00000,
>                                  qdev_get_gpio_in(uic[1], 0));
>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>   
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

Again, this is a host bridge, why not name it HOST_BRIDGE?



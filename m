Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E9746C7A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbpW-0003fF-F2; Tue, 04 Jul 2023 04:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbpU-0003dy-50
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:56:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbpS-0005fF-EE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:56:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso46015975e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460968; x=1691052968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/+MLJFs0XH7zbYGZSjQ/f38mKmsxZHjSLrw2TtEp9/w=;
 b=GoRErh2VsZp/xvnwKchiOzNy1e9oL6tf//U9SIq9px9OMQUhZKQPVWVdW9hKK61hJ5
 kHVlxxNncuRDrzG+XOfNejuT+NkmbikYapTc3Ffn3c+0rPbEb9jyLWhZ1IKZCRLJSR+b
 Gx4kK4zxp6y8zTJnfbfuZAXa0UN1fhkzEj9BDWBbQHOWoJnwKqp3UH0SO1nbXZP5JY38
 wfuVlDiyUJ5OwUBdKeoF5tcql2KhfzuBXO9VWv4GYAmUk3NUGyPcNYcSJxLkQXBcE8LE
 N/K9JQG03FJAGPM9qgWXKxlgLSZyIbAFDf9GzNB4n7n695wVODjfDQUQ2mKPTnuPmGiZ
 p7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460968; x=1691052968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+MLJFs0XH7zbYGZSjQ/f38mKmsxZHjSLrw2TtEp9/w=;
 b=jjqxtmU8NsKq/QjzD/F5/dpSomuICrs2ghTZyprMqu9fwySjAxLmglHfY/qMIPyc3v
 F9wJP30nhcU3gNS9acKmfEDcayrg1pA8AABBEMYMaykRKkgEGX4NlTUO+eF5KfcIbVhT
 bSE8ObeF+gVLX8r9BSk3Oxs1KKZHz8zSBV/HDOD9kVq+BE+tFESAOj4u5Yudo9mMrEHd
 Z/qhAkirbWf2+3RW1K1om0Njzqfssj2uYJB0yJvSWkmqt4adtgize1qMo3sC2Wpf2E7K
 6bU89vMap4oIo+/RQI01rDwrHMbGStNCLrkMijqib5DkBBL4LxY1WgsFMTb37LY7klod
 r96g==
X-Gm-Message-State: AC+VfDyFr/ukHVHCsegXG2vd4jRTh+GDJfSPddKlbWUrn/0JMJsDoAX4
 8oEPM/WVMW1oXrizMwPzorv5dQ==
X-Google-Smtp-Source: ACHHUZ41N+NGtMbEzweDQlrZ2w5efPVr3ZwUHOpg4Eo+27tRG2vII2Prv8q5gp9+XwSEEFv91jz0sg==
X-Received: by 2002:a7b:cd10:0:b0:3fb:ab76:164b with SMTP id
 f16-20020a7bcd10000000b003fbab76164bmr9775049wmj.13.1688460968525; 
 Tue, 04 Jul 2023 01:56:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm29254025wmc.7.2023.07.04.01.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:56:08 -0700 (PDT)
Message-ID: <a869053e-a26c-5d3f-537b-d81d31da26f1@linaro.org>
Date: Tue, 4 Jul 2023 10:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 09/13] ppc4xx_pci: Rename QOM type name define
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <217fab6a7ae5eca2a461b7d55fd76389954799b9.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <217fab6a7ae5eca2a461b7d55fd76389954799b9.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 00:02, BALATON Zoltan wrote:
> Rename the TYPE_PPC4xx_PCI_HOST_BRIDGE define and its string value to
> match each other and other similar types and to avoid confusion with
> "ppc4xx-host-bridge" type defined in same file.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
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

This is the host bridge however... Maybe we want to rename:

#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pci-hostbridge"




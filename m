Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAD746CA7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:02:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbuZ-0006j9-4W; Tue, 04 Jul 2023 05:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbuV-0006io-N2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:01:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbuT-0006zu-7K
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:01:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso55216085e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688461279; x=1691053279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qpn0O+efsAq13PSCa4ZjcSC9kIdT3mS7w4ty/4bQhzs=;
 b=Y3fsJwqXZDTyWAtS0Zekm8OvWYOWuawWVYA6SW93SsRHniaNZPexXmCm/Pq7eZkv0o
 ntOZP2wuZFAL47Hiobn28JYO/sDbybXWgLQK7AX4A+pobhaI5y39pykp80ge2BlKbL2k
 ktGUe3Y3vtTExjVSRLe2413O8OpSDBpslVK4i/Af4YgWtTdgtcGTmsLstQeYZ7+t8J12
 YkHw/Tao9LJQyTYneb6NDMrwpr1x2gbpkA3wMdE8K9hI9b69byVcrAAD/FAabZK/sA1L
 WFCFfoE5pxq2V9L5+75a+8Evy1bYDFqRukcHQNKu6Bu2GsvdM+fCz1NT2WCITj49NzAr
 t4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688461279; x=1691053279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpn0O+efsAq13PSCa4ZjcSC9kIdT3mS7w4ty/4bQhzs=;
 b=dEvuoF7PGlMulEo+xLoKRDvR4gDD0Z8MVXpNinTNWgV4V+bpgZMqaM/Tb5tErCvpUV
 VfeDJA9dLrSHgaRckeO0vKvNhHObxw2CTdAJ3uAoEj/BU1LkmVFWST5G5EpK5w6Ee5Jw
 S5g3+8/OruA1Z8njrl41PKTSzco5j7CNSjhcOnnnqW+T5e+RifpB46lbmcxw7MLGxHz1
 3w+8Lm4P7I5FEkR7m7G9uT9rwTxtXrmn3Osptj1rq0tQf3V/1BCtXLBIk0yDRFR6ZSwZ
 5BYLD4TmUuSne/xwt3sdZDjAFbc2O/MOMDwFkN0C1nEOjuLhb4PhHKjoERF2WWkPYhCd
 nL2Q==
X-Gm-Message-State: AC+VfDwSW/Dvrd6JkxTxZtnp5fdwKI3ptkx4J8YEYbkw1DW06ZkFvexM
 PtoKNlyF8Dzxu/nfaRnJDY/xVIr+BEYW0oFRmIpkzA==
X-Google-Smtp-Source: ACHHUZ4Y5yAmEiujWIu1kkS5anCTCQRU/agZgNxYLKxjiItBX4FlESZqzaOKVCfCjLuVhEvXJtcPtA==
X-Received: by 2002:a05:600c:ac8:b0:3fa:99d6:4796 with SMTP id
 c8-20020a05600c0ac800b003fa99d64796mr9392462wmr.2.1688461279085; 
 Tue, 04 Jul 2023 02:01:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a7bca57000000b003fbc30825fbsm12811899wml.39.2023.07.04.02.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 02:01:18 -0700 (PDT)
Message-ID: <30d1e44d-8ce5-030b-a052-0574ac76a0c7@linaro.org>
Date: Tue, 4 Jul 2023 11:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 13/13] ppc440_pcix: Stop using system io region for PCI bus
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <19ca518931d704615e801df249f2071c9f74a7dc.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <19ca518931d704615e801df249f2071c9f74a7dc.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
> Use the iomem region for the PCI io space and map it directly from the
> board without an intermediate alias that is not really needed.

"Reduce the I/O region to 64K."

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_pcix.c | 8 +++++---
>   hw/ppc/sam460ex.c    | 6 +-----
>   2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index ee2dc44f67..cca8a72c72 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -490,10 +490,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>       s = PPC440_PCIX_HOST(dev);
>   
>       sysbus_init_irq(sbd, &s->irq);
> -    memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
> +    memory_region_init(&s->busmem, OBJECT(dev), "pci-mem", UINT64_MAX);
> +    memory_region_init(&s->iomem, OBJECT(dev), "pci-io", 0x10000);

64 * KiB

>       h->bus = pci_register_root_bus(dev, NULL, ppc440_pcix_set_irq,
> -                         ppc440_pcix_map_irq, &s->irq, &s->busmem,
> -                         get_system_io(), PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
> +                         ppc440_pcix_map_irq, &s->irq, &s->busmem, &s->iomem,
> +                         PCI_DEVFN(0, 0), 1, TYPE_PCI_BUS);
>   
>       s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0),
>                                  TYPE_PPC4xx_HOST_BRIDGE);
> @@ -514,6 +515,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
>       memory_region_add_subregion(&s->container, PPC440_REG_BASE, regs);
>       sysbus_init_mmio(sbd, &s->container);
> +    sysbus_init_mmio(sbd, &s->iomem);
>   }

With the changes requested:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD8746C93
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbsj-0005s5-48; Tue, 04 Jul 2023 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbsg-0005rH-DO
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:59:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGbse-0006Jc-EO
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:59:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3141c8a6f30so5563595f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688461167; x=1691053167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j4szfMERPJvfEeou2PQDrip8MiSQ12BUQPxJEzjGF14=;
 b=lCLzuRYL18YqGB30m+WL5qRwrDSZ/nmSJ+I0Bw+1HwUHMdVBmMcOS9ZJtaxh33k0mp
 qqAmekXfXPbrFYUdvLuXGfocbfkhTJRQlLRXsYqabldDtxjZ06RhFIvpdn3JlLEJvYZZ
 stzYEOJeQ/qYBqaULdcKkLRYxLOngPZz3wSyOcNY4uRmos6QtB70zvo5up+QIhW73G6l
 Cdou3gOFsY7+Qb4Y0mwXPAnKWGfIksTICqPw1WEE1MwjRJwTM1D2DfkW4XPteIbIuJMn
 1LSrsCJAVSQjDdpumT2sZ/aiwiByB9PU0dLxa2b82tjj8uMHpRRjp0HoY0I70l7stq57
 pDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688461167; x=1691053167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j4szfMERPJvfEeou2PQDrip8MiSQ12BUQPxJEzjGF14=;
 b=BwYCLN/aWFBMDhZr8mcY9iw2Zd8GYlToEZu56FqbxUEm6qk5hr9uKNWGKWhBzLp24y
 J/D6Cs56uVj5bXYVDYD1ABODB9IX9/JlVgSXdLWhiCCvJufYTNpASYx8B/BskoxEnYM7
 NKXMT/wl2Mp3EsWl1pC8l9Tt+e30wvAQzK/MWZf+NZfAvYFFE5tRpqOLwi7KbWbp4p7z
 tDo2FJNry550erXtKbCwjhZ7DW0d9+V2n6shm78f8JT55bP2osYMPz1dn3oAKQ7IongF
 tQbXcPqCeNylKcVRJnWI0lT/2h5sE7LAcSg0YwMeUn6e4XS4Q4HbhPEWN6LVLAWg3ien
 oawA==
X-Gm-Message-State: ABy/qLYg1OZXGWJ5aZYlCBpGeOgc4tD9t23XMLjwR8g2KcM0vYAhqgaH
 3SqApT0bHnQ9mNg3moqbTZ/NsHfmnN2BPjdjmna2VQ==
X-Google-Smtp-Source: APBJJlHpQofKJF4+GDLVbCdv5KHvkKYbPuODgAYzyjnV51pBKuDeqYbmpn1qsPo1gXCpHDadjyi6lQ==
X-Received: by 2002:a5d:5543:0:b0:30f:c5b1:23ef with SMTP id
 g3-20020a5d5543000000b0030fc5b123efmr9410911wrw.41.1688461166984; 
 Tue, 04 Jul 2023 01:59:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d4908000000b0031432c2fb95sm6440973wrq.88.2023.07.04.01.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:59:26 -0700 (PDT)
Message-ID: <01cd4046-1f7e-beb5-d999-84db6ae23d3e@linaro.org>
Date: Tue, 4 Jul 2023 10:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 12/13] ppc440_pcix: Don't use iomem for regs
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <576b54159060392c8bc12a63c665928053b58f24.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <576b54159060392c8bc12a63c665928053b58f24.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
> The iomem memory region is better used for the PCI IO space but
> currently used for registers. Stop using it for that to allow this to
> be cleaned up in the next patch.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_pcix.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index adfecf1e76..ee2dc44f67 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -484,6 +484,7 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       PPC440PCIXState *s;
>       PCIHostState *h;
> +    MemoryRegion *regs = g_new(MemoryRegion, 1);

Why not hold it within PPC440PCIXState?

>       h = PCI_HOST_BRIDGE(dev);
>       s = PPC440_PCIX_HOST(dev);
> @@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
>                             h, "pci-conf-idx", 4);
>       memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_ops,
>                             h, "pci-conf-data", 4);
> -    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
> -                          "pci.reg", PPC440_REG_SIZE);
> +    memory_region_init_io(regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
> +                          PPC440_REG_SIZE);
>       memory_region_add_subregion(&s->container, PCIC0_CFGADDR, &h->conf_mem);
>       memory_region_add_subregion(&s->container, PCIC0_CFGDATA, &h->data_mem);
> -    memory_region_add_subregion(&s->container, PPC440_REG_BASE, &s->iomem);
> +    memory_region_add_subregion(&s->container, PPC440_REG_BASE, regs);
>       sysbus_init_mmio(sbd, &s->container);
>   }
>   



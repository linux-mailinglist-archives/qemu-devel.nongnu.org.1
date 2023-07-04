Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A42746C66
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGblH-0000p4-B4; Tue, 04 Jul 2023 04:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGblF-0000no-Gb
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:51:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGblD-0003G3-TZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:51:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3141c8a6f30so5555703f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688460706; x=1691052706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qL+NcNeWNybKEVUjeJlRzDpdZU0mnOJw7u81pJ/RwRE=;
 b=ZQpk1VvCo8ZqovyaJP0SmY17LwMjcX2NqHsMzR7fGYxnpuhdpEHpqw/r8Lis2ilbar
 6ElOd3L6kL+v8VzvwYVslLLhzx1KkCOjTqGuPD/Qfu1OrMlZpkcN9Jwj7ly6G+wLsJ9i
 OqLS7iq0xacQJp2MchRV/rTXyIIBB9Yxk5rM5GAtqFzw5HXoZai60orSviD8Rg0sN4N6
 a7gilL6t5M6MFyceiQQ90Idr9HEC29bU3EeXznxCtoijXEq7lRIMyFY9SVGcHWChZNWC
 BJuHbPAHtyHZ2/xNHHuckwnPM+vP/VGUtvGsU7/E0QpIUZW95LnkCsFD52juS/YHpFJH
 6d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688460706; x=1691052706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qL+NcNeWNybKEVUjeJlRzDpdZU0mnOJw7u81pJ/RwRE=;
 b=Y4RE9ZORp/xSFCq/2FvVHYBbN5OrHg3tt0U4QDDn/D7b/PmNz+sTgzEYD2LtcQ0iAD
 /8VRYwNzlSojWN6+tJCCcK8GkNAyaXYmCjzYwz8IXmkzFeVc3O8wYR2ookX2un9bYK0h
 xF5+EpVeEgfOuWBW3KXuhec/EeRWvIHX+uN+dub1CiLLiKJL/zDsFDiXkBGpPh9cCygi
 +3lOT6tUfK9qF3OfCznzI3JSH6ul3w4pqs8JC1vsM5wCUHP0XtRgsBHQ4T4foS9v6MMi
 mMNjdB1IBbiwxf/5PpFI6qemld4cCn9nV3WKa/lX1LJWA1Xo0b96WAt01n/X938mgZBX
 ET/g==
X-Gm-Message-State: ABy/qLbObh69r9reqapHyCqu/yuwzS4QRNiMNTN1tDXKlI67Ui/hWbGc
 nvPsEzLmNAGm6I08MOYWQF5IjQ==
X-Google-Smtp-Source: APBJJlE/+bAd0F/WDGuBQhwoqsMBDwCVJg6igU3PsHUsT12mRQawGibak/0wW6IXTmaFtb6tu2Ibsw==
X-Received: by 2002:adf:e9c2:0:b0:313:e9d7:108f with SMTP id
 l2-20020adfe9c2000000b00313e9d7108fmr9793193wrn.33.1688460706120; 
 Tue, 04 Jul 2023 01:51:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b003140f47224csm15309933wrj.15.2023.07.04.01.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:51:45 -0700 (PDT)
Message-ID: <5cea0f52-32d1-afbb-9845-b7bc41222470@linaro.org>
Date: Tue, 4 Jul 2023 10:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 05/13] ppc440: Stop using system io region for PCIe buses
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <2d1159457cd395dafbc5de3c4b4e3c5137af5e1a.1688421085.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2d1159457cd395dafbc5de3c4b4e3c5137af5e1a.1688421085.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> Add separate memory regions for the mem and io spaces of the PCIe bus
> to avoid different buses using the same system io region.

"Reduce the I/O space to 64K."

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc440_uc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 38ee27f437..0c5d999878 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -776,6 +776,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
>   struct PPC460EXPCIEState {
>       PCIExpressHost host;
>   
> +    MemoryRegion busmem;
>       MemoryRegion iomem;
>       qemu_irq irq[4];
>       int32_t dcrn_base;
> @@ -1056,15 +1057,17 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "invalid PCIe DCRN base");
>           return;
>       }
> +    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
> +    memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
>       snprintf(buf, sizeof(buf), "pcie%d-io", id);
> -    memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
> +    memory_region_init(&s->iomem, OBJECT(s), buf, 0x10000);

64 * KiB

>       for (i = 0; i < 4; i++) {
>           sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
>       }
>       snprintf(buf, sizeof(buf), "pcie.%d", id);
>       pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
> -                                pci_swizzle_map_irq_fn, s, &s->iomem,
> -                                get_system_io(), 0, 4, TYPE_PCIE_BUS);
> +                                pci_swizzle_map_irq_fn, s, &s->busmem,
> +                                &s->iomem, 0, 4, TYPE_PCIE_BUS);
>       ppc460ex_pcie_register_dcrs(s);
>   }
>   

With the changes addressed:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



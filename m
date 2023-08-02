Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AC76D99B
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJSi-0002gm-Ic; Wed, 02 Aug 2023 17:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJSX-0002fH-RQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:32:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJSS-0005d4-2V
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:32:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-317c11517a0so106549f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691011956; x=1691616756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IYoCKeQ8x7siip3i9rK4jjWLNzifaWvfhs7yTZyvE+8=;
 b=CCQ1FPkwDWoxkv2wi1ldd8SHM3XAM3IxIkeV69G4XdACtJyQIYs5wma9RT898gQDBa
 gYqBQq7FK68ILIudl1LNcWIvUrT28LJBeyoPujcszgTgxLR+PFXr3nmJBhQzj5qwqpMl
 UwU5ZPFvdt2EKzADIIMWuuDlNlm6oakTNkuCuiK2n0T163hB7OqVr4fwpdw+gU9881Xh
 /h7vjZeRFKWt3whYYScdINexEC2ttQ9MC2q4VkZ+ZpOCgxJkI2scZppxcqVR7XG6E1C3
 6NNWBUwiednaCtQWFDpnb6cIciYBgTiGBRy/ZAeT4nV9xNzgVFUkKyk6dduTtLiWWhnx
 70ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691011956; x=1691616756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IYoCKeQ8x7siip3i9rK4jjWLNzifaWvfhs7yTZyvE+8=;
 b=NKkgI0XWfzj7q3dVwSMbWQlWsUEyO80Cne9c07K2jt/rrfbdOOGespBxhHJZb+7bl3
 iRHdBI0NfrYtjYMZiulRJ2vRmOVvnDPeL8b419k6mac9s8d5uO+SJgloQNfSUYO/fruG
 KhTN7cVfXZJPlcNajugWXRsD6vc8zsqmMtWaJaxN4gLwUp4vPv0/r4MWVjQ3jZa4BM0D
 Z7chPeEefbKTfVREgoFYgKL+W9epLo4EofB1fUEfpuhvqhQ+u7R2DmReW14KUSi9nKqt
 0TK9zZ+pYlba1xZgErd2I+2iKMlh+LR3vjhefBkCOZd9YBkrqaQdqU+yL0oSYpTMTtj6
 ckLA==
X-Gm-Message-State: ABy/qLY7d8duLkbl6kVBRkCM5fXbxUT430cdMmgRreQkipOU9AlpQb4j
 oFVUy6ZhDA1Iv7rWCym1eiTjyg==
X-Google-Smtp-Source: APBJJlGDFlPIfYraAH1SJMJ4+2jO96A3zc33udXIP+05MxX7gXG5NOQbnqzL1rrgtfRwRxGD7cOhdg==
X-Received: by 2002:adf:e7cb:0:b0:317:59a6:6f68 with SMTP id
 e11-20020adfe7cb000000b0031759a66f68mr6478600wrn.0.1691011956677; 
 Wed, 02 Aug 2023 14:32:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff992000000b003176eab8868sm20018316wrr.82.2023.08.02.14.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:32:36 -0700 (PDT)
Message-ID: <14c9fd15-6925-79e4-3120-87e302de0e1c@linaro.org>
Date: Wed, 2 Aug 2023 23:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/5] Refactor i.MX6UL processor code
Content-Language: en-US
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <cover.1691010283.git.jcd@tribudubois.net>
 <649a1160b36c58ea89daf02a11b12f2dff164fee.1691010283.git.jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <649a1160b36c58ea89daf02a11b12f2dff164fee.1691010283.git.jcd@tribudubois.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

Hi Jean-Christophe,

On 2/8/23 23:08, Jean-Christophe Dubois wrote:
> * Add Addr and size definition for all i.MX6UL devices in i.MX6UL header file.

I'm OK with your patch, but some addr/size are added, while other
are changed. It is hard to review. Having one patch for changes
and another for additions would help review.

> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>    - SAI
>    - PWM (add missing PWM instances)
>    - CAN
> * Add/rework few comments
> 
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   hw/arm/fsl-imx6ul.c         | 149 +++++++++++++++++++++++------------
>   include/hw/arm/fsl-imx6ul.h | 150 +++++++++++++++++++++++++++++++++---
>   2 files changed, 240 insertions(+), 59 deletions(-)


> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
> index 9ee15ae38d..5d381740ef 100644
> --- a/include/hw/arm/fsl-imx6ul.h
> +++ b/include/hw/arm/fsl-imx6ul.h

For example here:

> +    FSL_IMX6UL_SNVS_HP_SIZE         = (4 * KiB),
> +
>       FSL_IMX6UL_USBPHY2_ADDR         = 0x020CA000,
> -    FSL_IMX6UL_USBPHY2_SIZE         = (4 * 1024),

> -    FSL_IMX6UL_USBPHY1_SIZE         = (4 * 1024),
> +    FSL_IMX6UL_USBPHYn_SIZE         = 0x100,

Don't we also need:

-- >8 --
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -210,7 +210,7 @@ static void imx_usbphy_realize(DeviceState *dev, 
Error **errp)
      IMXUSBPHYState *s = IMX_USBPHY(dev);

      memory_region_init_io(&s->iomem, OBJECT(s), &imx_usbphy_ops, s,
-                          "imx-usbphy", 0x1000);
+                          "imx-usbphy", 0x100);
      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
  }

---

?

Thanks,

Phil.


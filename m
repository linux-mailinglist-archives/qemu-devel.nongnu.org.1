Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FC74D326
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInwo-00039f-La; Mon, 10 Jul 2023 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInwi-00039B-IF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:16:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInwf-0006dj-DH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:16:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso4124829f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688984199; x=1691576199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XA1NSd1XU3oQYbF2tQtXXAlMDpTgvW5YjFDYuhmiIlI=;
 b=Nq2lNh1y/HUKpI89VT+Rqh3cF04/1CGzP0lYY4Vz9gLnhHSNX45UVBa0eIQr9hUcF5
 90GZHkDNRMsqNip2OKvyEb5fS+ZcVB5XGyfkDb5wSaYPVXct4EDaa4OKQjUlTJ+RvF5z
 eZ5Hczq5UsFRL8JfwsbUkxM1X+f2E/JOzKKgo+/+UWwiBnkJMJwhndkllq/XN6SdSSAx
 /o4jPQq9n2tO7aw364zEKgKn8GJFzWFMMcrRA2b4TeTkKG14X4c6THdqnw5AKCd63ip2
 eeZv/BOZGDyRF73EQJqAeEDW+KxGYFb0WERDz4zo1AqkycfGSqUAckwn7yAbLExSE2q+
 6Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688984199; x=1691576199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XA1NSd1XU3oQYbF2tQtXXAlMDpTgvW5YjFDYuhmiIlI=;
 b=SB/58L4EK2yIlRDjVMbv1yiYTLg2xfF72GaF+HsOpfcNkU1gGkM17/aapq6bBlq+es
 9A8jkPGmM/43ualo4pz41woUzu4Q4Zww9In2dBJam/IrBHTPDv1BAdQ8lUKwYEl7uVqa
 LSfXCrCPAGDzYjspYoi/eylfe/nPcuz+gwrTalAimbyRA69hl5ndquf+TNAzGasZfKrn
 Cq+VkOg2DJ38JnJe/6+xkShz/W/Q4viHvKaWznJAQbFb+FSoicHyHDjEEPAUxeO9Zhfk
 YODDtA0Q5zu++YP94nnfCTMkUX2IvN7x8KS7yy0lmlZc1aHHss8/pnQaRKH9uGVteW2l
 Owtw==
X-Gm-Message-State: ABy/qLZUv1CwEFBK4WTxxhLZGSty5Zt/IIXoOl2Fod4sl91uNUa9h3cf
 ijmK0Wlda4xK5iIYlYIVSU4c5EcpDcduzCL15u9MzA==
X-Google-Smtp-Source: APBJJlEE3e5WhxvgjkpvGQHjxCTYmuHWKCfboE35H0OonPlcerSXkVq/v9ON+FUhAKjJn6khQv13VA==
X-Received: by 2002:a5d:518e:0:b0:313:f98a:1fd3 with SMTP id
 k14-20020a5d518e000000b00313f98a1fd3mr9276119wrv.27.1688984199649; 
 Mon, 10 Jul 2023 03:16:39 -0700 (PDT)
Received: from [192.168.229.175] (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 i6-20020a5d6306000000b00313de682eb3sm11311305wru.65.2023.07.10.03.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:16:39 -0700 (PDT)
Message-ID: <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
Date: Mon, 10 Jul 2023 12:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>
References: <20230709080950.92489-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230709080950.92489-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 9/7/23 10:09, Bernhard Beschow wrote:
> Since commit c0a55a0c9da2 "hw/sd/sdhci: Support big endian SD host controller
> interfaces" sdhci_common_realize() forces all SD card controllers to use either
> sdhci_mmio_le_ops or sdhci_mmio_be_ops, depending on the "endianness" property.
> However, there are device models which use different MMIO ops: TYPE_IMX_USDHC
> uses usdhc_mmio_ops and TYPE_S3C_SDHCI uses sdhci_s3c_mmio_ops.
> 
> Forcing sdhci_mmio_le_ops breaks SD card handling on the "sabrelite" board, for
> example. Fix this by defaulting the io_ops to little endian and switch to big
> endian in sdhci_common_realize() only if there is a matchig big endian variant
> available.
> 
> Fixes: c0a55a0c9da2 ("hw/sd/sdhci: Support big endian SD host controller
> interfaces")
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sdhci.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 6811f0f1a8..362c2c86aa 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1382,6 +1382,8 @@ void sdhci_initfn(SDHCIState *s)
>   
>       s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
>       s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
> +
> +    s->io_ops = &sdhci_mmio_le_ops;
>   }
>   
>   void sdhci_uninitfn(SDHCIState *s)
> @@ -1399,9 +1401,13 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>   

What about simply keeping the same code guarded with 'if (!s->io_ops)'?

>       switch (s->endianness) {
>       case DEVICE_LITTLE_ENDIAN:
> -        s->io_ops = &sdhci_mmio_le_ops;
> +        /* s->io_ops is little endian by default */
>           break;
>       case DEVICE_BIG_ENDIAN:
> +        if (s->io_ops != &sdhci_mmio_le_ops) {
> +            error_setg(errp, "SD controller doesn't support big endianness");
> +            return;
> +        }
>           s->io_ops = &sdhci_mmio_be_ops;
>           break;
>       default:



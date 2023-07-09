Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABF74C674
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 19:01:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIXko-0001hY-PI; Sun, 09 Jul 2023 12:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qIXkm-0001gv-4v; Sun, 09 Jul 2023 12:59:20 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1qIXkj-0003sf-W0; Sun, 09 Jul 2023 12:59:19 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-57023c9be80so44602197b3.3; 
 Sun, 09 Jul 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688921956; x=1691513956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=vEfiqGqm6BNt+ovBQoQLKulxQlaKT99fz6iEBwdwip8=;
 b=Ms+QEF38L3o3IinM9yXzHSQtmTxyXwV7Xw08P2b5Ha85ZYbrrQ2IbR4u64NxwhKA3n
 o3ZKflTK1u5vbMxCd8EY1PmxcrT9EkPaU8E+6NDXTGqy3953SoE602un87Ivnm28VsSs
 AkB4ucYBdRKIjWZHfFeJWd6Ep413vPrxtn/2m01NLEgD1Fa9mTgV85+6YmNcWqEvfsI7
 NS+xy+OKt7xypDIpLlkP8jXhYvDld8KzLuAcG6ogoW2tkaRYngIUTdexKQR1gpuhZRjC
 VCno6H+AJMnFS9J7zbQ2s2E99XqJS7c8t4WuGWKSwiCWdT5hvOLlmV5RNO5taYq1ZRho
 2f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688921956; x=1691513956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEfiqGqm6BNt+ovBQoQLKulxQlaKT99fz6iEBwdwip8=;
 b=jaNLbdAkzLrILvUqQRCRzgMVrp83/ihJeBoBbZIr08uEyIK6jh9j2NxdDZEGf/EIis
 S4kRbXX3C5b+WIuSLP4GhhXXOEldXa2dAhRxQJjJygiBfZ5GezdtLjTlcBGT6sPgqPYk
 1NPX+NGRvt35eAJW9NuycS6aGGIZoAzHieajSODZObkfjWjHcWS9z2wAOmqREyXXWM33
 viHe6heVcirnkarfjQTMPWH2nes4+4ksW2i71OAdO/vI1czLboXO19VZYd9tiNT2kP7Y
 ve9ezoL/1JML6LC3SS/7KyJQE7Sanq6uSKNtkenZ280JzuSMfcbomW2VwiO9Rq3mzJ7z
 G9Ag==
X-Gm-Message-State: ABy/qLZ2bIAno2VQVfpktZx5KiRPeCQgpSQZ4pmJ/UsBn/IQgZU9Vstn
 INvx7jfQjjCdGQN7d7s/C8I=
X-Google-Smtp-Source: APBJJlHJzO1XmYuk7ArwzJFztBot9xEbMTPHAZPjBE4PHiv9c9yiMCKXl7KcSddov6p+C+2ENEa9hA==
X-Received: by 2002:a0d:eb42:0:b0:562:1850:bbf0 with SMTP id
 u63-20020a0deb42000000b005621850bbf0mr10460978ywe.21.1688921955737; 
 Sun, 09 Jul 2023 09:59:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 o188-20020a8173c5000000b00577139f85dfsm2523908ywc.22.2023.07.09.09.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jul 2023 09:59:15 -0700 (PDT)
Message-ID: <088f80cb-01c4-2125-2a10-6f5ef51de447@roeck-us.net>
Date: Sun, 9 Jul 2023 09:59:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230709080950.92489-1-shentey@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230709080950.92489-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=groeck7@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/9/23 01:09, Bernhard Beschow wrote:
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

Tested-by: Guenter Roeck <linux@roeck-us.net>

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



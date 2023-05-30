Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CBB716F42
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46OT-0005Ra-Sb; Tue, 30 May 2023 16:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46OR-0005R4-Bx
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:56:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46OP-0000Mp-Nv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:56:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso33506645e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685480192; x=1688072192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQSh4nyJNtfG4fQTBMsLnvOj6Tx0lKX2IP+60OpXJwU=;
 b=JA9xB+QskiqbGWg7JjbaPNRBIA3Lh+FAbeVlULE1kfVXEZq96u05PQe53fwJ4txWgl
 LpZeTqnZqJYdSZesPGIm75Gxd+xHvlNZ7f/Y7ePJSY95GlAE2ljBnZk+Bm6IZ9T22/gA
 mo1+2xb5Fdef0k3ULQ+YodGgcZyWXadFqKhSAHaMmnBchVoCOVvE+zuwboyQaFx6+3RI
 mxPm1kSaj0Oi55SOOcnOie5uZF7bnMm59ladg9bYuQp0Uqnq5zLrBPUikC9tEB2SBoZe
 FcbXBbDR/FQN0qm/fRRFeKnMqcV9TeqxLeMU2+ELfqh+xFle51xhUylPIaicUMEvoU9w
 6KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685480192; x=1688072192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQSh4nyJNtfG4fQTBMsLnvOj6Tx0lKX2IP+60OpXJwU=;
 b=XA7cSpGxOFPZN9JDYR6O9Vjubz2rrLaudIDpV2oaYdUfrKQNrEwDv6s5bbsrsKoCpb
 f1aFQ01yAxZSAupSoswtajbuCjAMMt+H7t5/s3+83lg4EhXduH4Nh8+YnFMSqQlU3Q/K
 VdTxAajQgI5k85YFQrQu7HSVCPcvOgoDmtecwuFKtLFFdkbDPnNJtQgmTLEQ8nDe6JVh
 AXV1JTbNszV3rOg7lL7FNJtzmOGpfbbMytrIku327YJw1/4htna7CAIky8Yi0w25xwG8
 ybhGwaasAbElAg/86z4MECQfRhix7hB4cLnwi362jL4nSMWZKqE47iiIPDjF8aiMxicB
 jkCg==
X-Gm-Message-State: AC+VfDxs2NkZ0NEAQzo9/R3kuD0sUAr2IW+rK8yOQQ59qmLUO8pcU8Zw
 kjDvHufAw2lAboeL4Crrqkin/A==
X-Google-Smtp-Source: ACHHUZ6Kp77evLQwBkvxsZQ5vdUVtzWg2kAU41CY9nAOAD0QioffDulShJtW2dvCCiRRSrcaX8mlag==
X-Received: by 2002:a5d:58da:0:b0:309:3698:8006 with SMTP id
 o26-20020a5d58da000000b0030936988006mr2450000wrf.34.1685480192211; 
 Tue, 30 May 2023 13:56:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b003062b2c5255sm4459893wrt.40.2023.05.30.13.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:56:31 -0700 (PDT)
Message-ID: <ad016c90-238c-2654-d550-9823bcb2a395@linaro.org>
Date: Tue, 30 May 2023 22:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 06/12] aspeed/smc: Wire CS lines at reset
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-7-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> Currently, a set of default flash devices is created at machine init
> and drives defined on the QEMU command line are associated to the FMC
> and SPI controllers in sequence :
> 
>     -drive file<file>,format=raw,if=mtd
>     -drive file<file1>,format=raw,if=mtd
> 
> The CS lines are wired in the same creation loop. This makes a strong
> assumption on the ordering and is not very flexible since only a
> limited set of flash devices can be defined : 1 FMC + 1 or 2 SPI,
> which is less than what the SoC really supports.
> 
> A better alternative would be to define the flash devices on the
> command line using a blockdev attached to a CS line of a SSI bus :
> 
>      -blockdev node-name=fmc0,driver=file,filename=./flash.img
>      -device mx66u51235f,addr=0x0,bus=ssi.0,drive=fmc0
> 
> However, user created flash devices are not correctly wired to their
> SPI controller and consequently can not be used by the machine. Fix
> that and wire the CS lines of all available devices when the SSI bus
> is reset.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c     | 5 +----
>   hw/ssi/aspeed_smc.c | 8 ++++++++
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index b654513f35..9a15899cbc 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -299,17 +299,14 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>   
>       for (i = 0; i < count; ++i) {
>           DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
> -        qemu_irq cs_line;
>           DeviceState *dev;
>   
>           dev = qdev_new(flashtype);
>           if (dinfo) {
>               qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
>           }
> +        qdev_prop_set_uint32(dev, "addr", i);
>           qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
> -
> -        cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
> -        qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
>       }
>   }
>   
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 7281169322..2a4001b774 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -692,6 +692,14 @@ static void aspeed_smc_reset(DeviceState *d)
>           memset(s->regs, 0, sizeof s->regs);
>       }
>   
> +    for (i = 0; i < asc->cs_num_max; i++) {
> +        DeviceState *dev = ssi_get_cs(s->spi, i);
> +        if (dev) {
> +            qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
> +            qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
> +        }
> +    }

Why did you chose the DeviceReset handler?
Shouldn't this be done in aspeed_smc_realize(), the DeviceRealize handler?

>       /* Unselect all peripherals */
>       for (i = 0; i < asc->cs_num_max; ++i) {
>           s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;



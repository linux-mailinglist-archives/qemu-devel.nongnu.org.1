Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799781F67D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:47:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImyu-0004WR-5o; Thu, 28 Dec 2023 04:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rImyr-0004V9-7p
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 04:47:09 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rImyo-0000qX-59
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 04:47:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3367601a301so5710583f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703756824; x=1704361624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X6l+8ee6ZPGhtJ+U0kFjCA6nf3DNWyK6Kz8fhg74K1k=;
 b=lAc2bKOk0hWefLeltuCXgChkh9pzPN1WIrmlt1sPDk5TXUiyL4fey0trIyghPSjZ7f
 /HKH3yiz/VjAyLquV9qPdg03JKWfFO5e0KOkuBUt2N98ZnGZCZlcRytR0RignFnld9DV
 dSlaiipQE4mj3S1rwx/KIbJ3wZQgIEVZ63+J9vRn5yvR2KIg0d+vliWgXRaTro27ULmV
 vH9xOLWOaB9jrefsJi8cOJ/xXRg8Bs1Zh6S5uuH9K5UuVfTXqo34K/YnySieI2B5JWtY
 KlSgM/SOCSUU5uw8zjbqAq9J7xMeY7ZbMnbLClx2FhYkyDdzH1fTlBNrOTnzM0FQRsiy
 Pfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703756824; x=1704361624;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6l+8ee6ZPGhtJ+U0kFjCA6nf3DNWyK6Kz8fhg74K1k=;
 b=wVlH/uGI7fEkWK2CQNU7RmgpFwKIa7wVdrkfxr3oMfFBIyVIEWCx+d2rc+aFHfjVKe
 R5PuQH9CGgvSDvDMHE2pagPnvNSl3V9CN4Dv0842bRmeJnAtkERPP8JOmBtEZgSNoErJ
 uzlcAnpEgsIPU3EEwKPW7fr2jkUz/fzPVjMNRwQ38IGjoz8lOsRCEIcGeg4PoRhzO2xF
 HmytEjPrLJShJolS9Gyiy5nCC1klI8MBlj64NllKf50DCQHMLw5sg9b+0lMHyQMwZYAx
 oINSgu5ptvx5DElUCCi7GtOc6v6pP2pIJ7H1IBR2q8bPSgv81/GFRp26Gk3MEEH/q/wU
 Rqbg==
X-Gm-Message-State: AOJu0YyFNatDRss5WHphiayiYwLt5LMb5XLES+Y5p1hN6qxLH3X06ERC
 R0gZZDA11lOGqZKCZoxuYQ9CpX9woEcN5w==
X-Google-Smtp-Source: AGHT+IEv7TL0aW/SGkUBQl/wPiqgT4xdc2TSkETd0rCZUaFxvO3fJ8KthLtVIkRIXWrFmh3CuPL6Pg==
X-Received: by 2002:a1c:7c10:0:b0:40d:5bf5:6085 with SMTP id
 x16-20020a1c7c10000000b0040d5bf56085mr1020686wmc.80.1703756824110; 
 Thu, 28 Dec 2023 01:47:04 -0800 (PST)
Received: from [192.168.69.100] (roo49-h02-176-184-1-50.dsl.sta.abo.bbox.fr.
 [176.184.1.50]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040d6eb862a7sm795751wmo.41.2023.12.28.01.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 01:47:03 -0800 (PST)
Message-ID: <42274b2d-5917-4add-a610-c1973bc1697d@linaro.org>
Date: Thu, 28 Dec 2023 10:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] q800: move dp8393x_prom memory region to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/12/23 22:02, Mark Cave-Ayland wrote:
> There is no need to dynamically allocate the memory region from the heap.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 7 +++----
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 4 insertions(+), 4 deletions(-)


> @@ -406,13 +405,13 @@ static void q800_machine_init(MachineState *machine)
>       sysbus_connect_irq(sysbus, 0,
>                          qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
>   
> -    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
> +    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
>                              SONIC_PROM_SIZE, &error_fatal);
>       memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
> -                                dp8393x_prom);
> +                                &m->dp8393x_prom);
>   
>       /* Add MAC address with valid checksum to PROM */
> -    prom = memory_region_get_ram_ptr(dp8393x_prom);
> +    prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
>       checksum = 0;
>       for (i = 0; i < 6; i++) {
>           prom[i] = revbit8(nd_table[0].macaddr.a[i]);

Similar pattern in mips_jazz_init(). I wonder if we can extract the
PROM checksums in a common helper declared in "hw/net/dp8393x.h".

Anyhow for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



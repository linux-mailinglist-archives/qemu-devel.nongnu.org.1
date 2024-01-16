Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368482EC82
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:05:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgJ4-0008EX-EW; Tue, 16 Jan 2024 05:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPgJ0-0008DV-FR
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:04:26 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPgIy-00085P-BD
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:04:25 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so11049841a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705399462; x=1706004262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6LbOO+70/NHRDqGhL19dCytYyC7QSSY/CHkPL1/Sa5s=;
 b=z6wTBhS4GfS2MAlOHZct1xiwj1ipYBmTd0cWMvp5WnDHTZLNahDfEOb8YmCEcyfaGZ
 z/Nya0bOotLhi3IeAJzbjm2fCzfrup8IfejwZCffw6C3w4qCCxiLHhAmCStCu8efhfpu
 IeQ7e1HGb3djau6gbcXcWnAZWAaBeFtU6b9sLS8NZK7N0vL51B3oW+t+n+8716jTUC8O
 QO1TkQG+SNHldgxRMlf0e1h4ZATIzxa3l5oYUJFSKvdXbcZ0EV2shnavU9ir+/ShxMzD
 jAcoOkyFJ6LEwnZmU1W6EuK/y/qfgBiP8nfwhjHZZ4YLyroGvyMbSZ7Dlg1nrKeu3R6G
 N4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705399462; x=1706004262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6LbOO+70/NHRDqGhL19dCytYyC7QSSY/CHkPL1/Sa5s=;
 b=TMTC8qF40LC6rU0L1y/wgoBejBzqjybs9w12Q8RCnFqgPxqCXFqRllvDsLWCsxXKf5
 AO0IsMzRw/QINI/N1CAqGfDG+ugx3TLdiA77lYrP0jvJOOh0cnNTo7URbHCxIgMRq5+t
 RmhTuWbNUpR0bGNC1zTzYX3sRApyODe2IljDAr2Znv7TQK5Dr0wazBfqwPNVfqxs66GS
 UEkmetCEO6jRgY9FDmpBvcmMC378C+1thsxD74LoloumnOZ1m6cFhSDDJzTIXwwRgRTx
 Lw5Tgr3iEmKhCHF//2OdT5w512SprY2Z1kEG0GPEDm0gqZTq0M1Ic60ZGvGQGPZvlFUa
 AIUg==
X-Gm-Message-State: AOJu0YzdieSPHvFUKmuIN7PcE+cATPiZLAewwW5Vpy92lXsYgABBbppw
 sqfFFeKMp2EMuUlkBVP+AiG73F2iuuWsCw==
X-Google-Smtp-Source: AGHT+IFgKpvYUQDInY8H9VRRkB01OaZzmtRAacqEVU1zyr532sLELffOOh3Nzw+n41L8kiLEhl2ZLw==
X-Received: by 2002:a05:6402:510d:b0:558:c044:e860 with SMTP id
 m13-20020a056402510d00b00558c044e860mr4852626edd.69.1705399462402; 
 Tue, 16 Jan 2024 02:04:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 ee34-20020a056402292200b00559bb6eef00sm114268edb.85.2024.01.16.02.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 02:04:22 -0800 (PST)
Message-ID: <7551e55e-89b3-40de-a3b4-60e158d00295@linaro.org>
Date: Tue, 16 Jan 2024 11:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/arm: Add watchdog timer to Allwinner H40 and
 Bananapi board
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Li Guang <lig.fnst@cn.fujitsu.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20240115182757.1095012-1-linux@roeck-us.net>
 <20240115182757.1095012-4-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115182757.1095012-4-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi,

(Cc'ing Li, Strahinja and Niek)

On 15/1/24 19:27, Guenter Roeck wrote:
> Add watchdog timer support to Allwinner-H40 and Bananapi.
> The watchdog timer is added as an overlay to the Timer
> module memory map.

I'm confused by these registers from TYPE_AW_A10_PIT
and the TYPE_AW_WDT implementation you are using:

   #define AW_A10_PIT_WDOG_CONTROL    0x90
   #define AW_A10_PIT_WDOG_MODE       0x94

Do we have 2 implementations of the same peripheral?

Should we instanciate AW_WDT within AW_A10_PIT?

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   docs/system/arm/bananapi_m2u.rst | 2 +-
>   hw/arm/Kconfig                   | 1 +
>   hw/arm/allwinner-r40.c           | 8 ++++++++
>   include/hw/arm/allwinner-r40.h   | 3 +++
>   4 files changed, 13 insertions(+), 1 deletion(-)


> diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> index 534be4a735..a28e5b3886 100644
> --- a/hw/arm/allwinner-r40.c
> +++ b/hw/arm/allwinner-r40.c
> @@ -53,6 +53,7 @@ const hwaddr allwinner_r40_memmap[] = {
>       [AW_R40_DEV_OHCI2]      = 0x01c1c400,
>       [AW_R40_DEV_CCU]        = 0x01c20000,
>       [AW_R40_DEV_PIT]        = 0x01c20c00,
> +    [AW_R40_DEV_WDT]        = 0x01c20c90,
>       [AW_R40_DEV_UART0]      = 0x01c28000,
>       [AW_R40_DEV_UART1]      = 0x01c28400,
>       [AW_R40_DEV_UART2]      = 0x01c28800,
> @@ -279,6 +280,8 @@ static void allwinner_r40_init(Object *obj)
>       object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
>                                 "clk1-freq");
>   
> +    object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
> +
>       object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
>   
>       for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
> @@ -545,6 +548,11 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
>                          qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
>   
> +    /* WDT */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0,
> +                            allwinner_r40_memmap[AW_R40_DEV_WDT], 1);
> +


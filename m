Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8B7B8C4F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7HI-00069I-VH; Wed, 04 Oct 2023 15:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7HG-00068U-JI; Wed, 04 Oct 2023 15:11:22 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qo7HE-0005yF-R9; Wed, 04 Oct 2023 15:11:22 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so221858e87.1; 
 Wed, 04 Oct 2023 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696446679; x=1697051479; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dh02cZXuc8d5hqIGOuDPJRkeEkb+fm9iaMPOZoIsNNc=;
 b=kWoFWlsmxPLj6hrVI3HLyXvEcJC72Ycm8hoZ21G5toX6Wou+lorBwi+xJp4DN+Z6rd
 KAbF+/6G7MK9kyydIY5C0WOxfuCje7hVes/WixpCs3/0Y5X3QtQ9Eld1Y9pZEhjGek2f
 P1TUkxy57VPLkqRqYWkF0bA+E1UYjO/N2gsYD5T5kI2YIpuPeD2DyB51Zr1mEO0b9yKX
 xfrFnLsralaKjQjaEBJdGr7IutlXTS8vbv1HgUGuOehJPb3a9neUNh9udUT8CRco6ZHw
 qNGxE1YO7oe8yrVTUCp6LMttv2dd8o+iaTar8Zb0EnOnJwf4lfKymZ70SNV3w7UPTr4O
 6SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696446679; x=1697051479;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dh02cZXuc8d5hqIGOuDPJRkeEkb+fm9iaMPOZoIsNNc=;
 b=lTD/CkmzMcfFrjk6Qb/XH99fGbDorXDqEb9G/wgo41Iy1ANliH+lqlHAfAvIJ/8Itk
 or8tcCQ8QmljtIhKphBqyOcr/9lcEIyQbaxaWNpAE8WxL4fxvv67Zo1CMx5ooje7IIEY
 9WU5hCK2fMD4Q+2Avis+o3HfEFI1yrwicJSAASohDproTjN1o9X0dEQmqz7XbUi+lxLW
 +hfx1Zhmd6hhaor/YUVUDICMtjsBk0HmZx2MDkojbqisgreEXF2+0Pel6Im9rTSS87uy
 hotlPsidoNS1Qvzao0bRXmqruqpulvGQk2SSFS7Qmzce8fCR2dWp9Do6JcdvLTwSA2Y1
 OhgQ==
X-Gm-Message-State: AOJu0YyYOXfSuHXKJLfIqpb8uqWPqPZeCLuhgcc9oS94K5/34moh4iyL
 Dilr0LTNMGHpR2PbtxptnKc=
X-Google-Smtp-Source: AGHT+IFMBYn24ZnAlo0S0nCd46UgGDVa6MOtqRZWuNJqi8Yuy8Wo9Ugu0BjDDyqzAV4PjnkKFJTeuw==
X-Received: by 2002:a19:e009:0:b0:500:c2d8:a2a2 with SMTP id
 x9-20020a19e009000000b00500c2d8a2a2mr2405082lfg.46.1696446678399; 
 Wed, 04 Oct 2023 12:11:18 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 k16-20020ac257d0000000b004fbac2646e3sm703210lfo.195.2023.10.04.12.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 12:11:17 -0700 (PDT)
Date: Wed, 4 Oct 2023 21:11:16 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, peter.maydell@linaro.org
Subject: Re: [PATCH v3 2/3] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG
 device
Message-ID: <20231004191115.GB20007@fralle-msi>
References: <20231004142746.350225-1-tong.ho@amd.com>
 <20231004142746.350225-3-tong.ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004142746.350225-3-tong.ho@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Oct 04] Wed 07:27:45, Tong Ho wrote:
> Connect the support for Versal True Random Number Generator
> (TRNG) device.
> 
> Warning: unlike the TRNG component in a real device from the
> Versal device familiy, the connected TRNG model is not of
> cryptographic grade and is not intended for use cases when
> cryptograpically strong TRNG is needed.
> 
> Signed-off-by: Tong Ho <tong.ho@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/arm/Kconfig               |  1 +
>  hw/arm/xlnx-versal.c         | 16 ++++++++++++++++
>  include/hw/arm/xlnx-versal.h |  5 +++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7e68348440..0a3ff6748d 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -482,6 +482,7 @@ config XLNX_VERSAL
>      select XLNX_BBRAM
>      select XLNX_EFUSE_VERSAL
>      select XLNX_USB_SUBSYS
> +    select XLNX_VERSAL_TRNG
>  
>  config NPCM7XX
>      bool
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index fa556d8764..4f74a64a0d 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -373,6 +373,21 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
>                         qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
>  }
>  
> +static void versal_create_trng(Versal *s, qemu_irq *pic)
> +{
> +    SysBusDevice *sbd;
> +    MemoryRegion *mr;
> +
> +    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
> +                            TYPE_XLNX_VERSAL_TRNG);
> +    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
> +    sysbus_realize(sbd, &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(sbd, 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
> +    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
> +}
> +
>  static void versal_create_xrams(Versal *s, qemu_irq *pic)
>  {
>      int nr_xrams = ARRAY_SIZE(s->lpd.xram.ctrl);
> @@ -909,6 +924,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_sds(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
> +    versal_create_trng(s, pic);
>      versal_create_xrams(s, pic);
>      versal_create_bbram(s, pic);
>      versal_create_efuse(s, pic);
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 7b419f88c2..54f4b98d9d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -31,6 +31,7 @@
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
> +#include "hw/misc/xlnx-versal-trng.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
> @@ -116,6 +117,7 @@ struct Versal {
>          } iou;
>  
>          XlnxZynqMPRTC rtc;
> +        XlnxVersalTRng trng;
>          XlnxBBRam bbram;
>          XlnxEFuse efuse;
>          XlnxVersalEFuseCtrl efuse_ctrl;
> @@ -160,6 +162,7 @@ struct Versal {
>  #define VERSAL_OSPI_IRQ            124
>  #define VERSAL_SD0_IRQ_0           126
>  #define VERSAL_EFUSE_IRQ           139
> +#define VERSAL_TRNG_IRQ            141
>  #define VERSAL_RTC_ALARM_IRQ       142
>  #define VERSAL_RTC_SECONDS_IRQ     143
>  
> @@ -329,4 +332,6 @@ struct Versal {
>  #define MM_PMC_CRP_SIZE             0x10000
>  #define MM_PMC_RTC                  0xf12a0000
>  #define MM_PMC_RTC_SIZE             0x10000
> +#define MM_PMC_TRNG                 0xf1230000
> +#define MM_PMC_TRNG_SIZE            0x10000
>  #endif
> -- 
> 2.25.1
> 


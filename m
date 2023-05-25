Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815271070C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q265g-000364-Eb; Thu, 25 May 2023 04:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q265e-00035d-LM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:12:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q265c-0002Hi-5r
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:12:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f50020e0f8so1869545e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685002370; x=1687594370;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwEYr+h9v7iFge5HOPml4q+J2nB29/aeNvJnD1CE9UY=;
 b=jnCk6PU4pN2rnpWsCOUQIfSHKf07ajio/tdevLB2A0BhLzyG/Ilc4bXqYB37rZGSWo
 gRKe5NECc7nweJbklih/dNxSAzMMrOgLONz2WjDSIotvH/vhdus4Ci1AYS/yu9y2M47e
 3zVN8DC3TbitvYEh2IEI9VY6t3Sq12zh4POqXBf3jhvlcZUlSHWyPpI0K0fHT6SZSReW
 nZ6z08nbzo7cwJX7z48WEM5J4pV+yT0r4+gZLfQC/eERAaQnoqdm5MZAu7RPSfV4I/hC
 nu3RnaIjrdkZb1H7PHoU+CCECX/e+YIN3pI6BW9nbOkwZ9zmNUUvTuelsxfj+w4/ozGP
 bcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002370; x=1687594370;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwEYr+h9v7iFge5HOPml4q+J2nB29/aeNvJnD1CE9UY=;
 b=eRdn1bh0ayQ58mjkNn23tlX3dkBNbGithw886KG2TVXqOGQUtw+vv9w7K0GbQ1Hvfq
 gfZtjTpFA27z0gUbmKy25WzBIYaEhK7mFENOkSI7pccUwi2S6PFpfO7Zhl5fX/LsqXRA
 CuKU2EUs9HmO/eJii4emMyDV++NRVJCSMmHTG8lHzrQPPnKeD0bZf7cqZZVUhwoqkQp6
 oLI02F+vzl1euUTNpOmIe6F44sDyxa6C9qNIKWEl51j1mhGxe+/cs3EqcEBCftrH+fEk
 C9nF3sTrM91IR0mkYKtPG0WajFXlxk2/5CxlSJz/S3eR+7jEwitlBpcMAXpLh79MOspG
 5NaQ==
X-Gm-Message-State: AC+VfDxU5rchzv1HA23mMd39pxNvmNsvNILHOTN4We5jEHt+OdIjVf4l
 IMD7y1rCrnD19bNE1FwNbpXpGw==
X-Google-Smtp-Source: ACHHUZ7gTgtnVHJZV5H2+VS01UWlPSQ/CC8Re2S5/5ms3yZvf+7CDA3G8NI/wQtZVi5cjYxW7mTG+Q==
X-Received: by 2002:a05:600c:4e45:b0:3f5:867:1aba with SMTP id
 e5-20020a05600c4e4500b003f508671abamr1542764wmq.15.1685002370324; 
 Thu, 25 May 2023 01:12:50 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 k10-20020a7bc40a000000b003f606869603sm4866154wmi.6.2023.05.25.01.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 01:12:50 -0700 (PDT)
Message-ID: <0fd19b1f-1cf5-3252-4ad3-71e58f2a141a@linaro.org>
Date: Thu, 25 May 2023 10:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/30] q800: add djMEMC memory controller
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> The djMEMC controller is used to store information related to the physical memory
> configuration.
> 
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   MAINTAINERS              |   2 +
>   hw/m68k/Kconfig          |   1 +
>   hw/m68k/q800.c           |   9 +++
>   hw/misc/Kconfig          |   3 +
>   hw/misc/djmemc.c         | 154 +++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build      |   1 +
>   hw/misc/trace-events     |   4 +
>   include/hw/m68k/q800.h   |   2 +
>   include/hw/misc/djmemc.h |  46 ++++++++++++
>   9 files changed, 222 insertions(+)
>   create mode 100644 hw/misc/djmemc.c
>   create mode 100644 include/hw/misc/djmemc.h


> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index f15f1eaff9..456407898e 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -40,6 +40,7 @@
>   #include "bootinfo.h"
>   #include "hw/m68k/q800.h"
>   #include "hw/misc/mac_via.h"
> +#include "hw/misc/djmemc.h"
>   #include "hw/input/adb.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
>   #include "hw/display/macfb.h"
> @@ -66,6 +67,7 @@
>   #define SONIC_PROM_BASE       (IO_BASE + 0x08000)
>   #define SONIC_BASE            (IO_BASE + 0x0a000)
>   #define SCC_BASE              (IO_BASE + 0x0c020)
> +#define DJMEMC_BASE           (IO_BASE + 0x0e000)
>   #define ESP_BASE              (IO_BASE + 0x10000)
>   #define ESP_PDMA              (IO_BASE + 0x10100)
>   #define ASC_BASE              (IO_BASE + 0x14000)
> @@ -492,6 +494,13 @@ static void q800_machine_init(MachineState *machine)
>                                &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(m->glue), &error_fatal);
>   
> +    /* djMEMC memory controller */
> +    m->djmemc = qdev_new(TYPE_DJMEMC);
> +    sysbus = SYS_BUS_DEVICE(m->djmemc);
> +    sysbus_realize_and_unref(sysbus, &error_fatal);
> +    memory_region_add_subregion(&m->macio, DJMEMC_BASE - IO_BASE,
> +                                sysbus_mmio_get_region(sysbus, 0));


> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 8d788a7072..d0e37cc665 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -33,6 +33,8 @@ struct Q800MachineState {
>       M68kCPU *cpu;
>       MemoryRegion rom;
>       DeviceState *glue;
> +    DeviceState *djmemc;

While I like the simplicity of using pointer to common QOM parent
type, isn't the consensus to have QOM objects embed their children
state? Maybe we never agreed on that explicitly :) So here I'd rather:

         DJMEMCState djmemc;

>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };



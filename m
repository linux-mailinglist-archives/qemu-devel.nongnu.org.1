Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558074ACA5
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgez-0004a4-2S; Fri, 07 Jul 2023 04:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgeu-0004Zm-IP
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:17:44 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHges-0008IH-CM
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:17:44 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-993d1f899d7so34791866b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717859; x=1691309859;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4kFfws0fh43l4EdnZ4aEj5x6AtqpydtPPnyOKO9DQA=;
 b=FJQM5Fx/pDmMQ8aENTxuoZKziGatwM9KF0Y00SWbnGJwe2VMWVNtxPuM2b5mkRD2xJ
 gOw5UTgYgK6ayfQoEsn7lt+WhySmiGpcRJYqvyL9reUT8teJHgRSymFIN+/uZhXQw5uI
 koDWwUcEoe7VG7YFS7KLQWYn/2pyYuFu9tdog0dx26YNWb0KPq/qtOsW1LdFM31fAFsN
 bwQxOXGsMeQYk5SGiMNJz00dj6NJMxeGYbdswvcWSF6BerG2Bz5FmijF0gbqraZLzzGr
 jpq/Q/ycu67ukDItxlqScAThmYWH7q7nN3QlKX8HRZMtTRUOjwhTIkWWBMdiNGXnL9Td
 MDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717859; x=1691309859;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4kFfws0fh43l4EdnZ4aEj5x6AtqpydtPPnyOKO9DQA=;
 b=CvdwFSOJmRci7UlMleqHRRquEo5ujMcEkbrI6wi5xAXSILdNacAdY8bHqZ8sfKGbUM
 BR2KlcoROb+2lcaVGRLdd1ufyA3AInQnxDHxPSoMdjzfWenrND900nj4JFBnk2GnH2JY
 LV14fX1+l74FNZjDxRN09fkfz6MyfmS5dB9oQzNbQGcULAMWUWEcSI21eGyef+014/zp
 S59FvKmQLgZ7nzeTTIbscd3wIYqibl3in5D1OmOvQDbL8GKPBUNAmNRzrZLK3gGrky4X
 J+nwWFAtole1eLyeRy+f/PYwkx5jkX6F92MQ721+f9GG+3T0JjmzZCLkc4A0/PvdYivU
 5/nw==
X-Gm-Message-State: ABy/qLboVw2wvdJMbijm0c5awTmmnEhahrvf+f8/nwuzzT3KtJwNj4Tu
 RkbF+2Z8ErZ9rCitEdx4X8/xRVuOo2c064qi1SM=
X-Google-Smtp-Source: APBJJlHFgKB8VAxS8/JEckgaFh32TNW/d91Hm9XAFmM3s8QyEG2TG9b5RMiXKqyjQAgcBSvUtk0qSw==
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id
 gg32-20020a17090689a000b0098ccc3c194emr2892813ejc.52.1688717859110; 
 Fri, 07 Jul 2023 01:17:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a1709064ad200b00993cc1242d4sm769497ejt.151.2023.07.07.01.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:17:38 -0700 (PDT)
Message-ID: <fc53bdaf-ec58-adbf-da7a-211ec26d13be@linaro.org>
Date: Fri, 7 Jul 2023 10:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 02/21] q800: add djMEMC memory controller
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> The djMEMC controller is used to store information related to the physical memory
> configuration.
> 
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   MAINTAINERS              |   2 +
>   hw/m68k/Kconfig          |   1 +
>   hw/m68k/q800.c           |  10 +++
>   hw/misc/Kconfig          |   3 +
>   hw/misc/djmemc.c         | 135 +++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build      |   1 +
>   hw/misc/trace-events     |   4 ++
>   include/hw/m68k/q800.h   |   2 +
>   include/hw/misc/djmemc.h |  30 +++++++++
>   9 files changed, 188 insertions(+)
>   create mode 100644 hw/misc/djmemc.c
>   create mode 100644 include/hw/misc/djmemc.h


> diff --git a/include/hw/misc/djmemc.h b/include/hw/misc/djmemc.h
> new file mode 100644
> index 0000000000..82d4e4a2fe
> --- /dev/null
> +++ b/include/hw/misc/djmemc.h
> @@ -0,0 +1,30 @@
> +/*
> + * djMEMC, macintosh memory and interrupt controller
> + * (Quadra 610/650/800 & Centris 610/650)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_DJMEMC_H
> +#define HW_MISC_DJMEMC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define DJMEMC_SIZE        0x2000
> +#define DJMEMC_NUM_REGS    (0x38 / sizeof(uint32_t))
> +
> +#define DJMEMC_MAXBANKS    10

MAXBANKS doesn't seem used, but not a problem.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



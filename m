Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A10F718889
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:35:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PiR-0004cY-0e; Wed, 31 May 2023 13:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4PiO-0004bb-9a
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:34:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4PiL-0002AC-H1
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:34:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ae95c4e75so4223719f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685554455; x=1688146455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YWF1WEFVEDNFVwf4rvHb/PtCZTNHIffH0745yjINvOI=;
 b=K5lmt6V2fGTilCiuNMfUZI4fLcEjGi1fy/LvB7i1uwgrNyfSDsZ5u4tqArPqAPJSWW
 M9GFpCLMrunGnWhcHdDuIhZHGrX+oNohpIe2fLfIelYszMCCqm4qAFUMk0j5qtbm4OIm
 FOhrY4CMZonE3pK78LZkCkJQwbMTt5L/GDKJH08FluG6hjN5177eW+qT8ZTcgH3n8izx
 GCHh4D9z64fQCTbDEF73p/kXJYR+YESA0iZlHu4d/9+gfyoKB+RzOxAraXLoLySNOGY0
 ht9JjkqQerxA7iqYZ6wzFJGGItIqdos03htvEIq/sJBv5ESUUvF6reazRBjeeJesBriG
 2LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685554455; x=1688146455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWF1WEFVEDNFVwf4rvHb/PtCZTNHIffH0745yjINvOI=;
 b=BuOuOYNcC6+VeoRNK+8BBnU+S+rbJ1AQls0MJDKlvwHZsZoqdYbZC5fqlYDh8+3U3w
 DQx8s9pkSXli0Hx4Lmq0lQ32AUC0QdfhQPtLI0+Q1mRBFyJi4B/M4Kn0MpuRacmlmn5P
 JCeGXl3wmQELalDkHTye9RLZ9csaAhpzZKzzli67fBOsv6kySSOwalwMKDnkbZKgz55w
 ft2R4jLIXfIRmgA8HssSO8IBSqIW0r3VDgX/9r4m9/tyflz4PpKhpRL9CYOiqaHmhpYs
 IqWiPacCgKWUn5Nq7DPq7IObAOpAqTR5ALdPshShFPU/+U4FV0lcKU8Aa7K6wfTqjmeS
 obWg==
X-Gm-Message-State: AC+VfDxoLeQV73vSstnnt9wwykOD6rh3U8yveXi+NLWXBAUJhWQBHJEO
 RFW4DZCdR2cnJd8LI2fWvNoFjw==
X-Google-Smtp-Source: ACHHUZ7EqpHgf0vOKmThQH5OrtGLbCHW62Es606hEFpBRaFp7SVsuDBp/yWAiePWpm5SLdi5WhF9tw==
X-Received: by 2002:adf:d84e:0:b0:2f8:2d4:74ef with SMTP id
 k14-20020adfd84e000000b002f802d474efmr4600532wrl.43.1685554455308; 
 Wed, 31 May 2023 10:34:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n13-20020adfe78d000000b003078681a1e8sm7473927wrm.54.2023.05.31.10.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 10:34:14 -0700 (PDT)
Message-ID: <5b407848-2a4c-6447-6726-cf85f278f3e7@linaro.org>
Date: Wed, 31 May 2023 19:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] Use named constants in BCM props
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20230531155258.8361-1-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531155258.8361-1-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Sergey,

On 31/5/23 17:52, Sergey Kambalin wrote:
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>   hw/misc/bcm2835_property.c            | 120 ++++++++++---------
>   include/hw/arm/raspi_platform.h       |   6 +
>   include/hw/misc/raspberrypi-fw-defs.h | 163 ++++++++++++++++++++++++++
>   3 files changed, 236 insertions(+), 53 deletions(-)
>   create mode 100644 include/hw/misc/raspberrypi-fw-defs.h


> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 4a56dd4b89..92a317950a 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -170,4 +170,10 @@
>   #define INTERRUPT_ILLEGAL_TYPE0        6
>   #define INTERRUPT_ILLEGAL_TYPE1        7
>   
> +/* Clock rates */
> +#define RPI_FIRMWARE_EMMC_CLK_RATE    50000000
> +#define RPI_FIRMWARE_UART_CLK_RATE    3000000
> +#define RPI_FIRMWARE_CORE_CLK_RATE    350000000
> +#define RPI_FIRMWARE_DEFAULT_CLK_RATE 700000000

Are these VideoCore constants?

>   #endif
> diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/misc/raspberrypi-fw-defs.h
> new file mode 100644
> index 0000000000..4551fe7450
> --- /dev/null
> +++ b/include/hw/misc/raspberrypi-fw-defs.h
> @@ -0,0 +1,163 @@
> +/*
> + * Raspberry Pi firmware definitions
> + *
> + * Copyright (C) 2022  Auriga LLC, based on Linux kernel
> + *   `include/soc/bcm2835/raspberrypi-firmware.h` (Copyright © 2015 Broadcom)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
> +#define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
> +
> +#include "qemu/osdep.h"

See https://qemu-project.gitlab.io/qemu/devel/style.html#include-directives:

   Do not include “qemu/osdep.h” from header files since the .c
   file will have already included it.

Otherwise your patch looks good!

I hope you are using the 'git cherry-pick -p' command to split
your previous big patch in multiple smaller, and not rewritting
the patches from scratch.


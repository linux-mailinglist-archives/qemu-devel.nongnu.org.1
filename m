Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77D8254C5
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:01:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLklM-0007jT-Vj; Fri, 05 Jan 2024 09:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkkf-0007Sp-1C
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:00:47 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkkb-0004q9-VF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:00:44 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so64368166b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704463239; x=1705068039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4QFZjfTudbE7tCSCZOHuFkUMXlIrZiBNhaRnMFRlLU=;
 b=HvSzw58JVr1zOLXLKFW7XLI0/6aMSZfEQFTbCQeaiYEpSGZsukUahVfxWj5JbbfrKZ
 Avg5FWsruTx9ARP91Rx/+lJ8acRpKpAT2Uj7PYIh4LEfy5blMnrFZBchDM6yHL/nhsGk
 qnMI/18vvt6r99WiBQWeT1PMYD+BpVzjt20cngylJT56ZjH203CbTyWV2PborX7jLnmg
 Yh1CIEj6ZAhGTH0sbS5ga1o61fwzBB3pYm1DAOkV7S2dycraVnH905tO9SU9cDaLR6Cv
 IVr1xJEQSlMXshnd0BMWNpLoHrGBr+Xq/BNl37Fy8DgPXl1lVrckBR3miucA67KUIw2L
 3C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704463239; x=1705068039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4QFZjfTudbE7tCSCZOHuFkUMXlIrZiBNhaRnMFRlLU=;
 b=sEmK0hDXv10FmlrZFEz125i5Xjj2RBqi9EkabOApTk4fvVfkwxFxlIIwjyPHfyThZx
 +awV8A/W/2EwV8otsd2Sb6WOSp7f4zxU13aoIXZEMFM7M8HzEchJvq/W3o8Q1TOHWskT
 toxxzFOZ2WqRmAUBXpuBQP6Tk6RbGvl7nYTmvtHMBQG8BbSw5mifJPct2zs6VKQ7KxHS
 CiA2rO31ya/b+mjyc9qmMm3kPniEC2x3ZUg1olahlRQCcI9T4vJTgW0sxoZla5y1z+rf
 F5eS3+WENPd7nfnzSN+rZbwWy45iSueGKLuyKNboSsjU50cHF+mpInLGPpslYMJPSwA+
 SJOQ==
X-Gm-Message-State: AOJu0Ywcshw1Prjo+ZQn0bYHP0oetGA2WDsyNgBBe1UMWNZK/L3OCEGu
 wvz8WrhS6dPFeYiRT+nb3yTqD53cbuqRzg==
X-Google-Smtp-Source: AGHT+IG7zBh6j2eUDcjcb/sbMtVjVFcyT+kHWcJK8kxX6C7w8t9DKLFeDWUzhP8oaTXXcaf7b6ZVmg==
X-Received: by 2002:a17:907:3a98:b0:a29:3fc1:a66 with SMTP id
 fh24-20020a1709073a9800b00a293fc10a66mr139089ejc.154.1704463238807; 
 Fri, 05 Jan 2024 06:00:38 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 o18-20020a1709064f9200b00a28ace8fb17sm903917eju.206.2024.01.05.06.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 06:00:38 -0800 (PST)
Message-ID: <104080fa-71d2-41a8-b273-171173d6cb44@linaro.org>
Date: Fri, 5 Jan 2024 15:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] sparc/grlib: split out the headers for each
 peripherals
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-2-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105102421.163554-2-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 5/1/24 11:24, Clément Chigot wrote:
> ... and move them in their right hardware directory.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/char/grlib_apbuart.c                       |  4 +--
>   hw/intc/grlib_irqmp.c                         |  4 +--
>   hw/sparc/leon3.c                              |  6 ++--
>   hw/timer/grlib_gptimer.c                      |  4 +--
>   include/hw/char/grlib_uart.h                  | 30 +++++++++++++++++++
>   .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 14 +++------
>   include/hw/timer/grlib_gptimer.h              | 30 +++++++++++++++++++
>   7 files changed, 74 insertions(+), 18 deletions(-)
>   create mode 100644 include/hw/char/grlib_uart.h
>   rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
>   create mode 100644 include/hw/timer/grlib_gptimer.h

This still matches the MAINTAINERS patterns, good.

> diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.h
> new file mode 100644
> index 0000000000..b67da6c62a
> --- /dev/null
> +++ b/include/hw/char/grlib_uart.h
> @@ -0,0 +1,30 @@
> +/*
> + * QEMU GRLIB UART
> + *
> + * Copyright (c) 2024 AdaCore
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.

When adding license, SPDX tag is prefered (although not enforced)
because it eases tools parsing.

> + */
> +
> +#ifndef GRLIB_UART_H
> +#define GRLIB_UART_H
> +
> +#define TYPE_GRLIB_APB_UART "grlib-apbuart"
> +
> +#endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



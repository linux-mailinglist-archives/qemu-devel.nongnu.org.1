Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BB825489
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:37:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkOA-0007od-FT; Fri, 05 Jan 2024 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkO8-0007oF-Bv
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:37:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLkO6-0000Vn-MZ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:37:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3373bc6d625so1208171f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704461845; x=1705066645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lB4zxDMWzAIjh26Q1A4CLloRuni1/xHvs5AjJmJ1XJg=;
 b=ZRf5oV8Mby7crVGkNhfmvjZmx7nnjrXzN9UKgpjo8a2ZN7Lrcx5LQp3vxUEBXCUFWP
 w40Y7yNU6sPKYMlYwHhIyM8+HJFReAitXirNLOO6SSwZV8tqCeIQb1Rm7pKng+SON2Dg
 wvH0I2TdFLtN0qDartwdoy0t6NCBv6o+jdolEcx5rAtUD/Xk4/0J1WMjOWo1Wx+FAQvP
 V6iRtDYXl+Ou2dhr0QZwhPxGD6DKIOvBcdfzwoL4G0UzHvEMNsJPEtOvnXVE60Gb1Gvl
 YqwkJ2rsf6KX3R1IZO8uU7P6FeX81mJN58QinflsQoPCUc2PTEr7P/IxZAbuiZDog49+
 BuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461845; x=1705066645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lB4zxDMWzAIjh26Q1A4CLloRuni1/xHvs5AjJmJ1XJg=;
 b=GyFNeAM9lB52tL9pu3xBQnv96lw5U6/Kq53uO+LycRik255DaeXs4sxExh9/cBIeAh
 H4Gxkh3BQGbua1Mleh/i5FU1UuRQT70npxM4F8umSM7chSSOVErcFV6ir5BCDIE1dqrz
 JUfeSsUIsnEGubuEksIqvBMjx+ewB1tBi7/6rJC76bmjflgCbD+bTCF7LqYF1dWxah7K
 cS1xM/L4QKXNnJ1Vif1M0dUxXT3vuY8uOkaXYarlNWHGOzR1Bhy3C4X4nU7OqNOuuiQd
 rCePyjoFS1cJ6zBb8/B6UfgbBm4XkVwP5jIsgq2kOqW8Xn7/BUQOupgFCX2K/qcADyAu
 CfBg==
X-Gm-Message-State: AOJu0Yw9SODnohZd5a8Oo+ATc0fpLK3uPbKL3lavOykhkupvpYuBwUkb
 Anw4namzLQe688UEVj2b7Ob2Un3UV0r0hw==
X-Google-Smtp-Source: AGHT+IEHq0ZTzAmMUsCkWUKvZ2SIROxXMBRUfn03yOemRjqVrCIVFAhcxKJx1W1jE1ohc+65w7hwDA==
X-Received: by 2002:a5d:4f86:0:b0:337:160:790d with SMTP id
 d6-20020a5d4f86000000b003370160790dmr1385012wru.23.1704461844651; 
 Fri, 05 Jan 2024 05:37:24 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 u5-20020a5d5145000000b00336cbbf2e0fsm1415457wrt.27.2024.01.05.05.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 05:37:24 -0800 (PST)
Message-ID: <a103ed7a-aeeb-4d51-b0e7-996897e30658@linaro.org>
Date: Fri, 5 Jan 2024 14:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] intc/grlib_irqmp: implements the multiprocessor
 status register
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-4-chigot@adacore.com>
 <702936da-4931-40b7-8f82-b256cdf8d9f1@linaro.org>
 <CAJ307EiJ1SEdnnqEFFL-=YeO3XNtAJLLctixvxxFasQBhu0eFQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ307EiJ1SEdnnqEFFL-=YeO3XNtAJLLctixvxxFasQBhu0eFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 5/1/24 14:23, Clément Chigot wrote:
> On Fri, Jan 5, 2024 at 12:32 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Hi Clément,
>>
>> On 5/1/24 11:24, Clément Chigot wrote:
>>> This implements the multiprocessor status register in grlib-irqmp and bind
>>> it to a start signal, which will be later wired in leon3-generic to
>>> start a cpu.
>>>
>>> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
>>> Signed-off-by: Clément Chigot <chigot@adacore.com>
>>> ---
>>>    hw/intc/grlib_irqmp.c | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>
>>
>>> @@ -323,6 +334,8 @@ static void grlib_irqmp_reset(DeviceState *d)
>>>
>>>        memset(irqmp->state, 0, sizeof *irqmp->state);
>>>        irqmp->state->parent = irqmp;
>>> +    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << 28)
>>
>> Can you #define this magic '28' number?
>>
>>> +        | ((1 << irqmp->ncpus) - 2);
>>>    }
>>>
>>>    static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
>>> @@ -336,6 +349,9 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
>>>        }
>>>
>>>        qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
>>> +    /* Transitionning from 0 to 1 starts the CPUs.  */
>>
>> What about 1 -> 0?
> 
> It does nothing. I have updated the comment to mention it.
> For the doc (also mention it in the commit message now).
>    | [15:1] Power-down status of CPU [n]: reads ‘1’ = power-down, ‘0’ = running.
>    | Write to start processor n: ‘1’=to start ‘0'=has no effect.

Then grlib_irqmp_write() could be simplified as:

      case MP_STATUS_OFFSET:
-        /* Read Only (no SMP support) */
+        state->mpstatus = deposit32(state->mpstatus,
+                                    value, 0, IRQMP_MAX_CPU);
+        for (unsigned i = 0; i < irqmp->ncpus; i++) {
+            qemu_set_irq(irqmp->start_signal[i],
+                         extract32(value, i, 1));
+        }
          return;


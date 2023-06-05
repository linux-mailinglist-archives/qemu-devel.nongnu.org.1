Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B372233C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:18:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67GX-0002QR-MV; Mon, 05 Jun 2023 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67GT-0002Px-N2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:16:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67GR-0002jk-U9
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:16:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso47068445e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685960198; x=1688552198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7go8rNNqx+hVATnyYQ8Zd/VCap0oO2FBclO+5M2vqJc=;
 b=o6raho6FyLt4DmvWDnkZiWijw1AS9VC1ruWh0rZEo+EAIip3lP8yrstzaiOcpj5RIs
 VcrrMXeUwlbnGn0DViC9cBx3Z8JtfXnuqgQHFvp4RPx4VDZKLKVib/JTJNhWWHg5jNc6
 sJiYHzgSerur92zO/BTZG0xhce4URCzWXG/AvQK03segCUlNycrEbDagJmcfyIBYbSzg
 HhJHP8WLgebuhIRb1EqUIEBWEEQ0jEHCwSmwp+JV+XPN/H9+VDzdY5O8BRcVXnK0yb2H
 Id2Sd1RMgO/QXUNWa/+pAT8LYRN5ylHoRfxFO7DPv3svBH4NIh+KndPbB/eza5yOOnEu
 mKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960198; x=1688552198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7go8rNNqx+hVATnyYQ8Zd/VCap0oO2FBclO+5M2vqJc=;
 b=JqbOs2ez60ZXjX6rA8Qx4JFeJyLk1sHAL0GHrqN6B5MXhy0k2YIMPv7WsPU1wnvtKv
 aZFYhWYp0tZe0gytNWzi9YZ/mvT9eN63PR7zphCauR82gLs3uH95Dfv8zYWF5n1cQk/Y
 b7PbUyl0JD8LgpxRCR6Nhh5uuVijklz/aZOYviYGcs6rWyWTdWkRLNEw7S5pZRzRvoKb
 U05Fp1pxEyxfa3aKNoNffYQZh28r8vov3G2JdYGKmIsB1Urt1y767YqMXn8q0AfwJ1ph
 LEUeY2ZRYXBc38bVUHtrIuA0gY6F673gLAbJH6Trg0TpRisZEVDd2iQv2DKWgVhvesot
 GCng==
X-Gm-Message-State: AC+VfDyZav2Aph19taOPig58f/bk0tz/YtGyX+ctwYEV6kC5suw6L3dV
 sv4Z3JAvaLJ0an9gFMC4MNK3Jkd2V5gzWGD9wKs=
X-Google-Smtp-Source: ACHHUZ6PB14bDgeJ1okMYbNnxO8lNxqJReGGwg7CxLJLmy5EO+chYx8BoICRU+X7o4Ysojma4MNssA==
X-Received: by 2002:a05:600c:b43:b0:3f5:ffe2:91c0 with SMTP id
 k3-20020a05600c0b4300b003f5ffe291c0mr8051926wmr.0.1685960198141; 
 Mon, 05 Jun 2023 03:16:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f080b2f9f4sm13833767wmi.27.2023.06.05.03.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:16:37 -0700 (PDT)
Message-ID: <596a040e-8d92-571f-5c18-618c707b6340@linaro.org>
Date: Mon, 5 Jun 2023 12:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 15/15] hw/timer/arm_timer: QOM'ify ARM_TIMER
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-16-philmd@linaro.org>
 <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
 <eae9ddaa-a914-b4f2-7fea-0f1731ab0706@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <eae9ddaa-a914-b4f2-7fea-0f1731ab0706@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/6/23 20:12, Mark Cave-Ayland wrote:
> On 03/06/2023 19:07, Mark Cave-Ayland wrote:
> 
>> On 31/05/2023 21:35, Philippe Mathieu-Daudé wrote:
>>
>>> Introduce the ARM_TIMER sysbus device.
>>>
>>> arm_timer_new() is converted as QOM instance init()/finalize()
>>> handlers. Note in arm_timer_finalize() we release a ptimer handle
>>> which was previously leaked.
>>>
>>> ArmTimerState is directly embedded into SP804State/IcpPitState,
>>> and is initialized as a QOM child.
>>>
>>> Since the timer frequency belongs to ARM_TIMER, have it hold the
>>> QOM property. SP804State/IcpPitState directly access it.
>>>
>>> Similarly the SP804State/IcpPitState input IRQ becomes the
>>> ARM_TIMER sysbus output IRQ.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/timer/arm_timer.c | 109 +++++++++++++++++++++++++++----------------
>>>   1 file changed, 70 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
>>> index 82123b40c0..a929fbba62 100644
>>> --- a/hw/timer/arm_timer.c
>>> +++ b/hw/timer/arm_timer.c
>>> @@ -17,6 +17,7 @@
>>>   #include "qemu/module.h"
>>>   #include "qemu/log.h"
>>>   #include "qom/object.h"
>>> +#include "qapi/error.h"
>>>   /* Common timer implementation.  */
>>> @@ -29,14 +30,18 @@
>>>   #define TIMER_CTRL_PERIODIC     (1 << 6)
>>>   #define TIMER_CTRL_ENABLE       (1 << 7)
>>> -typedef struct {
>>> +#define TYPE_ARM_TIMER "arm-timer"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(ArmTimerState, ARM_TIMER)
>>
>> As per our QOM guidelines ArmTimerState and the OBJECT_* macro should 
>> live in a separate header file.
> 
> Ah wait: does "ArmTimerState is directly embedded into 
> SP804State/IcpPitState, and is initialized as a QOM child." mean that 
> ARM_TIMER is never instantiated externally?

Correct, while the type is exposed as any QOM type, it is internal to
the two devices, thus local to this unit.

I don't mind exposing the state to have a consistent QOM style.

What was discussed with Alex is:
- We don't need to convert all non-QOM devices, but
- Heterogeneous machines must contain only QOM devices;

- If a non-QOM device forces incorrect API use or abuses,
   better convert it.

>>> +struct ArmTimerState {
>>> +    SysBusDevice parent_obj;
>>
>> And don't forget to add a blank line here too.

OK.

>>>       ptimer_state *timer;
>>>       uint32_t control;
>>>       uint32_t limit;
>>>       uint32_t freq;
>>>       int int_level;
>>>       qemu_irq irq;
>>> -} ArmTimerState;
>>> +};



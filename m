Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2601722352
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67Ko-0004SU-Gp; Mon, 05 Jun 2023 06:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67Kh-0004KX-0A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:21:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67Kf-0003XD-AB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:21:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so39806925e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685960459; x=1688552459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/i1IF1cHGu3YBIPrBtGDl6FsaB1DSpDzEDQxZZMLEQ=;
 b=KBOgKdDLAlJEWrNp1O+6mvas2J7lg9a27+03qW8Mcf9TDqtWh8CqPXTgkrisxxrpRf
 NtGocKZ69YIlGwMeDynB0FJiiNVexkNli6f4CTO1zv2SI0PG6Y9ODwo6oejQh4td8Etl
 Phgr8JxZwbVUA8VBhqgQTJlsy6ItJnGEn9Kf70n/1SmxqCoVjwxrCpGcuCGu4CAZUIVf
 GSrOIuL9dOsq6sB40KgalBWlCT4k1q5w+EHeYVQkQDYzcpGFLsT+E3TzrrKcZ/s/tUVX
 k7fkjluErcTtUK5WwWGNs7szSv1m99HfBSI1KTV35YN/lk5MydLi5qqxHfeEvpcfaXqD
 hBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960459; x=1688552459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/i1IF1cHGu3YBIPrBtGDl6FsaB1DSpDzEDQxZZMLEQ=;
 b=bqMswcxP1mhpjt6PHQgvhVYzbKepHfUpxSe9BanFI41YEjjspcsK2qKmuqkV51DCqd
 uKjVlAvskJ5ag6vkP5kwYk2CyXYxOKd1AXRWiNRIctYjya0If3kInJgI9GJsnAyV2swJ
 SGN+tkVbetZQ2idYXcGqyuOOoH9qxucZlhtqWczr1vSHZMviGpvN/FE6Z4ZkENL2jnG3
 Sqz6ENSZyWdS+edQr2mcOA1OmG7meUfFAm6iuTW73T5xc00sHvFKIFcu4i93ZdNa0HAk
 uXGPXHaI/3pFoLbUvY3+LUSgLOuGlxs0sMaemZIvOtrrQVkTi4+rdeXNfBJoC7uoqElM
 oV/Q==
X-Gm-Message-State: AC+VfDzYqARIfVhxEFFOQvoBiy/1+r+aYotSLg2T5tYZXkkCTWeM7RZ7
 rBi1gUjFn37+iOuf7Af5PvH+3w==
X-Google-Smtp-Source: ACHHUZ71da8GCgOySE1TZPeJGTtnnnd8i2Y4oTxwxYUAq2sdcVFRp98iS40K40VpRhNT7Vhwc/Ln2w==
X-Received: by 2002:a7b:cd1a:0:b0:3f7:3a19:b951 with SMTP id
 f26-20020a7bcd1a000000b003f73a19b951mr2031883wmj.21.1685960459636; 
 Mon, 05 Jun 2023 03:20:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bcb90000000b003f6028a4c85sm13795249wmi.16.2023.06.05.03.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:20:59 -0700 (PDT)
Message-ID: <33d6d99f-5a75-9891-b43f-c9caf40a62de@linaro.org>
Date: Mon, 5 Jun 2023 12:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 15/15] hw/timer/arm_timer: QOM'ify ARM_TIMER
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-16-philmd@linaro.org>
 <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <43f014f5-6dd7-7c46-eea4-ed9cffe8ec48@ilande.co.uk>
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

On 3/6/23 20:07, Mark Cave-Ayland wrote:
> On 31/05/2023 21:35, Philippe Mathieu-Daudé wrote:
> 
>> Introduce the ARM_TIMER sysbus device.
>>
>> arm_timer_new() is converted as QOM instance init()/finalize()
>> handlers. Note in arm_timer_finalize() we release a ptimer handle
>> which was previously leaked.
>>
>> ArmTimerState is directly embedded into SP804State/IcpPitState,
>> and is initialized as a QOM child.
>>
>> Since the timer frequency belongs to ARM_TIMER, have it hold the
>> QOM property. SP804State/IcpPitState directly access it.
>>
>> Similarly the SP804State/IcpPitState input IRQ becomes the
>> ARM_TIMER sysbus output IRQ.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/timer/arm_timer.c | 109 +++++++++++++++++++++++++++----------------
>>   1 file changed, 70 insertions(+), 39 deletions(-)


>> -static void arm_timer_reset(ArmTimerState *s)
>> +static void arm_timer_reset(DeviceState *dev)
>>   {
>> +    ArmTimerState *s = ARM_TIMER(dev);
>> +
>>       s->control = TIMER_CTRL_IE;
>>   }
> 
> If you're currently set up to test the ARM timers with these changes, is 
> it worth considering converting this to use the Resettable interface at 
> the same time?

Good point. Then ARM_TIMER doesn't need to inherit from SysBus: if the
parent device resets it explicitly, it can be a plan QDev.

Peter, what do you think?

Even generically, I wonder if a QDev could resets all its QOM children,
propagating each ResetType.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3C747455
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhFg-00006b-6K; Tue, 04 Jul 2023 10:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhFe-0008TF-F4
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:43:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhFc-0001Ew-V4
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:43:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so66912675e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688481810; x=1691073810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c/MhayssYSEpEhJFfD4NExHaxpwopuCo3xwJwvudW7o=;
 b=EqwAGPKaeBGG6aLiAlYIHx8lIZNL/oWYaUp9aFRwl6on2FsFsyh+FQLXCc90Wm9geK
 cfk3twqavF+yHwn78loXIj/eIZomgBWUnrPmmSYoe8iZbXhR8Kmv9oiz3EScSJsSZ11D
 2k427YJLzASl0ZeaqotDNjv/B0Cw7YGt2pWma4RcUccFn2C1NVukAE/yLd4Tifz80wLd
 UhL6MH5N795qJIErpIGJdYl3MRIWBFNjLGI0Sn+mCsQ7xND3B3GJGE3zWR34WrRQf2ve
 hqEmtpYaUlHJnAibPvbkUFgY2prtCO6sCNHXNVE2KqRVMZMIfSuWz/EzeYhYn4Th8tY9
 QuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688481810; x=1691073810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c/MhayssYSEpEhJFfD4NExHaxpwopuCo3xwJwvudW7o=;
 b=XWz/TXGYsEC6awkjXYj0yQnqcX/lOZJYDqonLOk+d+azGcyWZ1hbBk5MaT+rjE3YgF
 5AXZqBKFSYUS6DxoxQGzGQjoz0EdfLrqV9I/vf+nVxSoOoztTn2q0giqs2/O4bflzmvh
 88Ds93TfEqUDy+IzWQ/2vtMQQxh0mh/dyI2TmSudh5y3lX75TdpWQhbS4qr0Gy4fvwBI
 yJDbDu3llabWe/BSRNg4UDzMLCFewV2KJijP7D28z6nZO2eA6TOcvfxh3pjqZFFjXczV
 uNeNhsie92/XzRbmsU0EyYfQarZIZWYEakDStFB6/VvfVna8CiCEj+BUpf983IJ/Iz2V
 XvTg==
X-Gm-Message-State: AC+VfDzW94U+CY8rOf9+5LrKwdWMRh9Q68ZL2ky14hlIZIGVSVOZsX/Z
 ZyPn+J3Kmp+BL6lJYiM9xivq+w==
X-Google-Smtp-Source: ACHHUZ5jnbQnHV9qv2oKowcX/dBVrtmKHDvMc7QmQCUJN/gNI2tX2tWDL3KlzGBZIyDBG+06oFnSLA==
X-Received: by 2002:a7b:c315:0:b0:3f4:d18f:b2fb with SMTP id
 k21-20020a7bc315000000b003f4d18fb2fbmr13125226wmj.8.1688481810616; 
 Tue, 04 Jul 2023 07:43:30 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a7bcd89000000b003fbb5506e54sm16852184wmj.29.2023.07.04.07.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:43:30 -0700 (PDT)
Message-ID: <a986f942-a49f-032a-a50b-ae9dca3996c6@linaro.org>
Date: Tue, 4 Jul 2023 16:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] hw/timer/arm_timer: Add missing sp804_unrealize()
 handler
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-4-philmd@linaro.org>
 <CAFEAcA8ZXZ1x9ruh5DuFF+xMM+75W-dcjHJQXQLBcqi0i-peHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8ZXZ1x9ruh5DuFF+xMM+75W-dcjHJQXQLBcqi0i-peHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/6/23 16:41, Peter Maydell wrote:
> On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Release the IRQs allocated in sp804_realize() in the
>> corresponding sp804_unrealize() handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/timer/arm_timer.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)


>> +static void sp804_unrealize(DeviceState *dev)
>> +{
>> +    SP804State *s = SP804(dev);
>> +
>> +    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
>> +        qemu_free_irq(s->timer[i]->irq);
>> +    }
>> +}
> 
> I don't really see the purpose in this. It doesn't actually
> avoid a leak if we ever destroy an SP804, because
> s->timer[i] itself is memory allocated by arm_timer_init()
> which we don't clean up (the arm_timer_state not being
> a qdev). If we did convert arm_timer_state to qdev
> then these interrupts should turn into being sysbus irqs
> and gpio inputs on the relevant devices. (In fact if you
> were willing to take the migration-compat hit you
> could just have the sp804 create a 2 input OR gate and
> wire the arm_timer irqs up to it and use the output
> of the OR gate as the sp804 outbound interrupt line.)

Thank for the suggestion, I didn't notice the OR.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17555710D18
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Aqt-0007Kd-T1; Thu, 25 May 2023 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2Aqn-0007FB-Rn
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:17:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2Aqm-00025w-3q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:17:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso4428425e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685020670; x=1687612670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pEEr3CfBdx2rP0p6nDBknQNxdaBA2M9y66YlDHR4tCo=;
 b=Kwr5Q3ezPqJobPcsxhROlvumiznT9DgL/c1JuRLY54I2Zsc6Q+iMCe1cv8RRQGT5pS
 AkwcRTNTsNM6Zrg5mtCm2HXFH2Lxv2zna4tKxo+3mfSggMwAIhDINQ49kZwsIf2nekj2
 JiG2KyAg9UO+jJ6foVgc9vHgBj4l2xCMWrO/xlA6ZEgANS/JfxfeI2T58ETQPwB7l2u+
 1p1QpyO1nGwjCKdKx92vfoRuagFcAd63yS+CW/1XFuqbgL/ZVsDngOeLsb2Q/RVFfRD/
 QaEqaLR7laelzpXzPAOdQjYprwqYiufHUEHAInG8ApZ3jeBLcwMGDhQ8B++Gbmc7pfd9
 SrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020670; x=1687612670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pEEr3CfBdx2rP0p6nDBknQNxdaBA2M9y66YlDHR4tCo=;
 b=XOEhuWJQlFb0gLa6Q+CXg69t2G6+Xdk8uLHb8CQOqdPA6K4EMSfg6bPyCC1Qj+yD0+
 aOstRwhA+JbzcC5xk55puRjdKfAsk2dgW6FkghR9ueDex16Wke2mD1yQ8NIsRnUAL8te
 +aLpC03ll3jE/i35pxDNFJnWnh+NnwOyT0d5hm5ESB6l96dmXf4YaDlbwBjjn48wBmAY
 WoDpYHn6C5Zai70SO47s9M88FwIRBRzCVhm4dWZdWZyVuZd/Sg7NxsENYyVx1C9IQJv5
 oR0544XBYaYEdjtMsOhiREwVj8ETUTUOOhITxnPLgcoZNQq1nAU9kkkYhnaGYB4jpWsV
 fXcQ==
X-Gm-Message-State: AC+VfDxjvDjrFOpf/I6M+5c9LGfYI9o2zdyMTtXZkWbYgjDc+Hlqj8Rz
 TVEaDJHzcpnR4OvhWtiwKkorXA==
X-Google-Smtp-Source: ACHHUZ7sqmKBWbMWMQAhXe3tjx57Mnt83x0HgbHBnibfnMv31uZ7iYIUcFAd+1/KV0pAVoQoDawA3g==
X-Received: by 2002:a05:600c:248:b0:3f4:fffc:cd74 with SMTP id
 8-20020a05600c024800b003f4fffccd74mr2400775wmj.16.1685020670086; 
 Thu, 25 May 2023 06:17:50 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 v10-20020adfe28a000000b003063a1cdaf2sm1780166wri.48.2023.05.25.06.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:17:49 -0700 (PDT)
Message-ID: <af5d9e7a-a19c-b269-5a33-a3fc79e79094@linaro.org>
Date: Thu, 25 May 2023 15:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-10-philmd@linaro.org>
 <CAFEAcA_7dkWB9qPkzYmW6_F1eaAet0PPk0PHywGS2EpAkFAsUQ@mail.gmail.com>
 <87zg5stvyi.fsf@linaro.org>
 <CAFEAcA9EYLWnm6kEZGJn=Ah_wy1oE+8u0bZuVPq8=wTxtUo_Hw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9EYLWnm6kEZGJn=Ah_wy1oE+8u0bZuVPq8=wTxtUo_Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/5/23 14:55, Peter Maydell wrote:
> On Thu, 25 May 2023 at 13:52, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Mon, 22 May 2023 at 16:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Do not transmit characters when UART or transmitter are disabled.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Last time somebody tried to add checks on the tx/rx enable bits
>>> for the PL011 it broke 'make check' because the hand-rolled
>>> UART code in boot-serial-test and migration-test doesn't
>>> set up the UART control register strictly correctly:
>>>
>>> https://lore.kernel.org/qemu-devel/CAFEAcA8ZDmjP7G0eVpxcB1jiSGarZAbqPV0xr5WquR213mBUBg@mail.gmail.com/

Hmm I ran 'make check-qtest' my build directory only targets aarch64,
I probably missed the arm (32-bit) tests :/

>>> Given that imposing these checks doesn't help anything
>>> much and might break naive bare-metal tested-only-on-QEMU
>>> code, is it worthwhile ?
>>
>> Surely we aim to be a correct model so the fix should be in our naive
>> and incorrect code?
> 
> In our own test suites, sure -- we should probably fix that
> even if we don't change the PL011 model to require it.
> But if we let this kind of thing get past us in our own testsuite,
> it suggests there's probably a lot of similar naive code out
> there in the world -- these Arm boards with PL011s are pretty
> commonly used for "my first bare metal assembly program" stuff
> and there's a lot of cargo-culting of how to do things like
> serial output, and programs that were never tested on any
> real hardware...

OK. I'll add a comment, keep the current behavior when TX is
disabled, but add a GUEST_ERROR log message.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAF75E2C4
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:03:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNaao-0006iO-Cb; Sun, 23 Jul 2023 11:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNaak-0006i0-S2
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:01:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNaaj-0003Vg-9M
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:01:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso32698115e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690124507; x=1690729307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQh/9IFaX20bWV04gvARogqUgIV64wzBvQuFvvlmxmE=;
 b=CNRb8SQd/FL8G7lIhaby/NI7hFCgbIFg2OGYNwDpq7GBc+i42iap8i7r8qZvUHW/tv
 /uh57Mmy5Bv7opwJkhpGnIdQBdQSFgk4Jv11Sn54qBU5TYAyW2g4B1WHeJ8rG9ty8GzP
 3s7hWx4EtR98kIX731EZEjZt+ToWJ1eFpepDycyk+kod1EomnofJpSCzlXSfqgCzJzPT
 wxLxHMQRrn4bhcSRFRhpWCllD1iw/rgQHE7LWQWximypJO60WWk8b11MOWx50kSVJXGJ
 Lnpj44soKqXWhdOrxgmCt2DvhidpJnApWtx8YOb2UdI8DLeWFC6S0GcCQlmpSBUAFuH8
 uJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690124507; x=1690729307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQh/9IFaX20bWV04gvARogqUgIV64wzBvQuFvvlmxmE=;
 b=FNnPXtjq9xKshTTAmrpj3gju6i9ijJ0lJ05yEfJMtXQsodzxWXaAZcJU1+j0k8+o/m
 zahqZpzXLgxHAQ5vZljY88fTCWv/IaxGXRKnveJTKzUYKsVvhcbkbIPCoDSecAul2opO
 z4VLu41jmoRqMininT/J3fEV/vkP/jkDOc5K/dv3JM/5wX3cA3uJF2Pb0DgJ5iWqoOQm
 RmJs67BlBEToOT/f5rZOhynDpX6H3hSMM0Budxo/JWbRwuTtoUWRakhyIJZt8jzxyNCy
 MlGD3SvFB7wPRnpGNVVzsJLWtwzlffkxff+bK0FGZSNDe4czShzz/MiLgprGwgnyQiVw
 lV5w==
X-Gm-Message-State: ABy/qLYn+bSre1DOlqYzAqGzFOrGVhpsN/bxAVpoo2NAqc3OVAirnmMX
 Z7cmweP1latfyPRYKYz5EfE6EA==
X-Google-Smtp-Source: APBJJlG+Z8g5wHr9x/Mcpl3Wut3XcVwGSTfFYa2t66S8Ta2aGabsmZd08OSUI+OXUBJKt+oYle+VbQ==
X-Received: by 2002:adf:ce11:0:b0:313:f29f:5eb3 with SMTP id
 p17-20020adfce11000000b00313f29f5eb3mr6543267wrn.32.1690124507087; 
 Sun, 23 Jul 2023 08:01:47 -0700 (PDT)
Received: from [172.20.9.211]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a05600c045200b003fc01495383sm10486965wmb.6.2023.07.23.08.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:01:46 -0700 (PDT)
Message-ID: <52b4072c-7f8b-6de3-76df-a42898e96a65@linaro.org>
Date: Sun, 23 Jul 2023 16:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] include/exec: Add WITH_MMAP_LOCK_GUARD
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230722113507.78332-1-richard.henderson@linaro.org>
 <20230722113507.78332-2-richard.henderson@linaro.org>
 <CAFEAcA_G1TCCUiCTKN4JGBvMji5YFpUn74P+uEeXsSnCUJbJ=A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_G1TCCUiCTKN4JGBvMji5YFpUn74P+uEeXsSnCUJbJ=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/23/23 15:18, Peter Maydell wrote:
> On Sat, 22 Jul 2023 at 12:35, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/exec-all.h | 10 ++++++++++
>>   bsd-user/mmap.c         |  1 +
>>   linux-user/mmap.c       |  1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 5fa0687cd2..d02517e95f 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -629,6 +629,15 @@ void TSA_NO_TSA mmap_lock(void);
>>   void TSA_NO_TSA mmap_unlock(void);
>>   bool have_mmap_lock(void);
>>
>> +static inline void mmap_unlock_guard(void *unused)
>> +{
>> +    mmap_unlock();
>> +}
>> +
>> +#define WITH_MMAP_LOCK_GUARD()                                            \
>> +    for (int _mmap_lock_iter __attribute__((cleanup(mmap_unlock_guard)))  \
>> +         = (mmap_lock(), 0); _mmap_lock_iter == 0; _mmap_lock_iter = 1)
> 
> All our other WITH_FOO macros seem to use g_autoptr rather than
> a raw attribute((cleanup)); is it worth being consistent?

I didn't think it worthwhile, no, since that requires even more boilerplate.

> (This one also doesn't allow nested uses, I think.)

It does, since each variable will shadow the next within each context.


r~


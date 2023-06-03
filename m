Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08296721116
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 18:03:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ThK-0001AE-08; Sat, 03 Jun 2023 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ThH-00016I-M0
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:01:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ThF-0003Vj-6x
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 12:01:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b065154b79so33656335ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685808100; x=1688400100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oN1W3QZzguABfsk/9SDL/zGs9EOs0rrgU2900uxVlYE=;
 b=Rk8+9COpLeoRBW7kUH/ooOcjv76VGRl9BausOlE9Js7U9WA19IigLwVBtQJlt7uI4N
 36MnERZKK5hBhqK4Bkvkpst18zPOC/a2l5xyROmAaUrUbIbIGXoZ/U2DVDy2R1peS3Dd
 uoGh5atO/3o+0DKcmRfu8VGlLq8g71tZ1lRRQ2+SwB2xselp+x+NKagHuCZiWmHwIXKQ
 eDsu1h/9lGEHhPxlXYb3eZSppFdzKB/D7b26+MZiZfeZ9fXN/V+Bl/vYAC+voK89nSw1
 5WGorFqFhqHHR+xe0IuSQj4uJw66lmaxmINzRIHAQjZe2z3EL5KGbeSf0QNa73p6XYuL
 rl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685808100; x=1688400100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oN1W3QZzguABfsk/9SDL/zGs9EOs0rrgU2900uxVlYE=;
 b=f3Ch87gZAzTCX1jHrGbooYWOhQwb/zP8/fJC/DcqHo1B5yHHzpuS2yUKN15AJKQHGy
 hmxMv0cKkudLP6/bphEd9lMj55Pq6gxBKLcDPne/EeXfBxI7Os3VMEjpZZMV+V/PjjLb
 JICufBnjCO8ANPXOZ9c5cEMrGdiev5GUDrEnu42YsHnboUZIMVIPiCjv5wnyeq5bboFN
 jQyqjHi5btMSdY6dEl0e+w0lvsiCd3RdsFj8pCHFlyscc/BjA8svOWayfvsufI6lvD27
 /v0X7sW3E7sXT3a+rqx18593j3pORJ0w/60NBm8zwRKPE4DCKeyFZ9+c92wrOs+u00HJ
 6ndg==
X-Gm-Message-State: AC+VfDysRgJibMk12K0Q+4g6HGon+a1IAtqYXhL9uoTUZy4/Vl81FuBF
 n7LTxKwZKNM+p+uEN6uDEtfTDQ==
X-Google-Smtp-Source: ACHHUZ4FwrTU3z/TteXgciOt8hMb+hULOoCivNiLXN0yH70c6y89mGLXWvUEGykQasvCp2HpXTniZA==
X-Received: by 2002:a17:903:452:b0:1ae:89a:a4 with SMTP id
 iw18-20020a170903045200b001ae089a00a4mr2671718plb.8.1685808099647; 
 Sat, 03 Jun 2023 09:01:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a170902ec8a00b001ac8e0ea157sm3369387plg.144.2023.06.03.09.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 09:01:39 -0700 (PDT)
Message-ID: <c9e2980e-54bd-1b25-60b9-3351417aaecd@linaro.org>
Date: Sat, 3 Jun 2023 09:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 31/35] host/include/aarch64: Implement aes-round.h
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
 <20230603023426.1064431-32-richard.henderson@linaro.org>
 <CAMj1kXE5SKJS9YRuV6H3z84JvSMHDBkFWVuue8yMyYVK7TVkSw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXE5SKJS9YRuV6H3z84JvSMHDBkFWVuue8yMyYVK7TVkSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/3/23 05:50, Ard Biesheuvel wrote:
> On Sat, 3 Jun 2023 at 04:34, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Detect AES in cpuinfo; implement the accel hooks.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/aarch64/host/aes-round.h | 204 ++++++++++++++++++++++++++
>>   host/include/aarch64/host/cpuinfo.h   |   1 +
>>   util/cpuinfo-aarch64.c                |   2 +
>>   3 files changed, 207 insertions(+)
>>   create mode 100644 host/include/aarch64/host/aes-round.h
>>
>> diff --git a/host/include/aarch64/host/aes-round.h b/host/include/aarch64/host/aes-round.h
>> new file mode 100644
>> index 0000000000..27ca823db6
>> --- /dev/null
>> +++ b/host/include/aarch64/host/aes-round.h
>> @@ -0,0 +1,204 @@
>> +/*
>> + * AArch64 specific aes acceleration.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HOST_AES_ROUND_H
>> +#define HOST_AES_ROUND_H
>> +
>> +#include "host/cpuinfo.h"
>> +#include <arm_neon.h>
>> +
>> +#ifdef __ARM_FEATURE_AES
>> +# define HAVE_AES_ACCEL  true
>> +# define ATTR_AES_ACCEL
>> +#else
>> +# define HAVE_AES_ACCEL  likely(cpuinfo & CPUINFO_AES)
>> +# define ATTR_AES_ACCEL  __attribute__((target("+crypto")))
>> +#endif
>> +
>> +static inline uint8x16_t aes_accel_bswap(uint8x16_t x)
>> +{
>> +    /* No arm_neon.h primitive, and the compilers don't share builtins. */
> 
> vqtbl1q_u8() perhaps?

Ah, yes, thanks.


>> +static inline uint8x16_t aes_accel_aesmc(uint8x16_t d)
>> +{
>> +    asm(".arch_extension aes\n\t"
>> +        "aesmc %0.16b, %1.16b" : "=w"(d) : "w"(d));
> 
> 
> Most ARM cores fuse aese/aesmc into a single uop (with the associated
> performance boost) if the pattern is
> 
> aese x, y
> aesmc x,x
> 
> aesd x, y
> aesimc x,x
> 
> So it might make sense to use +w here at least, and use only a single
> register (which the compiler will likely do in any case, but still)
> 
> I would assume that the compiler cannot issue these separately based
> on the sequences below, but if it might, it may be worth it to emit
> the aese/aesmc together in a single asm() block

There could be shuffling.  It's low probability, but possible.

I really should move the builtin test to meson, as clang-16 fixes the builtin visibility 
issue.  I can see that gcc knows fusion of these pairs; I assume clang does as well, but I 
don't know the code base well enough to check.

I suppose it's going to be years until clang-16 can be assumed, as Debian bookworm is to 
be released this month with clang-14.  So it's probably worth spending a few more minutes 
on this now.


r~


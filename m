Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799DE704FE5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyv5z-0006qn-Ht; Tue, 16 May 2023 09:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv5x-0006qG-Bw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:52:05 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv5s-0004yJ-Kd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:52:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-24e0c29733fso12641656a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684245119; x=1686837119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isuqGXRqeLm3OlOI1iyHKmsTIxmfbDOsK8U2AZN/uXc=;
 b=kWgMjrCKV+y3LlTNaJNfpHuOKQpfNSVPc0nGGH/cXvFHblLu5HH+0vwcmeDnPApcUh
 MI2wSUp9z9davi//5Q3cLl7mCT3OwTPpplXMiWPFrAUk36/8gaNS9PNZ0THF1QKLdV/K
 GMlYEKvcyQTVxZdl3LlEhKLFa+OcZAFmcgrvSRGtVAM0nGDjL4QTm0agXK8gAT0ZkllC
 j5IEfmT3KExvbCEbnzHE2GPLUmzaPHXBs7RCTXEqPAdWhTTm+w8c+m5guqjg8g8D397d
 jszqGepfwM0WgAhaRvt6VueDEga2DFRTKHn+0oPYM6TikrDs3JoewgGKqVurqgjh9yp1
 02ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684245119; x=1686837119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=isuqGXRqeLm3OlOI1iyHKmsTIxmfbDOsK8U2AZN/uXc=;
 b=SKwHFlJJdMuQBoMwZKvEbP5ck/fTS3WD/Mp6g8neoVcjbpJ41RcXhxuNWcTEcw3wFg
 jI5N8RyZ3ARADYJVg/g2U4lHnTy+5KwE1exvVNrsa5pag0KpVM5or/JDTE/1v7WBn/ku
 QCVB1aFqQWjAsQB0ShJcu0OCwxsB61pl01DNLgVq8SG0qa2E5uT74FFSOiCIEOBIfx52
 kdfrkkLuLfWBQDkdn+b5twNoYpnHNFb5qnsquDs7GVRtxNnGCDp1E/FrfOqLijJaX02b
 xv2738JLI6d7lGY76K5ugOrL/LP5VPjdqkYg2roCdP/CMDqKfDkt2W44G0TurrqzjFbR
 CFPA==
X-Gm-Message-State: AC+VfDyUQW9FIbE6uGKnefDYnfhxO3TrBlNnuxdoJpqCkx2DB6zrPWLc
 8WA/PdketxX6vBq5nUqvl0diRg==
X-Google-Smtp-Source: ACHHUZ7Qb2aefzi9zjaN5GuQNGthHUFy8OX2zHSSbYKbIzLOR4xvxPl97gue8itsZ7em5oIEqee65Q==
X-Received: by 2002:a17:90b:3807:b0:24d:d7fd:86c3 with SMTP id
 mq7-20020a17090b380700b0024dd7fd86c3mr36952708pjb.16.1684245119157; 
 Tue, 16 May 2023 06:51:59 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a17090ab10900b0024e07ae2cfesm1629357pjq.38.2023.05.16.06.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 06:51:58 -0700 (PDT)
Message-ID: <0e0a1d89-8d7f-5ad7-f920-b361a19c8ef9@linaro.org>
Date: Tue, 16 May 2023 06:51:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 11/54] accel/tcg: Add aarch64 specific support in
 ldst_atomicity
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-12-richard.henderson@linaro.org>
 <CAFEAcA-En1=iy_M7o0Ky+5ZwOJ4TWxoNz7Yq27ftYgnbV9j8OA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-En1=iy_M7o0Ky+5ZwOJ4TWxoNz7Yq27ftYgnbV9j8OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 06:29, Peter Maydell wrote:
> On Mon, 15 May 2023 at 15:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We have code in atomic128.h noting that through GCC 8, there
>> was no support for atomic operations on __uint128.  This has
>> been fixed in GCC 10.  But we can still improve over any
>> basic compare-and-swap loop using the ldxp/stxp instructions.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/ldst_atomicity.c.inc | 60 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
>> index 69c1c61997..c3b2b35823 100644
>> --- a/accel/tcg/ldst_atomicity.c.inc
>> +++ b/accel/tcg/ldst_atomicity.c.inc
>> @@ -263,7 +263,22 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>>        * In system mode all guest pages are writable, and for user-only
>>        * we have just checked writability.  Try cmpxchg.
>>        */
>> -#if defined(CONFIG_CMPXCHG128)
>> +#if defined(__aarch64__)
>> +    /* We can do better than cmpxchg for AArch64.  */
>> +    {
>> +        uint64_t l, h;
>> +        uint32_t fail;
>> +
>> +        /* The load must be paired with the store to guarantee not tearing. */
>> +        asm("0: ldxp %0, %1, %3\n\t"
>> +            "stxp %w2, %0, %1, %3\n\t"
>> +            "cbnz %w2, 0b"
>> +            : "=&r"(l), "=&r"(h), "=&r"(fail) : "Q"(*p));
>> +
>> +        qemu_build_assert(!HOST_BIG_ENDIAN);
>> +        return int128_make128(l, h);
>> +    }
> 
> The compiler (well, clang 11, anyway) seems able to generate equivalent
> code to this inline asm:

See above, where GCC 8 can do nothing, and that is still a supported compiler.


r~


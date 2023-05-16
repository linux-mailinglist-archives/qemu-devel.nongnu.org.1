Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA1704FD3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:51:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyv4u-0005zE-RT; Tue, 16 May 2023 09:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv4o-0005yU-44
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:50:54 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv4k-0004oM-Hk
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:50:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5304d0d1eddso4727379a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684245048; x=1686837048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57MW2AM6RKbe/llk9WLHCI3L0KZQQn8HdJTDWDQuFfw=;
 b=wIU15ey424czJsEqP6MrCPaXlMmW0hg+tjMKmMUympSQmHcLQOvbFpyFY6LiLzkWT9
 Q/UUQU6Ankr58COZHndUW0+7OJ1gCTDOYp81GiAcDtZZiS9RieGQkGM31YmDUfxPQajL
 oJEubLSzpVL+qpxEPsPNO1qXP6rLfCA1yHHIXGlq7gAgtd+05Z6NqoAqKCtD2EuW5v4H
 7S/U2LFMMWK1pvrwv8ZAm+XiW2x8XoJ+0/CdF0ZJMi6BmssPiH8thR+rD/Ldlw7zafyY
 H/GIx/LVhLNWWvfj3++mYxYs1xEsqNo1S2IRBMR2XGyvYXhvU7TtICD0bcVwI+UCVKiZ
 vcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684245048; x=1686837048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=57MW2AM6RKbe/llk9WLHCI3L0KZQQn8HdJTDWDQuFfw=;
 b=fTBTojXwstw+PbfmjDVkVGQi6JIRUKbLigCZs9rYGBDji9HXUNF2O5mNCKH0fu+sRR
 bmcI4SWLNGqKH2+VsC+dNx7y8fEvckB5PWVIPHz1VAb1jpRzrZGS4ToS/feBDwf0hDJA
 XhN2jW9VWW5cjABeRh4nhfFH0lK8/xOTrEKWrpxfMBdj8QJMKlWX/qSG5mRDoCN4g0X8
 KZtJ0sXiDZoKfxl48rNhQJ5vv87uaK2jU/Xo2Hfab7zfcW416KcuYixHeQ0XK5ODor2p
 nXR6yczMOzfJj3NylqQXiXMEotb78BvsmBmJpPpGIVBWc7P3+JCCVOXDO0s/zywBjVvu
 U4rA==
X-Gm-Message-State: AC+VfDwTOel66/hEwzTYsOsc9+ABBaOl3oR3u9jSeOuY3Qm8mjCTrzTD
 Ml+kNAai9xsF1a6v1aWGT4+lMw==
X-Google-Smtp-Source: ACHHUZ5fzCeFUUrAudnoS6QP2fezjeX+kJpkdmIoEG3xD/TOVrBYYFnyDT76+YEGR3IGN5uQ7NTupg==
X-Received: by 2002:a17:902:bd06:b0:1ad:fc06:d7c0 with SMTP id
 p6-20020a170902bd0600b001adfc06d7c0mr12218404pls.1.1684245047806; 
 Tue, 16 May 2023 06:50:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a170902b10600b001ab06958770sm15578622plr.161.2023.05.16.06.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 06:50:47 -0700 (PDT)
Message-ID: <5d582ed2-c0df-9456-2089-45d053b81efd@linaro.org>
Date: Tue, 16 May 2023 06:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 10/54] accel/tcg: Use have_atomic16 in
 ldst_atomicity.c.inc
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-11-richard.henderson@linaro.org>
 <CAFEAcA_6jHw5kvqZNNR+2c_ihdPgD9d1ByBH0fNvDr6tX88jyA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_6jHw5kvqZNNR+2c_ihdPgD9d1ByBH0fNvDr6tX88jyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 5/16/23 03:38, Peter Maydell wrote:
> On Mon, 15 May 2023 at 15:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Hosts using Intel and AMD AVX cpus are quite common.
>> Add fast paths through ldst_atomicity using this.
>>
>> Only enable with CONFIG_INT128; some older clang versions do not
>> support __int128_t, and the inline assembly won't work on structures.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/ldst_atomicity.c.inc | 76 +++++++++++++++++++++++++++-------
>>   1 file changed, 60 insertions(+), 16 deletions(-)
>>
>> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
>> index dd387c9bdd..69c1c61997 100644
>> --- a/accel/tcg/ldst_atomicity.c.inc
>> +++ b/accel/tcg/ldst_atomicity.c.inc
>> @@ -35,6 +35,14 @@
>>
>>   #if defined(CONFIG_ATOMIC128)
>>   # define HAVE_al16_fast    true
>> +#elif defined(CONFIG_TCG_INTERPRETER)
>> +/*
>> + * FIXME: host specific detection for this is in tcg/$host/,
>> + * but we're using tcg/tci/ instead.
>> + */
>> +# define HAVE_al16_fast    false
>> +#elif defined(__x86_64__) && defined(CONFIG_INT128)
>> +# define HAVE_al16_fast    likely(have_atomic16)
>>   #else
>>   # define HAVE_al16_fast    false
>>   #endif
>> @@ -178,6 +186,12 @@ load_atomic16(void *pv)
>>
>>       r.u = qatomic_read__nocheck(p);
>>       return r.s;
>> +#elif defined(__x86_64__) && defined(CONFIG_INT128)
>> +    Int128Alias r;
>> +
>> +    /* Via HAVE_al16_fast, have_atomic16 is true. */
>> +    asm("vmovdqa %1, %0" : "=x" (r.u) : "m" (*(Int128 *)pv));
>> +    return r.s;
> 
> This is a compile-time check, so why if we can do
> 16-byte atomic loads would CONFIG_ATOMIC128 not be set?

This is *not* a compile-time check: have_atomic16 is initialized in 
tcg/i386/tcg-target.c.inc in patch 9.


r~


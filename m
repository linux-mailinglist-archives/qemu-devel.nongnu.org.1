Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45499771239
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 22:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSOIc-0007cx-4F; Sat, 05 Aug 2023 16:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSOIa-0007cp-Uv
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 16:54:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSOIZ-0003Pw-Ba
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 16:54:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-56401f1da3dso1716040a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691268894; x=1691873694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bei6ZjmrNUzujGjSlaqbhVIMZmn5Fgqb2L5CMsd1GB4=;
 b=XkwhLSrOmrgjhFaT9hgmo+jENnIz8J315fTNxuMvXN1ABiHo5+9Hz0n3TDLZfGStkp
 zo30y8AsYmq2U02+77CtVe9memJcqMVMmWZTZaQu4GG2NsrgrOWzayK0ZjDlJ/rilQjr
 xixcCuFQvxCfh0QKO1OQ9AoPYhNIjYCEBfumNsbon6qa4xj/CYi14jacXI28jt4/obf8
 Hs3FkX1yyl+9jvqvqPIzEnbIjLVZfd8KxmPC2cr7Dtpuo701b01zXdmlHl9YPwUx3p+K
 6CfZQuw3CKbmuwIERUfMcp+7jpaNxFhrd95pNUw+35QZo+UD8S+4olKJ8lSx/lhz17Bm
 pFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691268894; x=1691873694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bei6ZjmrNUzujGjSlaqbhVIMZmn5Fgqb2L5CMsd1GB4=;
 b=kIcMMptijcjvbjUQ/KjGHnJzJ02rHWXTxlQqd+Zxrnh/4txVq8uiaolBWmDbBf94Ei
 ZXbdOhMDHzQSWAlSNLPgUOSLzpEXV/01p71AI1EUqavq1OK14+vMhbg4TDlYtNlt7qrn
 Edvio+aJUGXYluDUQzwBA22udHOm9svNGU1k1TzvS988lmMhBTRv/Z7sdNSXRfuFqoZZ
 Qu+5hN4boLh42Y+2vWlTXOD5686jB7ChfVdkjkp7MyMl01LEzTi8/W3B1xOtnhXgIMXP
 1QwkolltpLuLT5oC/jpPEdjyqmL9V8+x3NQO0sIpeRw3vOWi73IGRkXq5gMQNjktCNTv
 tDnA==
X-Gm-Message-State: AOJu0Yw/A+tCxuYfPEHD9lTKLjjY9UHInJb5kXduqbGXuMeIVu8M+BT9
 tQW7fqst3CUcbC8xiQgFCKROrw==
X-Google-Smtp-Source: AGHT+IGP9P0qK6F66vnJEDEeS9DJQZPk5jNh+B80OOZq4GuIFOWTU+ndiHKzHNq/O+3zTQhKYQTpbg==
X-Received: by 2002:a17:90b:108c:b0:263:931b:bb5f with SMTP id
 gj12-20020a17090b108c00b00263931bbb5fmr3723188pjb.14.1691268893771; 
 Sat, 05 Aug 2023 13:54:53 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a17090274ca00b001bbb1eec92dsm3874735plt.224.2023.08.05.13.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 13:54:53 -0700 (PDT)
Message-ID: <fcdaa870-a3fd-1c7a-b2ae-06a25b0f6a29@linaro.org>
Date: Sat, 5 Aug 2023 13:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] Reduce generated code by 3% by increasing MMU indices
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <ZM59CkNZg5n4WXO3@p100>
 <53a2d13f-b508-0dba-5f0a-1b158372d1a4@linaro.org> <ZM6KOBfqFLumgpwm@p100>
 <e4c887b7-a055-3b30-8d41-0e8be0bc5d30@linaro.org>
 <a33687b2-066b-80e1-09b9-7ef108143147@gmx.de>
 <c7d0ff32-ee9a-94f7-bb1f-1bbb3b1f24ba@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c7d0ff32-ee9a-94f7-bb1f-1bbb3b1f24ba@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/23 13:04, Helge Deller wrote:
> On 8/5/23 21:40, Helge Deller wrote:
>> On 8/5/23 19:58, Richard Henderson wrote:
>>> On 8/5/23 10:43, Helge Deller wrote:
>>>>> If there were a way to change no more than two lines of code,
>>>>> that would be fine.  But otherwise I don't see this as being
>>>>> worth making the rest of the code base any more complex.
>>>>
>>>> Ok. What about that 6-line patch below for x86? It's trivial and
>>>> all what's needed for x86. Btw, any index which is >= 9 will use
>>>> the shorter code sequence.
>>>>
>>>> Helge
>>>>
>>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h index
>>>> e0771a1043..3e71e666db 100644 --- a/target/i386/cpu.h +++
>>>> b/target/i386/cpu.h @@ -2251,11 +2251,11 @@ uint64_t
>>>> cpu_get_tsc(CPUX86State *env); #define cpu_list x86_cpu_list
>>>>
>>>> /* MMU modes definitions */ -#define MMU_KSMAP_IDX   0 -#define
>>>> MMU_USER_IDX    1 -#define MMU_KNOSMAP_IDX 2 -#define
>>>> MMU_NESTED_IDX  3 -#define MMU_PHYS_IDX    4 +#define MMU_KSMAP_IDX
>>>> 11 +#define MMU_USER_IDX    12 +#define MMU_KNOSMAP_IDX 13 +#define
>>>> MMU_NESTED_IDX  14 +#define MMU_PHYS_IDX    15
>>>
>>> No.  The small patch would need to apply to all guests.
>>
>> Yes.
>>
>>> Perhaps something to handle indexing of CPUTLBDescFast, e.g.
>>>
>>> static inline CPUTLBDescFast cputlb_fast(CPUTLB *tlb, unsigned idx)
>>> { return &tlb->f[NB_MMU_MODES - 1 - idx]; }
>>>
>>> There's already tlb_mask_table_ofs, which handles all tcg backends;
>>> you just need to adjust that and cputlb.c> Introduce cputlb_fast with
>>> normal indexing in one patch, and then the second patch to invert the
>>> indexing may well be exactly two lines.  :-)
>>
>> You're cheating :-)
>> But ok, that's an easy one and I can come up with both patches.
>>
>> One last idea which came into my mind and which may be worth
>> asking before I start to hack the patch above...:
>>
>> include/exec/cpu-defs.h:
>> /* add some comment here why we use this transformation: */
>> #define MMU_INDEX(nr)    (NB_MMU_MODES - 1 - (x))
>>
>> target/*/cpu.h:
>> /* MMU modes definitions */
>> #define MMU_KSMAP_IDX   MMU_INDEX(0)
>> #define MMU_USER_IDX    MMU_INDEX(1)
>> #define MMU_KNOSMAP_IDX MMU_INDEX(2)
>> #define MMU_NESTED_IDX  MMU_INDEX(3)
>> ...
>>
>> Downside:
>> - of course it's a lot more than the 2 lines you asked for
>> Upsides:
>> - no additional subtaction at tcg compile time/runtime
>> - clear indication that this is an MMU index, easy to grep.
>> - easy to use
> 
> and it's actually a 1-line patch as you requested :-)
>    similiar to your approach above (multiple preparation patches,
>    one last patch which just changes
> #define MMU_INDEX(nr)    (nr)
>    to
> #define MMU_INDEX(nr)    (NB_MMU_MODES - 1 - (nr))
> 
> ;-)

:-) Plausible.  With a go, anyway.

r~



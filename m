Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17F791964
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAE0-0004bC-RP; Mon, 04 Sep 2023 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdADt-0004ZX-SI
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:06:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdADo-00018u-OC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:06:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso228052266b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693836389; x=1694441189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwyMHhZeSZclptVm/lKpxcxHNUhunHMxC2rmEIIQW3w=;
 b=CjHN4oEvNdgZfmpsSZZqDOWstPs3WrBkvi9fbUBBZl8onw/7eo6Z09gpZpscppBX5F
 e0t9yaMpodW6Tcwwx8ACGjIQY47QVmH07BTdfhV5/Av2392oS8dIYOLBL92fvrAJuNE/
 +bF1l4cwQWquWzpCXdniSlGcIMRMa1WklK9UedoBfD6XLo8+0m3a46XqcOkaPy/Eca6H
 qCttPR/PjgAUkMknc19TAKqSREXxsY6Y8KW2Z/XP1ZDd58QUVg9BuwQnI5aqbl7hJOwN
 KQG3AkosH72NlhKrq90MkW44DUBNVHNloxOBYhhNN8NkTWew4Dnp2oahTFF4tAKDhAzT
 v+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836389; x=1694441189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwyMHhZeSZclptVm/lKpxcxHNUhunHMxC2rmEIIQW3w=;
 b=MPSSEeHUZp1YuQdif9JHyPie0NPR02C37CcDVBVk3pEGkz21h+5/6LrNvQytqIKcsP
 Dv2+svLTd4qvdVg6+umHCtsjqnzX6ST6AP7nGSdmUuMDWhOjHWRD/4qYE2XDeUArW7s8
 ftwGQ8NxZYWWLkHcyy4ruiiI0Y0LA9k4y6aXEhEJlwP88PYoO5tYhb9f4gBf2Vg+5kQW
 Ms26Nd2JVUSU9Y3MNojNI0QYh5ROb8ynsXUqtrGwTW3e75jvko6DCJyLNgzpxFdRIotT
 d96D9BeCa0gQwQlPFLkR7CzvxddbdSQXdjChS7FtmH2mSwOxoc5qULenPVaouG28JAzo
 Tc9Q==
X-Gm-Message-State: AOJu0YwPXNmXnusr3nn5LSXvu0FN/8jdZirnkx7hMLxulTCrznKMJhQ5
 Wz9sd0AI3rx3//Tn0ujZZ39nsg==
X-Google-Smtp-Source: AGHT+IFBey0D0jWlV1oyH91a0YPB68bH0wGhoTEie4JT8nL7N5g5lP9cBQRyZ95U4FLD2OGoZDNq4A==
X-Received: by 2002:a17:906:6988:b0:99d:f560:5d3c with SMTP id
 i8-20020a170906698800b0099df5605d3cmr6900592ejr.23.1693836389281; 
 Mon, 04 Sep 2023 07:06:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a170906960100b00992d122af63sm6208298ejx.89.2023.09.04.07.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:06:28 -0700 (PDT)
Message-ID: <d136124b-ab5e-9868-8637-6cf3edb8ca54@linaro.org>
Date: Mon, 4 Sep 2023 16:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 02/11] target/arm: Clean up local variable shadowing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@csgraf.de>
References: <20230831225607.30829-1-philmd@linaro.org>
 <20230831225607.30829-3-philmd@linaro.org>
 <CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT_ydZWOwC0kBkDYYYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT_ydZWOwC0kBkDYYYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/23 12:46, Peter Maydell wrote:
> On Thu, 31 Aug 2023 at 23:56, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Fix:
>>
>>    target/arm/tcg/translate-m-nocp.c:509:18: error: declaration shadows a local variable [-Werror,-Wshadow]
>>          TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
>>                   ^
>>    target/arm/tcg/translate-m-nocp.c:433:14: note: previous declaration is here
>>      TCGv_i32 tmp;
>>               ^
>>    target/arm/tcg/mve_helper.c:2463:17: error: declaration shadows a local variable [-Werror,-Wshadow]
>>          int64_t extval = sextract64(src << shift, 0, 48);
>>                  ^
>>    target/arm/tcg/mve_helper.c:2443:18: note: previous declaration is here
>>      int64_t val, extval;
>>                   ^
>>    target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variable [-Werror,-Wshadow]
>>          int ret = 0;
>>              ^
>>    target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
>>      int ret;
>>          ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c              | 1 -
>>   target/arm/tcg/mve_helper.c       | 8 ++++----
>>   target/arm/tcg/translate-m-nocp.c | 2 +-
>>   3 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 486f90be1d..20d534faef 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1933,7 +1933,6 @@ int hvf_vcpu_exec(CPUState *cpu)
>>           uint32_t rt = (syndrome >> 5) & 0x1f;
>>           uint32_t reg = syndrome & SYSREG_MASK;
>>           uint64_t val;
>> -        int ret = 0;
>>
>>           if (isread) {
>>               ret = hvf_sysreg_read(cpu, reg, rt);
> 
> I'm not sure this is correct.
> 
> The hvf_vcpu_exec() function is not documented, but in practice
> its caller expects it to return either EXCP_DEBUG (for "this was
> a guest debug exception you need to deal with") or something else
> (presumably the intention being 0 for OK).
> 
> The hvf_sysreg_read() and hvf_sysreg_write() functions are also not
> documented, but they return 0 on success, or 1 for a completely
> unrecognized sysreg where we've raised the UNDEF exception (but
> not if we raised an UNDEF exception for an unrecognized GIC sysreg --
> I think this is a bug). We use this return value to decide whether
> we need to advance the PC past the insn or not. It's not the same
> as the return value we want to return from hvf_vcpu_exec().

Indeed.

> So I think the correct fix here is to retain the variable as
> locally scoped but give it a name that doesn't clash with the
> other function-scoped variable.

OK.

>> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
>> index 403b345ea3..32087b6f0a 100644
>> --- a/target/arm/tcg/mve_helper.c
>> +++ b/target/arm/tcg/mve_helper.c
>> @@ -924,8 +924,8 @@ DO_1OP_IMM(vorri, DO_ORRI)
>>           bool qc = false;                                                \
>>           for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
>>               bool sat = false;                                           \
>> -            TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
>> -            mergemask(&d[H##ESIZE(e)], r, mask);                        \
>> +            TYPE r_ = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);         \
>> +            mergemask(&d[H##ESIZE(e)], r_, mask);                       \
>>               qc |= sat & mask & 1;                                       \
>>           }                                                               \
>>           if (qc) {                                                       \
> 
> The commit message doesn't list an error message relating to
> this change and it's not immediately obvious to me what 'r'
> would be shadowing here.

Full error:

target/arm/tcg/mve_helper.c: In function ‘helper_mve_vqshlsb’:
target/arm/tcg/mve_helper.c:1259:19: warning: declaration of ‘r’ shadows 
a previous local [-Wshadow=compatible-local]
  1259 |         typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, 
&su32);  \
       |                   ^
target/arm/tcg/mve_helper.c:1267:5: note: in expansion of macro 
‘WRAP_QRSHL_HELPER’
  1267 |     WRAP_QRSHL_HELPER(do_sqrshl_bhs, N, M, false, satp)
       |     ^~~~~~~~~~~~~~~~~
target/arm/tcg/mve_helper.c:927:22: note: in expansion of macro 
‘DO_SQSHL_OP’
   927 |             TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat); 
         \
       |                      ^~
target/arm/tcg/mve_helper.c:945:5: note: in expansion of macro ‘DO_2OP_SAT’
   945 |     DO_2OP_SAT(OP##b, 1, int8_t, FN)            \
       |     ^~~~~~~~~~
target/arm/tcg/mve_helper.c:1277:1: note: in expansion of macro 
‘DO_2OP_SAT_S’
  1277 | DO_2OP_SAT_S(vqshls, DO_SQSHL_OP)
       | ^~~~~~~~~~~~

So 'r' comes from:

#define WRAP_QRSHL_HELPER(FN, N, M, ROUND, satp) \
     ({                                           \
         uint32_t su32 = 0;                       \
         typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32); \
         if (su32) {                              \
             *satp = true;                        \
         }                                        \
         r;                                       \
     })

I'll rename this one as 'qrshl_ret', and the previous one
'vqdmladh_ret'.

>> @@ -2460,7 +2460,7 @@ static inline int64_t do_sqrshl48_d(int64_t src, int64_t shift,
>>               return extval;
>>           }
>>       } else if (shift < 48) {
>> -        int64_t extval = sextract64(src << shift, 0, 48);
>> +        extval = sextract64(src << shift, 0, 48);
>>           if (!sat || src == (extval >> shift)) {
>>               return extval;
>>           }
>> @@ -2492,7 +2492,7 @@ static inline uint64_t do_uqrshl48_d(uint64_t src, int64_t shift,
>>               return extval;
>>           }
>>       } else if (shift < 48) {
>> -        uint64_t extval = extract64(src << shift, 0, 48);
>> +        extval = extract64(src << shift, 0, 48);
>>           if (!sat || src == (extval >> shift)) {
>>               return extval;
>>           }
> 
> These two parts are good, but one of them is missing from the
> listed error messages in the commit message.

I'll record both.

Thanks,

Phil.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABA73B056
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZhA-0001HO-96; Fri, 23 Jun 2023 01:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZh2-0001G2-41
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:50:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZgy-0001bU-2L
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:50:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fa23c3e618so4011455e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687499442; x=1690091442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MjmhUFA6nfrjqrmWmxi/fmnGTxJMx5I4O90u4n+/d+4=;
 b=fmwBawBefsIASZz3WaG5TYK2dqIkezoP6F/+24eZS8CgDKUphugdwSPWtwuBiV2syO
 3jMQtebAZzMNLlq6ayFdMiuqNplUIoiCjYtZenu+taa27kPnUY7/cW3xsyZsIfakd476
 LDZZ6f61lpBaicbZk/K24vNbaMlocy8BpKGTmpHEH0LYdTSPJwc7ePGAnuGWj4714gha
 EeVhQKsHfSERIzYYjmUWgHzJ+KGB5m9F0bjJ4EwnWk6WdzyclfRF9wJVzsVBgLuIMQwM
 hlG03qJ+R9lHnCiXhJC/CT/vedvUTt+mNkWK/rEdiT4pY6xV50NCpKZyQplo2oi9+yuf
 BQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687499442; x=1690091442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjmhUFA6nfrjqrmWmxi/fmnGTxJMx5I4O90u4n+/d+4=;
 b=FZRuIjjgyH+xVLuzsIC3gDQJ5YQetKnatIRxMRgAYUR7fef/DuDqdUhKZ3iEuLaX8M
 YCRXfc6EwzCLBmkMrENX25MjzQanvUAhXrRoskWvYcZyPDdpJeoypHN6ChuYeyWS2SOP
 gE69suc4QNKhh9jP2sF4KVsARaZgkuyTXCXnPFUAVCTHoBuX74rA1i8vNK/TFSxOBi0T
 MF2fV6IzQTOdrBZ61GNkaEraVUFX99VGxPIE+jlCbgyH3knvfIK2AwRwZqmYLNMOUgM/
 ZbsT5iS4xRNWHfCyIUB17Qd8P4R3y7LABJiBFuSlJ6c8zH1ZdCn5X2CGRrremKxD+Bdr
 KEwA==
X-Gm-Message-State: AC+VfDw1cwvZeEitD98aZLTC+YCd6eGEyEB7OaEw7XdcTi0EnSD/jD6L
 3lmNKefQ7Eqk21TQ8XNfgVkYZg==
X-Google-Smtp-Source: ACHHUZ7SBKPYTto/VUkvJwqWbBXhqgV7u3A/2Lg1q85DYvXdgGNtP+enD7YuR57DMxi+zY3oM8Tkeg==
X-Received: by 2002:a7b:c457:0:b0:3f9:bd3c:31b0 with SMTP id
 l23-20020a7bc457000000b003f9bd3c31b0mr5738082wmi.39.1687499442599; 
 Thu, 22 Jun 2023 22:50:42 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f9bd9e3226sm1327944wmi.7.2023.06.22.22.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 22:50:42 -0700 (PDT)
Message-ID: <644f6d2e-0c6c-e97e-6930-706d36af24f6@linaro.org>
Date: Fri, 23 Jun 2023 07:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <5082a19d-0fc2-a140-eeb7-8c608b33e410@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5082a19d-0fc2-a140-eeb7-8c608b33e410@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 22:55, BALATON Zoltan wrote:
> Hello,
> 
> What happened to this patch? Will this be merged by somebody?

Thanks for the reminder.  Queued to tcg-next.

r~

> 
> Regards,
> BALATON Zoltan
> 
> On Tue, 23 May 2023, BALATON Zoltan wrote:
>> On Tue, 23 May 2023, Alex Bennée wrote:
>>> Balton discovered that asserts for the extract/deposit calls had a
>>
>> Missing an a in my name and my given name is Zoltan. (First name and last name is in the 
>> other way in Hungarian.) Maybe just add a Reported-by instead of here if you want to 
>> record it.
>>
>>> significant impact on a lame benchmark on qemu-ppc. Replicating with:
>>>
>>>  ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lame \
>>>    -h pts-trondheim-3.wav pts-trondheim-3.mp3
>>>
>>> showed up the pack/unpack routines not eliding the assert checks as it
>>> should have done causing them to prominently figure in the profile:
>>>
>>>  11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>>>  11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>>>   8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>>>   6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>>>   5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>>>   4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>>>   4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>>>   3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
>>>
>>> After this patch the same test runs 31 seconds faster with a profile
>>> where the generated code dominates more:
>>>
>>> +   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619420
>>> +   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000616850
>>> +   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>>> +   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x000000400061bf70
>>> +    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>>> +    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>>> +    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] 
>>> parts64_canonicalize.constprop.0
>>> +    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000620130
>>> +    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619400
>>> +    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>>> +    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x00000040006167e0
>>> +    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fcffffd3
>>> +    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] 
>>> float64r32_round_pack_canonical
>>>
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-Id: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
>>> [AJB: Patchified rth's suggestion]
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> Replace Cc: with
>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> This solves the softfloat related usages, the rest probably are lower overhead, I could 
>> not measure any more improvement with removing asserts on top of this patch. I still 
>> have these functions high in my profiling result:
>>
>> children  self    command          symbol
>> 11.40%    10.86%  qemu-system-ppc  helper_compute_fprf_float64
>> 11.25%     0.61%  qemu-system-ppc  helper_fmadds
>> 10.01%     3.23%  qemu-system-ppc  float64r32_round_pack_canonical
>> 8.59%     1.80%  qemu-system-ppc  helper_float_check_status
>> 8.34%     7.23%  qemu-system-ppc  parts64_muladd
>> 8.16%     0.67%  qemu-system-ppc  helper_fmuls
>> 8.08%     0.43%  qemu-system-ppc  parts64_uncanon
>> 7.49%     1.78%  qemu-system-ppc  float64r32_mul
>> 7.32%     7.32%  qemu-system-ppc  parts64_uncanon_normal
>> 6.48%     0.52%  qemu-system-ppc  helper_fadds
>> 6.31%     6.31%  qemu-system-ppc  do_float_check_status
>> 5.99%     1.14%  qemu-system-ppc  float64r32_add
>>
>> Any idea on those?
>>
>> Unrelated to this patch I also started to see random crashes with a DSI on a dcbz 
>> instruction now which did not happen before (or not frequently enough for me to notice). 
>> I did not bisect that as it happens randomly but I wonder if it could be related to 
>> recent unaligned access changes or some other TCG change? Any idea what to check?
>>
>> Regards,
>> BALATON Zoltan
>>
>>> ---
>>> fpu/softfloat.c | 22 +++++++++++-----------
>>> 1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>>> index 108f9cb224..42e6c188b4 100644
>>> --- a/fpu/softfloat.c
>>> +++ b/fpu/softfloat.c
>>> @@ -593,27 +593,27 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, 
>>> uint64_t raw)
>>>     };
>>> }
>>>
>>> -static inline void float16_unpack_raw(FloatParts64 *p, float16 f)
>>> +static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
>>> {
>>>     unpack_raw64(p, &float16_params, f);
>>> }
>>>
>>> -static inline void bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
>>> +static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
>>> {
>>>     unpack_raw64(p, &bfloat16_params, f);
>>> }
>>>
>>> -static inline void float32_unpack_raw(FloatParts64 *p, float32 f)
>>> +static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
>>> {
>>>     unpack_raw64(p, &float32_params, f);
>>> }
>>>
>>> -static inline void float64_unpack_raw(FloatParts64 *p, float64 f)
>>> +static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
>>> {
>>>     unpack_raw64(p, &float64_params, f);
>>> }
>>>
>>> -static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
>>> +static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
>>> {
>>>     *p = (FloatParts128) {
>>>         .cls = float_class_unclassified,
>>> @@ -623,7 +623,7 @@ static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
>>>     };
>>> }
>>>
>>> -static void float128_unpack_raw(FloatParts128 *p, float128 f)
>>> +static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
>>> {
>>>     const int f_size = float128_params.frac_size - 64;
>>>     const int e_size = float128_params.exp_size;
>>> @@ -650,27 +650,27 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt 
>>> *fmt)
>>>     return ret;
>>> }
>>>
>>> -static inline float16 float16_pack_raw(const FloatParts64 *p)
>>> +static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
>>> {
>>>     return make_float16(pack_raw64(p, &float16_params));
>>> }
>>>
>>> -static inline bfloat16 bfloat16_pack_raw(const FloatParts64 *p)
>>> +static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
>>> {
>>>     return pack_raw64(p, &bfloat16_params);
>>> }
>>>
>>> -static inline float32 float32_pack_raw(const FloatParts64 *p)
>>> +static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
>>> {
>>>     return make_float32(pack_raw64(p, &float32_params));
>>> }
>>>
>>> -static inline float64 float64_pack_raw(const FloatParts64 *p)
>>> +static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
>>> {
>>>     return make_float64(pack_raw64(p, &float64_params));
>>> }
>>>
>>> -static float128 float128_pack_raw(const FloatParts128 *p)
>>> +static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
>>> {
>>>     const int f_size = float128_params.frac_size - 64;
>>>     const int e_size = float128_params.exp_size;
>>



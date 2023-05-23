Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F270E95E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1b5e-0008Pz-OE; Tue, 23 May 2023 19:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b5c-0008LT-04
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:06:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b5Z-0003pR-R3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:06:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2a613ec4so78028b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883204; x=1687475204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IvHqOcKx2O/4fAHnphtZ0DAAjg6w0P10nbx6LCaIq/g=;
 b=mteUpqkoebd1Vjdu+603R0BgO2fVqzrZztMY/Z0QEeiO5bo4avvlu5RRCs2mRrXDgo
 W6F46rXyXsIm/LdYl1j+KFBm9Yk7m/vbJme6lipts34DCfwZX39j7JeATqsTiOEGt6OR
 L4X4DpFKNFfSuRHFfwqkp8zvzHjR8zKb07hv2LgXYd6oNDeq/kwnvsFmp/bUVNW13jRt
 4Y4q1FensT9f5Ir/cFzA6WxnIyLpQNVBer6b1Vj11zUOEsalGIRDnImi4s+w1nh2n5yK
 n2NNkAa1Bf0yyseV4zVbAvTg2E/eRb1MmoKqSkNjpa/UMD1jdt/t4nxg2NMKRhrkLGd1
 ofXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883204; x=1687475204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IvHqOcKx2O/4fAHnphtZ0DAAjg6w0P10nbx6LCaIq/g=;
 b=K4P7go+ThNvBAmtfTVBzQrAMYrJrPnuiYlas2FZUWvZpYYfCyUBJt6htlTk4gUHV6r
 hEfZoSXRlxsyx4jak5UldTZEMD+Pe/GbPJ0KTiKgAp5XnvVHvn5XsbUpoZjngVSoY+4p
 HmLCE3lZYA/pR6ktGTjrImlWFITYozRsPbzIBnQ7pSo/eNzyl6HAyuuKuyfSzKu5g/iU
 h04/7/rWBezhGgXbyitoeo9YDJS281BWDpGxprYZ0Mx4rmcUpeD2Qk25j+c70yBMIPYE
 lf7yKaMcJDd2y4gGE9r/EMPVqNr9rBDlI19KBy9BMsoTXe9vtlblzxbi8byVFLe8BbIg
 EkuA==
X-Gm-Message-State: AC+VfDwBJglJgVZcMr7E05LrkM8bIP+PK2+aCAu4NooKc/c/GrKiq0Ix
 rWBCa6lMwKWxfXLaKEgqZKxG/g==
X-Google-Smtp-Source: ACHHUZ5fg0nvUXBtWIVDnU14PjfmPLVDCix6gvHdNceG28xpwriPkODKUIBHKLRfnxQp6XW43nJnIg==
X-Received: by 2002:a05:6a00:1888:b0:64d:1185:241a with SMTP id
 x8-20020a056a00188800b0064d1185241amr679908pfh.5.1684883204244; 
 Tue, 23 May 2023 16:06:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 t2-20020aa79382000000b0064d1d8fd24asm6265619pfe.60.2023.05.23.16.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:06:43 -0700 (PDT)
Message-ID: <a05ba9d6-4344-d088-bfab-6c9f9ab3e0a4@linaro.org>
Date: Tue, 23 May 2023 16:06:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-ppc@nongnu.org
References: <20230523202507.688859-1-richard.henderson@linaro.org>
 <e73e7d2d-275c-1489-1837-64c72db8b98d@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e73e7d2d-275c-1489-1837-64c72db8b98d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 16:02, BALATON Zoltan wrote:
> On Tue, 23 May 2023, Richard Henderson wrote:
>> Instead of computing an artifical "class" bitmask then
>> converting that to the fprf value, compute the final
>> value from the start.
>>
>> Reorder the tests to check the most likely cases first.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/ppc/fpu_helper.c | 78 ++++++++++++-----------------------------
>> 1 file changed, 22 insertions(+), 56 deletions(-)
>>
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index a66e16c212..03150a0f10 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -141,62 +141,28 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
>>     return ((f >> 52) & 0x7FF) - 1023;
>> }
>>
>> -/* Classify a floating-point number.  */
>> -enum {
>> -    is_normal   = 1,
>> -    is_zero     = 2,
>> -    is_denormal = 4,
>> -    is_inf      = 8,
>> -    is_qnan     = 16,
>> -    is_snan     = 32,
>> -    is_neg      = 64,
>> -};
>> -
>> -#define COMPUTE_CLASS(tp)                                      \
>> -static int tp##_classify(tp arg)                               \
>> -{                                                              \
>> -    int ret = tp##_is_neg(arg) * is_neg;                       \
>> -    if (unlikely(tp##_is_any_nan(arg))) {                      \
>> -        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
>> -        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
>> -                ? is_snan : is_qnan);                          \
>> -    } else if (unlikely(tp##_is_infinity(arg))) {              \
>> -        ret |= is_inf;                                         \
>> -    } else if (tp##_is_zero(arg)) {                            \
>> -        ret |= is_zero;                                        \
>> -    } else if (tp##_is_zero_or_denormal(arg)) {                \
>> -        ret |= is_denormal;                                    \
>> -    } else {                                                   \
>> -        ret |= is_normal;                                      \
>> -    }                                                          \
>> -    return ret;                                                \
>> -}
>> -
>> -COMPUTE_CLASS(float16)
>> -COMPUTE_CLASS(float32)
>> -COMPUTE_CLASS(float64)
>> -COMPUTE_CLASS(float128)
>> -
>> -static void set_fprf_from_class(CPUPPCState *env, int class)
>> -{
>> -    static const uint8_t fprf[6][2] = {
>> -        { 0x04, 0x08 },  /* normalized */
>> -        { 0x02, 0x12 },  /* zero */
>> -        { 0x14, 0x18 },  /* denormalized */
>> -        { 0x05, 0x09 },  /* infinity */
>> -        { 0x11, 0x11 },  /* qnan */
>> -        { 0x00, 0x00 },  /* snan -- flags are undefined */
>> -    };
>> -    bool isneg = class & is_neg;
>> -
>> -    env->fpscr &= ~FP_FPRF;
>> -    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
>> -}
>> -
>> -#define COMPUTE_FPRF(tp)                                \
>> -void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
>> -{                                                       \
>> -    set_fprf_from_class(env, tp##_classify(arg));       \
>> +#define COMPUTE_FPRF(tp)                                          \
>> +void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
>> +{                                                                 \
>> +    bool neg = tp##_is_neg(arg);                                  \
>> +    target_ulong fprf;                                            \
>> +    if (likely(tp##_is_normal(arg))) {                            \
>> +        fprf = neg ? 0x08 << FPSCR_FPRF : 0x04 << FPSCR_FPRF;     \
>> +    } else if (tp##_is_zero(arg)) {                               \
>> +        fprf = neg ? 0x12 << FPSCR_FPRF : 0x02 << FPSCR_FPRF;     \
>> +    } else if (tp##_is_zero_or_denormal(arg)) {                   \
>> +        fprf = neg ? 0x18 << FPSCR_FPRF : 0x14 << FPSCR_FPRF;     \
>> +    } else if (tp##_is_infinity(arg)) {                           \
>> +        fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
>> +    } else {                                                      \
>> +        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
>> +        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
>> +            fprf = 0x00 << FPSCR_FPRF;                            \
>> +        } else {                                                  \
>> +            fprf = 0x11 << FPSCR_FPRF;                            \
> 
> If everything above is always shifted by FPSCR_FPRF then maybe it's easier to read with 
> doing the shift once below an not in every case above.

I'm trying to make sure that the compiler generates all constants, instead of having a 
runtime shift of a constant ...

>> +    env->fpscr = (env->fpscr & ~FP_FPRF) | fprf;                  \

... here.


r~



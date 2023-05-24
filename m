Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774470F180
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:53:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kEs-0007nQ-Fr; Wed, 24 May 2023 04:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1kEl-0007iT-Df; Wed, 24 May 2023 04:52:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1kEh-0003nO-SD; Wed, 24 May 2023 04:52:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EE837748A56;
 Wed, 24 May 2023 10:52:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 93EA0748A55; Wed, 24 May 2023 10:52:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 925A174638A;
 Wed, 24 May 2023 10:52:43 +0200 (CEST)
Date: Wed, 24 May 2023 10:52:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
In-Reply-To: <a05ba9d6-4344-d088-bfab-6c9f9ab3e0a4@linaro.org>
Message-ID: <db66b113-2db2-4fa4-b98e-888174e08952@eik.bme.hu>
References: <20230523202507.688859-1-richard.henderson@linaro.org>
 <e73e7d2d-275c-1489-1837-64c72db8b98d@eik.bme.hu>
 <a05ba9d6-4344-d088-bfab-6c9f9ab3e0a4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2104818195-1684918363=:19665"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2104818195-1684918363=:19665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 23 May 2023, Richard Henderson wrote:
> On 5/23/23 16:02, BALATON Zoltan wrote:
>> On Tue, 23 May 2023, Richard Henderson wrote:
>>> Instead of computing an artifical "class" bitmask then
>>> converting that to the fprf value, compute the final
>>> value from the start.
>>> 
>>> Reorder the tests to check the most likely cases first.
>>> 
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>> target/ppc/fpu_helper.c | 78 ++++++++++++-----------------------------
>>> 1 file changed, 22 insertions(+), 56 deletions(-)
>>> 
>>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>>> index a66e16c212..03150a0f10 100644
>>> --- a/target/ppc/fpu_helper.c
>>> +++ b/target/ppc/fpu_helper.c
>>> @@ -141,62 +141,28 @@ static inline int 
>>> ppc_float64_get_unbiased_exp(float64 f)
>>>     return ((f >> 52) & 0x7FF) - 1023;
>>> }
>>> 
>>> -/* Classify a floating-point number.  */
>>> -enum {
>>> -    is_normal   = 1,
>>> -    is_zero     = 2,
>>> -    is_denormal = 4,
>>> -    is_inf      = 8,
>>> -    is_qnan     = 16,
>>> -    is_snan     = 32,
>>> -    is_neg      = 64,
>>> -};
>>> -
>>> -#define COMPUTE_CLASS(tp)                                      \
>>> -static int tp##_classify(tp arg)                               \
>>> -{                                                              \
>>> -    int ret = tp##_is_neg(arg) * is_neg;                       \
>>> -    if (unlikely(tp##_is_any_nan(arg))) {                      \
>>> -        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
>>> -        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
>>> -                ? is_snan : is_qnan);                          \
>>> -    } else if (unlikely(tp##_is_infinity(arg))) {              \
>>> -        ret |= is_inf;                                         \
>>> -    } else if (tp##_is_zero(arg)) {                            \
>>> -        ret |= is_zero;                                        \
>>> -    } else if (tp##_is_zero_or_denormal(arg)) {                \
>>> -        ret |= is_denormal;                                    \
>>> -    } else {                                                   \
>>> -        ret |= is_normal;                                      \
>>> -    }                                                          \
>>> -    return ret;                                                \
>>> -}
>>> -
>>> -COMPUTE_CLASS(float16)
>>> -COMPUTE_CLASS(float32)
>>> -COMPUTE_CLASS(float64)
>>> -COMPUTE_CLASS(float128)
>>> -
>>> -static void set_fprf_from_class(CPUPPCState *env, int class)
>>> -{
>>> -    static const uint8_t fprf[6][2] = {
>>> -        { 0x04, 0x08 },  /* normalized */
>>> -        { 0x02, 0x12 },  /* zero */
>>> -        { 0x14, 0x18 },  /* denormalized */
>>> -        { 0x05, 0x09 },  /* infinity */
>>> -        { 0x11, 0x11 },  /* qnan */
>>> -        { 0x00, 0x00 },  /* snan -- flags are undefined */
>>> -    };
>>> -    bool isneg = class & is_neg;
>>> -
>>> -    env->fpscr &= ~FP_FPRF;
>>> -    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
>>> -}
>>> -
>>> -#define COMPUTE_FPRF(tp)                                \
>>> -void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
>>> -{                                                       \
>>> -    set_fprf_from_class(env, tp##_classify(arg));       \
>>> +#define COMPUTE_FPRF(tp)                                          \
>>> +void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
>>> +{                                                                 \
>>> +    bool neg = tp##_is_neg(arg);                                  \
>>> +    target_ulong fprf;                                            \
>>> +    if (likely(tp##_is_normal(arg))) {                            \
>>> +        fprf = neg ? 0x08 << FPSCR_FPRF : 0x04 << FPSCR_FPRF;     \
>>> +    } else if (tp##_is_zero(arg)) {                               \
>>> +        fprf = neg ? 0x12 << FPSCR_FPRF : 0x02 << FPSCR_FPRF;     \
>>> +    } else if (tp##_is_zero_or_denormal(arg)) {                   \
>>> +        fprf = neg ? 0x18 << FPSCR_FPRF : 0x14 << FPSCR_FPRF;     \
>>> +    } else if (tp##_is_infinity(arg)) {                           \
>>> +        fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
>>> +    } else {                                                      \
>>> +        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
>>> +        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
>>> +            fprf = 0x00 << FPSCR_FPRF;                            \
>>> +        } else {                                                  \
>>> +            fprf = 0x11 << FPSCR_FPRF;                            \
>> 
>> If everything above is always shifted by FPSCR_FPRF then maybe it's easier 
>> to read with doing the shift once below an not in every case above.
>
> I'm trying to make sure that the compiler generates all constants, instead of 
> having a runtime shift of a constant ...

Didn't think about that. Maybe adding a macro for it could make it more 
readable then or noting it in a comment or in the commit message might 
worth it.

Regards,
BALATON Zoltan

>>> +    env->fpscr = (env->fpscr & ~FP_FPRF) | fprf;                  \
>
> ... here.
>
>
> r~
>
>
>
--3866299591-2104818195-1684918363=:19665--


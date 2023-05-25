Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13034711A7A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KBF-0003dB-7w; Thu, 25 May 2023 19:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2KBC-0003cw-Dl
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:15:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2KB9-0002HF-Ry
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:15:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8C74474635C;
 Fri, 26 May 2023 01:15:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6F0F474633D; Fri, 26 May 2023 01:15:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6BFE9745720;
 Fri, 26 May 2023 01:15:23 +0200 (CEST)
Date: Fri, 26 May 2023 01:15:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
In-Reply-To: <77189848-d618-9f55-4ae9-92756e635371@redhat.com>
Message-ID: <78e0f562-e79d-8171-b1b5-6ba6ce819c51@eik.bme.hu>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
 <77189848-d618-9f55-4ae9-92756e635371@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-482543495-1685056523=:5836"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-482543495-1685056523=:5836
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 May 2023, Paolo Bonzini wrote:
> On 5/23/23 16:33, Richard Henderson wrote:
>> The tests are poorly ordered, testing many unlikely things before the most 
>> likely thing (normal).  A better ordering would be
>>
>>      if (likely(tp##_is_normal(arg))) {
>>      } else if (tp##_is_zero(arg)) {
>>      } else if (tp##_is_zero_or_denormal(arg)) {
>>      } else if (tp##_is_infinity(arg)) {
>>      } else {
>>          // nan case
>>      }
>> 
>> Secondly, we compute the classify bitmask, and then deconstruct the mask 
>> again in set_fprf_from_class.  Since we don't use the classify bitmask for 
>> anything else, better would be to compute the fprf value directly in the 
>> if-ladder.
>
> So something like this:
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c

I've tested this too (patch did not apply for some reason, had to apply by 
hand) but Richard's patch seems to get better results. This one also helps 
but takes a few seconds more than with Richard's patch and with that this 
functino gets 1% lower in profile.

Regards,
BALATON Zoltan

> index a66e16c2128c..daed97ca178e 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -141,62 +141,30 @@ static inline int ppc_float64_get_unbiased_exp(float64 
> f)
>     return ((f >> 52) & 0x7FF) - 1023;
> }
> -/* Classify a floating-point number.  */
> -enum {
> -    is_normal   = 1,
> -    is_zero     = 2,
> -    is_denormal = 4,
> -    is_inf      = 8,
> -    is_qnan     = 16,
> -    is_snan     = 32,
> -    is_neg      = 64,
> -};
> -
> -#define COMPUTE_CLASS(tp)                                      \
> -static int tp##_classify(tp arg)                               \
> -{                                                              \
> -    int ret = tp##_is_neg(arg) * is_neg;                       \
> -    if (unlikely(tp##_is_any_nan(arg))) {                      \
> -        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
> -        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
> -                ? is_snan : is_qnan);                          \
> -    } else if (unlikely(tp##_is_infinity(arg))) {              \
> -        ret |= is_inf;                                         \
> -    } else if (tp##_is_zero(arg)) {                            \
> -        ret |= is_zero;                                        \
> -    } else if (tp##_is_zero_or_denormal(arg)) {                \
> -        ret |= is_denormal;                                    \
> -    } else {                                                   \
> -        ret |= is_normal;                                      \
> -    }                                                          \
> -    return ret;                                                \
> -}
> -
> -COMPUTE_CLASS(float16)
> -COMPUTE_CLASS(float32)
> -COMPUTE_CLASS(float64)
> -COMPUTE_CLASS(float128)
> -
> -static void set_fprf_from_class(CPUPPCState *env, int class)
> +static void set_fprf(CPUPPCState *env, uint8_t ret)
> {
> -    static const uint8_t fprf[6][2] = {
> -        { 0x04, 0x08 },  /* normalized */
> -        { 0x02, 0x12 },  /* zero */
> -        { 0x14, 0x18 },  /* denormalized */
> -        { 0x05, 0x09 },  /* infinity */
> -        { 0x11, 0x11 },  /* qnan */
> -        { 0x00, 0x00 },  /* snan -- flags are undefined */
> -    };
> -    bool isneg = class & is_neg;
> -
>     env->fpscr &= ~FP_FPRF;
> -    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
> +    env->fpscr |= ret << FPSCR_FPRF;
> }
> -#define COMPUTE_FPRF(tp)                                \
> -void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
> -{                                                       \
> -    set_fprf_from_class(env, tp##_classify(arg));       \
> +#define COMPUTE_FPRF(tp)                                       \
> +void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
> +{                                                              \
> +    int ret;                                                   \
> +    if (tp##_is_normal(arg)) {                                 \
> +        ret = 0x0408;                                          \
> +    } else if (tp##_is_zero(arg)) {                            \
> +        ret = 0x0212;                                          \
> +    } else if (tp##_is_zero_or_denormal(arg)) {                \
> +        ret = 0x1418;                                          \
> +    } else if (unlikely(tp##_is_infinity(arg))) {              \
> +        ret = 0x0509;                                          \
> +    } else {                                                   \
> +        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
> +        ret = (tp##_is_signaling_nan(arg, &dummy)              \
> +               ? 0x0000 : 0x1111);                             \
> +    }                                                          \
> +    set_fprf(env, tp##_is_neg(arg) ? (uint8_t)ret : ret >> 8); \
> }
>  COMPUTE_FPRF(float16)
>
>
> Not tested beyond compilation, but if Zoltan reports that it helps
> I can write a commit message and submit it.
>
> Paolo
>
>
--3866299591-482543495-1685056523=:5836--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F970E410
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WA7-0003YD-1i; Tue, 23 May 2023 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1WA4-0003X0-H2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:51:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1WA2-0003oA-Hv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:51:04 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 841ED746361;
 Tue, 23 May 2023 19:51:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 48013746335; Tue, 23 May 2023 19:51:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 45DBB74632B;
 Tue, 23 May 2023 19:51:00 +0200 (CEST)
Date: Tue, 23 May 2023 19:51:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
In-Reply-To: <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
Message-ID: <17bb5696-4cd8-4290-73ec-4e8ca9a3f33f@eik.bme.hu>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-1940768574-1684864260=:574"
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

--3866299591-1940768574-1684864260=:574
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 23 May 2023, Richard Henderson wrote:
> On 5/23/23 06:57, BALATON Zoltan wrote:
>> This solves the softfloat related usages, the rest probably are lower 
>> overhead, I could not measure any more improvement with removing asserts on 
>> top of this patch. I still have these functions high in my profiling 
>> result:
>> 
>> children  self    command          symbol
>> 11.40%    10.86%  qemu-system-ppc  helper_compute_fprf_float64
>
> You might need to dig in with perf here, but my first guess is
>
> #define COMPUTE_CLASS(tp)                                      \
> static int tp##_classify(tp arg)                               \
> {                                                              \
>    int ret = tp##_is_neg(arg) * is_neg;                       \
>    if (unlikely(tp##_is_any_nan(arg))) {                      \
>        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
>        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
>                ? is_snan : is_qnan);                          \
>    } else if (unlikely(tp##_is_infinity(arg))) {              \
>        ret |= is_inf;                                         \
>    } else if (tp##_is_zero(arg)) {                            \
>        ret |= is_zero;                                        \
>    } else if (tp##_is_zero_or_denormal(arg)) {                \
>        ret |= is_denormal;                                    \
>    } else {                                                   \
>        ret |= is_normal;                                      \
>    }                                                          \
>    return ret;                                                \
> }
>
> The tests are poorly ordered, testing many unlikely things before the most 
> likely thing (normal).  A better ordering would be
>
>    if (likely(tp##_is_normal(arg))) {
>    } else if (tp##_is_zero(arg)) {
>    } else if (tp##_is_zero_or_denormal(arg)) {
>    } else if (tp##_is_infinity(arg)) {
>    } else {
>        // nan case
>    }
>
> Secondly, we compute the classify bitmask, and then deconstruct the mask 
> again in set_fprf_from_class.  Since we don't use the classify bitmask for 
> anything else, better would be to compute the fprf value directly in the 
> if-ladder.

Thanks for the guidance. Alex, will you make a patch of this too or should 
I try to figure out how to do that? I'm not sure I understood everything 
in the above but read only once.

Regards,
BALATON Zoltan

>> 11.25%     0.61%  qemu-system-ppc  helper_fmadds
>
> This is unsurprising, and nothing much that can be done.
> All of the work is in muladd doing the arithmetic.
>
>> Unrelated to this patch I also started to see random crashes with a DSI on 
>> a dcbz instruction now which did not happen before (or not frequently 
>> enough for me to notice). I did not bisect that as it happens randomly but 
>> I wonder if it could be related to recent unaligned access changes or some 
>> other TCG change? Any idea what to check?
>
> No idea.
>
>
> r~
>
>
--3866299591-1940768574-1684864260=:574--


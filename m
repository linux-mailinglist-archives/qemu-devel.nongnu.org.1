Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0670DEE9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SVv-0003nv-00; Tue, 23 May 2023 09:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1SVr-0003j3-4E
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q1SVb-0004CZ-Cc
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:57:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 49C0D746361;
 Tue, 23 May 2023 15:57:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EA27674635C; Tue, 23 May 2023 15:57:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8A7E74632B;
 Tue, 23 May 2023 15:57:00 +0200 (CEST)
Date: Tue, 23 May 2023 15:57:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
In-Reply-To: <20230523131107.3680641-1-alex.bennee@linaro.org>
Message-ID: <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-524406227-1684850004=:38519"
Content-ID: <12c5c727-1dce-30b1-3a8e-735e6f13417c@eik.bme.hu>
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

--3866299591-524406227-1684850004=:38519
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <8d595ebe-b510-58d7-071a-ab1ee6c8c2f9@eik.bme.hu>

On Tue, 23 May 2023, Alex Bennée wrote:
> Balton discovered that asserts for the extract/deposit calls had a

Missing an a in my name and my given name is Zoltan. (First name and last 
name is in the other way in Hungarian.) Maybe just add a Reported-by 
instead of here if you want to record it.

> significant impact on a lame benchmark on qemu-ppc. Replicating with:
>
>  ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lame \
>    -h pts-trondheim-3.wav pts-trondheim-3.mp3
>
> showed up the pack/unpack routines not eliding the assert checks as it
> should have done causing them to prominently figure in the profile:
>
>  11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
>  11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
>   8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
>   6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
>   5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
>   4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
>   4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
>   3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
>
> After this patch the same test runs 31 seconds faster with a profile
> where the generated code dominates more:
>
> +   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619420
> +   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000616850
> +   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
> +   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x000000400061bf70
> +    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
> +    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
> +    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize.constprop.0
> +    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000620130
> +    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619400
> +    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
> +    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x00000040006167e0
> +    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fcffffd3
> +    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
> [AJB: Patchified rth's suggestion]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>

Replace Cc: with
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

This solves the softfloat related usages, the rest probably are lower 
overhead, I could not measure any more improvement with removing asserts 
on top of this patch. I still have these functions high in my profiling 
result:

children  self    command          symbol
11.40%    10.86%  qemu-system-ppc  helper_compute_fprf_float64
11.25%     0.61%  qemu-system-ppc  helper_fmadds
10.01%     3.23%  qemu-system-ppc  float64r32_round_pack_canonical
  8.59%     1.80%  qemu-system-ppc  helper_float_check_status
  8.34%     7.23%  qemu-system-ppc  parts64_muladd
  8.16%     0.67%  qemu-system-ppc  helper_fmuls
  8.08%     0.43%  qemu-system-ppc  parts64_uncanon
  7.49%     1.78%  qemu-system-ppc  float64r32_mul
  7.32%     7.32%  qemu-system-ppc  parts64_uncanon_normal
  6.48%     0.52%  qemu-system-ppc  helper_fadds
  6.31%     6.31%  qemu-system-ppc  do_float_check_status
  5.99%     1.14%  qemu-system-ppc  float64r32_add

Any idea on those?

Unrelated to this patch I also started to see random crashes with a DSI on 
a dcbz instruction now which did not happen before (or not frequently 
enough for me to notice). I did not bisect that as it happens randomly but 
I wonder if it could be related to recent unaligned access changes or some 
other TCG change? Any idea what to check?

Regards,
BALATON Zoltan

> ---
> fpu/softfloat.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 108f9cb224..42e6c188b4 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -593,27 +593,27 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
>     };
> }
>
> -static inline void float16_unpack_raw(FloatParts64 *p, float16 f)
> +static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
> {
>     unpack_raw64(p, &float16_params, f);
> }
>
> -static inline void bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
> +static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
> {
>     unpack_raw64(p, &bfloat16_params, f);
> }
>
> -static inline void float32_unpack_raw(FloatParts64 *p, float32 f)
> +static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
> {
>     unpack_raw64(p, &float32_params, f);
> }
>
> -static inline void float64_unpack_raw(FloatParts64 *p, float64 f)
> +static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
> {
>     unpack_raw64(p, &float64_params, f);
> }
>
> -static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
> +static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
> {
>     *p = (FloatParts128) {
>         .cls = float_class_unclassified,
> @@ -623,7 +623,7 @@ static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
>     };
> }
>
> -static void float128_unpack_raw(FloatParts128 *p, float128 f)
> +static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
> {
>     const int f_size = float128_params.frac_size - 64;
>     const int e_size = float128_params.exp_size;
> @@ -650,27 +650,27 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
>     return ret;
> }
>
> -static inline float16 float16_pack_raw(const FloatParts64 *p)
> +static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
> {
>     return make_float16(pack_raw64(p, &float16_params));
> }
>
> -static inline bfloat16 bfloat16_pack_raw(const FloatParts64 *p)
> +static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
> {
>     return pack_raw64(p, &bfloat16_params);
> }
>
> -static inline float32 float32_pack_raw(const FloatParts64 *p)
> +static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
> {
>     return make_float32(pack_raw64(p, &float32_params));
> }
>
> -static inline float64 float64_pack_raw(const FloatParts64 *p)
> +static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
> {
>     return make_float64(pack_raw64(p, &float64_params));
> }
>
> -static float128 float128_pack_raw(const FloatParts128 *p)
> +static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
> {
>     const int f_size = float128_params.frac_size - 64;
>     const int e_size = float128_params.exp_size;
>
--3866299591-524406227-1684850004=:38519--


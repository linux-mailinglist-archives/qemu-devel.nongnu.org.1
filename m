Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD47826E8
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 12:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1y3-0000CW-D0; Mon, 21 Aug 2023 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qY1y0-0000B1-Jx
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:17:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qY1xx-0005kL-QQ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:17:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0B124757244;
 Mon, 21 Aug 2023 12:16:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A12BD757239; Mon, 21 Aug 2023 12:16:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D9CC748FF1;
 Mon, 21 Aug 2023 12:16:51 +0200 (CEST)
Date: Mon, 21 Aug 2023 12:16:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] softfloat: Handle m68k extended precision denormals
 properly
In-Reply-To: <20230821003237.376935-1-richard.henderson@linaro.org>
Message-ID: <32c723cd-6f95-073e-230f-9572d2e62b17@eik.bme.hu>
References: <20230821003237.376935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 20 Aug 2023, Richard Henderson wrote:
> Motorola treats denormals with explicit integer bit set as
> having unbiased exponent 0, unlike Intel which treats it as
> having unbiased exponent 1 (like all other IEEE formats).
>
> Add a flag on FloatFmt to differentiate the behaviour.
>
> Reported-by: Keith Packard <keithp@keithp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> fpu/softfloat.c                |  9 +++++-
> tests/tcg/m68k/denormal.c      | 53 ++++++++++++++++++++++++++++++++++
> fpu/softfloat-parts.c.inc      |  5 ++--
> tests/tcg/m68k/Makefile.target |  2 +-
> 4 files changed, 65 insertions(+), 4 deletions(-)
> create mode 100644 tests/tcg/m68k/denormal.c
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 0cc130ae9b..3adfa8cee0 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -517,6 +517,7 @@ typedef struct {
>  *   round_mask: bits below lsb which must be rounded
>  * The following optional modifiers are available:
>  *   arm_althp: handle ARM Alternative Half Precision
> + *   m68k_denormal: explicit integer bit for extended precision may be 1

Is there a better name for this such as unbiased_exp or something telling 
it's an integer and maybe also somehow avoiding the ! when using it? This 
naming seems a bit unspecific and confusing.

Regards,
BALATON Zoltan

>  */
> typedef struct {
>     int exp_size;
> @@ -526,6 +527,7 @@ typedef struct {
>     int frac_size;
>     int frac_shift;
>     bool arm_althp;
> +    bool m68k_denormal;
>     uint64_t round_mask;
> } FloatFmt;
>
> @@ -576,7 +578,12 @@ static const FloatFmt float128_params = {
> static const FloatFmt floatx80_params[3] = {
>     [floatx80_precision_s] = { FLOATX80_PARAMS(23) },
>     [floatx80_precision_d] = { FLOATX80_PARAMS(52) },
> -    [floatx80_precision_x] = { FLOATX80_PARAMS(64) },
> +    [floatx80_precision_x] = {
> +        FLOATX80_PARAMS(64),
> +#ifdef TARGET_M68K
> +        .m68k_denormal = true,
> +#endif
> +    },
> };
>
> /* Unpack a float to parts, but do not canonicalize.  */
> diff --git a/tests/tcg/m68k/denormal.c b/tests/tcg/m68k/denormal.c
> new file mode 100644
> index 0000000000..599dafa663
> --- /dev/null
> +++ b/tests/tcg/m68k/denormal.c
> @@ -0,0 +1,53 @@
> +/*
> + * Test m68k extended double denormals.
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +
> +#define X0      0x1p+16383l
> +#define Y0      0x1p-16446l
> +#define X1      0x1.1p-8223l
> +#define Y1      0x1.1p-8224l
> +
> +static volatile long double test[2][3] = {
> +    { X0, Y0, X0 * Y0 },
> +    { X1, Y1, X1 * Y1 },
> +};
> +
> +static void dump_ld(const char *label, long double ld)
> +{
> +    union {
> +        long double     d;
> +        struct {
> +            uint32_t    exp:16;
> +            uint32_t    space:16;
> +            uint32_t    h;
> +            uint32_t    l;
> +        };
> +    } u;
> +
> +    u.d = ld;
> +    printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, u.l);
> +}
> +
> +int main(void)
> +{
> +    int i, err = 0;
> +
> +    for (i = 0; i < 2; ++i) {
> +        long double x = test[i][0];
> +        long double y = test[i][1];
> +        long double build_mul = test[i][2];
> +        long double runtime_mul = x * y;
> +
> +        if (runtime_mul != build_mul) {
> +            dump_ld("x", x);
> +            dump_ld("y", y);
> +            dump_ld("build_mul", build_mul);
> +            dump_ld("runtime_mul", runtime_mul);
> +            err = 1;
> +        }
> +    }
> +    return err;
> +}
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 527e15e6ab..d0c43c28fb 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -118,7 +118,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
>         } else {
>             int shift = frac_normalize(p);
>             p->cls = float_class_normal;
> -            p->exp = fmt->frac_shift - fmt->exp_bias - shift + 1;
> +            p->exp = fmt->frac_shift - fmt->exp_bias
> +                   - shift + !fmt->m68k_denormal;
>         }
>     } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
>         p->cls = float_class_normal;
> @@ -256,7 +257,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>             is_tiny = !frac_addi(&discard, p, inc);
>         }
>
> -        frac_shrjam(p, 1 - exp);
> +        frac_shrjam(p, !fmt->m68k_denormal - exp);
>
>         if (p->frac_lo & round_mask) {
>             /* Need to recompute round-to-even/round-to-odd. */
> diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
> index 1163c7ef03..6ff214e60a 100644
> --- a/tests/tcg/m68k/Makefile.target
> +++ b/tests/tcg/m68k/Makefile.target
> @@ -4,7 +4,7 @@
> #
>
> VPATH += $(SRC_PATH)/tests/tcg/m68k
> -TESTS += trap
> +TESTS += trap denormal
>
> # On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
> EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
>


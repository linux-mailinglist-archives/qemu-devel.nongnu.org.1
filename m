Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF777C7F53
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3j-000704-Il; Fri, 13 Oct 2023 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3f-0006kM-VI
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:08 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3c-0006ia-4B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:07 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so7227171fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183882; x=1697788682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aeKq35mmTIUN+fGFa1jZeWofe0W3T+gZsntbEXTBh4=;
 b=a3kqDC5vVU7ArTGOYVgvXPup2kWp2KrnPLe3l8IznY0gNv+KDL7x2mOX1FwwM3pycU
 jKw07JoDfr97vOFE3PdcJIMEWtYqbVJDmjHf46yTmUO9ms53T7cpaYqmWmLdv5cnqWE4
 tz+2VhP0/yJ63FOJq25C/jfZFnU4PZag0gXp82HxiaGVJ31FYM5SJXZDZ/vga1dV5oyp
 We5CbI5p99Q8PzqEuTBy5Qo7qB52pVxVIFugwXPUgARs0DApXFxWW6OIe24QukO8HUva
 wGckpg/mXukqjYiZogvzhqyy4l6jzE7uwVeTEeksXCfrh1fruQY8LyhWpAHnmQhCjQrk
 11DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183882; x=1697788682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aeKq35mmTIUN+fGFa1jZeWofe0W3T+gZsntbEXTBh4=;
 b=wLAFDkflsESkfldyVlsf4JufzY0+wohoZLvkYaif6TwodnNFTDdJLCAXdA9rGKDdUl
 CKbfiRRjLAi4gDhX5zxDjxhy8LioZStawd1mk/0UFSI6eLfYZOXxvqMTN4W5OwTUs/LM
 zOdBCLHAlh8IjMom4kNnzSDyVr4BVeMIsaV9XRjsnAo9XL7kbp1f9Ef653mLeBZQqDIa
 bjQpaGgApi3DXfXAjw1AnvrHtuddvz0gcZVD1ULG4jMWwQgJAtQ98Y1TTGTjK354ohfL
 PfH2DKSloui1dBo5qd3I7fkoHRvMl+FABScw64552VGEMl5i7smb5zVdTVBSxBqndJUk
 FKPA==
X-Gm-Message-State: AOJu0Yx+u3mN5QWzApieAkXNXjHd0gNgAYv3QsTlIRCpwLrejJBf7u+P
 klJbB5GFEDof5Gpkull3yP5eefW6HKHBA6Fnmtc=
X-Google-Smtp-Source: AGHT+IHZXL2v0J4mA3KSIMc9Y896n4MM1HVVuF36TvhnLKo7T+jq/+FgXHkmj2q6Y8WkCSOSQb0SoQ==
X-Received: by 2002:a2e:3e07:0:b0:2bc:dcd6:97b1 with SMTP id
 l7-20020a2e3e07000000b002bcdcd697b1mr21916986lja.47.1697183881735; 
 Fri, 13 Oct 2023 00:58:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:01 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 03/78] fpu/softfloat: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:30 +0300
Message-Id: <f329886becdeaa9a0b7cc2d19a02b3973266151b.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 fpu/softfloat-parts.c.inc | 8 ++++----
 fpu/softfloat.c           | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a44649f4f4..df64cc7a29 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -138,166 +138,166 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
 /*
  * Round and uncanonicalize a floating-point number by parts. There
  * are FRAC_SHIFT bits that may require rounding at the bottom of the
  * fraction; these bits will be removed. The exponent will be biased
  * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
  */
 static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                                    const FloatFmt *fmt)
 {
     const int exp_max = fmt->exp_max;
     const int frac_shift = fmt->frac_shift;
     const uint64_t round_mask = fmt->round_mask;
     const uint64_t frac_lsb = round_mask + 1;
     const uint64_t frac_lsbm1 = round_mask ^ (round_mask >> 1);
     const uint64_t roundeven_mask = round_mask | frac_lsb;
     uint64_t inc;
     bool overflow_norm = false;
     int exp, flags = 0;
 
     switch (s->float_rounding_mode) {
     case float_round_nearest_even:
         if (N > 64 && frac_lsb == 0) {
             inc = ((p->frac_hi & 1) || (p->frac_lo & round_mask) != frac_lsbm1
                    ? frac_lsbm1 : 0);
         } else {
             inc = ((p->frac_lo & roundeven_mask) != frac_lsbm1
                    ? frac_lsbm1 : 0);
         }
         break;
     case float_round_ties_away:
         inc = frac_lsbm1;
         break;
     case float_round_to_zero:
         overflow_norm = true;
         inc = 0;
         break;
     case float_round_up:
         inc = p->sign ? 0 : round_mask;
         overflow_norm = p->sign;
         break;
     case float_round_down:
         inc = p->sign ? round_mask : 0;
         overflow_norm = !p->sign;
         break;
     case float_round_to_odd:
         overflow_norm = true;
-        /* fall through */
+        fallthrough;
     case float_round_to_odd_inf:
         if (N > 64 && frac_lsb == 0) {
             inc = p->frac_hi & 1 ? 0 : round_mask;
         } else {
             inc = p->frac_lo & frac_lsb ? 0 : round_mask;
         }
         break;
     default:
         g_assert_not_reached();
     }
 
     exp = p->exp + fmt->exp_bias;
     if (likely(exp > 0)) {
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
             if (frac_addi(p, p, inc)) {
                 frac_shr(p, 1);
                 p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
                 exp++;
             }
             p->frac_lo &= ~round_mask;
         }
 
         if (fmt->arm_althp) {
             /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
             if (unlikely(exp > exp_max)) {
                 /* Overflow.  Return the maximum normal.  */
                 flags = float_flag_invalid;
                 exp = exp_max;
                 frac_allones(p);
                 p->frac_lo &= ~round_mask;
             }
         } else if (unlikely(exp >= exp_max)) {
             flags |= float_flag_overflow;
             if (s->rebias_overflow) {
                 exp -= fmt->exp_re_bias;
             } else if (overflow_norm) {
                 flags |= float_flag_inexact;
                 exp = exp_max - 1;
                 frac_allones(p);
                 p->frac_lo &= ~round_mask;
             } else {
                 flags |= float_flag_inexact;
                 p->cls = float_class_inf;
                 exp = exp_max;
                 frac_clear(p);
             }
         }
         frac_shr(p, frac_shift);
     } else if (unlikely(s->rebias_underflow)) {
         flags |= float_flag_underflow;
         exp += fmt->exp_re_bias;
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
             if (frac_addi(p, p, inc)) {
                 frac_shr(p, 1);
                 p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
                 exp++;
             }
             p->frac_lo &= ~round_mask;
         }
         frac_shr(p, frac_shift);
     } else if (s->flush_to_zero) {
         flags |= float_flag_output_denormal;
         p->cls = float_class_zero;
         exp = 0;
         frac_clear(p);
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
 
         if (!is_tiny) {
             FloatPartsN discard;
             is_tiny = !frac_addi(&discard, p, inc);
         }
 
         frac_shrjam(p, !fmt->m68k_denormal - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
             switch (s->float_rounding_mode) {
             case float_round_nearest_even:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1
                            ? frac_lsbm1 : 0);
                 } else {
                     inc = ((p->frac_lo & roundeven_mask) != frac_lsbm1
                            ? frac_lsbm1 : 0);
                 }
                 break;
             case float_round_to_odd:
             case float_round_to_odd_inf:
                 if (N > 64 && frac_lsb == 0) {
                     inc = p->frac_hi & 1 ? 0 : round_mask;
                 } else {
                     inc = p->frac_lo & frac_lsb ? 0 : round_mask;
                 }
                 break;
             default:
                 break;
             }
             flags |= float_flag_inexact;
             frac_addi(p, p, inc);
             p->frac_lo &= ~round_mask;
         }
 
         exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
         frac_shr(p, frac_shift);
 
         if (is_tiny && (flags & float_flag_inexact)) {
             flags |= float_flag_underflow;
         }
         if (exp == 0 && frac_eqz(p)) {
             p->cls = float_class_zero;
         }
     }
     p->exp = exp;
     float_raise(flags, s);
 }
@@ -1051,219 +1051,219 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
 /*
  * Returns the result of converting the floating-point value `a' to
  * the two's complement integer format. The conversion is performed
  * according to the IEC/IEEE Standard for Binary Floating-Point
  * Arithmetic---which means in particular that the conversion is
  * rounded according to the current rounding mode. If `a' is a NaN,
  * the largest positive integer is returned. Otherwise, if the
  * conversion overflows, the largest integer with the same sign as `a'
  * is returned.
  */
 static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
                                      int scale, int64_t min, int64_t max,
                                      float_status *s)
 {
     int flags = 0;
     uint64_t r;
 
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = max;
         break;
 
     case float_class_inf:
         flags = float_flag_invalid | float_flag_invalid_cvti;
         r = p->sign ? min : max;
         break;
 
     case float_class_zero:
         return 0;
 
     case float_class_normal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
         }
 
         if (p->exp <= DECOMPOSED_BINARY_POINT) {
             r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
         } else {
             r = UINT64_MAX;
         }
         if (p->sign) {
             if (r <= -(uint64_t)min) {
                 r = -r;
             } else {
                 flags = float_flag_invalid | float_flag_invalid_cvti;
                 r = min;
             }
         } else if (r > max) {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = max;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     float_raise(flags, s);
     return r;
 }
 
 /*
  *  Returns the result of converting the floating-point value `a' to
  *  the unsigned integer format. The conversion is performed according
  *  to the IEC/IEEE Standard for Binary Floating-Point
  *  Arithmetic---which means in particular that the conversion is
  *  rounded according to the current rounding mode. If `a' is a NaN,
  *  the largest unsigned integer is returned. Otherwise, if the
  *  conversion overflows, the largest unsigned integer is returned. If
  *  the 'a' is negative, the result is rounded and zero is returned;
  *  values that do not round to zero will raise the inexact exception
  *  flag.
  */
 static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
                                       int scale, uint64_t max, float_status *s)
 {
     int flags = 0;
     uint64_t r;
 
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = max;
         break;
 
     case float_class_inf:
         flags = float_flag_invalid | float_flag_invalid_cvti;
         r = p->sign ? 0 : max;
         break;
 
     case float_class_zero:
         return 0;
 
     case float_class_normal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
             if (p->cls == float_class_zero) {
                 r = 0;
                 break;
             }
         }
 
         if (p->sign) {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = 0;
         } else if (p->exp > DECOMPOSED_BINARY_POINT) {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = max;
         } else {
             r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
             if (r > max) {
                 flags = float_flag_invalid | float_flag_invalid_cvti;
                 r = max;
             }
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     float_raise(flags, s);
     return r;
 }
 
 /*
  * Like partsN(float_to_sint), except do not saturate the result.
  * Instead, return the rounded unbounded precision two's compliment result,
  * modulo 2**(bitsm1 + 1).
  */
 static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
                                             FloatRoundMode rmode,
                                             int bitsm1, float_status *s)
 {
     int flags = 0;
     uint64_t r;
     bool overflow = false;
 
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = 0;
         break;
 
     case float_class_inf:
         overflow = true;
         r = 0;
         break;
 
     case float_class_zero:
         return 0;
 
     case float_class_normal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
             flags = float_flag_inexact;
         }
 
         if (p->exp <= DECOMPOSED_BINARY_POINT) {
             /*
              * Because we rounded to integral, and exp < 64,
              * we know frac_low is zero.
              */
             r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
             if (p->exp < bitsm1) {
                 /* Result in range. */
             } else if (p->exp == bitsm1) {
                 /* The only in-range value is INT_MIN. */
                 overflow = !p->sign || p->frac_hi != DECOMPOSED_IMPLICIT_BIT;
             } else {
                 overflow = true;
             }
         } else {
             /* Overflow, but there might still be bits to return. */
             int shl = p->exp - DECOMPOSED_BINARY_POINT;
             if (shl < N) {
                 frac_shl(p, shl);
                 r = p->frac_hi;
             } else {
                 r = 0;
             }
             overflow = true;
         }
 
         if (p->sign) {
             r = -r;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     if (overflow) {
         flags = float_flag_invalid | float_flag_invalid_cvti;
     }
     float_raise(flags, s);
     return r;
 }
 
 /*
  * Integer to float conversions
  *
  * Returns the result of converting the two's complement integer `a'
  * to the floating-point format. The conversion is performed according
  * to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d..e16e1896ee 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1811,56 +1811,57 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
 static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
                                               float_status *s)
 {
     const FloatFmt *fmt = &floatx80_params[s->floatx80_rounding_precision];
     uint64_t frac;
     int exp;
 
     switch (p->cls) {
     case float_class_normal:
         if (s->floatx80_rounding_precision == floatx80_precision_x) {
             parts_uncanon_normal(p, s, fmt);
             frac = p->frac_hi;
             exp = p->exp;
         } else {
             FloatParts64 p64;
 
             p64.sign = p->sign;
             p64.exp = p->exp;
             frac_truncjam(&p64, p);
             parts_uncanon_normal(&p64, s, fmt);
             frac = p64.frac;
             exp = p64.exp;
         }
         if (exp != fmt->exp_max) {
             break;
         }
         /* rounded to inf -- fall through to set frac correctly */
+        fallthrough;
 
     case float_class_inf:
         /* x86 and m68k differ in the setting of the integer bit. */
         frac = floatx80_infinity_low;
         exp = fmt->exp_max;
         break;
 
     case float_class_zero:
         frac = 0;
         exp = 0;
         break;
 
     case float_class_snan:
     case float_class_qnan:
         /* NaNs have the integer bit set. */
         frac = p->frac_hi | (1ull << 63);
         exp = fmt->exp_max;
         break;
 
     default:
         g_assert_not_reached();
     }
 
     return packFloatx80(p->sign, exp, frac);
 }
 
 /*
  * Addition and subtraction
  */
@@ -2668,35 +2669,35 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
 static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
         float_raise(float_flag_invalid_snan, s);
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         /*
          * There is no NaN in the destination format.  Raise Invalid
          * and return a zero with the sign of the input NaN.
          */
         float_raise(float_flag_invalid, s);
         a->cls = float_class_zero;
         break;
 
     case float_class_inf:
         /*
          * There is no Inf in the destination format.  Raise Invalid
          * and return the maximum normal with the correct sign.
          */
         float_raise(float_flag_invalid, s);
         a->cls = float_class_normal;
         a->exp = float16_params_ahp.exp_max;
         a->frac = MAKE_64BIT_MASK(float16_params_ahp.frac_shift,
                                   float16_params_ahp.frac_size + 1);
         break;
 
     case float_class_normal:
     case float_class_zero:
         break;
 
     default:
         g_assert_not_reached();
     }
 }
@@ -3190,53 +3191,53 @@ static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
 static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
     int flags = 0;
     Int128 r;
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
 
     switch (p.cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = UINT128_MAX;
         break;
 
     case float_class_inf:
         flags = float_flag_invalid | float_flag_invalid_cvti;
         r = p.sign ? INT128_MIN : INT128_MAX;
         break;
 
     case float_class_zero:
         return int128_zero();
 
     case float_class_normal:
         if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
         }
 
         if (p.exp < 127) {
             int shift = 127 - p.exp;
             r = int128_urshift(int128_make128(p.frac_lo, p.frac_hi), shift);
             if (p.sign) {
                 r = int128_neg(r);
             }
         } else if (p.exp == 127 && p.sign && p.frac_lo == 0 &&
                    p.frac_hi == DECOMPOSED_IMPLICIT_BIT) {
             r = INT128_MIN;
         } else {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = p.sign ? INT128_MIN : INT128_MAX;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     float_raise(flags, s);
     return r;
 }
@@ -3617,54 +3618,54 @@ static uint64_t float128_to_uint64_scalbn(float128 a, FloatRoundMode rmode,
 static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
                                          int scale, float_status *s)
 {
     int flags = 0;
     Int128 r;
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
 
     switch (p.cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = UINT128_MAX;
         break;
 
     case float_class_inf:
         flags = float_flag_invalid | float_flag_invalid_cvti;
         r = p.sign ? int128_zero() : UINT128_MAX;
         break;
 
     case float_class_zero:
         return int128_zero();
 
     case float_class_normal:
         if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
             if (p.cls == float_class_zero) {
                 r = int128_zero();
                 break;
             }
         }
 
         if (p.sign) {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = int128_zero();
         } else if (p.exp <= 127) {
             int shift = 127 - p.exp;
             r = int128_urshift(int128_make128(p.frac_lo, p.frac_hi), shift);
         } else {
             flags = float_flag_invalid | float_flag_invalid_cvti;
             r = UINT128_MAX;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     float_raise(flags, s);
     return r;
 }
-- 
2.39.2



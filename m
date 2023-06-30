Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B56127437F5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 11:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFABp-00073d-2f; Fri, 30 Jun 2023 05:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFABn-00072r-4f
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:13:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qFABk-0000AP-0A
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 05:13:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso179365166b.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1688116390; x=1690708390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IX/I0sfGCUuRLUYWiDDex/hhFLmikHItMDR4zyKdTtk=;
 b=RegFUmrZQCeU/NWlmk/37iPoufyoHN3bEaYuRS09GAcW66ukUJnIoUxGRsbecA+Mnl
 jOo/RbFzAGuJ7b0nJJRqI14DM/hilNtWZxSmzi+GZqiiBlUwK40/PfBryWj8Ohgt3sIN
 l9rA9IIRb1BaF2gY0+bm5cf2Uij0ol2zoXoDQW+GB5kzaRdlmjqRtNlNgxvsoVbTTEaL
 fx3WFag+/MyM8w++BzwKVyOV5Kthdg6/AaL/rXZ94BvQJmU8gYHe4NPpM1L3xEghRLY6
 L5UqdWCAv/1gmYRKRggU1SqOsOeRp4FeckBL1eLuuC48O3sxU1u/ri0gJ6du2FECoNJz
 lsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688116390; x=1690708390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IX/I0sfGCUuRLUYWiDDex/hhFLmikHItMDR4zyKdTtk=;
 b=AFnMZNnpMf4zbm525ghfJkhZTVHR690TxBZ2m24ON5WwGc7U9zvUGW31W7ndIhGSNk
 WpkrrHXvQnH0GKelBn1084OIEvK+WOH6FrnCkGJ6VsfOahr810qYQ2MhPonFYMlVNjMI
 ZDWQTk1SWmHz+3Go0A8lEo4Vc/WWgxljufHMKEjflAAoRv62Pneu/q/zFXH8UYaPW1+n
 ua5W+zvtj98lJ1Yotr+PSXfkb4JYlh9awAi/k1U1suihPR870OlkUduN7/sTxjce9DmT
 emrwh4QAKWD5GqxFDCaoWQCMp2rhQSU3oriCNdv8z03HSPfAXUE52chuStejjkE3A7gB
 +xqg==
X-Gm-Message-State: ABy/qLanxgnHOEMHQmDTzcT86ZzItjn0elahjuKLoodRkdaOmiTHevA+
 /l83yGdabx18KTZcZBSGWbQ79w==
X-Google-Smtp-Source: ACHHUZ6mtKQOYeufzu+QMauFcQfkd/H6lV/ejPn22JvH5SgZlQirJWEMPikyf6mQOnFw6cMctE7DYQ==
X-Received: by 2002:a17:907:20a4:b0:982:80b7:ad4c with SMTP id
 pw4-20020a17090720a400b0098280b7ad4cmr1427882ejb.16.1688116390554; 
 Fri, 30 Jun 2023 02:13:10 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 lc1-20020a170906f90100b00988e953a586sm7869892ejb.61.2023.06.30.02.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 02:13:09 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jeff Law <jeffreyalaw@gmail.com>,
 Tsukasa OI <research_trasio@irq.a4lg.com>, liweiwei@iscas.ac.cn,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Rob Bradford <rbradford@rivosinc.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH v4 2/3] target/riscv: Use float64_to_int64_modulo for
 fcvtmod.w.d
Date: Fri, 30 Jun 2023 11:13:02 +0200
Message-ID: <20230630091303.1676486-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630091303.1676486-1-christoph.muellner@vrull.eu>
References: <20230630091303.1676486-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

For the most part we can use the new generic routine,
though exceptions need some post-processing.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 target/riscv/fpu_helper.c | 78 ++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 51 deletions(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 289b3bbea5..0f897cf072 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -482,70 +482,46 @@ target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
     return float64_to_int32(frs1, &env->fp_status);
 }
 
+/* T floating (double) */
+static inline float64 t_to_float64(uint64_t a)
+{
+    /* Memory format is the same as float64 */
+    CPU_DoubleU r;
+    r.ll = a;
+    return r.d;
+}
+
 /*
  * Implement float64 to int32_t conversion without saturation;
  * the result is supplied modulo 2^32.
  * Rounding mode is RTZ.
  * Flag behaviour identical to fcvt.w.d (see F specification).
- *
- * Similar conversion of this function can be found in
- * target/arm/vfp_helper.c (fjcvtzs): f64->i32 with other fflag behaviour, and
- * target/alpha/fpu_helper.c (do_cvttq): f64->i64 with support for several
- * rounding modes and different fflag behaviour.
  */
 uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
 {
     float_status *status = &env->fp_status;
-    uint32_t sign = extract64(value, 63, 1);
-    uint32_t exp = extract64(value, 52, 11);
-    uint64_t frac = extract64(value, 0, 52);
-
-    /* Handle the special cases first. */
-    if (exp == 0) {
-        if (unlikely(frac != 0)) {
-            /* Subnormal numbers. */
-            float_raise(float_flag_inexact, status);
-            return 0;
-        } else {
-            /* +0 or -0 */
-            return 0;
-	}
-    } else if (exp == 0x7ff) {
-        /* NaN (frac != 0) or INF (frac == 0). */
-        float_raise(float_flag_invalid, status);
-	return 0;
-    }
-
-    /* Normal value. */
-    int true_exp = exp - 1023;
-    int shift = true_exp - 52;
-    uint64_t true_frac = frac | 1ull << 52;
-    uint64_t ret;
-
-    /* Shift the fraction into place and set NX flag. */
-    if (shift >= 64 || shift <= -64) {
-            /* The fraction is shifted out entirely. */
-            ret = 0;
-            float_raise(float_flag_inexact, status);
-    } else if (shift >= 0) {
-        ret = true_frac << shift;
-        /* Raise NX if bit 52 got shifted out. */
-        if (shift >= 12)
-            float_raise(float_flag_inexact, status);
-    } else { /* shift < 0 */
-        ret = true_frac >> -shift;
-        /* Raise NX if bits got shifted out. */
-        if ((ret << -shift) != true_frac)
-            float_raise(float_flag_inexact, status);
+    int64_t ret;
+    int32_t ret32;
+    uint32_t e_old, e_new;
+    float64 fvalue;
+
+    e_old = get_float_exception_flags(status);
+    set_float_exception_flags(0, status);
+    fvalue = t_to_float64(value);
+    ret = float64_to_int32_modulo(fvalue, float_round_to_zero, status);
+    e_new = get_float_exception_flags(status);
+
+    /* Map the flags to the specified ones. */
+    if (e_new & float_flag_inexact) {
+        e_new = float_flag_inexact;
+    } else if (e_new) {
+        e_new = float_flag_invalid;
     }
 
-    /* Honor the sign bit. */
-    if (sign) {
-        ret = -ret;
-    }
+    set_float_exception_flags(e_old | e_new, status);
 
     /* Truncate to 32-bits. */
-    int32_t ret32 = (int32_t)ret;
+    ret32 = (int32_t)ret;
 
     /* If the truncation drops bits then raise NV. */
     if ((uint64_t)ret32 != ret)
-- 
2.41.0



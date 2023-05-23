Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A570DDDF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMa-0008Km-UN; Tue, 23 May 2023 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMY-0008CF-AK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMW-00013s-6I
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3bc502ddso5110115b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849659; x=1687441659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frmGIXxr84Ww41VQFYmyyhkxPgV+QZOjqj6i0A0DQ+A=;
 b=vAycIJibsbqoXbokQVsguoOpH+DT0bxlHRqca2pVTSrXPx79rdzhZUgS6qvhSAe1w9
 2mopA1/NBkHxAGejPGjx5i3LWMthlK2D3W62RMuIq2h3U3CyD7SMlZOy6ZOP98vr/z3s
 Rd5qQzpCtLj6pDmz7Y2yfbXi2O3JavJFt93tIhT9JatiOIyl0K+WnjzkQsTaxrDmGlc1
 2Fe2qY7IjkVSW2m0IJCWi/8N4qoW8iyU1+gf3CC8qorWo29243lsjMQfMjNAVN9d1ltg
 wGP+9N8eEC8rrdlfiyYx05+5e0XPXsexTW1RinyPWwrjB438QleILIW/t/gjdNHDph7b
 TOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849659; x=1687441659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frmGIXxr84Ww41VQFYmyyhkxPgV+QZOjqj6i0A0DQ+A=;
 b=dLua5tUiPEz2PZV2EEHx8taWxpaxmNSuBdEf4C3wFvTSDq3e7lSZCAe4wquND01JRm
 BxjV0KC9aenJsTADnB3XXjMraK4TLIyDY3CTM0e5cf80iKoeFaZdhpTH/HomHXsrsEQl
 0IupFCTiH2RMkrYi4Tv2cr52S9Kz9/SNvstMZ2zgPL5grIz3E8T/3duRKxalAFPfp8x1
 +W0YYsjIlbuxC0K4ED6IVRaW7QfvgS99WSfGvhOyfqPq+NBxPpviEghoP289oz1a2DY8
 Xx9LmUdQDB9sMSI0jwtFeEiUML720GEhq1YfqsQaS8c08fiqrK3CGH+eqirj2eoCag7i
 ATsA==
X-Gm-Message-State: AC+VfDzVGByLnJAhBha0HhX1sgWErln+kmj+v6OzzIXfwQI5RuolTiSR
 KP8QEXX6r2YNn+je+ot89C7kJiPCOXuGNTDB674=
X-Google-Smtp-Source: ACHHUZ4XkxlwAsWn3P9asfgz8aph/PivAxAwJOMkiI3JDUrU7XPx9/Q4vf9rI8NHZ9XXnj5v/CMPHw==
X-Received: by 2002:a05:6a20:160c:b0:104:4558:b412 with SMTP id
 l12-20020a056a20160c00b001044558b412mr16518600pzj.25.1684849658757; 
 Tue, 23 May 2023 06:47:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 04/27] tcg/i386: Use host/cpuinfo.h
Date: Tue, 23 May 2023 06:47:10 -0700
Message-Id: <20230523134733.678646-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use the CPUINFO_* bits instead of the individual boolean
variables that we had been using.  Remove all of the init
code that was moved over to cpuinfo-i386.c.

Note that have_avx512* check both AVX512{F,VL}, as we had
previously done during tcg_target_init.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  28 +++++----
 tcg/i386/tcg-target.c.inc | 123 ++------------------------------------
 2 files changed, 22 insertions(+), 129 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 0b5a2c68c5..0106946996 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -25,6 +25,8 @@
 #ifndef I386_TCG_TARGET_H
 #define I386_TCG_TARGET_H
 
+#include "host/cpuinfo.h"
+
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
 
@@ -111,16 +113,22 @@ typedef enum {
 # define TCG_TARGET_CALL_RET_I128    TCG_CALL_RET_BY_REF
 #endif
 
-extern bool have_bmi1;
-extern bool have_popcnt;
-extern bool have_avx1;
-extern bool have_avx2;
-extern bool have_avx512bw;
-extern bool have_avx512dq;
-extern bool have_avx512vbmi2;
-extern bool have_avx512vl;
-extern bool have_movbe;
-extern bool have_atomic16;
+#define have_bmi1         (cpuinfo & CPUINFO_BMI1)
+#define have_popcnt       (cpuinfo & CPUINFO_POPCNT)
+#define have_avx1         (cpuinfo & CPUINFO_AVX1)
+#define have_avx2         (cpuinfo & CPUINFO_AVX2)
+#define have_movbe        (cpuinfo & CPUINFO_MOVBE)
+#define have_atomic16     (cpuinfo & CPUINFO_ATOMIC_VMOVDQA)
+
+/*
+ * There are interesting instructions in AVX512, so long as we have AVX512VL,
+ * which indicates support for EVEX on sizes smaller than 512 bits.
+ */
+#define have_avx512vl     ((cpuinfo & CPUINFO_AVX512VL) && \
+                           (cpuinfo & CPUINFO_AVX512F))
+#define have_avx512bw     ((cpuinfo & CPUINFO_AVX512BW) && have_avx512vl)
+#define have_avx512dq     ((cpuinfo & CPUINFO_AVX512DQ) && have_avx512vl)
+#define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8b9a5f00e5..bfe9d98b7e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -158,42 +158,14 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 # define SOFTMMU_RESERVE_REGS  0
 #endif
 
-/* The host compiler should supply <cpuid.h> to enable runtime features
-   detection, as we're not going to go so far as our own inline assembly.
-   If not available, default values will be assumed.  */
-#if defined(CONFIG_CPUID_H)
-#include "qemu/cpuid.h"
-#endif
-
 /* For 64-bit, we always know that CMOV is available.  */
 #if TCG_TARGET_REG_BITS == 64
-# define have_cmov 1
-#elif defined(CONFIG_CPUID_H)
-static bool have_cmov;
+# define have_cmov      true
 #else
-# define have_cmov 0
-#endif
-
-/* We need these symbols in tcg-target.h, and we can't properly conditionalize
-   it there.  Therefore we always define the variable.  */
-bool have_bmi1;
-bool have_popcnt;
-bool have_avx1;
-bool have_avx2;
-bool have_avx512bw;
-bool have_avx512dq;
-bool have_avx512vbmi2;
-bool have_avx512vl;
-bool have_movbe;
-bool have_atomic16;
-
-#ifdef CONFIG_CPUID_H
-static bool have_bmi2;
-static bool have_lzcnt;
-#else
-# define have_bmi2 0
-# define have_lzcnt 0
+# define have_cmov      (cpuinfo & CPUINFO_CMOV)
 #endif
+#define have_bmi2       (cpuinfo & CPUINFO_BMI2)
+#define have_lzcnt      (cpuinfo & CPUINFO_LZCNT)
 
 static const tcg_insn_unit *tb_ret_addr;
 
@@ -3961,93 +3933,6 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
 
 static void tcg_target_init(TCGContext *s)
 {
-#ifdef CONFIG_CPUID_H
-    unsigned a, b, c, d, b7 = 0, c7 = 0;
-    unsigned max = __get_cpuid_max(0, 0);
-
-    if (max >= 7) {
-        /* BMI1 is available on AMD Piledriver and Intel Haswell CPUs.  */
-        __cpuid_count(7, 0, a, b7, c7, d);
-        have_bmi1 = (b7 & bit_BMI) != 0;
-        have_bmi2 = (b7 & bit_BMI2) != 0;
-    }
-
-    if (max >= 1) {
-        __cpuid(1, a, b, c, d);
-#ifndef have_cmov
-        /* For 32-bit, 99% certainty that we're running on hardware that
-           supports cmov, but we still need to check.  In case cmov is not
-           available, we'll use a small forward branch.  */
-        have_cmov = (d & bit_CMOV) != 0;
-#endif
-
-        /* MOVBE is only available on Intel Atom and Haswell CPUs, so we
-           need to probe for it.  */
-        have_movbe = (c & bit_MOVBE) != 0;
-        have_popcnt = (c & bit_POPCNT) != 0;
-
-        /* There are a number of things we must check before we can be
-           sure of not hitting invalid opcode.  */
-        if (c & bit_OSXSAVE) {
-            unsigned bv = xgetbv_low(0);
-
-            if ((bv & 6) == 6) {
-                have_avx1 = (c & bit_AVX) != 0;
-                have_avx2 = (b7 & bit_AVX2) != 0;
-
-                /*
-                 * There are interesting instructions in AVX512, so long
-                 * as we have AVX512VL, which indicates support for EVEX
-                 * on sizes smaller than 512 bits.  We are required to
-                 * check that OPMASK and all extended ZMM state are enabled
-                 * even if we're not using them -- the insns will fault.
-                 */
-                if ((bv & 0xe0) == 0xe0
-                    && (b7 & bit_AVX512F)
-                    && (b7 & bit_AVX512VL)) {
-                    have_avx512vl = true;
-                    have_avx512bw = (b7 & bit_AVX512BW) != 0;
-                    have_avx512dq = (b7 & bit_AVX512DQ) != 0;
-                    have_avx512vbmi2 = (c7 & bit_AVX512VBMI2) != 0;
-                }
-
-                /*
-                 * The Intel SDM has added:
-                 *   Processors that enumerate support for Intel® AVX
-                 *   (by setting the feature flag CPUID.01H:ECX.AVX[bit 28])
-                 *   guarantee that the 16-byte memory operations performed
-                 *   by the following instructions will always be carried
-                 *   out atomically:
-                 *   - MOVAPD, MOVAPS, and MOVDQA.
-                 *   - VMOVAPD, VMOVAPS, and VMOVDQA when encoded with VEX.128.
-                 *   - VMOVAPD, VMOVAPS, VMOVDQA32, and VMOVDQA64 when encoded
-                 *     with EVEX.128 and k0 (masking disabled).
-                 * Note that these instructions require the linear addresses
-                 * of their memory operands to be 16-byte aligned.
-                 *
-                 * AMD has provided an even stronger guarantee that processors
-                 * with AVX provide 16-byte atomicity for all cachable,
-                 * naturally aligned single loads and stores, e.g. MOVDQU.
-                 *
-                 * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
-                 */
-                if (have_avx1) {
-                    __cpuid(0, a, b, c, d);
-                    have_atomic16 = (c == signature_INTEL_ecx ||
-                                     c == signature_AMD_ecx);
-                }
-            }
-        }
-    }
-
-    max = __get_cpuid_max(0x8000000, 0);
-    if (max >= 1) {
-        __cpuid(0x80000001, a, b, c, d);
-        /* LZCNT was introduced with AMD Barcelona and Intel Haswell CPUs.  */
-        have_lzcnt = (c & bit_LZCNT) != 0;
-    }
-#endif /* CONFIG_CPUID_H */
-
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
-- 
2.34.1



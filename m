Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0F7B16BF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlmm5-0006Yc-MD; Thu, 28 Sep 2023 04:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmm3-0006Y6-8n
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:31 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlmm1-0004xi-57
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lk+bO9MVpIZNBBvU6IHOGrEJ52+lL/4qTPNX6trxxgg=; b=ifyL1hUwguGTpBI/qWClqJ3W0W
 yYtal+aVq8CP60ZLEk0YYiZv8isBugbhIimut8in44o9m0Nd1KM4PYPCqfz0oPLHGmjATiWvF+3K1
 sJVTVHk8FAc8FSKcBkR/0reHGXcOZV+PsZCkm6E6MXFCAaZz371pJ20GeZ7n7oM/sIVY=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 06/21] target/tricore: Implement ftohp insn
Date: Thu, 28 Sep 2023 10:52:48 +0200
Message-ID: <20230928085303.511518-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
References: <20230928085303.511518-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.28.84518, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.26.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

reported in https://gitlab.com/qemu-project/qemu/-/issues/1667

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-7-kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c               | 38 +++++++++++++++++++++++
 target/tricore/helper.c                   |  1 +
 target/tricore/helper.h                   |  1 +
 target/tricore/translate.c                |  7 +++++
 target/tricore/tricore-opcodes.h          |  1 +
 tests/tcg/tricore/Makefile.softmmu-target |  1 +
 tests/tcg/tricore/asm/test_ftohp.S        | 14 +++++++++
 7 files changed, 63 insertions(+)
 create mode 100644 tests/tcg/tricore/asm/test_ftohp.S

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index d0c474c5f3..848c4a40a0 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -373,6 +373,44 @@ uint32_t helper_ftoi(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)result;
 }
 
+uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_arg = make_float32(arg);
+    uint32_t result = 0;
+    int32_t flags = 0;
+
+    /*
+     * if we have any NAN we need to move the top 2 and lower 8 input mantissa
+     * bits to the top 2 and lower 8 output mantissa bits respectively.
+     * Softfloat on the other hand uses the top 10 mantissa bits.
+     */
+    if (float32_is_any_nan(f_arg)) {
+        if (float32_is_signaling_nan(f_arg, &env->fp_status)) {
+            flags |= float_flag_invalid;
+        }
+        result = float16_set_sign(result, arg >> 31);
+        result = deposit32(result, 10, 5, 0x1f);
+        result = deposit32(result, 8, 2, extract32(arg, 21, 2));
+        result = deposit32(result, 0, 8, extract32(arg, 0, 8));
+        if (extract32(result, 0, 10) == 0) {
+            result |= (1 << 8);
+        }
+    } else {
+        set_flush_to_zero(0, &env->fp_status);
+        result = float32_to_float16(f_arg, true, &env->fp_status);
+        set_flush_to_zero(1, &env->fp_status);
+        flags = f_get_excp_flags(env);
+    }
+
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+
+    return result;
+}
+
 uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index e615c3d6d4..7e5da3cb23 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -137,6 +137,7 @@ void fpu_set_state(CPUTriCoreState *env)
 
     set_flush_inputs_to_zero(1, &env->fp_status);
     set_flush_to_zero(1, &env->fp_status);
+    set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     set_default_nan_mode(1, &env->fp_status);
 }
 
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 827fbaa692..dcc5a492b3 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -111,6 +111,7 @@ DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
+DEF_HELPER_2(ftohp, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 382ecf4775..d76b6475f1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6260,6 +6260,13 @@ static void decode_rr_divide(DisasContext *ctx)
     case OPC2_32_RR_DIV_F:
         gen_helper_fdiv(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
+    case OPC2_32_RR_FTOHP:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            gen_helper_ftohp(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RR_CMP_F:
         gen_helper_fcmp(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index f070571665..29e655a667 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1152,6 +1152,7 @@ enum {
     OPC2_32_RR_ITOF                              = 0x14,
     OPC2_32_RR_CMP_F                             = 0x00,
     OPC2_32_RR_FTOIZ                             = 0x13,
+    OPC2_32_RR_FTOHP                             = 0x25, /* 1.6.2 only */
     OPC2_32_RR_FTOQ31                            = 0x11,
     OPC2_32_RR_FTOQ31Z                           = 0x18,
     OPC2_32_RR_FTOU                              = 0x12,
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index 91ae129a83..fc545d45ae 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -14,6 +14,7 @@ TESTS += test_dextr.asm.tst
 TESTS += test_dvstep.asm.tst
 TESTS += test_fadd.asm.tst
 TESTS += test_fmul.asm.tst
+TESTS += test_ftohp.asm.tst
 TESTS += test_ftoi.asm.tst
 TESTS += test_ftou.asm.tst
 TESTS += test_imask.asm.tst
diff --git a/tests/tcg/tricore/asm/test_ftohp.S b/tests/tcg/tricore/asm/test_ftohp.S
new file mode 100644
index 0000000000..9e23141c1e
--- /dev/null
+++ b/tests/tcg/tricore/asm/test_ftohp.S
@@ -0,0 +1,14 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(ftohp, 1, 0xffff, 0xffffffff)
+    TEST_D_D(ftohp, 2, 0xfc00, 0xff800000)
+    TEST_D_D(ftohp, 3, 0x7c00, 0x7f800000)
+    TEST_D_D(ftohp, 4, 0x0, 0x0)
+    TEST_D_D(ftohp, 5, 0x5, 0x34a43580)
+
+    #TEST_D_D_PSW(ftohp, 6, 0x400, 0x8c000b80, 0x387fee74)
+
+    TEST_PASSFAIL
+
-- 
2.42.0



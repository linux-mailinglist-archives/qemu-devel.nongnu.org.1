Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942827B008F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQy9-0000qS-Fe; Wed, 27 Sep 2023 05:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQxx-0000lX-5F
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:23 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qlQxr-0000gw-3K
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ztyiR4O7yUKNMu62qAC5I6VE6EL6Xn2CyTtUB4FAoRc=; b=D/nMtdhcu5JwOLFxUW3GIB+pqJ
 FkNL1gucIZtAtyqcJ5CPRRTX6d8bh7IPX8UBuunRT/Q1CxLvvqt01BJCR2AxxJCRFCFXnAudAUVZI
 Hj1vETSqR1Mc1FRbxYphB6d3yAI7/6/YMHFxwvTkQD5ROSgaZSpthgpUvhLZ3QE7czT0=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/21] target/tricore: Implement FTOU insn
Date: Wed, 27 Sep 2023 11:35:35 +0200
Message-ID: <20230927093552.493279-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
References: <20230927093552.493279-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: add header
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.27.92417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.26.602000
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-5-kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c               | 32 +++++++++++++++++++++++
 target/tricore/helper.h                   |  1 +
 target/tricore/translate.c                |  3 +++
 tests/tcg/tricore/Makefile.softmmu-target |  1 +
 tests/tcg/tricore/asm/test_ftou.S         | 12 +++++++++
 5 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/tricore/asm/test_ftou.S

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index cb7ee7dd35..3aefeb776e 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -429,6 +429,38 @@ uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
+uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_arg = make_float32(arg);
+    uint32_t result;
+    int32_t flags = 0;
+
+    result = float32_to_uint32(f_arg, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags & float_flag_invalid) {
+        flags &= ~float_flag_inexact;
+        if (float32_is_any_nan(f_arg)) {
+            result = 0;
+        }
+    /*
+     * we need to check arg < 0.0 before rounding as TriCore needs to raise
+     * float_flag_invalid as well. For instance, when we have a negative
+     * exponent and sign, softfloat would only raise float_flat_inexact.
+     */
+    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
+        flags = float_flag_invalid;
+        result = 0;
+    }
+
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return result;
+}
+
 uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 190645413a..827fbaa692 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -114,6 +114,7 @@ DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
+DEF_HELPER_2(ftou, i32, env, i32)
 DEF_HELPER_2(ftouz, i32, env, i32)
 DEF_HELPER_2(updfl, void, env, i32)
 /* dvinit */
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4e7e18f985..382ecf4775 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6269,6 +6269,9 @@ static void decode_rr_divide(DisasContext *ctx)
     case OPC2_32_RR_ITOF:
         gen_helper_itof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_FTOU:
+        gen_helper_ftou(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     case OPC2_32_RR_FTOUZ:
         gen_helper_ftouz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index b8d9b33933..91ae129a83 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -15,6 +15,7 @@ TESTS += test_dvstep.asm.tst
 TESTS += test_fadd.asm.tst
 TESTS += test_fmul.asm.tst
 TESTS += test_ftoi.asm.tst
+TESTS += test_ftou.asm.tst
 TESTS += test_imask.asm.tst
 TESTS += test_insert.asm.tst
 TESTS += test_ld_bu.asm.tst
diff --git a/tests/tcg/tricore/asm/test_ftou.S b/tests/tcg/tricore/asm/test_ftou.S
new file mode 100644
index 0000000000..10f106ad62
--- /dev/null
+++ b/tests/tcg/tricore/asm/test_ftou.S
@@ -0,0 +1,12 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(ftou, 1, 0x00000000, 0x1733f6c2)
+    TEST_D_D(ftou, 2, 0x00000000, 0x2c9d9cdc)
+    TEST_D_D(ftou, 3, 0xffffffff, 0x56eb7395)
+    TEST_D_D(ftou, 4, 0x79900800, 0x4ef32010)
+    TEST_D_D(ftou, 5, 0x0353f510, 0x4c54fd44)
+
+    TEST_PASSFAIL
+
-- 
2.42.0



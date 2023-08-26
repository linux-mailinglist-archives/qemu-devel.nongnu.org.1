Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D567897EB
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvkr-0006Xb-Cz; Sat, 26 Aug 2023 12:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvko-0006XI-L7
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:14 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkl-0007t3-VG
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PRwHxW2E/2oEnJkXNZC1X0+LsWKBChTR9cxnYbjXc2k=; b=shgj00TYq3nx+2VoLNI3D3y22u
 G+YpArwqpQZCAdKrViZkhRRjWRLH4XTzNdgXEPciXL4OILE4E137BQ8m8JukRNuln8mU1V4McNCyy
 UpFdfqKpal6ZDz7ATTDKheD4m+usFwLpnaiu3uWxPwD7PGwD0bDbYuTx0/B9a+XqR9fk=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 06/10] target/tricore: Implement hptof insn
Date: Sat, 26 Aug 2023 18:02:38 +0200
Message-ID: <20230826160242.312052-7-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1667
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c               | 39 +++++++++++++++++++++++
 target/tricore/helper.h                   |  1 +
 target/tricore/translate.c                |  7 ++++
 target/tricore/tricore-opcodes.h          |  1 +
 tests/tcg/tricore/Makefile.softmmu-target |  1 +
 tests/tcg/tricore/asm/test_hptof.S        | 12 +++++++
 6 files changed, 61 insertions(+)
 create mode 100644 tests/tcg/tricore/asm/test_hptof.S

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 3db2341ac0..b91f872396 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -29,6 +29,8 @@
 #define MUL_NAN   0x7fc00002
 #define HP_NEG_INFINITY 0xfc00
 #define HP_POS_INFINITY 0x7c00
+#define NEG_INFINITY 0xff800000
+#define POS_INFINITY 0x7f800000
 #define FPU_FS PSW_USB_C
 #define FPU_FI PSW_USB_V
 #define FPU_FV PSW_USB_SV
@@ -375,6 +377,43 @@ uint32_t helper_ftoi(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)result;
 }
 
+uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
+{
+    float16 f_arg = make_float16(arg);
+    uint32_t result = 0;
+    int32_t flags = 0;
+
+    if (float16_is_any_nan(f_arg)) {
+        if (float16_is_signaling_nan(f_arg, &env->fp_status)) {
+            flags |= float_flag_invalid;
+        }
+        result = 0;
+        result = float32_set_sign(result, f_arg >> 15);
+        result = deposit32(result, 23, 8, 0xff);
+        result = deposit32(result, 21, 2, extract32(f_arg, 8, 2));
+        result = deposit32(result, 0, 8, extract32(f_arg, 0, 8));
+    } else if (float16_is_infinity(f_arg)) {
+        if (float16_is_neg(f_arg)) {
+            result = NEG_INFINITY;
+        } else {
+            result = POS_INFINITY;
+        }
+    } else {
+        set_flush_inputs_to_zero(0, &env->fp_status);
+        result = float16_to_float32(f_arg, true, &env->fp_status);
+        set_flush_inputs_to_zero(1, &env->fp_status);
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
 uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index dcc5a492b3..1d97d078b0 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -112,6 +112,7 @@ DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(ftohp, i32, env, i32)
+DEF_HELPER_2(hptof, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index d94c273f89..4400d2c3cb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6271,6 +6271,13 @@ static void decode_rr_divide(DisasContext *ctx)
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
+   case OPC2_32_RR_HPTOF:
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            gen_helper_hptof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        } else {
+            generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
+        }
+        break;
     case OPC2_32_RR_CMP_F:
         gen_helper_fcmp(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 29e655a667..60d2402b6e 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -1153,6 +1153,7 @@ enum {
     OPC2_32_RR_CMP_F                             = 0x00,
     OPC2_32_RR_FTOIZ                             = 0x13,
     OPC2_32_RR_FTOHP                             = 0x25, /* 1.6.2 only */
+    OPC2_32_RR_HPTOF                             = 0x24, /* 1.6.2 only */
     OPC2_32_RR_FTOQ31                            = 0x11,
     OPC2_32_RR_FTOQ31Z                           = 0x18,
     OPC2_32_RR_FTOU                              = 0x12,
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index f4a27a83e4..afcf41a977 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -17,6 +17,7 @@ TESTS += test_fmul.asm.tst
 TESTS += test_ftohp.asm.tst
 TESTS += test_ftoi.asm.tst
 TESTS += test_ftou.asm.tst
+TESTS += test_hptof.asm.tst
 TESTS += test_imask.asm.tst
 TESTS += test_insert.asm.tst
 TESTS += test_ld_bu.asm.tst
diff --git a/tests/tcg/tricore/asm/test_hptof.S b/tests/tcg/tricore/asm/test_hptof.S
new file mode 100644
index 0000000000..8adc5e5273
--- /dev/null
+++ b/tests/tcg/tricore/asm/test_hptof.S
@@ -0,0 +1,12 @@
+#include "macros.h"
+.text
+.global _start
+_start:
+    TEST_D_D(hptof, 1, 0xba190000, 0xcc0e90c8)
+    TEST_D_D(hptof, 2, 0x3eaea000, 0x8be23575)
+    TEST_D_D(hptof, 3, 0xc33b8000, 0xcc48d9dc)
+    TEST_D_D(hptof, 4, 0x43e2a000, 0xaef95f15)
+    TEST_D_D(hptof, 5, 0x3d55e000, 0x04932aaf)
+
+    TEST_PASSFAIL
+
-- 
2.41.0



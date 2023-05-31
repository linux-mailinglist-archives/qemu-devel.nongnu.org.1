Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CC7174E3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4E-0007b6-6z; Wed, 31 May 2023 00:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D48-0007Wj-Hw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D44-0006I9-2o
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d3bc502ddso6150746b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505838; x=1688097838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=duGA7kwxRMuS9B9Tz8i364FZ2ORJWULrhCwI7Ct0WCs=;
 b=pD4ksJRSRIVMnMPc9GZc3OWMvqCQgbJS2BWfzTj0vL8BavKq1ZdPsWyXpOc+2d8QF2
 /3NBgASqTBTr+1bmTtuNfOhXhJR49s/maI7CLMho2qaMljUFmkSPWLwk5HxubkhU6xW6
 4gXC9Lx//adRaJHEoyNzreVAx866GdRXE8EbK684YGAO/+sd/c1GHP0jnjczk5bweEv+
 SyjhMlz5D/P73rLH6214uAL2FoMuHVz9/s4mZm+H6Nx3GYGNPKT7qhHovarE9RF0Kd9j
 2TaE8UzPh1J/QK3jUPhUeqJWNdDoLL1KWL43IVWRj2io535jTjiwJVkfeElhLSDMaInj
 6MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505838; x=1688097838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duGA7kwxRMuS9B9Tz8i364FZ2ORJWULrhCwI7Ct0WCs=;
 b=Mobd43+EUkGjbFMXIhNp7BOpCsnXVWA/qAm1WZi3rofdAf+lhdCOxhWa4nNh9FpFh4
 kaN9zr8pC0mX1pPMoJ54xWO/yXqjO/d04t1P3mvIIWmF9pDl0vh2l4MfGD61wTM2bhUI
 xxgQrr4aIlffMkN3mOVFmku7TlpqpQ5t5HZ2vjWNyaVI5tFVbgKYUxdpVcqjP1hH+M8B
 qat8bU09zecvXjdf/v2afJNUFmNjWiFqppuVplXlkUBpqf92bu/nwujwz6Bipc48Xkvw
 irq7hCkbhADySHfzNCLVxMIK33wtcahDroqt5ZRIC9pqIzwuk7QM8TxF91s0O4L3WJ9d
 VlWw==
X-Gm-Message-State: AC+VfDw1FR5q9u9s88TD/kRYPOfucymT5m6myOujPaMzI6h8ePsfuO7J
 CAsSSeVlYH6iSg9k2CjZn0d2/ovebajh/ibXoH0=
X-Google-Smtp-Source: ACHHUZ4T7+UBV7dv/vYRDGtIVNxo0drCccyxsiI/MQO0h5ihzHXhw9LimInXheHeiTvKjXEgYTqdbg==
X-Received: by 2002:a05:6a20:8f26:b0:10b:6e18:b694 with SMTP id
 b38-20020a056a208f2600b0010b6e18b694mr5522277pzk.55.1685505838236; 
 Tue, 30 May 2023 21:03:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 35/48] accel/tcg: Introduce translator_io_start
Date: Tue, 30 May 2023 21:03:17 -0700
Message-Id: <20230531040330.8950-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

New wrapper around gen_io_start which takes care of the USE_ICOUNT
check, as well as marking the DisasContext to end the TB.
Remove exec/gen-icount.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                   |  1 -
 include/exec/gen-icount.h                     |  6 --
 include/exec/translator.h                     | 10 +++
 target/arm/cpregs.h                           |  4 +-
 accel/tcg/translator.c                        | 27 ++++++-
 target/alpha/translate.c                      | 15 +---
 target/arm/tcg/translate-a64.c                | 23 +++---
 target/arm/tcg/translate-mve.c                |  1 -
 target/arm/tcg/translate-neon.c               |  1 -
 target/arm/tcg/translate-vfp.c                |  4 +-
 target/arm/tcg/translate.c                    | 20 ++---
 target/avr/translate.c                        |  1 -
 target/cris/translate.c                       |  2 -
 target/hppa/translate.c                       |  5 +-
 target/i386/tcg/translate.c                   | 52 +++----------
 target/loongarch/translate.c                  |  2 -
 target/m68k/translate.c                       |  2 -
 target/microblaze/translate.c                 |  2 -
 target/mips/tcg/translate.c                   | 29 +++----
 target/nios2/translate.c                      |  1 -
 target/openrisc/translate.c                   |  9 +--
 target/ppc/translate.c                        | 13 +---
 target/riscv/translate.c                      |  2 -
 target/rx/translate.c                         |  2 -
 target/s390x/tcg/translate.c                  |  6 +-
 target/sh4/translate.c                        |  2 -
 target/sparc/translate.c                      | 75 +++++--------------
 target/tricore/translate.c                    |  2 -
 target/xtensa/translate.c                     | 27 ++-----
 target/loongarch/insn_trans/trans_extra.c.inc |  4 +-
 .../insn_trans/trans_privileged.c.inc         |  4 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |  8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       | 24 ++----
 33 files changed, 117 insertions(+), 269 deletions(-)
 delete mode 100644 include/exec/gen-icount.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b025a7b63..63e688202f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2864,7 +2864,6 @@ F: ui/cocoa.m
 Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: include/exec/gen-icount.h
 F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: include/sysemu/runstate-action.h
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
deleted file mode 100644
index 6006af4c06..0000000000
--- a/include/exec/gen-icount.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef GEN_ICOUNT_H
-#define GEN_ICOUNT_H
-
-void gen_io_start(void);
-
-#endif
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 797fef7515..c1a1203789 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -160,6 +160,16 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
  */
 bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest);
 
+/**
+ * translator_io_start
+ * @db: Disassembly context
+ *
+ * If icount is enabled, set cpu->can_to_io, adjust db->is_jmp to
+ * DISAS_TOO_MANY if it is still DISAS_NEXT, and return true.
+ * Otherwise return false.
+ */
+bool translator_io_start(DisasContextBase *db);
+
 /*
  * Translator Load Functions
  *
diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b04d344a9f..14785686f6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -67,8 +67,8 @@ enum {
     ARM_CP_ALIAS                 = 1 << 8,
     /*
      * Flag: Register does I/O and therefore its accesses need to be marked
-     * with gen_io_start() and also end the TB. In particular, registers which
-     * implement clocks or timers require this.
+     * with translator_io_start() and also end the TB. In particular,
+     * registers which implement clocks or timers require this.
      */
     ARM_CP_IO                    = 1 << 9,
     /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index b0d0015c70..7a130e706e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,20 +12,43 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
-#include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "exec/replay-core.h"
 
 
-void gen_io_start(void)
+static void gen_io_start(void)
 {
     tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
                    offsetof(ArchCPU, parent_obj.can_do_io) -
                    offsetof(ArchCPU, env));
 }
 
+bool translator_io_start(DisasContextBase *db)
+{
+    uint32_t cflags = tb_cflags(db->tb);
+
+    if (!(cflags & CF_USE_ICOUNT)) {
+        return false;
+    }
+    if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
+        /* Already started in translator_loop. */
+        return true;
+    }
+
+    gen_io_start();
+
+    /*
+     * Ensure that this instruction will be the last in the TB.
+     * The target may override this to something more forceful.
+     */
+    if (db->is_jmp == DISAS_NEXT) {
+        db->is_jmp = DISAS_TOO_MANY;
+    }
+    return true;
+}
+
 static TCGOp *gen_tb_start(uint32_t cflags)
 {
     TCGv_i32 count = tcg_temp_new_i32();
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 545e5743c3..1f7dd078d8 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -96,8 +96,6 @@ static TCGv cpu_lock_value;
 static TCGv cpu_pal_ir[31];
 #endif
 
-#include "exec/gen-icount.h"
-
 void alpha_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUAlphaState, V) }
@@ -1236,8 +1234,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
     case 249: /* VMTIME */
         helper = gen_helper_get_vmtime;
     do_helper:
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
+        if (translator_io_start(&ctx->base)) {
             helper(va);
             return DISAS_PC_STALE;
         } else {
@@ -1298,8 +1295,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 
     case 251:
         /* ALARM */
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
+        if (translator_io_start(&ctx->base)) {
             ret = DISAS_PC_STALE;
         }
         gen_helper_set_alarm(cpu_env, vb);
@@ -2335,13 +2331,10 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         case 0xC000:
             /* RPCC */
             va = dest_gpr(ctx, ra);
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-                gen_helper_load_pcc(va, cpu_env);
+            if (translator_io_start(&ctx->base)) {
                 ret = DISAS_PC_STALE;
-            } else {
-                gen_helper_load_pcc(va, cpu_env);
             }
+            gen_helper_load_pcc(va, cpu_env);
             break;
         case 0xE000:
             /* RC */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bc0cb98955..8d45dbf8fc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -28,7 +28,6 @@
 #include "internals.h"
 #include "qemu/host-utils.h"
 #include "semihosting/semihost.h"
-#include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "cpregs.h"
 #include "translate-a64.h"
@@ -1552,9 +1551,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPUARMState, elr_el[s->current_el]));
 
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&s->base);
 
     gen_helper_exception_return(cpu_env, dst);
     /* Must exit loop to check un-masked IRQs */
@@ -1582,9 +1579,8 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
                    offsetof(CPUARMState, elr_el[s->current_el]));
 
     dst = auth_branch_target(s, dst, cpu_X[31], !a->m);
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+
+    translator_io_start(&s->base);
 
     gen_helper_exception_return(cpu_env, dst);
     /* Must exit loop to check un-masked IRQs */
@@ -2044,6 +2040,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
                                       crn, crm, op0, op1, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
+    bool need_exit_tb = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
 
@@ -2171,8 +2168,9 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     }
 
-    if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        gen_io_start();
+    if (ri->type & ARM_CP_IO) {
+        /* I/O operations must end the TB here (whether read or write) */
+        need_exit_tb = translator_io_start(&s->base);
     }
 
     tcg_rt = cpu_reg(s, rt);
@@ -2202,10 +2200,6 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         }
     }
 
-    if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        /* I/O operations must end the TB here (whether read or write) */
-        s->base.is_jmp = DISAS_UPDATE_EXIT;
-    }
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
          * A write to any coprocessor regiser that ends a TB
@@ -2217,6 +2211,9 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
+        need_exit_tb = true;
+    }
+    if (need_exit_tb) {
         s->base.is_jmp = DISAS_UPDATE_EXIT;
     }
 }
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index 31fb2110f1..2ad3c40975 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -21,7 +21,6 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
-#include "exec/gen-icount.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index af8685a4ac..6fac577abd 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
-#include "exec/gen-icount.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index dd782aacf4..95ac8d9db3 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -24,7 +24,6 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
-#include "exec/gen-icount.h"
 #include "translate.h"
 #include "translate-a32.h"
 
@@ -117,9 +116,8 @@ static void gen_preserve_fp_state(DisasContext *s, bool skip_context_update)
          * so we must mark it as an IO operation for icount (and cause
          * this to be the last insn in the TB).
          */
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+        if (translator_io_start(&s->base)) {
             s->base.is_jmp = DISAS_UPDATE_EXIT;
-            gen_io_start();
         }
         gen_helper_v7m_preserve_fp_state(cpu_env);
         /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 379f266256..7caf6d802d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -34,7 +34,6 @@
 #include "cpregs.h"
 #include "translate.h"
 #include "translate-a32.h"
-#include "exec/gen-icount.h"
 #include "exec/helper-proto.h"
 
 #define HELPER_H "helper.h"
@@ -2908,9 +2907,7 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
      * appropriately depending on the new Thumb bit, so it must
      * be called after storing the new PC.
      */
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&s->base);
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
@@ -4559,7 +4556,7 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
     uint32_t key = ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     TCGv_ptr tcg_ri = NULL;
-    bool need_exit_tb;
+    bool need_exit_tb = false;
     uint32_t syndrome;
 
     /*
@@ -4704,8 +4701,9 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
         g_assert_not_reached();
     }
 
-    if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-        gen_io_start();
+    if (ri->type & ARM_CP_IO) {
+        /* I/O operations must end the TB here (whether read or write) */
+        need_exit_tb = translator_io_start(&s->base);
     }
 
     if (isread) {
@@ -4787,10 +4785,6 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
         }
     }
 
-    /* I/O operations must end the TB here (whether read or write) */
-    need_exit_tb = ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
-                    (ri->type & ARM_CP_IO));
-
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
          * A write to any coprocessor register that ends a TB
@@ -8047,9 +8041,7 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
     if (exc_return) {
         /* Restore CPSR from SPSR.  */
         tmp = load_cpu_field(spsr);
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
+        translator_io_start(&s->base);
         gen_helper_cpsr_write_eret(cpu_env, tmp);
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4fa40b568a..ef2edd7415 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -29,7 +29,6 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "exec/translator.h"
-#include "exec/gen-icount.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 3c21826cc2..1445cd8bb5 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -88,8 +88,6 @@ static TCGv env_btaken;
 static TCGv env_btarget;
 static TCGv env_pc;
 
-#include "exec/gen-icount.h"
-
 /* This is the state at translation time.  */
 typedef struct DisasContext {
     DisasContextBase base;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2c50fa72c3..d33813d173 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -364,8 +364,6 @@ static TCGv_reg cpu_psw_v;
 static TCGv_reg cpu_psw_cb;
 static TCGv_reg cpu_psw_cb_msb;
 
-#include "exec/gen-icount.h"
-
 void hppa_translate_init(void)
 {
 #define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUHPPAState, V) }
@@ -2090,8 +2088,7 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         /* FIXME: Respect PSW_S bit.  */
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
+        if (translator_io_start(&ctx->base)) {
             gen_helper_read_interval_timer(tmp);
             ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         } else {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d509105505..5cf14311a6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -78,8 +78,6 @@ static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 
-#include "exec/gen-icount.h"
-
 typedef struct DisasContext {
     DisasContextBase base;
 
@@ -3933,10 +3931,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
-            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-                s->base.is_jmp = DISAS_TOO_MANY;
-            }
+            translator_io_start(&s->base);
             gen_helper_rdrand(s->T0, cpu_env);
             rm = (modrm & 7) | REX_B(s);
             gen_op_mov_reg_v(s, dflag, rm, s->T0);
@@ -4974,10 +4969,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                           SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_ins(s, ot);
         } else {
@@ -4992,10 +4984,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_STR_MASK)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_outs(s, ot);
         } else {
@@ -5014,10 +5003,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
@@ -5030,10 +5016,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
@@ -5047,10 +5030,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
@@ -5063,10 +5043,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
             break;
         }
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
@@ -5674,10 +5651,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         gen_helper_rdtsc(cpu_env);
         break;
     case 0x133: /* rdpmc */
@@ -6133,10 +6107,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
-            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-                s->base.is_jmp = DISAS_TOO_MANY;
-            }
+            translator_io_start(&s->base);
             gen_helper_rdtscp(cpu_env);
             break;
 
@@ -6490,10 +6461,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         ot  = (CODE64(s) ? MO_64 : MO_32);
 
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            s->base.is_jmp = DISAS_TOO_MANY;
-        }
+        translator_io_start(&s->base);
         if (b & 2) {
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0 + reg);
             gen_op_mov_v_reg(s, ot, s->T0, rm);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 67140ada56..1cf27a4611 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -24,8 +24,6 @@
 TCGv cpu_gpr[32], cpu_pc;
 static TCGv cpu_lladdr, cpu_llval;
 
-#include "exec/gen-icount.h"
-
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 90ca51fb9e..551ef9e52a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -65,8 +65,6 @@ static TCGv NULL_QREG;
 /* Used to distinguish stores from bad addressing modes.  */
 static TCGv store_dummy;
 
-#include "exec/gen-icount.h"
-
 void m68k_tcg_init(void)
 {
     char *p;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7a5d1066da..7e7f837c63 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -58,8 +58,6 @@ static TCGv_i32 cpu_iflags;
 static TCGv cpu_res_addr;
 static TCGv_i32 cpu_res_val;
 
-#include "exec/gen-icount.h"
-
 /* This is the state at translation time.  */
 typedef struct DisasContext {
     DisasContextBase base;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index bff1859b86..312ed66989 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1215,8 +1215,6 @@ static TCGv_i32 hflags;
 TCGv_i32 fpu_fcr0, fpu_fcr31;
 TCGv_i64 fpu_f64[32];
 
-#include "exec/gen-icount.h"
-
 static const char regnames_HI[][4] = {
     "HI0", "HI1", "HI2", "HI3",
 };
@@ -5670,9 +5668,8 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case CP0_REG09__COUNT:
             /* Mark as an IO operation because we read the time.  */
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-            }
+            translator_io_start(&ctx->base);
+
             gen_helper_mfc0_count(arg, cpu_env);
             /*
              * Break the TB to be able to take timer interrupts immediately
@@ -6111,14 +6108,13 @@ cp0_unimplemented:
 static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
+    bool icount;
 
     if (sel != 0) {
         check_insn(ctx, ISA_MIPS_R1);
     }
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    icount = translator_io_start(&ctx->base);
 
     switch (reg) {
     case CP0_REGISTER_00:
@@ -6856,7 +6852,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("mtc0", register_name, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+    if (icount) {
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -7173,9 +7169,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case CP0_REG09__COUNT:
             /* Mark as an IO operation because we read the time.  */
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-            }
+            translator_io_start(&ctx->base);
             gen_helper_mfc0_count(arg, cpu_env);
             /*
              * Break the TB to be able to take timer interrupts immediately
@@ -7601,14 +7595,13 @@ cp0_unimplemented:
 static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *register_name = "invalid";
+    bool icount;
 
     if (sel != 0) {
         check_insn(ctx, ISA_MIPS_R1);
     }
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    icount = translator_io_start(&ctx->base);
 
     switch (reg) {
     case CP0_REGISTER_00:
@@ -8336,7 +8329,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     trace_mips_translate_c0("dmtc0", register_name, reg, sel);
 
     /* For simplicity assume that all writes can cause interrupts.  */
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+    if (icount) {
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -11147,9 +11140,7 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_store_gpr(t0, rt);
         break;
     case 2:
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
+        translator_io_start(&ctx->base);
         gen_helper_rdhwr_cc(t0, cpu_env);
         gen_store_gpr(t0, rt);
         /*
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 28c1d700e1..a365ad8293 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -32,7 +32,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
-#include "exec/gen-icount.h"
 #include "semihosting/semihost.h"
 
 #define HELPER_H "helper.h"
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 06e6eae952..7760329e75 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -31,7 +31,6 @@
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "exec/gen-icount.h"
 
 #include "exec/log.h"
 
@@ -828,8 +827,7 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 
     check_r0_write(dc, a->d);
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
+    if (translator_io_start(&dc->base)) {
         if (dc->delayed_branch) {
             tcg_gen_mov_tl(cpu_pc, jmp_pc);
             tcg_gen_discard_tl(jmp_pc);
@@ -848,9 +846,8 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
 {
     TCGv spr = tcg_temp_new();
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&dc->base);
+
     /*
      * For SR, we will need to exit the TB to recognize the new
      * exception state.  For NPC, in theory this counts as a branch
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 67d7ee0a70..519f66bb05 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -80,8 +80,6 @@ static TCGv cpu_reserve_val2;
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
 
-#include "exec/gen-icount.h"
-
 void ppc_translate_init(void)
 {
     int i;
@@ -300,16 +298,7 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
 
 static void gen_icount_io_start(DisasContext *ctx)
 {
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-        /*
-         * An I/O instruction must be last in the TB.
-         * Chain to the next TB, and let the code from gen_tb_start
-         * decide if we need to return to the main loop.
-         * Doing this first also allows this value to be overridden.
-         */
-        ctx->base.is_jmp = DISAS_TOO_MANY;
-    }
+    translator_io_start(&ctx->base);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ed968162da..933b11c50d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -46,8 +46,6 @@ static TCGv load_val;
 static TCGv pm_mask;
 static TCGv pm_base;
 
-#include "exec/gen-icount.h"
-
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 89dbec26f9..08cabbde61 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -73,8 +73,6 @@ static TCGv_i64 cpu_acc;
 
 #define cpu_sp cpu_regs[0]
 
-#include "exec/gen-icount.h"
-
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
                            int i, int n)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 60b17585a7..7c549cd8d0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -38,7 +38,6 @@
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
-#include "exec/gen-icount.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 
@@ -6354,10 +6353,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
         /* input/output is the special case for icount mode */
         if (unlikely(insn->flags & IF_IO)) {
-            icount = tb_cflags(s->base.tb) & CF_USE_ICOUNT;
-            if (icount) {
-                gen_io_start();
-            }
+            icount = translator_io_start(&s->base);
         }
     }
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9d2c7a3337..efd889d9d3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -75,8 +75,6 @@ static TCGv cpu_fregs[32];
 /* internal register indexes */
 static TCGv cpu_flags, cpu_delayed_pc, cpu_delayed_cond;
 
-#include "exec/gen-icount.h"
-
 void sh4_translate_init(void)
 {
     int i;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ebaf376500..bad2ec90a0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -66,8 +66,6 @@ static TCGv cpu_wim;
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
-#include "exec/gen-icount.h"
-
 typedef struct DisasContext {
     DisasContextBase base;
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
@@ -3217,16 +3215,12 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_constant_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            gen_io_start();
+                        if (translator_io_start(&dc->base)) {
+                            dc->base.is_jmp = DISAS_EXIT;
                         }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            /* I/O operations in icount mode must end the TB */
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
                     }
                     break;
                 case 0x5: /* V9 rdpc */
@@ -3269,16 +3263,12 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_constant_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, stick));
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            gen_io_start();
+                        if (translator_io_start(&dc->base)) {
+                            dc->base.is_jmp = DISAS_EXIT;
                         }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            /* I/O operations in icount mode must end the TB */
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
                     }
                     break;
                 case 0x19: /* System tick compare */
@@ -3399,15 +3389,11 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_constant_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            gen_io_start();
+                        if (translator_io_start(&dc->base)) {
+                            dc->base.is_jmp = DISAS_EXIT;
                         }
                         gen_helper_tick_get_count(cpu_tmp0, cpu_env,
                                                   r_tickptr, r_const);
-                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                            /* I/O operations in icount mode must end the TB */
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
                     }
                     break;
                 case 5: // tba
@@ -4212,10 +4198,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_start();
-                                    }
+                                    translator_io_start(&dc->base);
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     /* End TB to handle timer interrupt */
@@ -4235,10 +4218,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_start();
-                                    }
+                                    translator_io_start(&dc->base);
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     /* End TB to handle timer interrupt */
@@ -4258,10 +4238,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_start();
-                                    }
+                                    translator_io_start(&dc->base);
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     /* End TB to handle timer interrupt */
@@ -4369,10 +4346,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_start();
-                                    }
+                                    translator_io_start(&dc->base);
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     /* End TB to handle timer interrupt */
@@ -4384,14 +4358,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 break;
                             case 6: // pstate
                                 save_state(dc);
-                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                    gen_io_start();
-                                }
-                                gen_helper_wrpstate(cpu_env, cpu_tmp0);
-                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                    /* I/O ops in icount mode must end the TB */
+                                if (translator_io_start(&dc->base)) {
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
+                                gen_helper_wrpstate(cpu_env, cpu_tmp0);
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 7: // tl
@@ -4401,14 +4371,10 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 8: // pil
-                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                    gen_io_start();
-                                }
-                                gen_helper_wrpil(cpu_env, cpu_tmp0);
-                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                    /* I/O ops in icount mode must end the TB */
+                                if (translator_io_start(&dc->base)) {
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
+                                gen_helper_wrpil(cpu_env, cpu_tmp0);
                                 break;
                             case 9: // cwp
                                 gen_helper_wrcwp(cpu_env, cpu_tmp0);
@@ -4499,10 +4465,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, hstick));
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_start();
-                                    }
+                                    translator_io_start(&dc->base);
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_hstick_cmpr);
                                     /* End TB to handle timer interrupt */
@@ -5125,9 +5088,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
-                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                gen_io_start();
-                            }
+                            translator_io_start(&dc->base);
                             gen_helper_done(cpu_env);
                             goto jmp_insn;
                         case 1:
@@ -5135,9 +5096,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
-                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-                                gen_io_start();
-                            }
+                            translator_io_start(&dc->base);
                             gen_helper_retry(cpu_env);
                             goto jmp_insn;
                         default:
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index eee935bbaf..8e4f99478c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -55,8 +55,6 @@ static TCGv cpu_PSW_SV;
 static TCGv cpu_PSW_AV;
 static TCGv cpu_PSW_SAV;
 
-#include "exec/gen-icount.h"
-
 static const char *regnames_a[] = {
       "a0"  , "a1"  , "a2"  , "a3" , "a4"  , "a5" ,
       "a6"  , "a7"  , "a8"  , "a9" , "sp" , "a11" ,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 11bb8c079b..b7386ff0f0 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -94,8 +94,6 @@ static TCGv_i32 cpu_exclusive_val;
 
 static GHashTable *xtensa_regfile_table;
 
-#include "exec/gen-icount.h"
-
 static char *sr_name[256];
 static char *ur_name[256];
 
@@ -577,9 +575,7 @@ static int gen_postprocess(DisasContext *dc, int slot)
 
 #ifndef CONFIG_USER_ONLY
     if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
+        translator_io_start(&dc->base);
         gen_helper_check_interrupts(cpu_env);
     }
 #endif
@@ -2129,9 +2125,7 @@ static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&dc->base);
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
 #endif
@@ -2447,9 +2441,7 @@ static void translate_waiti(DisasContext *dc, const OpcodeArg arg[],
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 pc = tcg_constant_i32(dc->base.pc_next);
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&dc->base);
     gen_helper_waiti(cpu_env, pc, tcg_constant_i32(arg[0].imm));
 #endif
 }
@@ -2514,9 +2506,7 @@ static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
     uint32_t id = par[0] - CCOMPARE;
 
     assert(id < dc->config->nccompare);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&dc->base);
     tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
     gen_helper_update_ccompare(cpu_env, tcg_constant_i32(id));
 #endif
@@ -2526,9 +2516,7 @@ static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
                                  const uint32_t par[])
 {
 #ifndef CONFIG_USER_ONLY
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&dc->base);
     gen_helper_wsr_ccount(cpu_env, arg[0].in);
 #endif
 }
@@ -2715,10 +2703,7 @@ static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
 #ifndef CONFIG_USER_ONLY
     TCGv_i32 tmp = tcg_temp_new_i32();
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
-
+    translator_io_start(&dc->base);
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(tmp, cpu_SR[par[0]]);
     gen_helper_wsr_ccount(cpu_env, arg[0].in);
diff --git a/target/loongarch/insn_trans/trans_extra.c.inc b/target/loongarch/insn_trans/trans_extra.c.inc
index ad713cd61e..06f4de4515 100644
--- a/target/loongarch/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/insn_trans/trans_extra.c.inc
@@ -39,9 +39,7 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
     TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_rdtime_d(dst1, cpu_env);
     if (word) {
         tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 5a04352b01..02bca7ca23 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -185,9 +185,7 @@ static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
     if ((csr->flags & CSRFL_READONLY) && write) {
         return false;
     }
-    if ((csr->flags & CSRFL_IO) &&
-        (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT)) {
-        gen_io_start();
+    if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
         ctx->base.is_jmp = DISAS_EXIT_UPDATE;
     } else if ((csr->flags & CSRFL_EXITTB) && write) {
         ctx->base.is_jmp = DISAS_EXIT_UPDATE;
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 7c2837194c..528baa1652 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -77,9 +77,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
         decode_save_opc(ctx);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
+        translator_io_start(&ctx->base);
         gen_helper_sret(cpu_pc, cpu_env);
         exit_tb(ctx); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -96,9 +94,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx);
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_mret(cpu_pc, cpu_env);
     exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index c70c495fc5..2031e9931e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -813,9 +813,7 @@ static bool do_csrr(DisasContext *ctx, int rd, int rc)
     TCGv dest = dest_gpr(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrr(dest, cpu_env, csr);
     gen_set_gpr(ctx, rd, dest);
     return do_csr_post(ctx);
@@ -825,9 +823,7 @@ static bool do_csrw(DisasContext *ctx, int rc, TCGv src)
 {
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrw(cpu_env, csr, src);
     return do_csr_post(ctx);
 }
@@ -837,9 +833,7 @@ static bool do_csrrw(DisasContext *ctx, int rd, int rc, TCGv src, TCGv mask)
     TCGv dest = dest_gpr(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrrw(dest, cpu_env, csr, src, mask);
     gen_set_gpr(ctx, rd, dest);
     return do_csr_post(ctx);
@@ -851,9 +845,7 @@ static bool do_csrr_i128(DisasContext *ctx, int rd, int rc)
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrr_i128(destl, cpu_env, csr);
     tcg_gen_ld_tl(desth, cpu_env, offsetof(CPURISCVState, retxh));
     gen_set_gpr128(ctx, rd, destl, desth);
@@ -864,9 +856,7 @@ static bool do_csrw_i128(DisasContext *ctx, int rc, TCGv srcl, TCGv srch)
 {
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrw_i128(cpu_env, csr, srcl, srch);
     return do_csr_post(ctx);
 }
@@ -878,9 +868,7 @@ static bool do_csrrw_i128(DisasContext *ctx, int rd, int rc,
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
 
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&ctx->base);
     gen_helper_csrrw_i128(destl, cpu_env, csr, srcl, srch, maskl, maskh);
     tcg_gen_ld_tl(desth, cpu_env, offsetof(CPURISCVState, retxh));
     gen_set_gpr128(ctx, rd, destl, desth);
-- 
2.34.1



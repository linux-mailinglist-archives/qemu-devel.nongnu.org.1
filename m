Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A97B79CB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwvy-00035q-LG; Wed, 04 Oct 2023 04:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwtM-0005tk-KF; Wed, 04 Oct 2023 04:06:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwtA-0003gI-3z; Wed, 04 Oct 2023 04:05:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 877E2275B2;
 Wed,  4 Oct 2023 11:02:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C06AF2CBEB;
 Wed,  4 Oct 2023 11:02:29 +0300 (MSK)
Received: (nullmailer pid 2702862 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 37/45] accel/tcg: Track current value of can_do_io in
 the TB
Date: Wed,  4 Oct 2023 11:01:58 +0300
Message-Id: <20231004080221.2702636-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Simplify translator_io_start by recording the current
known value of can_do_io within DisasContextBase.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0ca41ccf1c555f97873b8e02a47390fd6af4b18f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index b6ab9f3d33..850d82e26f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,11 +16,14 @@
 #include "tcg/tcg-op-common.h"
 #include "internal.h"
 
-static void gen_io_start(void)
+static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
+    if (db->saved_can_do_io != val) {
+        db->saved_can_do_io = val;
+        tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
+                       offsetof(ArchCPU, parent_obj.can_do_io) -
+                       offsetof(ArchCPU, env));
+    }
 }
 
 bool translator_io_start(DisasContextBase *db)
@@ -30,12 +33,8 @@ bool translator_io_start(DisasContextBase *db)
     if (!(cflags & CF_USE_ICOUNT)) {
         return false;
     }
-    if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
-        /* Already started in translator_loop. */
-        return true;
-    }
 
-    gen_io_start();
+    set_can_do_io(db, true);
 
     /*
      * Ensure that this instruction will be the last in the TB.
@@ -47,7 +46,7 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
-static TCGOp *gen_tb_start(uint32_t cflags)
+static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 {
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
@@ -91,12 +90,9 @@ static TCGOp *gen_tb_start(uint32_t cflags)
          * cpu->can_do_io is cleared automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
          * -icount, plus it would be very easy to forget doing it in the
-         * translator. Doing it here means we don't need a gen_io_end() to
-         * go with gen_io_start().
+         * translator.
          */
-        tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
-                       offsetof(ArchCPU, env));
+        set_can_do_io(db, false);
     }
 
     return icount_start_insn;
@@ -147,6 +143,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
+    db->saved_can_do_io = -1;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
@@ -154,7 +151,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     /* Start translating.  */
-    icount_start_insn = gen_tb_start(cflags);
+    icount_start_insn = gen_tb_start(db, cflags);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -181,7 +178,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
            the next instruction.  */
         if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
-            gen_io_start();
+            set_can_do_io(db, true);
         }
         ops->translate_insn(db, cpu);
 
diff --git a/include/exec/translator.h b/include/exec/translator.h
index a53d3243d4..0f4ecad7a2 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,6 +72,7 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
+ * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -83,6 +84,7 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
+    int8_t saved_can_do_io;
     void *host_addr[2];
 } DisasContextBase;
 
-- 
2.39.2



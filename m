Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283D741051
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETdN-0003sC-1S; Wed, 28 Jun 2023 07:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcO-0002gB-5u
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcJ-00058t-6D
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WmsO4TdphjoYdEaQr+/EGzlsRw5mm7MRTDUQrp4kIrg=; b=zO8zufq5dB+Hd6vZ5OULF5twvR
 brqayWv90YC4GrkmkPL1zklS4TVG9qEE3Y7a9cc0NY5b+KRervkqZ5VdVw6MyLMU0FbCVuq2J7opf
 x3kXFGe0VNlaDBfa1/McrKTE8jLQPi88J1h3SO9DpNTt9Je48YZLVsAN4V2IZgEEG7zoS5IEjLzTZ
 FCNCwaKddXXYKwt4EwRXyRM5tmFYPnuntuE3/e/p09KklZLQbgtVpEdHAGNFw5Gu8smPxoY9ArXtq
 2B8gw9HDxFI5iFj9twHU5NIYNQ6E7ywg/u/47qjkJCg65reUkKqpXu0Nqc2M6rXqwont7c9zbV4e/
 dIhc7bS988bEzYxvuoMwio6kwxe2T9NePiRF6N0LM0bOU3vWRPWFRbD9riAXkRlQ16Ke6Mnnhaw8e
 jbuOr9B6KAyQ0hCCSoe0+KFE+eFha+3yclbGuYkcTwuMVt2CbuaQ7ZPeq33qQGJuYjjTexItoVXQV
 SzOR/Df+kY6btAH/dGTcwArmM4rypkaBvAe5zgpmoBytURV7Y1PwkMV3LIopIIEDDW6iZcMhjj0aP
 K0glhyW0iei35RMd6g+MV52arDH9Z6Mh8qYpMCU9s7jLrA/ItAy3Xq8vg5ZOMhd1no8p03hngN4+w
 yCADvz9acF5Ca8qOsVU4Jg3VWF1A9S1DaWvcFLuzo=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbt-00007c-AW; Wed, 28 Jun 2023 12:45:25 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:59 +0100
Message-Id: <20230628114504.546265-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 05/10] target/sparc: Introduce DYNAMIC_PC_LOOKUP
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Create a new artificial "next pc" which also indicates
that nothing has changed within the cpu state which
requires returning to the main loop.

Pipe this new value though all pc/npc checks.
Do not produce this new value yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230628071202.230991-5-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 147 +++++++++++++++++++++++++++------------
 1 file changed, 103 insertions(+), 44 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1312c3e94d..75aa1a138e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,9 +37,12 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#define DYNAMIC_PC  1 /* dynamic pc value */
-#define JUMP_PC     2 /* dynamic pc value which takes only two values
-                         according to jump_pc[T2] */
+/* Dynamic PC, must exit to main loop. */
+#define DYNAMIC_PC         1
+/* Dynamic PC, one of two values according to jump_pc[T2]. */
+#define JUMP_PC            2
+/* Dynamic PC, may lookup next TB. */
+#define DYNAMIC_PC_LOOKUP  3
 
 #define DISAS_EXIT  DISAS_TARGET_0
 
@@ -901,22 +904,25 @@ static void gen_branch_n(DisasContext *dc, target_ulong pc1)
 {
     target_ulong npc = dc->npc;
 
-    if (likely(npc != DYNAMIC_PC)) {
+    if (npc & 3) {
+        switch (npc) {
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
+            tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc,
+                               cpu_cond, tcg_constant_tl(0),
+                               tcg_constant_tl(pc1), cpu_npc);
+            dc->pc = npc;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
         dc->pc = npc;
         dc->jump_pc[0] = pc1;
         dc->jump_pc[1] = npc + 4;
         dc->npc = JUMP_PC;
-    } else {
-        TCGv t, z;
-
-        tcg_gen_mov_tl(cpu_pc, cpu_npc);
-
-        tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-        t = tcg_constant_tl(pc1);
-        z = tcg_constant_tl(0);
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc, cpu_cond, z, t, cpu_npc);
-
-        dc->pc = DYNAMIC_PC;
     }
 }
 
@@ -941,10 +947,19 @@ static void flush_cond(DisasContext *dc)
 
 static void save_npc(DisasContext *dc)
 {
-    if (dc->npc == JUMP_PC) {
-        gen_generic_branch(dc);
-        dc->npc = DYNAMIC_PC;
-    } else if (dc->npc != DYNAMIC_PC) {
+    if (dc->npc & 3) {
+        switch (dc->npc) {
+        case JUMP_PC:
+            gen_generic_branch(dc);
+            dc->npc = DYNAMIC_PC;
+            break;
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
         tcg_gen_movi_tl(cpu_npc, dc->npc);
     }
 }
@@ -977,13 +992,21 @@ static void gen_check_align(TCGv addr, int mask)
 
 static void gen_mov_pc_npc(DisasContext *dc)
 {
-    if (dc->npc == JUMP_PC) {
-        gen_generic_branch(dc);
-        tcg_gen_mov_tl(cpu_pc, cpu_npc);
-        dc->pc = DYNAMIC_PC;
-    } else if (dc->npc == DYNAMIC_PC) {
-        tcg_gen_mov_tl(cpu_pc, cpu_npc);
-        dc->pc = DYNAMIC_PC;
+    if (dc->npc & 3) {
+        switch (dc->npc) {
+        case JUMP_PC:
+            gen_generic_branch(dc);
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            dc->pc = DYNAMIC_PC;
+            break;
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            tcg_gen_mov_tl(cpu_pc, cpu_npc);
+            dc->pc = dc->npc;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
         dc->pc = dc->npc;
     }
@@ -5501,13 +5524,21 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
         break;
     }
     /* default case for non jump instructions */
-    if (dc->npc == DYNAMIC_PC) {
-        dc->pc = DYNAMIC_PC;
-        gen_op_next_insn();
-    } else if (dc->npc == JUMP_PC) {
-        /* we can do a static jump */
-        gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
-        dc->base.is_jmp = DISAS_NORETURN;
+    if (dc->npc & 3) {
+        switch (dc->npc) {
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            dc->pc = dc->npc;
+            gen_op_next_insn();
+            break;
+        case JUMP_PC:
+            /* we can do a static jump */
+            gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
+            dc->base.is_jmp = DISAS_NORETURN;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
         dc->pc = dc->npc;
         dc->npc = dc->npc + 4;
@@ -5578,13 +5609,23 @@ static void sparc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    target_ulong npc = dc->npc;
 
-    if (dc->npc == JUMP_PC) {
-        assert(dc->jump_pc[1] == dc->pc + 4);
-        tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
-    } else {
-        tcg_gen_insn_start(dc->pc, dc->npc);
+    if (npc & 3) {
+        switch (npc) {
+        case JUMP_PC:
+            assert(dc->jump_pc[1] == dc->pc + 4);
+            npc = dc->jump_pc[0] | JUMP_PC;
+            break;
+        case DYNAMIC_PC:
+        case DYNAMIC_PC_LOOKUP:
+            npc = DYNAMIC_PC;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
+    tcg_gen_insn_start(dc->pc, npc);
 }
 
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
@@ -5608,19 +5649,37 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    bool may_lookup;
 
     switch (dc->base.is_jmp) {
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
-        if (dc->pc != DYNAMIC_PC &&
-            (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
+        if (((dc->pc | dc->npc) & 3) == 0) {
             /* static PC and NPC: we can use direct chaining */
             gen_goto_tb(dc, 0, dc->pc, dc->npc);
-        } else {
-            if (dc->pc != DYNAMIC_PC) {
-                tcg_gen_movi_tl(cpu_pc, dc->pc);
+            break;
+        }
+
+        if (dc->pc & 3) {
+            switch (dc->pc) {
+            case DYNAMIC_PC_LOOKUP:
+                may_lookup = true;
+                break;
+            case DYNAMIC_PC:
+                may_lookup = false;
+                break;
+            default:
+                g_assert_not_reached();
             }
-            save_npc(dc);
+        } else {
+            tcg_gen_movi_tl(cpu_pc, dc->pc);
+            may_lookup = true;
+        }
+
+        save_npc(dc);
+        if (may_lookup) {
+            tcg_gen_lookup_and_goto_ptr();
+        } else {
             tcg_gen_exit_tb(NULL, 0);
         }
         break;
-- 
2.30.2



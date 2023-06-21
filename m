Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43078738E24
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dj-0000GY-K0; Wed, 21 Jun 2023 14:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dh-0000G3-Cc
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Df-00071o-IG
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso8335734a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370774; x=1689962774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVRvzQ8FxqPvpZ1jAAFokBmJb9ilv9ZlzYsLqweXES0=;
 b=TS+3b0hshZqVm5z29OEgCuuZAEXoD8L/fENCNejzmb6GcDt6/wZMLYAGfRzM/V9Qwe
 4hwu0AeKf/H3YCqRh1VZYkG6uEI6RDnSGKbHtpck3EqyP0B/ozY8ppubovepIFN1393x
 YJEKv/156CVDgkQ5PoxWlq+2SJMoip/lzdZkDIexd/jCTY2Mg5q1nM55iKWM63C6UAYI
 LghHuPRN+XAi8l21+WbUjw/dKZlY85FC9V8WVPwzniuIjfBA8wcQcX4MqKAKb941IFJp
 a/weeA2LDNB3Z3EhhttEH0FCg6CeE94PgiaU7nlPX9+iBIb9dTdgW264soJmlhA/uM4G
 3Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370774; x=1689962774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVRvzQ8FxqPvpZ1jAAFokBmJb9ilv9ZlzYsLqweXES0=;
 b=i6B1MYV8pq8WriGwpHlJAd5iJeD7srwOd7A/SAmky/55iFiHUN1dkgmTnITIfwIaP8
 uafTRludTkqv8OcMsWrGSyXxwznb6GHPbzpVEuF3KBacnbsWxk7IVKZkIQ9sHhvUwIWe
 pDHFpS+oPhUb00k1MRCgU6NhxGZhqed9X0fQCqZiMEirUq6p37uY2TeAs5iW9lSUEBQq
 b7mXQTXw69y0R80qg+gMubpFHN66W3T6XTxqg//0yXK7R4P23FGCeAkgQ4fNK0kJqJha
 QDVMWG6m4INHwjiNFjdXMteK5r0IAunqJ9rhftk0JRwmFNryTUbmyZT9smkHDQ3wrBLY
 lUdQ==
X-Gm-Message-State: AC+VfDzt0T606edrBxREWd/mnzbvPnNEdwUQ/fU/yBYYeScgT/4vEuWN
 TgEOwKXITXY3zf1a5WwIeNGZ0bTtS+x3xkOSEy6KpqIF
X-Google-Smtp-Source: ACHHUZ68uTncJ7PrjGu1FpPfXr+QMxlFSk+NrDMei8M2ekS8v6/SQwxFQfsplyLxCrbhpFTeOFLZYg==
X-Received: by 2002:aa7:d404:0:b0:51b:dcb7:9b45 with SMTP id
 z4-20020aa7d404000000b0051bdcb79b45mr1842519edq.10.1687370774106; 
 Wed, 21 Jun 2023 11:06:14 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 4/8] target/sparc: Introduce DYNAMIC_PC_LOOKUP
Date: Wed, 21 Jun 2023 20:06:03 +0200
Message-Id: <20230621180607.1516336-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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

Create a new artificial "next pc" which also indicates
that nothing has changed within the cpu state which
requires returning to the main loop.

Pipe this new value though all pc/npc checks.
Do not produce this new value yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 155 ++++++++++++++++++++++++++++-----------
 1 file changed, 111 insertions(+), 44 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1312c3e94d..d12f2ac423 100644
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
@@ -5608,20 +5649,46 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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
+        switch (dc->npc) {
+        case DYNAMIC_PC_LOOKUP:
+            if (may_lookup) {
+                tcg_gen_lookup_and_goto_ptr();
+                break;
+            }
+            /* fall through */
+        case DYNAMIC_PC:
             tcg_gen_exit_tb(NULL, 0);
+            break;
+        default:
+            g_assert_not_reached();
         }
         break;
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3AF74099E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLu-0003Pk-Fu; Wed, 28 Jun 2023 03:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLX-00034j-Mg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:12 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLV-0005J3-EH
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:11 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f865f0e16cso7655548e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936328; x=1690528328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slq0RmbTf282ywfgNZrhCdz2QdRjAp+22Nb7dnlea+w=;
 b=SHR3nVu2VAhAxcGl2bI8O1zdcd+idGOtdnGhT69D9JpcCukaS0WVKp4kJ4PPzR5lFB
 ZVygvuAGGkHCf/Qjbk1ipZKK5cUPzCK5o4ur3K8nCBsLnWn8zNNFNeeNGEZQKFprtJrp
 gulHt34hgSP+JNSI8OFreUsYhnbgLMoxgg4scPYOM1I6rZr0pC30OrM/yXBBh28Ljc6m
 sGh+NXot+bllgEwV19PXgVxuWf6omWNAlG0mKa0PfN/On3fTH/Q+XCLq8BkN0pGbCtC5
 d/bGX7TU+fRRMap5bJ41t64ggLP8qulSxkESOH//04xqRZOe1ysLGa7r+ZMgKdolIHvV
 CAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936328; x=1690528328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slq0RmbTf282ywfgNZrhCdz2QdRjAp+22Nb7dnlea+w=;
 b=gGoS+SiMVwf4tkeWB8PPqQYZ2QJin7QOsiKTueeBI4S/Rgjd7MwKm8pNJUc4ao6KFe
 Dx45ENapduy7G0SKho8id2KGuUOCtZdEPw6YYxZnoPfnxaqKXKWfZw2EMke476qe8YJJ
 Y3Y7WMnRH3GFftGcnfFgfFEVcfXYp6KptbCJDjt8urk5x+h+gYhdIcGlFQKMVfplczVj
 o+OYD6h+Ts7TEM0X5YAvA4B6lxXwenT2EfMnwE/OOhkfxMi5GtsKkrU4fMk0gvLMq1LS
 MdWU3yMEeTkcGR1psFmXlyHqJfmPnpKmXgbeEc9ro1ASxMPj+hRtkIjq0fPJ8rhgk5BC
 0Lpw==
X-Gm-Message-State: AC+VfDwGnhsw4+flhXLEft/MJWb9cX8EYWYBj3afRddgp78PyMO7GDVF
 /1lWnOXMCdAvk9EfVOVQh5rbJnK+HmbNVoGkKuMkmAYf
X-Google-Smtp-Source: ACHHUZ7KTNhqHdykAVydLfimKpH20K6STfhs9vxs5A+aYZDk8P1jHyYv/QwrKx5n4VFGX0OLBgBXCQ==
X-Received: by 2002:a19:c206:0:b0:4fa:3a0:2257 with SMTP id
 l6-20020a19c206000000b004fa03a02257mr6154271lfc.5.1687936327870; 
 Wed, 28 Jun 2023 00:12:07 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 4/8] target/sparc: Introduce DYNAMIC_PC_LOOKUP
Date: Wed, 28 Jun 2023 09:11:58 +0200
Message-Id: <20230628071202.230991-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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
2.34.1



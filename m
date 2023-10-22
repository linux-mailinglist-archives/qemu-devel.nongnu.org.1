Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E255A7D2159
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWT-0000fV-Aj; Sun, 22 Oct 2023 02:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWA-0000Zs-RR
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW5-0001Yg-2A
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d425a2dd0so1924618a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954447; x=1698559247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bRQOnevKS41xkhrVOREUbtHjCWnHr38sXTFU/ZrPKc=;
 b=j8k/Gltnrx18Xh52I+JBx9eKFY+lRW7bs47IhTRNYbbs2NHkXRt1ESydxxMwhmZnOr
 Ldc0l2o2Kxfaz9F8RC6gWmN0Vm1eGDsFgfvsIdWFWQ4gSN7SNORva9hcdiHV8iwOvhf5
 5WYc0H2kgz/JJqKnazl9TZgvGPhhUpYM83SVih7eaGbNF/wffjvdb5YiVXlbJB9rzl3F
 u419aKx4XlpduMdJNTzWyLHJcIVhBomXrT8It6jR5+5CFvbuOhTpVn4OQVKuCJfwRsry
 Sojfa+pZ8kw9JvK36PuGrBaGikACGUteJsVt4rFOhPi5ICFdeeDBSXyLUjtCY3Zo4uoC
 5yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954447; x=1698559247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bRQOnevKS41xkhrVOREUbtHjCWnHr38sXTFU/ZrPKc=;
 b=mC4L71ZDgzsykNwgKhBaJUrD0KsVitGwAstiU01JHF+tJohkau206Kvo2Uoyt59YIp
 LAq+rHDom+XRtVM3wvcWDL/I+P8qo1zOTCGlx9k7oF7dgkY4BHjK4Nq3tVWal0hScO+3
 ie3MvWWwfn646aR0GOWC0Cpa1BYPX9UP9peQgbB+0PuYejKxFr2aTBYph/pgXUGsYaAp
 WgOw9ctg9kByiOuoQvHefFH+U3589CnXEx/nCIcn2saaJ7dDdZEoM1P6cq6imDeyX8gj
 YzD3hfGw8icKGfhvVRTnaGjBek1bV53Z2lIUNncuAikO7VEGERXopVJxsv038EvxZZAi
 avEQ==
X-Gm-Message-State: AOJu0YzYaotnK2WdHB2dPcOYPpryXsR+gsrHqUyWS+Z5/84ZcY41Hw2t
 3gbdc4lSbRDIa6m2m52u4ArcpjbZEafaD5TGRDc=
X-Google-Smtp-Source: AGHT+IEPWgvF5WgXlrEPkRCAm3puVhEdL1f351g2FkNT1yvql949vAq5060mBcZ4jaN/ncu3hFSryA==
X-Received: by 2002:a17:902:e5c3:b0:1c9:aac5:df1a with SMTP id
 u3-20020a170902e5c300b001c9aac5df1amr7403875plf.51.1697954447137; 
 Sat, 21 Oct 2023 23:00:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 17/90] target/sparc: Merge gen_branch_[an] with only caller
Date: Sat, 21 Oct 2023 22:59:18 -0700
Message-Id: <20231022060031.490251-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 73 +++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b8d51d6d64..503598ed93 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -900,47 +900,6 @@ static void gen_branch2(DisasContext *dc, target_ulong pc1,
     gen_goto_tb(dc, 1, pc2, pc2 + 4);
 }
 
-static void gen_branch_a(DisasContext *dc, target_ulong pc1)
-{
-    TCGLabel *l1 = gen_new_label();
-    target_ulong npc = dc->npc;
-
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_cond, 0, l1);
-
-    gen_goto_tb(dc, 0, npc, pc1);
-
-    gen_set_label(l1);
-    gen_goto_tb(dc, 1, npc + 4, npc + 8);
-
-    dc->base.is_jmp = DISAS_NORETURN;
-}
-
-static void gen_branch_n(DisasContext *dc, target_ulong pc1)
-{
-    target_ulong npc = dc->npc;
-
-    if (npc & 3) {
-        switch (npc) {
-        case DYNAMIC_PC:
-        case DYNAMIC_PC_LOOKUP:
-            tcg_gen_mov_tl(cpu_pc, cpu_npc);
-            tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-            tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc,
-                               cpu_cond, tcg_constant_tl(0),
-                               tcg_constant_tl(pc1), cpu_npc);
-            dc->pc = npc;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        dc->pc = npc;
-        dc->jump_pc[0] = pc1;
-        dc->jump_pc[1] = npc + 4;
-        dc->npc = JUMP_PC;
-    }
-}
-
 static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
@@ -2942,10 +2901,38 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
 
 static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
 {
+    target_ulong npc = dc->npc;
+
     if (annul) {
-        gen_branch_a(dc, dest);
+        TCGLabel *l1 = gen_new_label();
+
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_cond, 0, l1);
+        gen_goto_tb(dc, 0, npc, dest);
+        gen_set_label(l1);
+        gen_goto_tb(dc, 1, npc + 4, npc + 8);
+
+        dc->base.is_jmp = DISAS_NORETURN;
     } else {
-        gen_branch_n(dc, dest);
+        if (npc & 3) {
+            switch (npc) {
+            case DYNAMIC_PC:
+            case DYNAMIC_PC_LOOKUP:
+                tcg_gen_mov_tl(cpu_pc, cpu_npc);
+                tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
+                tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc,
+                                   cpu_cond, tcg_constant_tl(0),
+                                   tcg_constant_tl(dest), cpu_npc);
+                dc->pc = npc;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            dc->pc = npc;
+            dc->jump_pc[0] = dest;
+            dc->jump_pc[1] = npc + 4;
+            dc->npc = JUMP_PC;
+        }
     }
     return true;
 }
-- 
2.34.1



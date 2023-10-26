Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E87D7954
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2y-0007Ju-7F; Wed, 25 Oct 2023 20:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2t-0007AK-Br
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2n-0004ud-Ta
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso2323335ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279372; x=1698884172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3CDbvxaTN0BxklWFCzrNGwroWfsphJJp/UH4zaunfY=;
 b=kOuaRh5CdRK+Wb/ZitPX74/84t2TJLnFvrKxoOpJp5/yvYruf9y5u3Q9dnAJXs2Fy7
 BFla3bPw4i7TcYG7SlxZ29YA4+WIk+Aa+I7qA0aeWJ6xE8V4PBR+YMij1TkIQyCKPk7A
 Zn+I/F/7FY2ul/YjFq0mOH+6qq4c4jFTBU2Ht77wAANz6LnoDiEdF2NVBMjwYUrTiYh+
 hmX1yciN5nL/gdPH1u8TDlDElmCYte691/i8JU7/xSLRZ99FFg2JXje4GBvqMYq7b6cK
 M1xZxiEH4nCFx3Ct+nLeOCm6VT8N3aZH8DmoDlcTUAntI/lof2ut2Sfg8fzXwNIbjH//
 BTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279372; x=1698884172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3CDbvxaTN0BxklWFCzrNGwroWfsphJJp/UH4zaunfY=;
 b=VxGoyECYOJ9jyqYg6DOkrpOOF2suZIgkYocmMQebfDusQTWYYGI7xA5odqcs2pKYWT
 LmCmkVHO8L0p9Czt0W8SPnlZyPJ6B05r+nUcZN8Fby39Yf277m5kH8G3iAIdOGhHMuLs
 PFISUi60evPEfocacTUK4YTrVUKyH7mIoc9kCJkWLAsaCVfZBeMUjcngpDuo9Kdda4Gt
 FKz/qI/7X9lpybjqUKHo0MyHVkjCFw6t4Kus0GwVjFviiZDYcc/lyE3nHM52vbzY95k7
 Hb4Hiz4wKw8/J1vMpF0pC/a6UDOfiUHCy7P2KeEbx+BltPvsV8YYgyu4tXnxN6KrrKsT
 Z9kg==
X-Gm-Message-State: AOJu0YwR6Hlu+uRPXCZcH3MgXbR6QEcyig3cGx1yj0rUawsf6ZjYOau1
 Et6y74Nf6gGfyJ8Jmshh3ulqbzQr1mMd/HOdRSk=
X-Google-Smtp-Source: AGHT+IG9dB/lI5Q3n/RHKuyYnx+X4l0oEd9F83M3nMkajvDW3LvnNQI/MUvdWsu1PLWaPOX9+Bq7cA==
X-Received: by 2002:a17:903:23c2:b0:1ca:6abe:cb37 with SMTP id
 o2-20020a17090323c200b001ca6abecb37mr13698410plh.9.1698279372726; 
 Wed, 25 Oct 2023 17:16:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 18/94] target/sparc: Merge gen_branch_[an] with only caller
Date: Wed, 25 Oct 2023 17:14:14 -0700
Message-Id: <20231026001542.1141412-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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



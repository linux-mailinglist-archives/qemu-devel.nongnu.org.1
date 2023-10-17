Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6267CBACB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKH-0000SN-Qg; Tue, 17 Oct 2023 02:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKE-0000Lu-Uy
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK9-0003sh-Ja
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso35619305ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523180; x=1698127980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hORCZe2HkkMW2bK+KJWMNA6VHjazi7PbrlTmz+O48ZA=;
 b=P/nzQ5XA9RHvbHfrx0qjKgHS0wdq0/6Tp8/L1xTAMFktcdAJR9VXe/9OUk6hUHElJh
 db4DCXQ7bO7ir35SUyhLqd0U6ad1ybYcllzJqdloVIONPBrWjyK4HoCLYVwcVi4q9sN5
 fRlFMnJEkGXMf759whPbwt2hD90uDBNT+F55voyt89eCogJr+JuSiWu2LA4n7pMaoK4A
 ypBgNVQg9TtIzC4c7wjzqKdW4M15g/BZ6HEDx8ounTRnltOe5VLowai3kQJjs2fahnTy
 kc/nUDZY2zJwlZihEVjquyF7kOE4NDnaLfS/trijo//LEnn21qXblAK1dKTyCmJkL3AN
 ypUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523180; x=1698127980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hORCZe2HkkMW2bK+KJWMNA6VHjazi7PbrlTmz+O48ZA=;
 b=rCzjt3cSpfk34U3IIrcn19kZbpLadHs021/wPye91yjvlbbICexqxJNwnjbtMHBl64
 kuBep6qevk9S6F9QgNPRjfrP61ooQ9KeaN4cLVpMBXpIaBO4HbKsAac9MIp5t3isKlFe
 9VFsciFkvdWEnCacgWoXJs/zm7FTbUQ63jAqwHgr08SUm7sfUOkXrK5TVxZx6iM9qmUx
 SdWD21DjUDtkV9XT4Y8zOUxDTyrJXzqBOs7Vo3rWF2NHshpRAh/4FqyznUkvnoC0aYdp
 YU/V7mKffBFAY+1GwX+GWgRwuAckPxOqhM4vX2CyVZmaXlDokK2/xLxPjPG43CZfuWMy
 Ga4Q==
X-Gm-Message-State: AOJu0YzzjY46iuIFWp9m3isSVL04+0Vy/pMbWVBONSmtGK3kT0oI2f8l
 NlIfQP5NDtFQeipDmQsE3z87X8OySo2m5XzsWJo=
X-Google-Smtp-Source: AGHT+IEFy6W5nlD6LjBstNJeJyI2CG2IfV79Z3NNRi3esOtBsJZb/gHddi6HDDpTSe+KNipxm5M50w==
X-Received: by 2002:a17:903:22c2:b0:1c5:9d00:be84 with SMTP id
 y2-20020a17090322c200b001c59d00be84mr1415536plg.33.1697523180359; 
 Mon, 16 Oct 2023 23:13:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 17/90] target/sparc: Merge gen_branch_[an] with only caller
Date: Mon, 16 Oct 2023 23:11:31 -0700
Message-Id: <20231017061244.681584-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index cc19f0606e..9188196657 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -895,47 +895,6 @@ static void gen_branch2(DisasContext *dc, target_ulong pc1,
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
@@ -2937,10 +2896,38 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
 
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



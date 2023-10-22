Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161F7D2703
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtc-0007JF-LG; Sun, 22 Oct 2023 19:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtN-00079J-I0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:58 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtJ-0006lf-Mq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:57 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3576e74ae9dso9711325ab.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017390; x=1698622190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Die0E9thWWJCvlQ5xUUN0v+CHdwVm8XQRwC6LlIs3H8=;
 b=R3xmxNncaTQGpA5d7W0iQwN5hRilkmUEFL5Dupe7nHnYbsCV26FB1kwPFRT5oR6PUA
 w/l7kfpVIe5s8J3yEpK/QvrV7nnMTEmN6daMF3N7Kg5ff8jb9Qmtp65ljRQ1VagQeGYl
 ZPDP953qe2Umwm+Kn7TlClUNKzFvDDGYAZUii5CQeqVDh5ASUGbm/fe93GvawWAy/uOU
 H7FV4Y28drrvFH+f84Pqjyi1OegyKg2OsJxCqZJiZ3vy8KiwYj0EvJrFapYUThrGeWsF
 Q0son35vXKDin0cjeHsYbN9RHQBBuZt1/ASk55Vnu4f10GSHjF4gpg5KkQu5+K5qlfbv
 8gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017390; x=1698622190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Die0E9thWWJCvlQ5xUUN0v+CHdwVm8XQRwC6LlIs3H8=;
 b=OCKe/ZblXZEMQDVXygc24mekjOOTSoLS3yhs4e9h+DXnyhqTYUxgpmq2QCx5gccJDP
 nnTsrVF6WOliKuimy2UOH+TWlIbHzbVA0aFqOsappyXYaT6IjbEXU4z4203UaLPIuSQ/
 Ay/AeODZVW6NyacS5159qXygwqqivw9bPNIbkYsU+4JcWzk+2GmE3G2Fzg4LHiH0QaGR
 mhlzYX5YaAG2KklIcWZxKwudyDz5U//ggncVOXnu5KkoIsJkeUQB3rC5f1ecS4H23kEH
 qEirnFiBj+0GcwYHRFqV45eKh1OwDR3laFQ6L0IHjdLDu8TzybPywDYYhCUdfkPDsNk4
 f+nw==
X-Gm-Message-State: AOJu0YyE5ZFpB4MXw0OrkwuIva+hZE42yXmoB5RdFpNpSwJmaK3ZNPCi
 e+ht8JocApyEVWvUk9L1QSUKNe0CgNPhewr+YBA=
X-Google-Smtp-Source: AGHT+IFMrbIxuiN/H4XbGbAyaArjnpg2AV3/BNr0n4HGCOBkIjq4AFG1jX/oxJBP7aGdUzRi/uNwWA==
X-Received: by 2002:a05:6e02:1d84:b0:34f:c9b4:5f9e with SMTP id
 h4-20020a056e021d8400b0034fc9b45f9emr11054346ila.19.1698017390513; 
 Sun, 22 Oct 2023 16:29:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 19/94] target/sparc: Pass DisasCompare to advance_jump_cond
Date: Sun, 22 Oct 2023 16:28:17 -0700
Message-Id: <20231022232932.80507-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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

Fold the condition into the branch or movcond when possible.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 503598ed93..d12f2b4b87 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2899,14 +2899,15 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
     return true;
 }
 
-static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
+static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
+                              bool annul, target_ulong dest)
 {
     target_ulong npc = dc->npc;
 
     if (annul) {
         TCGLabel *l1 = gen_new_label();
 
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_cond, 0, l1);
+        tcg_gen_brcond_tl(tcg_invert_cond(cmp->cond), cmp->c1, cmp->c2, l1);
         gen_goto_tb(dc, 0, npc, dest);
         gen_set_label(l1);
         gen_goto_tb(dc, 1, npc + 4, npc + 8);
@@ -2919,8 +2920,8 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
             case DYNAMIC_PC_LOOKUP:
                 tcg_gen_mov_tl(cpu_pc, cpu_npc);
                 tcg_gen_addi_tl(cpu_npc, cpu_npc, 4);
-                tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc,
-                                   cpu_cond, tcg_constant_tl(0),
+                tcg_gen_movcond_tl(cmp->cond, cpu_npc,
+                                   cmp->c1, cmp->c2,
                                    tcg_constant_tl(dest), cpu_npc);
                 dc->pc = npc;
                 break;
@@ -2932,6 +2933,11 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
             dc->npc = JUMP_PC;
+            if (cmp->is_bool) {
+                tcg_gen_mov_tl(cpu_cond, cmp->c1);
+            } else {
+                tcg_gen_setcond_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
+            }
         }
     }
     return true;
@@ -2951,12 +2957,7 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
         flush_cond(dc);
 
         gen_compare(&cmp, a->cc, a->cond, dc);
-        if (cmp.is_bool) {
-            tcg_gen_mov_tl(cpu_cond, cmp.c1);
-        } else {
-            tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
-        }
-        return advance_jump_cond(dc, a->a, target);
+        return advance_jump_cond(dc, &cmp, a->a, target);
     }
 }
 
@@ -2980,12 +2981,7 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
         flush_cond(dc);
 
         gen_fcompare(&cmp, a->cc, a->cond);
-        if (cmp.is_bool) {
-            tcg_gen_mov_tl(cpu_cond, cmp.c1);
-        } else {
-            tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
-        }
-        return advance_jump_cond(dc, a->a, target);
+        return advance_jump_cond(dc, &cmp, a->a, target);
     }
 }
 
@@ -3006,8 +3002,7 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
 
     flush_cond(dc);
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
-    tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
-    return advance_jump_cond(dc, a->a, target);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
-- 
2.34.1



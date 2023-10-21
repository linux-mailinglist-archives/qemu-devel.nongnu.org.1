Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0187D1AEC
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bF-0007Da-4m; Sat, 21 Oct 2023 01:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4av-0007BZ-Iv
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:17 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4at-0008Ph-UL
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:17 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6cd33d51852so1006650a34.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866335; x=1698471135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe3uuotNEE/3RgpcgrZRfr0F8BaHUoNj59/qICwQLyk=;
 b=vbE4E1UdZKUO1BrBxRO8g94jIhTa8FizzPxg04GHF1CFBVM0L1dLajn/HY5ZxpEIPW
 LQAmB/1eJYdg81SD4F+BCo8cwXZ2A0OG3xWKeFOBVL1DgTZSDBZgNUiOBfDPJhJN4yi7
 d46TRhLy6oGqjNbUIusCo8/8pI9XrUdXhH0kXpugdDe6CmVBaLFuL6kQb26IR4RQwHRN
 UxrH05v0LrLW6US8qPdro7py+joWBFjjKhIXHoyqdpEQY69UVDxEy4po0/W7DHnSyAGg
 g1ktLnaKSs3Nh5qrFMj6cpJOGVq/noZdTtXJwnHga8yJfsGuUhHzDOCGqcQZvMCiSp+3
 ek/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866335; x=1698471135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pe3uuotNEE/3RgpcgrZRfr0F8BaHUoNj59/qICwQLyk=;
 b=EBi6QH3YeU1Ex/P3/J/OrTFqyhvBp34yTruROR/8qdafuWWnU9+WPqYcMeEV1r7e/z
 +25hnGut4PKVlsWBer7HucQNczmEm5W2f4DKzjKWWfsxh0S1jz2dhXTkkO8w2vgNTGD7
 UZu7oI8ds9HtwkcFfKJ+x+qU5gX3qwrVD3qKKgjJDZ14lDeBJb02rQRVEmz7BGNku9Ow
 kMJc6Hly2pf6rXtxJSfvBZ+1NC1HBjDMD/C8IGRFaWUyb1BWjBxYar8Dy+1f6miFYMZS
 S9eR/Jfy4M4dTdbjD4N9H+JlkVOVJNfXWMZ99fBSh75z6TxiZCMpNf3rmq0E8UCVg2HD
 ZN4Q==
X-Gm-Message-State: AOJu0YxSlbCJN3yElVV237SMKO5z4hKi/Ub1n8xC/chS+3Q7iY84LVv2
 bB8QDQo2je2tBGOFtNZ14a7N1SIN5CuReL7ocXk=
X-Google-Smtp-Source: AGHT+IHOLBb8v/svftUXiZSp/AlqDsDrKX84SMPtJPbiZ18kG6naAnYn4qczptJn4q9dTSkCVlh+yg==
X-Received: by 2002:a05:6830:10c2:b0:6cd:a989:c7ea with SMTP id
 z2-20020a05683010c200b006cda989c7eamr4308359oto.16.1697866334849; 
 Fri, 20 Oct 2023 22:32:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 18/90] target/sparc: Pass DisasCompare to advance_jump_cond
Date: Fri, 20 Oct 2023 22:30:46 -0700
Message-Id: <20231021053158.278135-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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



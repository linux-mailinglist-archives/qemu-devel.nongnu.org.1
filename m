Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562A7CBAB4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKF-0000K7-3A; Tue, 17 Oct 2023 02:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKC-0000Dl-45
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKA-0003sy-FB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c871a095ceso35915605ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523181; x=1698127981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvY88bgh70CnfBtV0mfKDRwJvl7SdeYowQVqeWU69q0=;
 b=eOvzWpv5CrrEqV5HSV0M2c0LW8xaK/rc7KbHbICwcq7DShuCh+im1VNYBbP7cJ55So
 iCUvAqvegeT8h0XtnjqRt5meDytbiQvJLiIVDovmAUOQRX4avD5go7f/3WaHKbKW6xNT
 JLl1Z0iMI34+uCwvmlg6cS6rnEX8a3sHJYknBUam0AaZYEbm2eOiE9gSgIvMbJV6gHyR
 fLHHYawJxnQKMv+zySzjia9NZsyjgNDsryKNx7fAennFIK1JxCV+oVgbOj/RS4Zcls79
 WB3sSOfdDOqDIazkRtyYD9Yp4lcKFEnISg7UMtKfZhIYg3pKeza4cDCrlbF8rq1sH7Jo
 LNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523181; x=1698127981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvY88bgh70CnfBtV0mfKDRwJvl7SdeYowQVqeWU69q0=;
 b=WiZ7T6CFA772dTlS7UjUenWxNVugYut619cfc4e7vMz5p1a1jrs7ZvQZFwX7ZSRXnr
 pUFYaF+ta5gHVuRFgbD/gy+OZUo0UYayDiIXWlE9vd8lpYzLiU+JYn8iPmKv8+/BtL3C
 uN9Uy1ydEyUD/2vMutlMCZeE9HXqjkxr+khqTDShNl4rnXDUV0LwI9wY8lpw0Uw/cthJ
 R8J1v1uh3OInU9hxLg34xo+0HIOum/G4seajrEUKRXOhVtADYUOg5R3vHfC4/3xcqd/p
 UoHrsKBnLOPJfwtCnDiTRRQD4vwMn7nMwEQcXPzVoXupU+V9OonrVigtIHKRLZ5Bplfi
 zcXA==
X-Gm-Message-State: AOJu0YxdglB+O0jBVgkZGts2OSa6FLK/R+C15d1gri0r2i84kb3XQlnY
 aikCrbWVzjk8QVXDLBMyXKYI9Xe3CuIN0xAX8No=
X-Google-Smtp-Source: AGHT+IFVY0QnEf2FRFPfjWFzVromIXaA8OFJSznv/Ru1b+1EyJSJpYSB98AuAsGccSTCep1jOgSHeA==
X-Received: by 2002:a17:902:aa41:b0:1c9:d948:33ea with SMTP id
 c1-20020a170902aa4100b001c9d94833eamr1211984plr.21.1697523181327; 
 Mon, 16 Oct 2023 23:13:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/90] target/sparc: Pass DisasCompare to advance_jump_cond
Date: Mon, 16 Oct 2023 23:11:32 -0700
Message-Id: <20231017061244.681584-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/sparc/translate.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9188196657..70bfbb41e9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2894,14 +2894,15 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
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
@@ -2914,8 +2915,8 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
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
@@ -2927,6 +2928,11 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
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
@@ -2949,12 +2955,7 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
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
 
@@ -2981,12 +2982,7 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
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
 
@@ -3013,9 +3009,7 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
     flush_cond(dc);
 
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
-    tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
-
-    return advance_jump_cond(dc, a->a, target);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
-- 
2.34.1



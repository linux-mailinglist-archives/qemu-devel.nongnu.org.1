Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA987D213C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:03:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW8-0000ZD-Cm; Sun, 22 Oct 2023 02:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW6-0000Xr-MO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:50 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW5-0001Z0-1V
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:50 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2ea7cc821so1666759b6e.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954448; x=1698559248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe3uuotNEE/3RgpcgrZRfr0F8BaHUoNj59/qICwQLyk=;
 b=zm1Q7pHT9rXmSo+W5bf99I1vq7NtEmq8gcKxd9JmyZef2yH4obToeTQ1tuJk44461r
 KGMc5RhgNV4bTOZPEHg+XhOvCRDlnqlkfcHUq5/FT/2O2lEH+TJ7z9hpBt3eOyH54/Rf
 PtD9uKPX3ZLQGtClMRU9E0AzGH1T4UASNTkT3LEx7naRtPvMSId6Iyf5BFr+4HQ+Y9Hy
 ELLcAxX4Xn4Q2W7twwUvwSx+Riymxx9JC/AAO5C5Ow3vZGwvTyQ6C1FC6quUD0sTzzou
 A49JZubfRAaAezmJT3dz7JzDIziWDfFPa49Ym8z7/bgpjYhaQC36vYb0QYDE7EltST2C
 K1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954448; x=1698559248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pe3uuotNEE/3RgpcgrZRfr0F8BaHUoNj59/qICwQLyk=;
 b=bR35FEov3/fpOtZ8Fs5ex+/sDwi07Nm6qVXvmYeawKhaCTKRhKFbGx+VLZd/vSkz/R
 nmV/yFzmz+Q6trqjF6fy91D2G0ew0Uo4FgxxkUmmM2TUoDp5lcNyps4njygDMcvKe0Hr
 feyiGUiIWaAo4mCoUhnG4a15VBjOCVuhsMiTGbJdc25fB6Qya0dXTCIVm+6HnLlOKbuZ
 0iOr8fgKqVU1Y4OVGGH3mCYBaRDy2L4syXXXKu0jYeWP+qT1CGCFC8As5SOyFfi129nx
 sGKkwien8F91GvTHabx/KIn2MN7dtJKDIXFYGAqWOmk3SzabfWeTTkUb7rP/ZbFVe+3k
 c1Kw==
X-Gm-Message-State: AOJu0Yxg2vO6eDHSYjoIVhtIVdE5NVf4lsKeC6yiJ4jcOOV0JU2CRWlN
 OMM+1+MS7FBnzmwxm1wBsbmFEIsomFfgOgJpzlQ=
X-Google-Smtp-Source: AGHT+IHQ5Nyp6iOthx8Hgn17puNS1lX47iBTNbOlwviDoJYc0Spd9PyFrq7SaY6y8KywrEKzZoMKIQ==
X-Received: by 2002:a05:6808:1990:b0:3a9:7634:23f9 with SMTP id
 bj16-20020a056808199000b003a9763423f9mr7066025oib.12.1697954447994; 
 Sat, 21 Oct 2023 23:00:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 18/90] target/sparc: Pass DisasCompare to advance_jump_cond
Date: Sat, 21 Oct 2023 22:59:19 -0700
Message-Id: <20231022060031.490251-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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



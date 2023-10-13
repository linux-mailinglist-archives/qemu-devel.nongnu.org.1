Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1517C8F08
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiS-0006EU-5t; Fri, 13 Oct 2023 17:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiQ-0006Dr-Rb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:02 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiP-0000Sf-6E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:02 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c4fa1c804bso1610789a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232540; x=1697837340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7ow8y9a3x8If+UMZNffyHa6NE//ScpWsabSmxt6Y/g=;
 b=YEYaL3NLPbm8unCbVDH2h0r+iZqrylsz4FM2r/6+RBJv86UwkVxVonqHg2gdf8DUIH
 MQIiSsO9xhB8zEm2ONxHuhHnCKBYpOSAjqBs0fBsrwHJmdPItRPP6RLY5G+gLo60JhXY
 yLRynN+Yk75GatxNGSLX0OspAS7IZOU0PaPszrJpIsCOW6vwKJHy/qpcA1fdFFuT9kqT
 v8kJo5rZZ+WeZks64jkcISQ8BhkpU98NWRhp4eXngQRbIXxjrmgb2Ud5EykX4bdwJFr0
 LINI9HDGwcvX9oN2Ls6o5x+cSR/wvdRfnPufAZUTNyjh15H9OzzFFJxHkuBpiLUxMXzn
 LyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232540; x=1697837340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7ow8y9a3x8If+UMZNffyHa6NE//ScpWsabSmxt6Y/g=;
 b=QvClvBLCEsnLuYIDqdTRZd+6zac9lJMKGn5xz7o02gtGoA5Yr5vxr5Pzy+zzA497TO
 wiV54HuPFlZGnsUXAn1GyeUVko2Hcvya8tKIVeRtpLMTmSGl0DvDCmD7TAFvi5Q0Zf/r
 ZGv7WnaRmVPV2wxp1jSVhCdZDFqy68QwnVvx0EB3SKRZp+djSDfPolYTdeFnnF5s/a1Y
 PL3nDbhLytyaAivrYNEL2KcQuVZiWviHcAkGyHRDpgJVtJd2HJyOu+7G4cws668E9OgL
 C2Fz702XtdCMyeezxsHWRH00gm+GUTx9MJo/nSUYwHAjb9Y7/41jTO+yXML0wPdSqEVZ
 5fuw==
X-Gm-Message-State: AOJu0YyuBBZ2lk+BJkXmD3vLnoYuNQReka2V5deSH9U8jsNPQgt6DBuS
 gAoq/TW/j7vzGLhqKm8CMiQYVuVa6B/bPMO2NtY=
X-Google-Smtp-Source: AGHT+IEXmkHsirZdxePPOfWkega37ejgBs09FtnjR3ogRSYwt8hJskyjRp3Y5KUksZh8X8H2B3fB1w==
X-Received: by 2002:a05:6870:1196:b0:1e9:ac92:9ab6 with SMTP id
 22-20020a056870119600b001e9ac929ab6mr7582122oau.46.1697232540088; 
 Fri, 13 Oct 2023 14:29:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 13/85] target/sparc: Pass DisasCompare to advance_jump_cond
Date: Fri, 13 Oct 2023 14:27:34 -0700
Message-Id: <20231013212846.165724-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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
index ee8c0450aa..5cea835b28 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2855,14 +2855,15 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
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
@@ -2875,8 +2876,8 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
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
@@ -2888,6 +2889,11 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
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
@@ -2910,12 +2916,7 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
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
 
@@ -2942,12 +2943,7 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
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
 
@@ -2974,9 +2970,7 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
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



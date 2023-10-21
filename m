Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A497D1AF5
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bH-0007Hr-52; Sat, 21 Oct 2023 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4av-0007BQ-2K
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:17 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4at-0008PH-GH
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:16 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1e9c9d181d6so1103903fac.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866334; x=1698471134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bRQOnevKS41xkhrVOREUbtHjCWnHr38sXTFU/ZrPKc=;
 b=k6ByhLGIJjfbJV9LVDTIeMPrOyFVYGUchUGylXo8xSRjs2T5zfIxkOq2CBVqZtmc/U
 ScB0SdEcU67zIUUrON/k0BXmCg+CpCbBPNpnJpBDZ+4oOJ5gJFbPjRASuewI7E2MsnGN
 v9oGAx58ebna1Cha8PPM2yieBekKGkzLzlldDQyYgYMfqUQQ/vgvLMjVqmxKsCmBrOAD
 QjYC8yUIfXZ0V4g3/cZVIt/7U+aqmelMqPVFCDVXHiKC86m5lpNIdkUHc0/sKt5782w2
 TMUCuFiw1ChnfVlh4eCcEjBDH1a1MDwZYFnyyVtpe9CRAoy+MRj6Zg5Jm5AbXcnCQObo
 Cckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866334; x=1698471134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bRQOnevKS41xkhrVOREUbtHjCWnHr38sXTFU/ZrPKc=;
 b=tN7sznl8lG3hoDBRjcI0UCLj8dp79E7OJJDgIQHQpaX30gCiG8rUskhLqKGgKc9arG
 HfmLaLzc/rjBsKD4fMyVwg9HZlRRPax/5wKGQLf7+rwGV8V8qZavDcGiXS0hlxAgXHP5
 7xLRVLb1Wb71vGcTTI7OXHtQG4AqT3Mw2+UUQC09KSzGApaQ+ROmeZRBqzh5RkniEIXS
 pD4Ok0MvU5XnDJcxiRPTLyaD6DoSZ8ItUIikXZWv/yTNSlijSI+MD5sIb5aHRnWW6IZb
 PueqcnWbuzY1njIPPxTAAgC81/+06gtmC5khxYK0U9FLJjvFL6hgTzx+ndmLTdH30Srh
 GjZg==
X-Gm-Message-State: AOJu0Yw1LAMuaBCFbXtqR5DFqs5ann7kfVmAdfyQrFwf9begDHSlnWfq
 C/9tT11Cj1zeI1RxY007UMA38eFMFm8kIgfpUjM=
X-Google-Smtp-Source: AGHT+IF+QUOQl2Jw8OMev7pyhD25DqQk0mTjom2Y4haeVCiaeTrPC2gvfo+bDszj8uwdQ2w2/DpuUA==
X-Received: by 2002:a05:6870:1254:b0:1e9:dd69:2fc1 with SMTP id
 20-20020a056870125400b001e9dd692fc1mr3952699oao.7.1697866334116; 
 Fri, 20 Oct 2023 22:32:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 17/90] target/sparc: Merge gen_branch_[an] with only caller
Date: Fri, 20 Oct 2023 22:30:45 -0700
Message-Id: <20231021053158.278135-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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



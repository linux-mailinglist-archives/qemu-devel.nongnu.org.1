Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA97DDBDA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:15:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aC-0005yX-7c; Wed, 01 Nov 2023 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a5-0005x3-0L
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a3-0007ZP-9I
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso5341217b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811906; x=1699416706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Civ3ElsSsGr4Gx2CB8NWWBuM1eA0J16s9JH6E6QtGVY=;
 b=VL8IhTdipTYdv9SXgzO/7qUsjXTQNDFON/JuUJEMJ8RaVW7q5I6DoQsS3C3PqNnxL6
 48pozFKlhtznRqg5a3K4S1sAFr8oCT2hxQ0vk0h2ZocW5NNyTNWG65Z0RN4lOLy+Pfqb
 m/ulj6/p5c+IZHh8awAJfa3Gm9XDAh0HqEsbVxHjOVO/TXmwMUdqTSiEirnYiMLnMT5q
 diB8As7o7tNtd++YlNs+5M0LbdRR2ThFlTISqDL5kSErMVnRmKg6WHgJfDovj94HqvIf
 BJWFBNbEzYCoS57Zfz43ybh+EF3GFg6q25MqcO3RVm/LhOxH9AT/shqam+vpo6izhjUX
 naag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811906; x=1699416706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Civ3ElsSsGr4Gx2CB8NWWBuM1eA0J16s9JH6E6QtGVY=;
 b=SKy1bSEFqhAPttbEMjmrn644Bufx7XxXnFfM/i3YWlPTZvxBBCDI0LjI/veEbK4a/P
 HMMdUgXVhwxQXc17MXH2nGDWdvCwBGx1CUfjt+heFejp4NHOGVVLWoMocVprmGp8HwM3
 Ny5wT8EfDntnAPZ/L/9W0FvkxRuSQ3t6oM0HSK0FNAcGCAquNheSPu+L3A8rSt8Mr5n9
 Alm36pIy9C1TYICrtPFWOyoVBRpOx/Q14VC/wqu3fM3qaljT0CcMOQMgyD0UeLiBubDi
 HXq9H4EPbv/AVxTEwn4ITxls9/zambHMCx47pK05ah5XYC5BiHwJQVfw5BWx2qesq5Uc
 7VNg==
X-Gm-Message-State: AOJu0YzBLxRxPMX4TtUYAJAhOfZP47TfTbVrVRE8Gvb44Eq34FwARVAR
 veMcIgtAJm3O5t8vW2sWvZHU14zHvt0OPLb7xDI=
X-Google-Smtp-Source: AGHT+IG7l1D/aUWrwstGaQrnvPXQOo8tBy5r8YQG2B26KvoUiZLsokSlmf9FEuSULCSA7lZpSCTZ0Q==
X-Received: by 2002:a05:6a00:2d16:b0:68e:351b:15b8 with SMTP id
 fa22-20020a056a002d1600b0068e351b15b8mr12672903pfb.12.1698811905966; 
 Tue, 31 Oct 2023 21:11:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/21] target/sparc: Merge advance_jump_uncond_{never,
 always} into advance_jump_cond
Date: Tue, 31 Oct 2023 21:11:25 -0700
Message-Id: <20231101041132.174501-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Handle these via TCG_COND_{ALWAYS,NEVER}.
Allow dc->npc to be variable, using gen_mov_pc_npc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 74 ++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e134ba8821..cbee5435a3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2378,37 +2378,37 @@ static bool advance_pc(DisasContext *dc)
  * Major opcodes 00 and 01 -- branches, call, and sethi
  */
 
-static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
-{
-    if (annul) {
-        dc->pc = dc->npc + 4;
-        dc->npc = dc->pc + 4;
-    } else {
-        dc->pc = dc->npc;
-        dc->npc = dc->pc + 4;
-    }
-    return true;
-}
-
-static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
-                                       target_ulong dest)
-{
-    if (annul) {
-        dc->pc = dest;
-        dc->npc = dest + 4;
-    } else {
-        dc->pc = dc->npc;
-        dc->npc = dest;
-        tcg_gen_mov_tl(cpu_pc, cpu_npc);
-    }
-    return true;
-}
-
 static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                               bool annul, target_ulong dest)
 {
     target_ulong npc;
 
+    if (cmp->cond == TCG_COND_ALWAYS) {
+        if (annul) {
+            dc->pc = dest;
+            dc->npc = dest + 4;
+        } else {
+            gen_mov_pc_npc(dc);
+            dc->npc = dest;
+        }
+        return true;
+    }
+
+    if (cmp->cond == TCG_COND_NEVER) {
+        npc = dc->npc;
+        if (npc & 3) {
+            gen_mov_pc_npc(dc);
+            if (annul) {
+                tcg_gen_addi_tl(cpu_pc, cpu_pc, 4);
+            }
+            tcg_gen_addi_tl(cpu_npc, cpu_pc, 4);
+        } else {
+            dc->pc = npc + (annul ? 4 : 0);
+            dc->npc = dc->pc + 4;
+        }
+        return true;
+    }
+
     flush_cond(dc);
     npc = dc->npc;
 
@@ -2478,15 +2478,8 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
     DisasCompare cmp;
 
-    switch (a->cond) {
-    case 0x0:
-        return advance_jump_uncond_never(dc, a->a);
-    case 0x8:
-        return advance_jump_uncond_always(dc, a->a, target);
-    default:
-        gen_compare(&cmp, a->cc, a->cond, dc);
-        return advance_jump_cond(dc, &cmp, a->a, target);
-    }
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 TRANS(Bicc, ALL, do_bpcc, a)
@@ -2500,15 +2493,8 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    switch (a->cond) {
-    case 0x0:
-        return advance_jump_uncond_never(dc, a->a);
-    case 0x8:
-        return advance_jump_uncond_always(dc, a->a, target);
-    default:
-        gen_fcompare(&cmp, a->cc, a->cond);
-        return advance_jump_cond(dc, &cmp, a->a, target);
-    }
+    gen_fcompare(&cmp, a->cc, a->cond);
+    return advance_jump_cond(dc, &cmp, a->a, target);
 }
 
 TRANS(FBPfcc,  64, do_fbpfcc, a)
-- 
2.34.1



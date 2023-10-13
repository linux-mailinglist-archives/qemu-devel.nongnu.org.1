Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F17C8F1C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiT-0006F5-F9; Fri, 13 Oct 2023 17:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiQ-0006Di-Eq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiO-0000SW-O2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so682809b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232539; x=1697837339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlQ9pFIgVRbOyfQkOIdiUxbXB54/56KnrpWFPW7bYUw=;
 b=CkuEPnTuQEs/f73p+v7ztHjNNbKjY3KsG2RKc7efSH1jTJjjs27B4/ESWKPoHh4aFq
 CXHgeNW4+ofFed8ze/Zs1yCDBwoYDLkcyjLumtL4c7NslcW3TrIBQo0NhEEG1sLO4ySE
 D96asXtmijSi2/HZDw6UsmLCtBUarNyyvulMnyUVAQOKbmxCQ8DHHfZANZkLo8vrcxcw
 zr/Y1891A6jXbejPRcsgC/V3+eMeZB5lsl+yRBqrizDPF5DjJFPPIJxYLoj0pO6Izcmv
 lW3+bCQ8E3m7R6Ed0Xi/gznXGs1PVqh2DTSysmuFYkp2lzzmnIp2XB5DbS3rlXTG6cjp
 HRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232539; x=1697837339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlQ9pFIgVRbOyfQkOIdiUxbXB54/56KnrpWFPW7bYUw=;
 b=THzopcChCqIUYD4VCJkkKySpKLdDiYmonXE8VfJie1xxVUXvfs6bhpjHfrJEFt8Rwy
 VJlv4UnG7CBqFgflFUWT1fMUM04EikSikZBBUYW2Wp5pq3t01RjUWACIowRroQEP2dBo
 CkXlMrR2NT9PrqWBGnRvGs3F2cmr+sX8te1wFFgpE/iL3Tx5Y2WnvProBP+rUYsMzd4l
 tD9kNJWmGL85Jak0cH5NWGx7fIUQBULLAQYqJlkkzuuBf/KkNfXwU6W9mUxV3JTcE4L+
 RUhnt9Y33qW+YZOB0cgHg5QrEZFqtmmOw2+omA09t34vsVxopf8aphtElPhU23TpqOrY
 qglg==
X-Gm-Message-State: AOJu0YyZKs8iMkcCVEntHs6/JiVrV5DPhUdGlLIov4OzHC4zQT5X21j7
 QNZnykwIQUFfc0DwoG4wCLEVvX8SBjrhgD0dVTM=
X-Google-Smtp-Source: AGHT+IHQyznpRvpaHSvmtme/lti2CWDCBbstaS1F4fFTkgNpihMaUYVCjpbxnTbS6IOPRlyEHv90cQ==
X-Received: by 2002:a05:6a20:4417:b0:174:32c:dc03 with SMTP id
 ce23-20020a056a20441700b00174032cdc03mr1567604pzb.3.1697232539275; 
 Fri, 13 Oct 2023 14:28:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 12/85] target/sparc: Merge gen_branch_[an] with only caller
Date: Fri, 13 Oct 2023 14:27:33 -0700
Message-Id: <20231013212846.165724-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index ecb485c305..ee8c0450aa 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -885,47 +885,6 @@ static void gen_branch2(DisasContext *dc, target_ulong pc1,
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
@@ -2898,10 +2857,38 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
 
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



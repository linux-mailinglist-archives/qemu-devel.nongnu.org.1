Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635F7DDBDB
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:15:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aD-0005yf-4Z; Wed, 01 Nov 2023 00:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a7-0005xi-Kk
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a5-0007Zx-SH
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso5341240b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811908; x=1699416708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xk5ZwxYX86AmAacGdCPjwS66WTpS6fUcE9+XR+Lw5Gc=;
 b=RyqS5Aap0tZvqCRHYiboVGLq0NUkk/MUhTaLvpPQ+Bdeblssz1tiy6ruAmlxaPdRLP
 T9Zt0TMs1WryQG1Yyxkpmtnz2LFFtRyOl909HEgphvbbMRqquwstxhh1nQJndLsucqcq
 i2hf1oORmawWsW8GEODItHXy6kSGeu27eBdSr91kQNftLWsWkwbUV5EyntC3ANG7v3fo
 VANR5vHnbO0JBUtexiANZCxT5TTvmHPODmFvZl1M9AYqUvg+Kb2zV/plHJRyIwfacz9/
 F+AH7twnK/l6elrbURE5DM2AgEwYnPHCzD/Io9H4x8uY/YCN3wwqlytQ9oczI4Bocb7Y
 3+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811908; x=1699416708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xk5ZwxYX86AmAacGdCPjwS66WTpS6fUcE9+XR+Lw5Gc=;
 b=p7NhgSeU39OVu01T4J+kURRBpg0cUxfHMUNRru2o+j1uMuV9KHuIlHp8YvKSO4rvB9
 BVqhuJ+FOtrVu4OvWy3S31AcsC54lHxwhGDuBS11Al+ItYNZVP4FTbJFC/vsCS4yugkl
 7mi9oRAb0p7O8oP0nj0es+pFW++hCWXc5eLvls60k73VqFc5XXK8XS37zW7+/eBN1ZSa
 hy+LgvMDbbf+3pkz0SGF4shqIDycURD1HMm9QHic+IwJH7smL+/n0glgrCaQ4nuvHiwS
 KARQ2dyyzfPMmwU0R+hf0grE/e7HU5UZiJ/a5V0kpiBvll4yXh6Psde6LgGkHEnruePs
 alRw==
X-Gm-Message-State: AOJu0Yz4k5nFkyvjAvVGfZ63+A/x6enL9f61auggq2lDtcRV4URNYUwZ
 7Mtuc4qRVQ65xvO+IZJ9nUnfGv3Ko9oGIwH1cUM=
X-Google-Smtp-Source: AGHT+IHnvhYBMVjpRFN7G8NiYFhLsGXQJhlLcelEPTizYHPEuA6na3N1NcRHVF5Km2SeVS04mJILEA==
X-Received: by 2002:a05:6a00:22c5:b0:6b2:5d32:58c with SMTP id
 f5-20020a056a0022c500b006b25d32058cmr12919126pfj.22.1698811908418; 
 Tue, 31 Oct 2023 21:11:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 17/21] target/sparc: Record entire jump condition in
 DisasContext
Date: Tue, 31 Oct 2023 21:11:28 -0700
Message-Id: <20231101041132.174501-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Use the original condition instead of consuming cpu_cond,
which will now only be live along exception paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0bbe4cff3b..5c9a3d45fa 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -146,6 +146,12 @@ static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 # define env64_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 #endif
 
+typedef struct DisasCompare {
+    TCGCond cond;
+    TCGv c1;
+    int c2;
+} DisasCompare;
+
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
@@ -159,7 +165,11 @@ typedef struct DisasContext {
     DisasContextBase base;
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
     target_ulong npc;   /* next PC: integer or DYNAMIC_PC or JUMP_PC */
-    target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
+
+    /* Used when JUMP_PC value is used. */
+    DisasCompare jump;
+    target_ulong jump_pc[2];
+
     int mem_idx;
     bool fpu_enabled;
     bool address_mask_32bit;
@@ -178,12 +188,6 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 } DisasContext;
 
-typedef struct {
-    TCGCond cond;
-    TCGv c1;
-    int c2;
-} DisasCompare;
-
 // This function uses non-native bit order
 #define GET_FIELD(X, FROM, TO)                                  \
     ((X) >> (31 - (TO)) & ((1 << ((TO) - (FROM) + 1)) - 1))
@@ -912,9 +916,9 @@ static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
     TCGv npc1 = tcg_constant_tl(dc->jump_pc[1]);
-    TCGv zero = tcg_constant_tl(0);
+    TCGv c2 = tcg_constant_tl(dc->jump.c2);
 
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc, cpu_cond, zero, npc0, npc1);
+    tcg_gen_movcond_tl(dc->jump.cond, cpu_npc, dc->jump.c1, c2, npc0, npc1);
 }
 
 /* call this function before using the condition register as it may
@@ -2347,7 +2351,7 @@ static bool advance_pc(DisasContext *dc)
         case JUMP_PC:
             /* we can do a static jump */
             l1 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_cond, 0, l1);
+            tcg_gen_brcondi_tl(dc->jump.cond, dc->jump.c1, dc->jump.c2, l1);
 
             /* jump not taken */
             gen_goto_tb(dc, 1, dc->jump_pc[1], dc->jump_pc[1] + 4);
@@ -2434,9 +2438,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             }
         } else {
             dc->pc = npc;
+            dc->npc = JUMP_PC;
+            dc->jump = *cmp;
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
-            dc->npc = JUMP_PC;
 
             /* The condition for cpu_cond is always NE -- normalize. */
             if (cmp->cond == TCG_COND_NE) {
-- 
2.34.1



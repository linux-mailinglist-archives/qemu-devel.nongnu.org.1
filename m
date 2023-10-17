Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61567CBB79
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlz-0007wV-NC; Tue, 17 Oct 2023 02:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlf-0007tp-WF
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0001sz-QI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so10588115ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524883; x=1698129683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ye55zVt3/R/BevwAdDu8QM2ZndN+yEEyw8ybj2p0Xcc=;
 b=S7SNwd5Hy0gssronVMl2Xk8Nihw24RAy4sh1GvUCK6uOvEZvhCEq1CE4SuTAFXWLPu
 klITMz6220YBGKglrwUSDMEPafGWAT1pO8qruaeQ2VYE1/G5nb8oXKdJMhimfrfrbY4q
 vREbp6U0Xux4hHodgwAogFnFdrmmqzZVMuTsS53W5QYZ/cUoBi3fhTpRFpxmL4CEa+9w
 +s9bAUd5fMRjzsTYQhJjTn9NYI2hO0AVUoVXm7RPJO2iInKk6IFLQD1Yh7G20hYtGzQ+
 rgTqBwnl7w6l1klYqt7bMK1Q34HMDDqtpmnK7AKR/ibpqOAN0K93j1C3zRKnPUyXn9nG
 BuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524883; x=1698129683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ye55zVt3/R/BevwAdDu8QM2ZndN+yEEyw8ybj2p0Xcc=;
 b=SdBlqxaXChosGEyCAE5CgHjl2RC9yeVuGNNIxvPYiwr4r2m8dv5yZHxfyvThh3mAjl
 b4r/uJIGedsatOQBt1QoZUpk7oz/iNH8qcL3GlsSu2Q5jo0be1g4Icdfh4NSXUqj9zbZ
 puPe1C81bMnf48pYqoQMReBvryZC++d0ukpuDd52VmnDwD67fofSZZSdQkKTPpwWXNEl
 N1jN8kjk4glioJOgDif+ri13/vPGjvWMbRm2L/lHMxyXBLLA+kxa9XwkzKe+B5dBPDh/
 B8mT7ZRFIQl0Hy2BKe4P/m1JoovhLIyxxHS12nc9kGolPwC1kfnlqTVquobNleWyUlYZ
 SXtQ==
X-Gm-Message-State: AOJu0YyigR244X2E1bHaOEJoWSlb9FoUt0tEEbzAHWmsdohxN1FQY6+l
 IrgDQvduX7G0/SUaB5v4lyR+45Qme7FCV+r4WSs=
X-Google-Smtp-Source: AGHT+IGwveSF2AW4EARaFJ4IbNSD4Ynwllupm+cyuAMSWEP1A2G+oZcUqrPAF3KkWRUKo1BnOUxUmg==
X-Received: by 2002:a17:902:d2ca:b0:1c7:8446:d65c with SMTP id
 n10-20020a170902d2ca00b001c78446d65cmr1633123plc.43.1697524883533; 
 Mon, 16 Oct 2023 23:41:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/20] target/sparc: Record entire jump condition in
 DisasContext
Date: Mon, 16 Oct 2023 23:41:06 -0700
Message-Id: <20231017064109.681935-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Use the original condition instead of consuming cpu_cond,
which will now only be live along exception paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8a92fa4a1a..bdf1753a65 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -149,6 +149,12 @@ static TCGv cpu_wim;
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
+typedef struct DisasCompare {
+    TCGCond cond;
+    TCGv c1;
+    int c2;
+} DisasCompare;
+
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
@@ -162,7 +168,11 @@ typedef struct DisasContext {
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
@@ -181,12 +191,6 @@ typedef struct DisasContext {
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
@@ -850,9 +854,9 @@ static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
     TCGv npc1 = tcg_constant_tl(dc->jump_pc[1]);
-    TCGv zero = tcg_constant_tl(0);
+    TCGv c2 = tcg_constant_tl(dc->jump.c2);
 
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc, cpu_cond, zero, npc0, npc1);
+    tcg_gen_movcond_tl(dc->jump.cond, cpu_npc, dc->jump.c1, c2, npc0, npc1);
 }
 
 /* call this function before using the condition register as it may
@@ -2255,7 +2259,7 @@ static bool advance_pc(DisasContext *dc)
         case JUMP_PC:
             /* we can do a static jump */
             l1 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_cond, 0, l1);
+            tcg_gen_brcondi_tl(dc->jump.cond, dc->jump.c1, dc->jump.c2, l1);
 
             /* jump not taken */
             gen_goto_tb(dc, 1, dc->jump_pc[1], dc->jump_pc[1] + 4);
@@ -2339,9 +2343,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
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



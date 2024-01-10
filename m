Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9EF82A43E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLZ-0000JP-34; Wed, 10 Jan 2024 17:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLR-0008L8-2H
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:45 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLO-0003bY-8o
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:44 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4299400fd94so20948261cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926800; x=1705531600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V+CWkXdNqNJeKthv/lyY08kBwUymIwSbvahoKExcsA=;
 b=sgQcaqVDhrxnO4ZeTdfSaIJMdKeX46Fd6pjNoYtaS4wEuUtAzg8VLlzyUkBpIgLslL
 LQwx7pmB6u4Lee5DNroQx7jSsxIu8MjhEMxyr7RZyLEJGzBMOV9RcDMtNgi7zQfM8nea
 jIf0LMsMOOAmTWyN0d6CG0b3r8qEOumg4s8VpEKK58+MNmjQINOHaBiqQrvl8ay52EcT
 NQ4nVV8aZ6wULoOLN90iDUoXzvC1GmKUzVJdH8xQnnHr9POjn9LiT8Q3xAvXeAy3f1gF
 t3MbHEUoreOceIZubKqEwFLPgD4yRBj/JPT7xg7vak8TnOsJN/txBrawFx4uoLKSAdhc
 mzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926800; x=1705531600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3V+CWkXdNqNJeKthv/lyY08kBwUymIwSbvahoKExcsA=;
 b=RGtXSXtR9D2EEKn7dMRrMI9uRGCOcx6jtL20uaO0JmpLcynFuX13CW9M6bcsSzdoIa
 ZXRv3EeOTgdE6pdTHCn3Quu3pEvGsPqfefHWO/c+IJzBuC2p1gbrBmNYBnPO1C91MySp
 SMjb8T7fKY/kRjwAcDSfEINzT/ms1d4T3rH4+++jOSUKT+3gr94nkMq+FEZJ7TiNyOB1
 F7pVnLEoMB3+h4yykmRJUATbKNaBKEguMXxAbT6WihG19uBo9sxPrqppccBhcAwljj8/
 zkHSGR6WJxRYRrR/O+G78o/ZwcheeeTW+EZkLgKSK48OzZQfmL+C7FiQd4/BSV5oypGu
 Ni1g==
X-Gm-Message-State: AOJu0Yxmk004Sjib7gPqAMXEwCeyGAFaRjtJjrn1Aj6j0+U0FfRqHlzO
 +aO2UoV0bgVHlM7/ybHp+mgz5qH6xpNIejucXsn10QNki1sKUXFb
X-Google-Smtp-Source: AGHT+IG0fIUOVCiiihf4C5V64lNv4+G3gjUkv4eCGiuPu1fr942xbmfATaMIOulXSGuI9X9NL0P/vA==
X-Received: by 2002:a05:622a:110:b0:429:c15c:7d91 with SMTP id
 u16-20020a05622a011000b00429c15c7d91mr27654qtw.137.1704926800705; 
 Wed, 10 Jan 2024 14:46:40 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 31/38] tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
Date: Thu, 11 Jan 2024 09:44:01 +1100
Message-Id: <20240110224408.10444-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

Using cr0 means we could choose to use rc=1 to compute the condition.
Adjust the tables and tcg_out_cmp that feeds them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 830d2fe73a..b9323baa86 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -671,30 +671,30 @@ enum {
 };
 
 static const uint32_t tcg_to_bc[] = {
-    [TCG_COND_EQ]  = BC | BI(7, CR_EQ) | BO_COND_TRUE,
-    [TCG_COND_NE]  = BC | BI(7, CR_EQ) | BO_COND_FALSE,
-    [TCG_COND_LT]  = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GE]  = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LE]  = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GT]  = BC | BI(7, CR_GT) | BO_COND_TRUE,
-    [TCG_COND_LTU] = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GEU] = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LEU] = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GTU] = BC | BI(7, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GT]  = BC | BI(0, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_LTU] = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GEU] = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LEU] = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GTU] = BC | BI(0, CR_GT) | BO_COND_TRUE,
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
 static const uint32_t tcg_to_isel[] = {
-    [TCG_COND_EQ]  = ISEL | BC_(7, CR_EQ),
-    [TCG_COND_NE]  = ISEL | BC_(7, CR_EQ) | 1,
-    [TCG_COND_LT]  = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GE]  = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LE]  = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GT]  = ISEL | BC_(7, CR_GT),
-    [TCG_COND_LTU] = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GEU] = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LEU] = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
+    [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GT]  = ISEL | BC_(0, CR_GT),
+    [TCG_COND_LTU] = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GEU] = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LEU] = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GTU] = ISEL | BC_(0, CR_GT),
 };
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -1827,7 +1827,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isa_3_10) {
         tcg_insn_unit bi, opc;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         /* Re-use tcg_to_bc for BI and BO_COND_{TRUE,FALSE}. */
         bi = tcg_to_bc[cond] & (0x1f << 16);
@@ -1880,7 +1880,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isel) {
         int isel, tab;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         isel = tcg_to_isel[cond];
 
@@ -1966,7 +1966,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *l, TCGType type)
 {
-    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
     tcg_out_bc_lab(s, cond, l);
 }
 
@@ -1980,7 +1980,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
     }
 
-    tcg_out_cmp(s, cond, c1, c2, const_c2, 7, type);
+    tcg_out_cmp(s, cond, c1, c2, const_c2, 0, type);
 
     if (have_isel) {
         int isel = tcg_to_isel[cond];
@@ -2024,7 +2024,7 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     if (const_a2 && a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
         tcg_out32(s, opc | RA(a0) | RS(a1));
     } else {
-        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
+        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 0, type);
         /* Note that the only other valid constant for a2 is 0.  */
         if (have_isel) {
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
@@ -2079,7 +2079,7 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     do_equality:
         tcg_out_cmp(s, cond, al, bl, blconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond, ah, bh, bhconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
     case TCG_COND_LT:
@@ -2097,8 +2097,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 
         tcg_out_cmp(s, cond, ah, bh, bhconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond2, al, bl, blconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
-        tcg_out32(s, CROR | BT(7, CR_EQ) | BA(6, bit1) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
+        tcg_out32(s, CROR | BT(0, CR_EQ) | BA(6, bit1) | BB(0, CR_EQ));
         break;
 
     default:
@@ -2110,8 +2110,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
     tcg_out_cmp2(s, args + 1, const_args + 1);
-    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(7));
-    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
+    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
+    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
 
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
@@ -2442,12 +2442,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
                         0, 6, TCG_TYPE_I32);
 
-            /* Combine comparisons into cr7. */
-            tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+            /* Combine comparisons into cr0. */
+            tcg_out32(s, CRAND | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         } else {
-            /* Full comparison into cr7. */
+            /* Full comparison into cr0. */
             tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 7, addr_type);
+                        0, 0, addr_type);
         }
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
-- 
2.34.1



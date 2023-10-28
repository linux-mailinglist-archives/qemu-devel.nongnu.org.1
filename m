Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158807DA907
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFw-0004qK-Pd; Sat, 28 Oct 2023 15:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFl-0004l9-6w
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:50 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFj-00049m-Ce
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:48 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso2117959fac.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522346; x=1699127146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWynlm/jnWba87671dZ3jT3T3Pz1rJpw/GEtPhdBxeA=;
 b=gMKwFBnS30D9z859HPNrbUM6qEfVK+TnB7zGMZx8Rk94EGZM1UeambTamJCprLJ5T3
 MlQWoqskXopizQ0h9Rv65klHpwvMmSqe9d+CcrIzyviZdemWK6rjsrzcKczmPk3OJEB+
 y1LICGivKtrh4bAsGXxzAtd/nagXRo+77amfvRCIO4FTn5f4auz00IEs/rqUpzuTDQ0V
 KDHFh+JOk/7d1KIJIBjYzvBh1N4/xLjStm6n6akcMGFA2nXKOTbxw9Yov3rH+m0EB+7X
 6CS9dO13k7Fxh8umufg+tfr3oIvTkC+jtgzjv43NJyfARtGju/h/isJTM5/Zjnm65YQk
 IQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522346; x=1699127146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWynlm/jnWba87671dZ3jT3T3Pz1rJpw/GEtPhdBxeA=;
 b=qZEzfY/VOgdL5UDG70w/042QyIybSb1CyF/k+svycF/PbNR/8fCWnwg7F7oYXGJYoC
 zR7uo8v5fOwr/Kz2VHG04QMBRm+0SeVlhGRBds/uuviB4OeW1R8aDGDBfwWSzhKdny/f
 tQ/0S5liBiKa8K6gkwNO5AARcs+YyoMFF0z2RhC8DvAQIVpGlk1942/2MroePU0Z6VjY
 bMkxKaFvbNAeJ3tuqpgRvn1OB+VmH+urTM+4WQPSZ/kknHjVx/l56XfstScb7hI+yO3a
 /oQgghlv9gh5INRElcWz0j3oFPmNZXXtkXKe0zRoMQ6FRIhBQm32QVU9j+W6cFKWFz15
 B9aQ==
X-Gm-Message-State: AOJu0YwsagAE6nLrxOtXp38ALaZzqLMeCMDaRp32O8xVYM9Uu8O+mROU
 mCC3AmL4sMNROvXTCmy2QiP7lhECtUVBQNiz2+g=
X-Google-Smtp-Source: AGHT+IF/MhrPqERbqvkCe2O0yvsbJk+zvTLj0F6ST7SJ1Js8NZW7P28F6LKK6DKj2zgDNh//Q7R+zg==
X-Received: by 2002:a05:6358:2806:b0:168:e48a:8b25 with SMTP id
 k6-20020a056358280600b00168e48a8b25mr6960551rwb.0.1698522345874; 
 Sat, 28 Oct 2023 12:45:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 24/35] tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
Date: Sat, 28 Oct 2023 12:45:11 -0700
Message-Id: <20231028194522.245170-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Using cr0 means we could choose to use rc=1 to compute the condition.
Adjust the tables and tcg_out_cmp that feeds them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index ca281dd33e..1ac11acc7c 100644
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



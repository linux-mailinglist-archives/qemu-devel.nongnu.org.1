Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BD82A436
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLW-0008Sn-NS; Wed, 10 Jan 2024 17:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLL-0007UC-Jh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:39 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLJ-0003Yj-K9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:39 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-427f21ced6aso30334331cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926796; x=1705531596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Njou8078FZIGaih/KmoVshAEm+KpvJ/TDJRnizv9npg=;
 b=laCXAx+1wcStctR2BZGWoWFTvb8aRcK6iSGCh0GIL6BhcG6k1PWpMwBvj8OYp1LVWF
 /S/QatoEU/tCrNtOl/oVm245XqvS64shICZc1ibOeRfztHNW5P3L475J2l/uDU7OBh24
 3x6qBo5pqIBfxThrRXMS8o8XxQ+vzoakNlZhJhFILU6itzqwmVbHjMVeYdTJjB5aMHVt
 wBB6D1+RL/jgEms/tm5SPR1vz2IT6W3ZGIAgFFIu/bBSPWgoSOlw37j7NZNPd697I2Ox
 /Xd01KL0fNIdAQlrJLRsgz66lYLjyJBBOvEaU75qEYH9R2IlKv4XCOmJlnxYwNffzYcE
 OwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926796; x=1705531596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Njou8078FZIGaih/KmoVshAEm+KpvJ/TDJRnizv9npg=;
 b=Fl/PreJ7mFulk1aBpRgkWmhhlTrioXYn7W5lchVQBCdwoewbF+sItXxG/QTDAiM8cv
 ZYU0uma5hPevMrBgeE2geB9vplVEMApGO+y87lqpdOwYb9ii/rYmiWP4HlI3KxBNUCVs
 e0+fKGOYvQfhpUfOkxUwbDX8oma5CsE65W5zFAlNpOX5SkIx74suRwmvbO5wpEnEaJtZ
 8zL16vEzQkgEPlY/UUajH30w5p6xETT/HFzvDBfCqrbPQqVd7PVCHpZYmEbjdD0zYcgN
 7usNrWPjhjJi7jOEBhn05C2ZtaxDEnotXyhsZ37rPnsemq5A1S+sHegMCHo0Ctr2Ehql
 S88Q==
X-Gm-Message-State: AOJu0YwDRNkSInQ9wHrTsRb1joAm7A47AJ1/EO8aYB4QPpetldKXfY8g
 jkmJQbINFh7gS8C7ELfPB7vK24wFy2AtspvSKt/8/xx+fYGFHVKw
X-Google-Smtp-Source: AGHT+IH/vbNkhNkcXSVbcdqyJCV86Lhy2wF083Drgw9gWIkWGLtnJKUQwcoBbMQyXQPWX0Xl1o0rWA==
X-Received: by 2002:a05:622a:3c9:b0:429:7f89:4868 with SMTP id
 k9-20020a05622a03c900b004297f894868mr293924qtx.65.1704926796708; 
 Wed, 10 Jan 2024 14:46:36 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 30/38] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Date: Thu, 11 Jan 2024 09:44:00 +1100
Message-Id: <20240110224408.10444-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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

Rename the current tcg_out_bc function to tcg_out_bc_lab, and
create a new function that takes an integer displacement + link.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 850ace98b2..830d2fe73a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1946,14 +1946,20 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
-static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
+static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
 {
+    tcg_out32(s, tcg_to_bc[cond] | bd);
+}
+
+static void tcg_out_bc_lab(TCGContext *s, TCGCond cond, TCGLabel *l)
+{
+    int bd = 0;
     if (l->has_value) {
-        bc |= reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
+        bd = reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
     }
-    tcg_out32(s, bc);
+    tcg_out_bc(s, cond, bd);
 }
 
 static void tcg_out_brcond(TCGContext *s, TCGCond cond,
@@ -1961,7 +1967,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGLabel *l, TCGType type)
 {
     tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
-    tcg_out_bc(s, tcg_to_bc[cond], l);
+    tcg_out_bc_lab(s, cond, l);
 }
 
 static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
@@ -2003,7 +2009,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
             }
         }
         /* Branch forward over one insn */
-        tcg_out32(s, tcg_to_bc[cond] | 8);
+        tcg_out_bc(s, cond, 8);
         if (v2 == 0) {
             tcg_out_movi(s, type, dest, 0);
         } else {
@@ -2024,11 +2030,11 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
             tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
         } else if (!const_a2 && a0 == a2) {
-            tcg_out32(s, tcg_to_bc[TCG_COND_EQ] | 8);
+            tcg_out_bc(s, TCG_COND_EQ, 8);
             tcg_out32(s, opc | RA(a0) | RS(a1));
         } else {
             tcg_out32(s, opc | RA(a0) | RS(a1));
-            tcg_out32(s, tcg_to_bc[TCG_COND_NE] | 8);
+            tcg_out_bc(s, TCG_COND_NE, 8);
             if (const_a2) {
                 tcg_out_movi(s, type, a0, 0);
             } else {
@@ -2108,11 +2114,11 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
 }
 
-static void tcg_out_brcond2 (TCGContext *s, const TCGArg *args,
-                             const int *const_args)
+static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
+                            const int *const_args)
 {
     tcg_out_cmp2(s, args, const_args);
-    tcg_out_bc(s, BC | BI(7, CR_EQ) | BO_COND_TRUE, arg_label(args[5]));
+    tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
 }
 
 static void tcg_out_mb(TCGContext *s, TCGArg a0)
@@ -2446,7 +2452,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+        tcg_out_bc(s, TCG_COND_NE, LK);
 
         h->base = TCG_REG_TMP1;
     } else {
-- 
2.34.1



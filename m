Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC07D7952
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6I-0001Aj-Bs; Wed, 25 Oct 2023 20:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo66-0000td-MH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5r-0006ac-2g
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-694ed847889so287512b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279559; x=1698884359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ia7E+sZTkzV+toHLImE8uJD4WD71ICthxvcmZF9Bb/k=;
 b=QfwWZkPSbSm0BQP78MdhrgO6FQJZeB89pMhD3UCEsl4KOQd1WlmgeqPix7lqIRSnkV
 DyYX5wkNNdodTtqmAWLp+uq4oMQV0wEtoOq+SxiyVbbaNG+XHz5wMD5uDgEfSh6WUMnn
 erTDGK1Nf6NyIUdDwkq5xtmwvacNqeULsaCLcfcgatFuwoEmsf4NyHZH0jtGMFaZ+9+0
 x7/Wo9tuWhmPrurigK2iVCuWtBVZf9Wp9sZ3H0pxuyKtbkzNRj1DbSbqA7dFE2aw8xKv
 4Kuoz51md/gg5XkLgboHPGWjTm2g8WDtH8YTgnBvVa9sfOll0M04IlDnHZKZyrKZMJwm
 xO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279559; x=1698884359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia7E+sZTkzV+toHLImE8uJD4WD71ICthxvcmZF9Bb/k=;
 b=hSFoLbNvmocfjslPPDkomrXylx/XijnUphdEChPWPcWWOR3UHrqoDMIcr04LT/hbyo
 MhE9c5YsDqwt1H71bq8/gJQ1EfmqKs5rsphiO7we3xtAacO55smTJVpMh4jN4jZ45rBk
 58yaw4x/JpCYyxXiIxotHlPkyVFWd91yGgzg7d6fkPrexrTwyw+l/tZFjxt9WSixv3+Y
 noKN1NETcL9G3EIeZQlcvqY1mbzi7AkpMqyORt0Vn63QEVPGKXk4PCe4Nvb3KwUd0Wxy
 bk6YadADeo6cnPAmUcne0XxUxOD6nFB7RoSKUeniIioAP50qoVlATSDLZvMH0seDhUHt
 V+iA==
X-Gm-Message-State: AOJu0YxAgli0UC4N0RHyblJbeqovHUQKBxXK8t8kixDwPKwYTlQgD0nd
 MswzbpmwzGU2M3fgRDjmIXpLjPYSBEVWA90TwY8=
X-Google-Smtp-Source: AGHT+IGfd8suIyavF2EiSCs/hPEJl1HkeueyHscA62O0DtjZqfGGhjQDcxWTNEOg2GxXX51dLsB/Ng==
X-Received: by 2002:a05:6a21:66c9:b0:14b:7d8b:cbaf with SMTP id
 ze9-20020a056a2166c900b0014b7d8bcbafmr6320475pzb.57.1698279559195; 
 Wed, 25 Oct 2023 17:19:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/29] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Date: Wed, 25 Oct 2023 17:14:21 -0700
Message-Id: <20231026001542.1141412-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Rename the current tcg_out_bc function to tcg_out_bc_lab, and
create a new function that takes an integer displacement + link.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 856c3b18f5..666d480e86 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1945,14 +1945,20 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
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
@@ -1960,7 +1966,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGLabel *l, TCGType type)
 {
     tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
-    tcg_out_bc(s, tcg_to_bc[cond], l);
+    tcg_out_bc_lab(s, cond, l);
 }
 
 static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
@@ -2002,7 +2008,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
             }
         }
         /* Branch forward over one insn */
-        tcg_out32(s, tcg_to_bc[cond] | 8);
+        tcg_out_bc(s, cond, 8);
         if (v2 == 0) {
             tcg_out_movi(s, type, dest, 0);
         } else {
@@ -2023,11 +2029,11 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
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
@@ -2107,11 +2113,11 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
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
@@ -2445,7 +2451,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+        tcg_out_bc(s, TCG_COND_NE, LK);
 
         h->base = TCG_REG_TMP1;
     } else {
-- 
2.34.1



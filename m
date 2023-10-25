Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30B7D629A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIi-0000JY-J9; Wed, 25 Oct 2023 03:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIe-0000IV-Ck
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:32 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIc-0004io-Fi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ab53b230f1so3455091a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218849; x=1698823649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia7E+sZTkzV+toHLImE8uJD4WD71ICthxvcmZF9Bb/k=;
 b=UTzpST6BSFpT4dUIdZUrP5R5EJ4x+9uYYiMIwNXv3zxccYpnjjF/njIzzlnKyvsxJO
 UEC9wH/w27UepmmQtRu+DXmM6JbqmpLxZfxxHbZ0NMHXnGR09mgNqFgoi4A4Gg0sA+5U
 Nzk8hi9gZ+7ImERXnShc36BVL3WBAhqwZyaa5VL5ONEBaEHDZVfazh5pfnW62rQ4tFSO
 pt6e/SkpmuvGpEq+Sz7KY07bQuD6AMS9c2jUyCk44nxZP2gAIDOK4OMcxX33PS2a7sLf
 +49+Xde2wOMcs9S4UVOFAPD666VDYiGqRBeXXXR6P9K3QiVQSb4z7Ii2RglXFQpy8VYI
 2BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218849; x=1698823649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia7E+sZTkzV+toHLImE8uJD4WD71ICthxvcmZF9Bb/k=;
 b=BNTfUbQtsjkB04mKDK7N5D67PkdkGxfKOLHzzpDuq+z8dbTVuclkP4/Q7u/3dq39z5
 0IM84gyO0/F2CQYC7puAZv/jh7tSTzG2T/m6EZUz6cZ2iSqbCHizEIUSJKzPfa/s3vTw
 MzF+NmEWKFu5ZK6fPJ1AUObzjkPIleXhz6FS6m1GwlTs8GmjVNtAq1+ldRQypHcjtU1x
 zZotQctAKIRM0K06DO18CGS4V2mqjQ/7MdJCVIaqcXbD/0xJ2NLzuUcclHnhxSrXX8l5
 7JyvlMNgi1XoFR+ebeyc1g4BQ8uUCTR24ItIEaYqRZ7vs1q4mMYmM8YoOZabqhuqQbIL
 o49g==
X-Gm-Message-State: AOJu0YwNwvaM9yKlS9bB7Jf6Zl9dkg7hZ63O5dk912rGImTLZrops5EH
 LFay0pxqxq4X6lfluZHNnZJstoFmdMrx0rkjZ6w=
X-Google-Smtp-Source: AGHT+IFR4B2489Rj51BeKQw5ESW4rwO1OihWil/4rDog43nO5STNOK0tlavVN3ybHsW8QxqGgj6vUw==
X-Received: by 2002:a05:6a21:8197:b0:174:2c0:a4e2 with SMTP id
 pd23-20020a056a21819700b0017402c0a4e2mr4478722pzb.39.1698218849297; 
 Wed, 25 Oct 2023 00:27:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 21/29] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Date: Wed, 25 Oct 2023 00:26:59 -0700
Message-Id: <20231025072707.833943-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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



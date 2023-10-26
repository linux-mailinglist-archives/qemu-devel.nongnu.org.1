Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB777D7935
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2p-00073n-Ke; Wed, 25 Oct 2023 20:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0006zZ-Ua
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2X-0004q2-ET
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cac925732fso2239485ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279351; x=1698884151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=p7sHZTYH5eS2Q/EBI8/XUAWycHrOI8dHk2GvMoBZ12UKgQcXv8Fi3CGc7zL41An5mG
 LZyfL7pkO669t+cD+s+20GGy5buDcqGBJYmxgS+gZn/j+NBoZIfvFUTkfLBc4dwyh08p
 kNSBT6RMk6ooHlht1WjNA+58G54xhaJigmGt3XHcZuisE2obBPhalk+7jX8EFNybWg9G
 3qycPbmmFxwP756EBx7vwlEpTeWzyMG2QYSnwmWHremDKzuIjBElrsunIgMj06uIr9kj
 bImhk/EoSV/qD+w8yQu2n+DOI/BIl88iqOUkNDPKf9TEgmpW8Veef9066R55S7f37YIL
 sIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279351; x=1698884151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=MCgDT/wsX75q/dHrriKPY3qDnPVi81Ppc2w595CNi97aSYBcz/lgy3nj0SasHujexZ
 +6EKZ1NFzSKxtNiamds6R478kbjGbWt4MPKbTLufYfrcZTdy3CuVDiDXr1hWQE+hkeke
 fUdcFJ0Blt2B/0DhSo7k+ACpRsrfOIPF9OYtn681jpKNFq1C5Ypx0Um0/niB7vG7rrsp
 s5clrp5Ch2Df04XCoMbVcE05h6tErENGgOcfwALaOeWRlogLe7ccOJivYV0R/qGhDFUB
 +ajp0CAyXabIcE7SPRSHcEiVg5oGltzEuBGTmxxm1ogUD+bn4aw/WPWXMNBpsZ+E9+m1
 IFaQ==
X-Gm-Message-State: AOJu0YwLglAQqWcw35d7SBFER+fM1cthyhRf4Z355RKCo/clC1DBsbYL
 bKuRgPmWOURF/W8/f3wxwLxaM3v1dDb/EId+EOA=
X-Google-Smtp-Source: AGHT+IHTofsyucuKU6KnRLzB9OBX9uAgEPTeXQluwYQXUj2tmqyhcomn3UVVYZEsoTX5PDVTvBSZkQ==
X-Received: by 2002:a17:903:3208:b0:1ca:8e43:765d with SMTP id
 s8-20020a170903320800b001ca8e43765dmr12437887plh.64.1698279350813; 
 Wed, 25 Oct 2023 17:15:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/29] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Date: Wed, 25 Oct 2023 17:13:47 -0700
Message-Id: <20231026001542.1141412-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Mirror the new do_constant_folding_cond1 by doing all
argument and condition adjustment within one helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 107 ++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 89cc794d24..76be0fc337 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -589,43 +589,6 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
     return -1;
 }
 
-/*
- * Return -1 if the condition can't be simplified,
- * and the result of the condition (0 or 1) if it can.
- */
-static int do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
-{
-    TCGArg al = p1[0], ah = p1[1];
-    TCGArg bl = p2[0], bh = p2[1];
-
-    if (arg_is_const(bl) && arg_is_const(bh)) {
-        tcg_target_ulong blv = arg_info(bl)->val;
-        tcg_target_ulong bhv = arg_info(bh)->val;
-        uint64_t b = deposit64(blv, 32, 32, bhv);
-
-        if (arg_is_const(al) && arg_is_const(ah)) {
-            tcg_target_ulong alv = arg_info(al)->val;
-            tcg_target_ulong ahv = arg_info(ah)->val;
-            uint64_t a = deposit64(alv, 32, 32, ahv);
-            return do_constant_folding_cond_64(a, b, c);
-        }
-        if (b == 0) {
-            switch (c) {
-            case TCG_COND_LTU:
-                return 0;
-            case TCG_COND_GEU:
-                return 1;
-            default:
-                break;
-            }
-        }
-    }
-    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
-        return do_constant_folding_cond_eq(c);
-    }
-    return -1;
-}
-
 /**
  * swap_commutative:
  * @dest: TCGArg of the destination argument, or NO_DEST.
@@ -672,6 +635,10 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+/*
+ * Return -1 if the condition can't be simplified,
+ * and the result of the condition (0 or 1) if it can.
+ */
 static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
@@ -689,6 +656,51 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
     return r;
 }
 
+static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
+{
+    TCGArg al, ah, bl, bh;
+    TCGCond c;
+    bool swap;
+
+    swap = swap_commutative2(args, args + 2);
+    c = args[4];
+    if (swap) {
+        args[4] = c = tcg_swap_cond(c);
+    }
+
+    al = args[0];
+    ah = args[1];
+    bl = args[2];
+    bh = args[3];
+
+    if (arg_is_const(bl) && arg_is_const(bh)) {
+        tcg_target_ulong blv = arg_info(bl)->val;
+        tcg_target_ulong bhv = arg_info(bh)->val;
+        uint64_t b = deposit64(blv, 32, 32, bhv);
+
+        if (arg_is_const(al) && arg_is_const(ah)) {
+            tcg_target_ulong alv = arg_info(al)->val;
+            tcg_target_ulong ahv = arg_info(ah)->val;
+            uint64_t a = deposit64(alv, 32, 32, ahv);
+            return do_constant_folding_cond_64(a, b, c);
+        }
+        if (b == 0) {
+            switch (c) {
+            case TCG_COND_LTU:
+                return 0;
+            case TCG_COND_GEU:
+                return 1;
+            default:
+                break;
+            }
+        }
+    }
+    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
+        return do_constant_folding_cond_eq(c);
+    }
+    return -1;
+}
+
 static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 {
     for (int i = 0; i < nb_args; i++) {
@@ -1085,15 +1097,13 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[4];
-    TCGArg label = op->args[5];
+    TCGCond cond;
+    TCGArg label;
     int i, inv = 0;
 
-    if (swap_commutative2(&op->args[0], &op->args[2])) {
-        op->args[4] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond2(&op->args[0], &op->args[2], cond);
+    i = do_constant_folding_cond2(ctx, &op->args[0]);
+    cond = op->args[4];
+    label = op->args[5];
     if (i >= 0) {
         goto do_brcond_const;
     }
@@ -1841,14 +1851,11 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[5];
+    TCGCond cond;
     int i, inv = 0;
 
-    if (swap_commutative2(&op->args[1], &op->args[3])) {
-        op->args[5] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond2(&op->args[1], &op->args[3], cond);
+    i = do_constant_folding_cond2(ctx, &op->args[1]);
+    cond = op->args[5];
     if (i >= 0) {
         goto do_setcond_const;
     }
-- 
2.34.1



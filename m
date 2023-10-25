Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58367D629C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:28:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIS-0000AA-5S; Wed, 25 Oct 2023 03:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIO-00008Y-5U
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIM-0004eF-G3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ca215cc713so34856275ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218833; x=1698823633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=ThYRaIlKLVrrVPATJ+0iYoxPF0I8Tpg6x2wbFb3QmZeqGIh1WwwcuC583VDx7khX9X
 h2/NvwYz5y4MWYVfjJO5Yf9AX1guH/1sbv8OMr4PGT7fABuDZZn+xDV3pBA6uHUqUOa2
 pSxR9wAQy86cuVd18y45fhLPudcx+Hpz2MwRQ9zABCCwDwggmfgh4U8mwmffImcFYjPH
 XK3TGEMHg3M6MRhlJqVbm7PiocpPOQq9fzUVWAixGbhk+yRk8Na/QReCQK0CWPtjyt9G
 PNZaGn0quQQic8+d4ldrP+SFr35t2CtHHG53t02uVoYquhiZptocSMFYZ3md6dswi3EY
 C/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218833; x=1698823633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=fjd8u+IUjw944z91612uktpVsLtZokBsZ5g02F4eHsU0XGwhMpc+1onk+9/APe+gO7
 4CQDHgJJjy+mnRs5snpej+6vtO5W9CQGJv5cDNA2X05bAPgFrSqUt2PqAUVHCOQqCs8l
 osgW8NtxOOoRWMWSKGyreJlMJzs09pUzg5Fy0DVdkfLc/5JRHz3mUIiO0RGzp8PWvEYm
 o65h7L4sQ2xciRX5B4G/kngKtQEOeEHKgLRVbH+AALzzNZ52fUxsXvz0OgnobzxCNb3M
 YspLRzgofYATXrRHKLROLnOqaOqZeb6f+FIgFR9+aSdF/vYAhs2g1fzlOOz/UHqlDmIZ
 Ul6w==
X-Gm-Message-State: AOJu0Ywb//mWMt/ugqfe+q4RWmD0L1sYoE6d1NfaAvrsZaI729h9o2cP
 iGMgumvW3Q6GVpLCcIiyrN1LXORohdybkMm4MQg=
X-Google-Smtp-Source: AGHT+IGU68e4el0ujEcpRRFNjHLk+JW90H4VFHwoCUeSDSG+1siupZuQGVpV+faRtBX6fA+kWATvpg==
X-Received: by 2002:a17:903:22c4:b0:1c7:443d:7412 with SMTP id
 y4-20020a17090322c400b001c7443d7412mr13104176plg.26.1698218832716; 
 Wed, 25 Oct 2023 00:27:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 04/29] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Date: Wed, 25 Oct 2023 00:26:42 -0700
Message-Id: <20231025072707.833943-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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



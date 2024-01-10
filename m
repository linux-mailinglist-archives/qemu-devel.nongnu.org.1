Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FB82A420
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJp-0004WW-F0; Wed, 10 Jan 2024 17:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJn-0004WJ-S1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:03 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJl-0002hk-Uq
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:03 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bbd6e377ceso3851519b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926700; x=1705531500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRgNiPJydpvDmMhlC8JjCGm8KjRyw9Ww/5hSgKncWeA=;
 b=MorRs4Tgdi/pbbxWQu9IMoL6Sl/iI3Z1rJqLDRWD1wY2hU7zL9rqlLCoHP2GSvgx0z
 gdFamU4WWMvuyJjF+80/t9CxqQoiLVJMSb7EBkWnJDBbXKU3AvyoPYHrg8dxotXBGNxJ
 nU2lZdK3N9/VqV00uATv9Hb67sRc7a1ilDhv7RM3SYaeIwBFmDLj+d6lCBMtPoc+RqdX
 MEMvSkba2xLPLjZVMeHPMTon+MA+eDrm66N1Z8DWhXugpSpScP3H82wuQ+atGq8thOzo
 FcJ4zrgRgmZOk0N8E2kLuQCtlvyW3QugwV9SIIxHgMfrWWwhAg5YpfHUrFOhUzP41s5E
 +MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926700; x=1705531500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRgNiPJydpvDmMhlC8JjCGm8KjRyw9Ww/5hSgKncWeA=;
 b=mOJQ+XjOcbUsDSxrP1iRdAdCLW2LahTRFlQO0rYflmF7+Cu7yWNaNArMmEA4WRj4JS
 jUyK3akKkW8xfnEpBw9F057FY5S+QpPfkOVAwu5J5tcXG4JmODllzmLTh9T9Ywr/GLyl
 /B15XOW557IcKmfzw8ZigQ/0N5UMYVPJkOXw9BHzWqGDdkLLiPmOKSg9Od3q0uCqMWLN
 64bCsJIFJrShU+fPtAzuPFb7vECrIJlXTcqo7JTDzKl2BoV0genewzGdyvQutwf237lS
 SMr0AIc6+4slVLFCBSlJnwPlKOcGblKNKd/LL8oVLg61V9l9M+dsuXeqPrC7A36k0n1N
 46sQ==
X-Gm-Message-State: AOJu0YyF6yfHkmMWhA8aoZMYOZrQo8sVJp2IpZMmAWIcGS+DmW8jQtlq
 HP82YIlSRT07pbPbpX/oCCuCmkhJbrBN2c/bUZbg3QpFAKg1PyZe
X-Google-Smtp-Source: AGHT+IEKVe5t7LdUA50/Q3Z8q5b39g736y2vs5XArUJydfwgIDYXBM1y6Kn6em3c5uWN7opwF/nz7A==
X-Received: by 2002:a05:6808:16a2:b0:3bb:cd42:752c with SMTP id
 bb34-20020a05680816a200b003bbcd42752cmr320840oib.70.1704926700464; 
 Wed, 10 Jan 2024 14:45:00 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 05/38] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Date: Thu, 11 Jan 2024 09:43:35 +1100
Message-Id: <20240110224408.10444-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Mirror the new do_constant_folding_cond1 by doing all
argument and condition adjustment within one helper.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 107 ++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9c04dba099..08a9280432 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -713,43 +713,6 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
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
@@ -796,6 +759,10 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+/*
+ * Return -1 if the condition can't be simplified,
+ * and the result of the condition (0 or 1) if it can.
+ */
 static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
@@ -813,6 +780,51 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
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
@@ -1225,15 +1237,13 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
 
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
@@ -1986,14 +1996,11 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 
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



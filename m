Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD47DA912
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFV-0004ho-M8; Sat, 28 Oct 2023 15:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFT-0004gv-2A
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:31 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFR-000464-Av
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:30 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso1764654eaf.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522328; x=1699127128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=VWWOxOM50lFaRMYTGpBOXrwPaHUiJhkGjPaC6rBXlRmWU+Ho9B/Xw9SvQooCoysGnW
 3I9LPbpKx8XTL8C0B9fL2DL0zTCvd7ZdFZ7GbM5s29ubYVInLhlLPoMd1wHbqE6aDSb9
 MWWOPf9VZS/3xXu2KOcon4xhVhkUiLwSpHiJ3VfE/UMCIo8sx0eHi4vLzchXsORuB41r
 nzYYrvPPVCPtJdjO2Ph5LJnIS4DT1j6deNjKrUnZOjy+k7fmA8N6U2O9NMAjWF1cHBVc
 W2sKeGFxUFA2s0P3llLdLUEJLzXHcRsZuiRYmPaIC1q4XFPWNtBrMPWAKi58Yg3mtkIt
 1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522328; x=1699127128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFOV1ZTpKlHV2EkIZjqhQOIe3ZbiCQ+tGnrYqmSw9YI=;
 b=PxHTvDiryqrdqWl0mkKBovsK5r8wWjfD4gEj5vJ7PDgiWF0RdBUE2Ewc0nzPSKfgoH
 n2cIyOVPgof6H5r0w7obyjq3Xvz1qRgYWiwiOV7FG6fTzDrZFTCCHEJ9dCfAUOqR+gOT
 qu9kmX6fWiDNl0XBCp0/8T9oQo8NZP99TDflgaz3MJNil65zpE6XfiJeqt00ClIJ+uW+
 Am/g5YtLW8czY8wQPurotE1+2m/UbF+9Kw0o1txOEsT8CyjUKCFjbbm2/m5bKScjBDKH
 bavF4cw1QoBIpjjGx0UAStwTxtnMzQVpVuz/n7wTldem7vq00k9dNzBIPNcan0qAyo3p
 iMFg==
X-Gm-Message-State: AOJu0YxtvPMpGDxK7W+W9s8JR7vqa2F7YkQzOQkE2tdVp+yWQ5p61fbU
 uvOZtjq6+g8SoOsF6oL0kBLad7bkbnzNigkf+38=
X-Google-Smtp-Source: AGHT+IF/GIOD1aNT2KJGZKLZC7WXujy3118AIqpzRDB/TUcqh33pIGEpQVGht2NsS0z66fQAkSIvtg==
X-Received: by 2002:a05:6358:7f0e:b0:168:e4c1:eb9c with SMTP id
 p14-20020a0563587f0e00b00168e4c1eb9cmr8296887rwn.20.1698522328145; 
 Sat, 28 Oct 2023 12:45:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 04/35] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Date: Sat, 28 Oct 2023 12:44:51 -0700
Message-Id: <20231028194522.245170-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF847D799F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2u-0007B5-Gp; Wed, 25 Oct 2023 20:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2p-00073s-Ic
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-0004rz-JI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso2376285ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279365; x=1698884165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KUL+P8NrKSp/2wsdRODDHeKdHM6SlkUdqF+vGMepqTA=;
 b=PQGsmS+03OmJLtFyQ/eE3XmOxzRV1op/pePko97hx87PGNY0Dp5xLMjc2baTCx99tY
 Kv0zJfREZl089d6ZsLx2pSybzYFUIkFGJN1IPkAoWoIbSd4V25dLJROumGYv8ndOKVwf
 zyoFRRwiB8qtqjELTuDtHJCe063esrYdkeZSnwZIXiUlEYzwQXSxKRMIvBweDSZGxSGq
 sARKRcnr6ZpX5Goii/xSwGy/DESoMjG+gVoQC9ZNX/gpdtYqieRWS9otIE2lSYBcz2TM
 tOg6UZH4zBdKHcW5YhS1Z2vB/bbOw9XzF9IgpuUmOBrzZI38b0b5YKW/Dqk4vNl2UGqM
 42GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279365; x=1698884165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUL+P8NrKSp/2wsdRODDHeKdHM6SlkUdqF+vGMepqTA=;
 b=EmLeHacPsLaA9cR0bBCikhpS9by/E+B5FtVu5yGEqgNThE0zbfzJFDKmVlO1yNXsCX
 xCoAkr/sVDr+L0fhlzklNlBPFCXQ2deXqzMiYAbDwxz8dPykU+WMTlkIL+nUJKWALVwb
 v6BzHdOaF2i9NAhrkjcyAPnGL0ok1Vax8m5mCmOmIy4pzZ5gJj3FsqpyXLCmq+BpmEJ5
 aAtidAerEHhpvU4B5kUx9UWSbGfI4g4G+ERoIrqhYpxLSG4iDdlzg4TJcydn1D7Od4Y+
 bK8XB95SqnUeF+wFLr+a6sV8GtS4cmOUYSG9VqzlOS4eFFkD2hD+9djUe668lxGu0kop
 FSRg==
X-Gm-Message-State: AOJu0YzI6xIaFptESyDJZfumkQDqKcG8lfKM2Ew3EHfftmji1kMwE81y
 3CUMvhHFi3CiUieop3kjGwOwiUcHQ4Jju5vkGac=
X-Google-Smtp-Source: AGHT+IHxnT8vK4cblqFRyc8Yp8aIkAbLwUq+H7k3f2IGqx49u6D6tzOhTk5UmS2++gfcOrUCp4AnPA==
X-Received: by 2002:a17:902:f0d2:b0:1c9:b785:bc50 with SMTP id
 v18-20020a170902f0d200b001c9b785bc50mr10998924pla.47.1698279365560; 
 Wed, 25 Oct 2023 17:16:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/29] tcg/i386: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:05 -0700
Message-Id: <20231026001542.1141412-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 43 +++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f4f456a2c0..0d97864174 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -504,6 +504,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_GEU] = JCC_JAE,
     [TCG_COND_LEU] = JCC_JBE,
     [TCG_COND_GTU] = JCC_JA,
+    [TCG_COND_TSTEQ] = JCC_JE,
+    [TCG_COND_TSTNE] = JCC_JNE,
 };
 
 #if TCG_TARGET_REG_BITS == 64
@@ -1419,12 +1421,14 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 }
 
 /* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
+static void tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
 {
     if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
         tcg_out8(s, i);
+    } else if ((i & ~0xff00) == 0 && r < 4) {
+        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, r);
+        tcg_out8(s, i >> 8);
     } else {
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, r);
         tcg_out32(s, i);
@@ -1434,15 +1438,25 @@ tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    if (const_arg2) {
-        if (arg2 == 0) {
-            /* test r, r */
+    if (is_tst_cond(cond)) {
+        if (!const_arg2) {
+            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
+        } else {
+            if (!rexw) {
+                arg2 = (uint32_t)arg2;
+            } else if ((arg2 >> 31 >> 1) == 0) {
+                rexw = 0;
+            }
+            tcg_out_testi(s, arg1, arg2, rexw);
+        }
+    } else {
+        if (!const_arg2) {
+            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        } else if (arg2 == 0) {
             tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
         } else {
             tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
         }
-    } else {
-        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
     }
     return tcg_cond_to_jcc[cond];
 }
@@ -1461,18 +1475,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
+    TCGCond cond = args[4];
 
-    switch(args[4]) {
+    switch (cond) {
     case TCG_COND_EQ:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
-                       label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+    case TCG_COND_TSTEQ:
+        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
+                       args[0], args[2], const_args[2], label_next, 1);
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+    case TCG_COND_TSTNE:
+        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
                        label_this, small);
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_LT:
-- 
2.34.1



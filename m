Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C257D7949
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2s-00076f-4E; Wed, 25 Oct 2023 20:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2k-00070l-W9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0004rY-Ji
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so2266925ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279362; x=1698884162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KAuC6MuCUKIHHBxqGTcvXulP9OV1zIYTQIpMzlqMLcg=;
 b=a5HtLAIX+A3bemenxWauITQK4CD+rNKOTw1hp0u4LCVGqkOetaWQ26OWanHJcuArjV
 fJi4MbqDVzjzXtl839Cz9z6r6+3n0DjhJXoMQiqtLF9DqUGMVpaVoK8APkaVeM7ErlTY
 1SKROH6BHdd/xYgZj2NzI+QcqnnsPBgRdWeyBllJ0Ky8hPUnu0oFnuwrJoZXMknvXYEa
 GXZstrsa3g8YxHImuKqmuibpj8Mx+Wm2c9r8CJC4YYWnVwUn4bUporHGZcEy/10q+zzW
 npmwtj+9+AIq5GvPwvplOOlNcHSOpETiyj1hkgqA87Bn/5GMC6BfadiS4uJT+iuj4lOq
 YBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279362; x=1698884162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAuC6MuCUKIHHBxqGTcvXulP9OV1zIYTQIpMzlqMLcg=;
 b=NApVGFBV1cCVMsBuOb4nvdV5WwN6kO7pKxY0Rsb5VAztMzjS44KjX9XvrNNtAlzsht
 WKtDgx6Cpwr2yn28GK10waQI3Ds2q80VMGNm0j9+t57iNxoWP/7uX4Cdt835M5acVX06
 Ffprn5tQt+LC9EI+bPRWy6pPUww7lYu+MqROfzswBaY7/ysWZzMKJ1SvPJDXQh/xV+ZE
 bKdvtEfBkOOrKEpnwRCysAMn8l8q4R5BKn24/0xQI/uNwq++peOvBYye3IeRuuGxjy5z
 20pVCgU/wA2gPLThVIO0CRZKVlIA9P0xaB3rAwzu9HBbf2b4IVAAXxGYGUeKrBhnfmTo
 QXbw==
X-Gm-Message-State: AOJu0Yxj+UfCyGi+03kaTR3B6HOUfItA97fR27L8SQCPGJIlD2bMPX56
 o+pbiv/2Ajo7VxeDRCDTUAkBV18WY0LfIohM/3A=
X-Google-Smtp-Source: AGHT+IGYHhXQ11OJRBQCDoSGV4Kdb+heZoAAJ2fLbrl4Mc3JKsWYKKTq86fuErY2b3zyybH9FaeauA==
X-Received: by 2002:a17:902:cec6:b0:1c5:cbfb:c16f with SMTP id
 d6-20020a170902cec600b001c5cbfbc16fmr16385499plg.25.1698279362200; 
 Wed, 25 Oct 2023 17:16:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/29] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Date: Wed, 25 Oct 2023 17:14:01 -0700
Message-Id: <20231026001542.1141412-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Return the x86 condition codes to use after the compare.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0daffb0e70..6e8af1fcf6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1418,8 +1418,8 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int rexw)
+static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
+                       TCGArg arg2, int const_arg2, int rexw)
 {
     if (const_arg2) {
         if (arg2 == 0) {
@@ -1431,14 +1431,15 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
     } else {
         tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
     }
+    return tcg_cond_to_jcc[cond];
 }
 
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
+    int jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_jxx(s, jcc, label, small);
 }
 
 #if TCG_TARGET_REG_BITS == 32
@@ -1530,6 +1531,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
 {
     bool inv = false;
     bool cleared;
+    int jcc;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1566,7 +1568,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1613,8 +1615,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
@@ -1685,8 +1687,8 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
                             TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
+    int jcc = tcg_out_cmp(s, cond, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, jcc, rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1728,8 +1730,8 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
+        int jcc = tcg_out_cmp(s, TCG_COND_EQ, arg1, 0, 1, rexw);
+        tcg_out_cmov(s, jcc, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1



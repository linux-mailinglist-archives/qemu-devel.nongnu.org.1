Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DD57D62EC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIX-0000EW-OT; Wed, 25 Oct 2023 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIU-0000CS-6j
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIS-0004gD-Jj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so35210945ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218839; x=1698823639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAuC6MuCUKIHHBxqGTcvXulP9OV1zIYTQIpMzlqMLcg=;
 b=aJ/xFwXwEyhqg1DVIzg3QT9r7GDFD43iFOaql3C3XLdfyoVXoH2vBTCJyrbtbtIdvD
 nyWq4fVjDeWoidvmkloeH6R5ZQODmVbSaqEK3hNYFDJ0ZQZl6knPmqcQ9Z78Oc+MjFwj
 ASeYvOIgglRYgIdeeIZ8CxVDN45UBx1XJo7vjkgFt9WyQu8jfgJiA48P/+msP1B9hjNT
 roJRiVjaH077TQZg0RRiHQ7y3xBIT0PpB3GWlhNThKLW926LOFKlIMbiNYpf5RhShZx4
 qTnnjvBXuqT3qxl0lKPXt/heNu0bsEnPG4YqrbkiwtDG2lNGiWb3quxPB6l3zTRGlBbk
 2UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218839; x=1698823639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAuC6MuCUKIHHBxqGTcvXulP9OV1zIYTQIpMzlqMLcg=;
 b=ZUkbPRtl7g/A+9961zbVqS2qCLINmpENq/nG+LspFYgmct5JX5XYW2deC8W7NRf/8w
 NECHuGzbj3D6GF4nQRUewRwYJv76UVLtuRAFGlysynWvlir2SPAJtYikWdniSns2S+5A
 qNrNw2VVwbl7K2Ft64HeoPndYF83F95lQkLyKsc8xY2pnrBbS8tDhthXZGXUyDCShjPq
 U5huAynpWd9R6iFAKApe9pXE+8qkja5yiBE1ZCuczc2rp9IeSSxEmybtIgawrM6OrCLM
 E5vlyejQ0LsWHDfVsu2z0mmR8sDi4nMqFS4uDV7o9ordnEwtiStuxAFrcK1rTyv3fkLu
 7CEA==
X-Gm-Message-State: AOJu0YxvI4+KQtTRfJP+3hgJbfuZKBdSBoVh85McD1PLQjQQygd2tLFz
 LvN9X2Iwms+wsWNbCWmmRmDH7RH1IFs2sh+O1u8=
X-Google-Smtp-Source: AGHT+IHFNli50eckZeNFRTuJf7FlzyuE3LnaMuYOAhxD9cMiS7jnHo3jv9MmCnKFzxH2gfyvIokDrw==
X-Received: by 2002:a17:902:e391:b0:1ca:678b:5764 with SMTP id
 g17-20020a170902e39100b001ca678b5764mr8359147ple.54.1698218839334; 
 Wed, 25 Oct 2023 00:27:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 11/29] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Date: Wed, 25 Oct 2023 00:26:49 -0700
Message-Id: <20231025072707.833943-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
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



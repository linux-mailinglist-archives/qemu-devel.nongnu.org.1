Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442447DA90C
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG0-0004ug-Qx; Sat, 28 Oct 2023 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFb-0004js-AC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:40 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFZ-00047s-Ic
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2528168a12.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522336; x=1699127136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avET+iT/h/AqsEJA9yMKornLFdjzPZD4XFSW/W2EXLM=;
 b=sxR9b+PZAy7Swk6+NwtRM0BL/paAkwWBHJCfyk2BNu3EprrEmP2bMiSEKr6zgbpWV9
 8KIo6VRRRQ8AZNaMSpgToruYk3Lbt7p8mST/P0HdFz+ahtKjPOCFzH4f+Sz4KowsfIxp
 UZFHRORyLaY2RVokpBfGIDpccNQv4LI0g5fid/hS51+jPHC7CdP5NnPOkgpQYnbd1fKx
 lxTCg1S5524etWeZcOqAX1zxwXVodjXebdZ79WFamf6Utm4aJS2PWR9ed73FvgtiEzbo
 rWKvDbFo8bCMUwJnmwnvH0xeTU08vFBy1QytYPEEdvpIeawnJnldoe+II17lu7QvSbgP
 eRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522336; x=1699127136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avET+iT/h/AqsEJA9yMKornLFdjzPZD4XFSW/W2EXLM=;
 b=adwOTS0gupqUknuUdAcQRx0G3UgD8cJaFyqM7miscUKi8hJDty2DdWMeUHv5SFhid2
 FhVmOs2UXPVjjEaYgXvyiUiSUTKj6arr3zs6c5t7WYx4A9AgPzV9VTPUIt6xspUcm0h/
 LztkmFOvZGTpjiJhVsX5adJyVDxnE+sCfdzBCoXzn/WGsAfm2ovtyvCfhaHvI9J/sbZ7
 uyQi3Pms2utWFQlMjJ0CrkEroxOBpPOsWNGVJv6zaJXndJSUyxFWYFnlmlJC7V+VHL28
 3W3Vj+WcTc0o2sCMQRloN4AmuqBRo+0fOAE6FglHXkjdGSdP8NT6dtCpQWRipA40qZaN
 iVzQ==
X-Gm-Message-State: AOJu0YwMqgTGfUC9bcPHJSnKexDRF7rXFFqvJytE9yEiq1wxk2wT7S5f
 /s7wKmqMbILFe+30cHmyeY9aN5q5tnhtyQ0ft/E=
X-Google-Smtp-Source: AGHT+IHd3d2++BqX6yqOWnwto7B5Zom5dVPVmVW1QWkPKd6tebZrfUGL6tQQ7RgBScAxlLVUlOmhmw==
X-Received: by 2002:a17:90b:19d0:b0:268:ca76:64a with SMTP id
 nm16-20020a17090b19d000b00268ca76064amr4963481pjb.49.1698522336145; 
 Sat, 28 Oct 2023 12:45:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 13/35] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Date: Sat, 28 Oct 2023 12:45:00 -0700
Message-Id: <20231028194522.245170-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
index 8b1baa8206..7d5ed0d045 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1419,8 +1419,8 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int rexw)
+static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
+                       TCGArg arg2, int const_arg2, int rexw)
 {
     if (const_arg2) {
         if (arg2 == 0) {
@@ -1432,14 +1432,15 @@ static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
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
@@ -1531,6 +1532,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
 {
     bool inv = false;
     bool cleared;
+    int jcc;
 
     switch (cond) {
     case TCG_COND_NE:
@@ -1567,7 +1569,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1614,8 +1616,8 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
-    tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
         tcg_out_ext8u(s, dest, dest);
@@ -1686,8 +1688,8 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
                             TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
+    int jcc = tcg_out_cmp(s, cond, c1, c2, const_c2, rexw);
+    tcg_out_cmov(s, jcc, rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1729,8 +1731,8 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CC711352
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQG-0008Mx-7q; Thu, 25 May 2023 14:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQD-0008Lc-6n
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:45 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQB-0005rF-J2
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53033a0b473so1364197a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038243; x=1687630243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PjVO4EwG0pWR82jvmleP9L75H2ptZyzCcmmMncc3rzw=;
 b=Bb+O+iSLpgjlJp3GYJDrZevUyefyLq/4xoLwxTZhDRKie7cOcZxK7Hq1ylice+q23W
 Ar/JboIJLzvMtL+bU/nJjCL/yY0cFUhMIskUzKORf0r0OL5kv3akn/532cGJqZc1tkzj
 Nd5LQiTLYhySBnkhlBfTjDoM5Fwa3wX8VPBPGICfR/JYO5YSOw/neLTGvSJZ45Hmci3Q
 PbhPg0VD0RG4oEw2lXGxyVxnzpT4tGL04M59iMjVrvmNt3x9rIgVaC992qFxA5oEXAnF
 Bddn8MUqc11yW+ke5gnZhN6pUTNtrDd+39UTrdNKOYRyWHlO7P6bxjFO6gRG7e/pjYw1
 KQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038243; x=1687630243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjVO4EwG0pWR82jvmleP9L75H2ptZyzCcmmMncc3rzw=;
 b=NU12K22YYmc7wScwMgMjdkbR51/yYOqrec+RwyEgFqrJBVr8VNSZ54LjCOpkmXku9a
 O257dVZnnV4rjcHc5cJKo3jrj8qn3zpjTXMWZ7ZZJ7bq7302JqI8VixH+eQywKhYIu2w
 yjAEPds2qJOeVVPLZh+j2nxOn0DhYycKRH+SoaR86URe+zK3rBXb13uvWDd2xMzSe9L+
 v4ICa8Pa7TjQLk3gG77lcz3C8DiPqoXKImLzBfBanE2dgf8+cKyZABNyqaaVz2kl1nX5
 pPE5LaqgfSoxwVzdwXl5uuAT2l6EEi6iUfPkC/A7NISuu30e3+RFlgnMUkrvRI3hARdk
 1FWw==
X-Gm-Message-State: AC+VfDzmF7FbPn9N0ydn0dVasi9MvGdY7mSpgTKkCN/f2YK7bf0Fjias
 dhnf0cE5fLGrT4fB6d95rRo19TQtiLMcd0IySUM=
X-Google-Smtp-Source: ACHHUZ4rCOoLY/32piupkQjNRxgJRNcdl4mnAt0i0EG+RGq5Y4eeP23tQRH4pNK0CGzg5qog4hj+mQ==
X-Received: by 2002:a17:903:41ca:b0:1a6:abac:9cc with SMTP id
 u10-20020a17090341ca00b001a6abac09ccmr2709569ple.66.1685038242777; 
 Thu, 25 May 2023 11:10:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] tcg/mips: Split out tcg_out_movi_two
Date: Thu, 25 May 2023 11:10:19 -0700
Message-Id: <20230525181036.1559435-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Emit all 32-bit signed constants, which can be loaded in two insns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index bbff510c46..7a19f8db1d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -527,6 +527,22 @@ static bool tcg_out_movi_one(TCGContext *s, TCGReg ret, tcg_target_long arg)
     return false;
 }
 
+static bool tcg_out_movi_two(TCGContext *s, TCGReg ret, tcg_target_long arg)
+{
+    /*
+     * All signed 32-bit constants are loadable with two immediates,
+     * and everything else requires more work.
+     */
+    if (arg == (int32_t)arg) {
+        if (!tcg_out_movi_one(s, ret, arg)) {
+            tcg_out_opc_imm(s, OPC_LUI, ret, TCG_REG_ZERO, arg >> 16);
+            tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg & 0xffff);
+        }
+        return true;
+    }
+    return false;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
@@ -534,21 +550,18 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
         arg = (int32_t)arg;
     }
 
-    if (tcg_out_movi_one(s, ret, arg)) {
+    /* Load all 32-bit constants. */
+    if (tcg_out_movi_two(s, ret, arg)) {
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 32 || arg == (int32_t)arg) {
-        tcg_out_opc_imm(s, OPC_LUI, ret, TCG_REG_ZERO, arg >> 16);
+    tcg_out_movi(s, TCG_TYPE_I32, ret, arg >> 31 >> 1);
+    if (arg & 0xffff0000ull) {
+        tcg_out_dsll(s, ret, ret, 16);
+        tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg >> 16);
+        tcg_out_dsll(s, ret, ret, 16);
     } else {
-        tcg_out_movi(s, TCG_TYPE_I32, ret, arg >> 31 >> 1);
-        if (arg & 0xffff0000ull) {
-            tcg_out_dsll(s, ret, ret, 16);
-            tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg >> 16);
-            tcg_out_dsll(s, ret, ret, 16);
-        } else {
-            tcg_out_dsll(s, ret, ret, 32);
-        }
+        tcg_out_dsll(s, ret, ret, 32);
     }
     if (arg & 0xffff) {
         tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg & 0xffff);
-- 
2.34.1



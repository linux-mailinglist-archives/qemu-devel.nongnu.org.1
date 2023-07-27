Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C67652B4
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyOn-0005d9-8z; Thu, 27 Jul 2023 06:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOyOl-0005cM-K2
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:39:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOyOj-0000TE-R4
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 06:39:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso792785f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690454348; x=1691059148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uXfHqz+RHJ/O21c1DjEA4/cGZpHuHI1aduBBkgJ49gQ=;
 b=v2ys6ePfPlWbMK7qpNrCRyXx5ekx4+Tx32ThbEq0xZwfM0yOH4x7x/iPPuDPMEiwX3
 edOsRPIjRg2etXhBreUIXmc9SQHEhj8nLQ2cfKXdx+7t1ypSUjg5HXPhfJYM5SmjQjxh
 gkdMavaJlCrfjyQNJd17wxt/k3Ux4V3BqpnGAKCHT8WDAg0NZ4U6m02yluoB2uljZ8uP
 RiqGNg6pMMULXsoC8EsI/3h6u88n0avvuV9hSoo5LLD0OEo7vkORHaxB9ShSOo7wUQtd
 9qslgr0L2KFVEQI4A1jZji5Tn66vejWjztn7daTcwXCIoOjIgvoh5IsobCag4JegOu+h
 roSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690454348; x=1691059148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXfHqz+RHJ/O21c1DjEA4/cGZpHuHI1aduBBkgJ49gQ=;
 b=h4W3smAWm+4JfGwmjn8Gws8xjq6bFKEEN2cQzinDkBRxC1qv4VYPy9dJOg+Bx3NaqA
 vqsSGYXr6O41G1ueMZepi+k9T4BFOy7gpvEgS54mNrvybeiaZRNY8MPHb8UwrUSgGK00
 U65n/vkUE7KIFC1xw3yLoeLcA5DrPDLi9Iao5hDkp3hdqCU72mjh6SMjre9wplpiwwNC
 NY4FiXGsbia2KtTfpdnnBiVVehfk0tn6wp8czEfFt3JR6NZwovDsWQPaMb4+Rc5xRvIi
 kUPVkI5hXn4QOzt0kEeR4MdeNuPkUsZpbmDgjxS525qfRyne/TFIoTbHjrdj1c++Q+Me
 ulcg==
X-Gm-Message-State: ABy/qLYlpJy/VWbJCF6Qs6UzhQzv8koLBtVJFYZgPgFAjehOsa44lzmT
 TB2vvZByEZ3KohV93e5/SFVjFQ==
X-Google-Smtp-Source: APBJJlGPk3p1fVLvI8M8HifwoBK+9lBSQyhgmCJrTvJpUIUYC+/aPye85b9fuiPb2VcryIPWQ9wElQ==
X-Received: by 2002:a5d:6706:0:b0:316:e422:38e8 with SMTP id
 o6-20020a5d6706000000b00316e42238e8mr1466785wru.66.1690454348154; 
 Thu, 27 Jul 2023 03:39:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a056000104400b003143b14848dsm1633205wrx.102.2023.07.27.03.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 03:39:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Avoid writing to constant TCGv in trans_CSEL()
Date: Thu, 27 Jul 2023 11:39:06 +0100
Message-Id: <20230727103906.2641264-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In commit 0b188ea05acb5 we changed the implementation of
trans_CSEL() to use tcg_constant_i32(). However, this change
was incorrect, because the implementation of the function
sets up the TCGv_i32 rn and rm to be either zero or else
a TCG temp created in load_reg(), and these TCG temps are
then in both cases written to by the emitted TCG ops.
The result is that we hit a TCG assertion:

qemu-system-arm: ../../tcg/tcg.c:4455: tcg_reg_alloc_mov: Assertion `!temp_readonly(ots)' failed.

(or on a non-debug build, just produce a garbage result)

Adjust the code so that rn and rm are always writeable
temporaries whether the instruction is using the special
case "0" or a normal register as input.

Cc: qemu-stable@nongnu.org
Fixes: 0b188ea05acb5 ("target/arm: Use tcg_constant in trans_CSEL")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
These insns are v8.1M-only, which is why this bug has
lingered for so long.
---
 target/arm/tcg/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9f..b71ac2d0d53 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8799,7 +8799,7 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 /* v8.1M CSEL/CSINC/CSNEG/CSINV */
 static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    TCGv_i32 rn, rm, zero;
+    TCGv_i32 rn, rm;
     DisasCompare c;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
@@ -8817,16 +8817,17 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     /* In this insn input reg fields of 0b1111 mean "zero", not "PC" */
-    zero = tcg_constant_i32(0);
+    rn = tcg_temp_new_i32();
+    rm = tcg_temp_new_i32();
     if (a->rn == 15) {
-        rn = zero;
+        tcg_gen_movi_i32(rn, 0);
     } else {
-        rn = load_reg(s, a->rn);
+        load_reg_var(s, rn, a->rn);
     }
     if (a->rm == 15) {
-        rm = zero;
+        tcg_gen_movi_i32(rm, 0);
     } else {
-        rm = load_reg(s, a->rm);
+        load_reg_var(s, rm, a->rm);
     }
 
     switch (a->op) {
@@ -8846,7 +8847,7 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     arm_test_cc(&c, a->fcond);
-    tcg_gen_movcond_i32(c.cond, rn, c.value, zero, rn, rm);
+    tcg_gen_movcond_i32(c.cond, rn, c.value, tcg_constant_i32(0), rn, rm);
 
     store_reg(s, a->rd, rn);
     return true;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815ABFF157
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 06:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjK-0000cd-NR; Thu, 23 Oct 2025 00:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjG-0000cI-MF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjD-0007IS-R6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so463185b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192906; x=1761797706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teMt2way951YBxY9HJbUv32x5kU3XvCldsY+jVeFn8s=;
 b=fsrymvowvhhloDlNjlyTpbAHk7FRnBgxqtVimld9fVuHUbxjulg9nPJ4TYdMRDMbIp
 3Fqj+8PrOE2wmJeTJbm2GUdPEyspz8VydZukrZuQDpMyzN7B/5JmIOqiMajpNbyP/7Af
 0LCyQM71WPEy628rWjPj2u2V9MPWPKqgAhGXg2wBcKtFxMsKxfIAisd3BY/MOhEyz0Vw
 UdeLbJIYXb9XHaR2xsPOyKX7FcvxNad+pAhO4zpnTUPN7IDHR9WNLkGIj6x3EOYf6yDL
 GNPoHUeZG6jcDlc7y2eH5d961VwdpDvt0oAqj/BLN1ZKOcBsEHgfNdcf5hhq33XM2iYv
 6sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192906; x=1761797706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teMt2way951YBxY9HJbUv32x5kU3XvCldsY+jVeFn8s=;
 b=d1c15GtWsem9hzEE+5W+PWUORUDsx1SnTlxMDzVDZQ8W5FCvK4Fh2uxwi6udzaFvM3
 9AH69efNTu4Kb8NAMm7peXtEDNS+SOKKo5g78lX2YIQQqDcxBaucke7zO7dHYIvIPX7S
 +fdl9qru1Dqn0OmJQOy2ubejNwaDYA4ui96fP3OdczZpHLn8x2TTCzYxddjONu8ZabJD
 ZYlmaWZ7KWA+943toW0+bsFZJBzCksGO9RWBIz9xKfcI9IeRMwAyHqprRq8i2hsjf0n+
 tS213TWGMyxYaSorK5fao8vA1jf6G9t1r1gp9HFFXYPqpbo3lewhVMX/7l5OyEDJobsj
 kgZw==
X-Gm-Message-State: AOJu0YwcrYSTlwB45UZCqMKYN5BZlN125ghwN2nhfhGwDELznhPXZ+lB
 4t1LlN7K4NGC4Qa6QlVCmJOXeD832y6qy08PQA7QmgWVzO41HrafViuZ27t3xw==
X-Gm-Gg: ASbGncta6+05jC0UGPtz/OCpaiegoy7bYPsdavbLllkilS8nucTOH9CM7M0s2dDUwZS
 UM1o2XXfd6wVVkKoMoD8EqtYxgu2rJt9ZQt4Oww4DRWJqMrCJ6ULIJkCqaKsF7zCuBBpy7KGD9q
 SyrNEXsqrMmSW/anA782wOXGFGlwU6RyXXD942UQNNIBwZ0yIgL7Dixb4tjJAqMHiNJNwzt8718
 8lomPP6/bh+mGcxBCnd58uCdNmJwDf4VdahtKzYZbiwi27ihRYXJFkV5ilnOonAXXSaubHvfF+7
 fC8ahfiLTtskUypXMTjgcp0Nil9hD20e4vdIb4V2KYBB3rvUOrxlU3FiK/JVY9ecxqp1dpidFnH
 PPBRUARcs5IZ4atPg/ht0ypgH7RnfSRBBNqXeGOxK7MGp7UFYguPWkDw7LYWZ4bAXHrBToLqAXm
 Qjdyr1VDcw/OaYmTL1dmfCiFSKRTIndjP4LVHA+w+OaM0thi3Jesztnne+LsO6CocxfDjf7mSwY
 jnYxSjA3a8r9AOy3RN7
X-Google-Smtp-Source: AGHT+IHSGwojHXW1kWuVMB8L+8Jjjc4BotrzoUisrnYtXrEwSMRHwG59I2D4+sdlw13PNM2ONUAjjA==
X-Received: by 2002:a05:6a20:2590:b0:334:a775:a59b with SMTP id
 adf61e73a8af0-334a8650ca9mr34519341637.58.1761192905721; 
 Wed, 22 Oct 2025 21:15:05 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/37] target/riscv: Conceal MO_TE within gen_load() /
 gen_store()
Date: Thu, 23 Oct 2025 14:14:03 +1000
Message-ID: <20251023041435.1775208-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_load() / gen_store() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-6-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc   | 24 ++++++++++++-----------
 target/riscv/insn_trans/trans_rvzce.c.inc |  6 +++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 34012caf1e..9a03058f46 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -402,6 +402,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -426,24 +427,24 @@ static bool trans_lb(DisasContext *ctx, arg_lb *a)
 
 static bool trans_lh(DisasContext *ctx, arg_lh *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_SW);
+    return gen_load(ctx, a, MO_SW);
 }
 
 static bool trans_lw(DisasContext *ctx, arg_lw *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_SL);
+    return gen_load(ctx, a, MO_SL);
 }
 
 static bool trans_ld(DisasContext *ctx, arg_ld *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_SQ);
+    return gen_load(ctx, a, MO_SQ);
 }
 
 static bool trans_lq(DisasContext *ctx, arg_lq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UO);
+    return gen_load(ctx, a, MO_UO);
 }
 
 static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
@@ -453,19 +454,19 @@ static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
 
 static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
 {
-    return gen_load(ctx, a, MO_TE | MO_UW);
+    return gen_load(ctx, a, MO_UW);
 }
 
 static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UL);
+    return gen_load(ctx, a, MO_UL);
 }
 
 static bool trans_ldu(DisasContext *ctx, arg_ldu *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UQ);
+    return gen_load(ctx, a, MO_UQ);
 }
 
 static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
@@ -503,6 +504,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -521,24 +523,24 @@ static bool trans_sb(DisasContext *ctx, arg_sb *a)
 
 static bool trans_sh(DisasContext *ctx, arg_sh *a)
 {
-    return gen_store(ctx, a, MO_TE | MO_SW);
+    return gen_store(ctx, a, MO_SW);
 }
 
 static bool trans_sw(DisasContext *ctx, arg_sw *a)
 {
-    return gen_store(ctx, a, MO_TE | MO_SL);
+    return gen_store(ctx, a, MO_SL);
 }
 
 static bool trans_sd(DisasContext *ctx, arg_sd *a)
 {
     REQUIRE_64_OR_128BIT(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UQ);
+    return gen_store(ctx, a, MO_UQ);
 }
 
 static bool trans_sq(DisasContext *ctx, arg_sq *a)
 {
     REQUIRE_128BIT(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UO);
+    return gen_store(ctx, a, MO_UO);
 }
 
 static bool trans_addd(DisasContext *ctx, arg_addd *a)
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index d130179432..c8dc102c8e 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
 static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TE | MO_UW);
+    return gen_load(ctx, a, MO_UW);
 }
 
 static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_load(ctx, a, MO_TE | MO_SW);
+    return gen_load(ctx, a, MO_SW);
 }
 
 static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
@@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
 static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 {
     REQUIRE_ZCB(ctx);
-    return gen_store(ctx, a, MO_TE | MO_UW);
+    return gen_store(ctx, a, MO_UW);
 }
 
 #define X_S0    8
-- 
2.51.0



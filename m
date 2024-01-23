Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A385838D10
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:12:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEgF-0003AE-7I; Tue, 23 Jan 2024 06:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfz-0002qu-Js
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfw-0004Nf-2k
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:43 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3392d417a9fso1487043f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706008235; x=1706613035;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecnCqjTLfYnZuQfJNBUJ4tk5GBJDgWj5pyxdn7gFen4=;
 b=IA3/OisnSICUyVbGmbwUlTVwlp0JbO4hzOjPqnrgYhDcziF27pOovd5twsGcW1kRVa
 yZ4xHnDNVNeDNaKvZ2IozC2lihyroy+VBYMh+8o5t1sisM9blR1RP3s778+yIPepQucu
 mHkzHZRtq94AjvZGwuOUu4E+PgNJdM7Bic+vIsyrY8MVo1OF3zMxfMD8iZI0gaVqx9Ht
 PxgQowZqCG6wYBlHCTtUA9GZ/u29nnWBeOV4jJRtezM4pDt46hK/+JJdHDZApYe+Ylm3
 dKtI4PUHIRky4MgENWsTElvffpi33hKum8Lnyjs436wZYq5GCchGgSEMRoRf/4a0jNOB
 t7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008235; x=1706613035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecnCqjTLfYnZuQfJNBUJ4tk5GBJDgWj5pyxdn7gFen4=;
 b=pm6OKmgbjA813xk7oggSxrRRB0Ci0Ftx87K8nEK2dBDfEiPxffOQoIhneAJ/o27rQ8
 3alUqtfvL+GyLGv+bvM8qsSEJNGYPKicIcxrOgwjC3rRFQBnMAuqkST3py4Mip+S9m6f
 eX8ikOhI4/6niBez83bsiI6uRPT9D8P9OTLVBcod+Tu/PFXj5iG4cFvghRwnIga6WdO6
 dKni95V6vjtqkHPch8C2sIYrl5l0femiXOYntuS4tlSvI8TW3mfdOUKx8ui8sr8iHnk4
 z9WXpJ02fHFZ7DN1A6NQDxND6BwQfXTkQ4L/+pSUXz46OXwwpfAutPAPx2gBQDqPN3Qf
 kfOA==
X-Gm-Message-State: AOJu0YzHcxoYlhm6GEUAZEzTKiTv+XKz83maiNU1A8NNn1mdyVWYmTXz
 x/UQBPqHDcsSbi9rJLgxT+T0yT5CgbNPeGfPUoRJdSLv9cOosGw5ark2Py9QZgnZNPPwQDh+qnL
 Blno=
X-Google-Smtp-Source: AGHT+IGPPkysfIR6MvUpExF4K7S59++cGtcoHVzpNu9BR7tHZv27apgpVSJ+6v6huD93DMJtFsGpLQ==
X-Received: by 2002:a05:6000:184c:b0:337:bd04:8c26 with SMTP id
 c12-20020a056000184c00b00337bd048c26mr3695655wri.105.1706008235010; 
 Tue, 23 Jan 2024 03:10:35 -0800 (PST)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b00337d6f0013esm12288013wrt.107.2024.01.23.03.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 03:10:34 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v3 2/3] target/riscv: Check 'A' and split extensions for
 atomic instructions
Date: Tue, 23 Jan 2024 11:10:29 +0000
Message-ID: <20240123111030.15074-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123111030.15074-1-rbradford@rivosinc.com>
References: <20240123111030.15074-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Following the pattern for 'M' and Zmmul check if either the 'A'
extension is enabled or the appropriate split extension for the
instruction.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index f0368de3e4..267930e5bc 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -18,6 +18,18 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
+    if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
+        return false;                                     \
+    }                                                     \
+} while (0)
+
+#define REQUIRE_A_OR_ZALRSC(ctx) do {                      \
+    if (!ctx->cfg_ptr->ext_zalrsc && !has_ext(ctx, RVA)) { \
+        return false;                                     \
+    }                                                     \
+} while (0)
+
 static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1;
@@ -96,143 +108,143 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZALRSC(ctx);
     return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_EXT(ctx, RVA);
+    REQUIRE_A_OR_ZAAMO(ctx);
     return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
 }
-- 
2.43.0



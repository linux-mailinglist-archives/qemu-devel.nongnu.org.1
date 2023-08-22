Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B991783AA5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLbB-0000R9-H2; Tue, 22 Aug 2023 03:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLb9-0000Qc-Jo
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLb7-0002vD-26
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:14:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee87dd251so23569965e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688479; x=1693293279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V161z4Ei7sDtuZQE5rhbvAPYD0+mOubaYtO5GaVSVj4=;
 b=l6y7g1Z2XmIlzqb2EtQ23lFR7Ihy9YhI0ETra6VmkrEAju6q1zJhwPAwIZF3kVV2BC
 L42C5jOWFE1En7zrUwR9iy2d7geehWp/TZtcG8YD64fx9LjWSPSCVyKD878eJqpGKkOM
 Q7556v+j2M8gvfYwISalA5zUnEFssVFYdK3jwrj29NkbS+f1nePeldr3jlbo+Ab3lMqu
 0/BauZVFTIYyaUAf1HsjKUe2/WKRpQuT303c/mQeTHjJfyDZ/yGlxu+XoulvppWbN/aU
 zoQmNcc0t6vtA4PQfxDdRRQ+tfkpQ+pY4gM4RmltmTtIFrceq7kk7sG/dfg3R0/pCU71
 /arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688479; x=1693293279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V161z4Ei7sDtuZQE5rhbvAPYD0+mOubaYtO5GaVSVj4=;
 b=ARfe8n2xhIeaBaIRmc04HR1h0TDXFFDxIFTFesYRr01mTpzIPJFX0n7mvB4p2Y0ozK
 VSiRgRNnV5rGENnd2hTlqo9dx3qkfoti0gTxwXTg6JsB5JwqRfjp4lmGOLoKYpdBfKGW
 GYzdgvKN80IroC89qS+nlhiEt84Smf2lfQ3Gh6b9N4FBeJR7tWsff2jTD51KgFKyqHy9
 mfa5+T+JSXBDk3S5Jid8mKwjLWl1KDiXmTVlTykQ2nQ0sAZW/Xif0u6V7R85wv9IR76q
 wtDdD4NVz4CLVMsCqyzLTr0bmTXr5LdxcT+J6C9jX58xHuPgW9PuRG4f4hoRBNG3hdDQ
 3Phg==
X-Gm-Message-State: AOJu0YxpaouwdcpCNiFuBAxgO8euVbhHqIStwbingqxjfEK37QXqNQdc
 PN8HpidVRUMbM3cdJBP70LvJvP7Sa6IDQ356S3dbBg==
X-Google-Smtp-Source: AGHT+IGrt5m+XoWGfqjKAUe7jJiEFzCXsNl2zT77yoEkNmNpvCT8lkpp0hK4kVoDU36irHS/DxJOBw==
X-Received: by 2002:a1c:f204:0:b0:3fe:1c33:2814 with SMTP id
 s4-20020a1cf204000000b003fe1c332814mr6779899wmc.30.1692688479531; 
 Tue, 22 Aug 2023 00:14:39 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a7bc38c000000b003fbb06af219sm14971591wmj.32.2023.08.22.00.14.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:14:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 05/19] target/loongarch: Extract make_address_x()
 helper
Date: Tue, 22 Aug 2023 09:13:51 +0200
Message-ID: <20230822071405.35386-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/translate.c                   | 12 ++++++++++++
 .../loongarch/insn_trans/trans_fmemory.c.inc   | 18 ++++++------------
 target/loongarch/insn_trans/trans_lsx.c.inc    |  6 ++----
 target/loongarch/insn_trans/trans_memory.c.inc |  6 ++----
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index ac847745df..a68a979a55 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -208,6 +208,18 @@ static void set_fpr(int reg_num, TCGv val)
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
 }
 
+static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
+{
+    TCGv temp = NULL;
+
+    if (addend) {
+        temp = tcg_temp_new();
+        tcg_gen_add_tl(temp, base, addend);
+        base = temp;
+    }
+    return base;
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 91c09fb6d9..88ad209338 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -57,8 +57,7 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -75,8 +74,7 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -91,9 +89,8 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -110,9 +107,8 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -127,9 +123,8 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -146,9 +141,8 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..875cb7d51d 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4315,14 +4315,13 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     rl = tcg_temp_new_i64();
     rh = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
@@ -4339,14 +4338,13 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index 75cfdf59ad..ccebd0a4e0 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -39,9 +39,8 @@ static bool gen_loadx(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -53,9 +52,8 @@ static bool gen_storex(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
 
     return true;
-- 
2.41.0



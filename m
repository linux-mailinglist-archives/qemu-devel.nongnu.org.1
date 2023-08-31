Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F078F415
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJv-0000BJ-NX; Thu, 31 Aug 2023 16:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJs-0000Aw-Em
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJp-0002rm-B0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so1114324f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513866; x=1694118666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGIdt7gdw15SUX7XAakdKyogx2vXcJbQwgMp+pQoatU=;
 b=NmvpEyzGnR/l4BHEQPoNHzwxrgH63KswG170GP8o43M9oDv4N5965P+I2nnDF0/v8e
 orhzziWzo2Xu3npwL+oo3hAS0s+ksZXxWWS6W0X5lJvYIydX+uXbTKxjKr1atxdcPuCm
 fbYTgx/jwXBfKJDmAWXS0qrKyQsT+C7I7ayCN0SI+muzyfj+xnLXUUWHpO/fM9hWsUp7
 2UIqjvfMr5XHQSfnTleVEME9oqyutCsPP1KDhpgyILlefdknuKmz/7ygaN99T+svEvX7
 eaguNbOeOzwmwwKY1SQfn0DvP0ryZ90YRIy8ZpMdS89jkj+sL511OuV+kAcglBssAFJU
 d9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513866; x=1694118666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGIdt7gdw15SUX7XAakdKyogx2vXcJbQwgMp+pQoatU=;
 b=cFb1zr30X6o8isylf74m7fCZYZcT9qW5t5PBBAGwBixq4BcJLC4VRy8MbEUWmPitOq
 cdfkmysGakEYJYHpx5bzSdSYMhYs+opwSbnchWzUSJGdrPkK/B2nxUwLeKThYbeBrDCR
 VMuQSUxEkOtWV70iNW6WlAVzo0eM+el9NyroGiDQpxRvxWlGfaSbHUFOEcwjcJi5ipGt
 31+3V0fkUvD4xau733K1acdqDOA4kv8vQnPE9g8vsPqXmXTuWlcb7adZh6JjIk6qG6Ms
 t8cKh/tw8LlCb4MhC7wObDkec+TMm+iCXpLCveqfnTDhSN5JXFAjILivZUufUoKbzmL0
 rykw==
X-Gm-Message-State: AOJu0Yy9X2lV0iKCLYgEy/ly6ZnAsnHfmbHC4BFR8U6ZME55DK3TPBfW
 eyec48VSCpHDQNV4N1OiEH3i9WyY06La4K3Uj/4=
X-Google-Smtp-Source: AGHT+IGQE5WB1v/tBKXTuq0JwqzUk5GVdmGIebKHDK7WQdC1uad6PQo1RN2MbdhxlzgqkmrofrMTow==
X-Received: by 2002:adf:f6c7:0:b0:31d:74f8:fae with SMTP id
 y7-20020adff6c7000000b0031d74f80faemr366679wrp.71.1693513866474; 
 Thu, 31 Aug 2023 13:31:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 q6-20020aa7da86000000b0052a063e52b8sm1168685eds.83.2023.08.31.13.31.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:31:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 7/7] target/mips: Convert Loongson [D]MULT[U].G opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:23 +0200
Message-ID: <20230831203024.87300-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert the following opcodes to decodetree:

- MULT.G - multiply 32-bit signed integers
- MULTU.G - multiply 32-bit unsigned integers
- DMULT.G - multiply 64-bit signed integers
- DMULTU.G - multiply 64-bit unsigned integers

Now that all opcodes from the extension have been converted, we
can remove completely gen_loongson_integer() and its 2 calls in
decode_opc_special2_legacy() and decode_opc_special3_legacy().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/tcg/godson2.decode    |  3 ++
 target/mips/tcg/loong-ext.decode  |  3 ++
 target/mips/tcg/loong_translate.c | 41 +++++++++++++++++
 target/mips/tcg/translate.c       | 73 +------------------------------
 4 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index e3bf6b12e4..86015ac8e5 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -13,6 +13,9 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+MULTu_G         011111 ..... ..... ..... 00000 01100-   @rs_rt_rd
+DMULTu_G        011111 ..... ..... ..... 00000 01110-   @rs_rt_rd
+
 DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index d63406e3f4..b05236eb41 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -14,6 +14,9 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+MULTu_G         011100 ..... ..... ..... 00000 0100-0   @rs_rt_rd
+DMULTu_G        011100 ..... ..... ..... 00000 0100-1   @rs_rt_rd
+
 DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
 DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index bddf1cb7aa..c896e64b9e 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -252,6 +252,47 @@ static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, true);
 }
 
+static bool gen_lext_MULT_G(DisasContext *s, int rd, int rs, int rt,
+                            bool is_double)
+{
+    TCGv t0, t1;
+
+    if (is_double) {
+        if (TARGET_LONG_BITS != 64) {
+            return false;
+        }
+        check_mips_64(s);
+    }
+
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return true;
+    }
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+
+    return true;
+}
+
+static bool trans_MULTu_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DMULTu_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MULT_G(s, a->rt, a->rs, a->rd, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if ((ctx->insn_flags & INSN_LOONGSON2E)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 2cfabb3103..e770840d28 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -328,11 +328,6 @@ enum {
     OPC_MUL      = 0x02 | OPC_SPECIAL2,
     OPC_MSUB     = 0x04 | OPC_SPECIAL2,
     OPC_MSUBU    = 0x05 | OPC_SPECIAL2,
-    /* Loongson 2F */
-    OPC_MULT_G_2F   = 0x10 | OPC_SPECIAL2,
-    OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
-    OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
-    OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
     /* Misc */
     OPC_CLZ      = 0x20 | OPC_SPECIAL2,
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
@@ -361,12 +356,6 @@ enum {
     OPC_RDHWR    = 0x3B | OPC_SPECIAL3,
     OPC_GINV     = 0x3D | OPC_SPECIAL3,
 
-    /* Loongson 2E */
-    OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
-    OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
-    OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-
     /* MIPS DSP Load */
     OPC_LX_DSP         = 0x0A | OPC_SPECIAL3,
     /* MIPS DSP Arithmetic */
@@ -3582,46 +3571,6 @@ static void gen_cl(DisasContext *ctx, uint32_t opc,
     }
 }
 
-/* Godson integer instructions */
-static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
-                                 int rd, int rs, int rt)
-{
-    TCGv t0, t1;
-
-    if (rd == 0) {
-        /* Treat as NOP. */
-        return;
-    }
-
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
-    gen_load_gpr(t0, rs);
-    gen_load_gpr(t1, rt);
-
-    switch (opc) {
-    case OPC_MULT_G_2E:
-    case OPC_MULT_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-        break;
-    case OPC_MULTU_G_2E:
-    case OPC_MULTU_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-        break;
-#if defined(TARGET_MIPS64)
-    case OPC_DMULT_G_2E:
-    case OPC_DMULT_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        break;
-    case OPC_DMULTU_G_2E:
-    case OPC_DMULTU_G_2F:
-        tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
-        break;
-#endif
-    }
-}
-
 /* Loongson multimedia instructions */
 static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
 {
@@ -13543,11 +13492,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_MULT_G_2F:
-    case OPC_MULTU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
     case OPC_CLO:
     case OPC_CLZ:
         check_insn(ctx, ISA_MIPS_R1);
@@ -13572,11 +13516,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         check_mips_64(ctx);
         gen_cl(ctx, op1, rd, rs);
         break;
-    case OPC_DMULT_G_2F:
-    case OPC_DMULTU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
 #endif
     default:            /* Invalid */
         MIPS_INVAL("special2_legacy");
@@ -13709,10 +13648,9 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_MULT_G_2E:
-    case OPC_MULTU_G_2E:
+    case OPC_MUL_PH_DSP:
         /*
-         * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
+         * OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1.
          */
         if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MUL_PH_DSP)) {
@@ -13743,8 +13681,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
                 gen_reserved_instruction(ctx);
                 break;
             }
-        } else if (ctx->insn_flags & INSN_LOONGSON2E) {
-            gen_loongson_integer(ctx, op1, rd, rs, rt);
         } else {
             gen_reserved_instruction(ctx);
         }
@@ -13973,11 +13909,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DMULT_G_2E:
-    case OPC_DMULTU_G_2E:
-        check_insn(ctx, INSN_LOONGSON2E);
-        gen_loongson_integer(ctx, op1, rd, rs, rt);
-        break;
     case OPC_ABSQ_S_QH_DSP:
         op2 = MASK_ABSQ_S_QH(ctx->opcode);
         switch (op2) {
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE069B73D4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 05:24:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MjV-0003HO-P3; Thu, 31 Oct 2024 00:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MjL-00039E-Ie
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:19 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MjJ-0006w1-EJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:24:19 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so7321781fa.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348654; x=1730953454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qX8dxvfJ08Ht6ngTOZkjTn6eoR1ftxPI6Vog6jbJNpU=;
 b=yfxlsakMznNAQ04Ra6a1Pjliv1B2/tROk/upBSY1aQ1vLvBuczCiSiNhtUDXYtLH9i
 bryh7jAyhS55IyZQ3fL3WYFbtLFwg/SEiJ1OC1JuJqS6FYyAK0AI3b78LQflumQU/+9A
 UcWMdNFCfwA4ay6T5hoiAgXkGLy1KISdEsOEhaPh1NGJTfsIbcJ+ELFfE+k0Al9hLB6r
 hJfxYA42BxNvHRLcn7mmnliagP7OYr/H8ex0atCE82hnkk53kjFCAO4CaMRrHgzvQmjC
 HMVN+uBbFRvYY8JG9fwE3HtcbAtWOeRITIl+W1J1HVlhcdxUmGv2SN876XjA6mnVDt+W
 voLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348654; x=1730953454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qX8dxvfJ08Ht6ngTOZkjTn6eoR1ftxPI6Vog6jbJNpU=;
 b=DH08JFp61MsDp+l3akBwTL9P5Yp0OEqEd3XwG3+xW4avgyPHEhDBlDrAnUlOsyNtaM
 YhT7/83UscP59yGbu9lP1D9q9paXvYHuVl5Dbfy8J9GWMOWoQZY29PXZ56mKprgpYOUj
 7KKG/bkZPRaXoQOMDEOds1H0EL4rlCSwLvFNoFsehb2+N7LvftVbhPdlSpGspL6w32iC
 kguQNJZ/dJUSLRvi8+WqA1LYuskRFQBoAnhj2UBOnZ3KOwi1bxroSw60zMu4d1exRkFl
 +j5njesBRBiOdNnq0eeXCgS068r2bdRrL3Sq9l4ewxDDXJJdCjyKBSa0ou4MXvHA3M4e
 vyzw==
X-Gm-Message-State: AOJu0YxNQDGQhQ9ckp9fdkSKSWlYOjxeVOfIjL3QdAWjc1BYbAy59uRK
 +PIL0UYMmRFFe4vjppPSRIoi2pekZ1nw++VXoKWtCJb41XlCrvnV9hKK1B8IclHZEIrOwOhLRc6
 y
X-Google-Smtp-Source: AGHT+IG0A74w9V8Xu82kvx6y/kqSMGvZ2ceZyrUpFF3Ob7zqg9PXZwlFslLSchkyerIo1HW6Qk1+jw==
X-Received: by 2002:a05:6512:224b:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-53b348dac70mr13710657e87.25.1730348654184; 
 Wed, 30 Oct 2024 21:24:14 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bde3a47sm75604e87.291.2024.10.30.21.24.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:24:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/14] target/mips: Convert Loongson [D]MULT[U].G opcodes to
 decodetree
Date: Thu, 31 Oct 2024 01:21:26 -0300
Message-ID: <20241031042130.98450-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241026175349.84523-9-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/godson2.decode    |  3 ++
 target/mips/tcg/loong-ext.decode  |  3 ++
 target/mips/tcg/loong_translate.c | 41 +++++++++++++++++
 target/mips/tcg/translate.c       | 73 +------------------------------
 4 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index c03c8b717d9..25b396b6822 100644
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
index f0fd36c9218..b43979d0ef5 100644
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
index 76c1a8cef2d..c02e60bb15b 100644
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
     if (!decode_64bit_enabled(ctx)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 4abc30a6a5f..2d01f5c4a8b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -327,11 +327,6 @@ enum {
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
@@ -360,12 +355,6 @@ enum {
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
@@ -3572,46 +3561,6 @@ static void gen_cl(DisasContext *ctx, uint32_t opc,
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
@@ -13467,11 +13416,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
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
@@ -13496,11 +13440,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
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
@@ -13633,10 +13572,9 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
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
@@ -13667,8 +13605,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
                 gen_reserved_instruction(ctx);
                 break;
             }
-        } else if (ctx->insn_flags & INSN_LOONGSON2E) {
-            gen_loongson_integer(ctx, op1, rd, rs, rt);
         } else {
             gen_reserved_instruction(ctx);
         }
@@ -13897,11 +13833,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
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
2.45.2



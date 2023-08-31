Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275AE78F412
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJk-0000A0-KJ; Thu, 31 Aug 2023 16:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJg-00009e-4i
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:00 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJd-0002kx-KJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:59 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5008faf4456so2399555e87.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513854; x=1694118654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5ahbwysnfVzLLZgaHX/S0gGsWmbKaRZ7KZifG+Dg0c=;
 b=psiF9Jy7HYtZrgk+h7EsrNH5eOroovwAzXH0j0UYFwwh1sxJp7NEGaZ8Y4iQ1YuNyg
 xW3X5ke0BlJipmWPCrHtusgH12ePl+E9eY4JtMO884vfv0+tA4bStXFDVeaFl9z6Jdml
 O/Zn7rc65aECIJWiVNjfsFrExN18SJ/MjM5Jz3hZbQq0Rjd6dS34xohfKI7a83AIZb0s
 u6p77Cn9fUtEeUnErf5fra3nw4xXj8a8biDSWF16DgzhJBb/8gFWxu/h117sAc1AiMaN
 85uLpsM1xVTF4q6NVAzkLs5SuqiNLlh8wtene3FwPQs1yQjw/GKbUcw2v0au5iL1lxDS
 /aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513854; x=1694118654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5ahbwysnfVzLLZgaHX/S0gGsWmbKaRZ7KZifG+Dg0c=;
 b=EEBXNTt2zF49xtn7mgRU9X+XrYUuyAftUEMSHsY240ilnIPosA3pMhIQlOVGMhU/oG
 7Vmto65H5WsWLq18PDs075u/+ArEMy64gPm+6sMeqbgpN6PM4r0OdQ7LlIV1b0iKV+EY
 IwNcxynAkSpTvWfss14VAvyz2n952WBy+hhO5eesUH084/lkKu4zEVEvU0W6eLOQqOPk
 15UMDeYd2ySq3bSJahxokiCIecQl5GOCcETzYEubRO99RdCm8v4PDWx0F0JN4TOnADXf
 j6n2tvJpibe+f/x4CdmP3pGHkVWBbq9gA36Bk/7U9foT7ZHEoxip/T9+/Kaaze7Abl4c
 Q9bg==
X-Gm-Message-State: AOJu0Yx3IIIarXeuer2q+V+7wBaB6eoQkbRaPK9EgUxeUNVUpxdKHxjc
 VNmEoMNiDkfQYTEuhuqEdS81bwtawPODeMHrK1w=
X-Google-Smtp-Source: AGHT+IE6x5SPn8RlMwRNexQcDjaccsSiHLrswyBIzBv+SE309POBTU8JS6VtN65oRA/8A1ktnivUjw==
X-Received: by 2002:a05:6512:3c9e:b0:500:c2d7:3ab4 with SMTP id
 h30-20020a0565123c9e00b00500c2d73ab4mr292336lfv.8.1693513854500; 
 Thu, 31 Aug 2023 13:30:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 gj17-20020a170906e11100b009929ab17bdfsm1113496ejb.168.2023.08.31.13.30.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/7] target/mips: Convert Loongson [D]DIVU.G opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:21 +0200
Message-ID: <20230831203024.87300-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Convert DIVU.G (divide 32-bit unsigned integers) and DDIVU.G
(divide 64-bit unsigned integers) opcodes to decodetree.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/tcg/godson2.decode    |  2 ++
 target/mips/tcg/loong-ext.decode  |  2 ++
 target/mips/tcg/loong_translate.c | 54 +++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 37 ---------------------
 4 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 91940c1263..4352d1e5e7 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -14,4 +14,6 @@
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
 DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
+DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
+DDIVU_G         011111 ..... ..... ..... 00000 011111   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index e9378abc8e..77639227a1 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -16,3 +16,5 @@
 
 DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
+DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
+DDIVU_G         011100 ..... ..... ..... 00000 010111   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index d42cdb7d2e..87023696a0 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -87,6 +87,60 @@ static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, true);
 }
 
+static bool gen_lext_DIVU_G(DisasContext *s, int rd, int rs, int rt,
+                            bool is_double)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2;
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
+    l1 = gen_new_label();
+    l2 = gen_new_label();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    if (!is_double) {
+        tcg_gen_ext32u_tl(t0, t0);
+        tcg_gen_ext32u_tl(t1, t1);
+    }
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l2);
+
+    return true;
+}
+
+static bool trans_DIVU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if ((ctx->insn_flags & INSN_LOONGSON2E)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 59853f1d87..f1c99a9218 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -333,8 +333,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
-    OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
     OPC_DMOD_G_2F   = 0x1d | OPC_SPECIAL2,
     OPC_MODU_G_2F   = 0x1e | OPC_SPECIAL2,
@@ -370,10 +368,8 @@ enum {
     /* Loongson 2E */
     OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_DDIVU_G_2E  = 0x1F | OPC_SPECIAL3,
     OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
     OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
     OPC_DMOD_G_2E   = 0x26 | OPC_SPECIAL3,
@@ -3621,22 +3617,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_DIVU_G_2E:
-    case OPC_DIVU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l2);
-        }
-        break;
     case OPC_MOD_G_2E:
     case OPC_MOD_G_2F:
         {
@@ -3682,19 +3662,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DDIVU_G_2E:
-    case OPC_DDIVU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l2);
-        }
-        break;
     case OPC_DMOD_G_2E:
     case OPC_DMOD_G_2F:
         {
@@ -13650,7 +13617,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_DIVU_G_2F:
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
@@ -13684,7 +13650,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
@@ -13822,7 +13787,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_DIVU_G_2E:
     case OPC_MOD_G_2E:
     case OPC_MODU_G_2E:
     case OPC_MULT_G_2E:
@@ -14089,7 +14053,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DDIVU_G_2E:
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
     case OPC_DMOD_G_2E:
-- 
2.41.0



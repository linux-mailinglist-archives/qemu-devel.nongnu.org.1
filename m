Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2F78F417
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJd-000093-Kr; Thu, 31 Aug 2023 16:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJa-00007y-F5
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:54 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJX-0002hO-Od
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:54 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso147768666b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513849; x=1694118649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rt6iE8ggaPyry/ioAw3N5RsRnOtR5rgLa4k2sO+h/kg=;
 b=wd6N1qo7GSP/FUVO9Dtt1txnY2hXFQyE7lHBWLhvwCnoE3CSwDClbetXo5JYVoIPN4
 Pb7VvVGXHB4D3CFx7GsHdw37Uz40SnbM1UjoEKTmCIaeOttmRqBz90PXzHhqnOsHvIWc
 /Cx/y9SXaJmDM4qJMFASnP1y0i3uEMeg6RnSsQYzJXoj78d5xYevkpJWtyaBQ8oUFcm8
 FE4UCgSct5D/MZPSIUjLJZiOT+ixJJ1h+Bv06i+TlgDcYCL9ENXzqhCjTsZs87n3Kb1h
 EI4gX1ok91+LZKShxY5o4/F4MvVA/BpxVD7booAiV7xOzeqIvUgg3KI4eUwZgx/hQmFI
 weHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513849; x=1694118649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt6iE8ggaPyry/ioAw3N5RsRnOtR5rgLa4k2sO+h/kg=;
 b=lBBEK5MumJE6Xl3U+zlPLdCT1lQttvDuALQyVKKMoCLbTwS10+kjVCPwwRlIogK9A+
 HVOa5A9yUXQgALnF45BhPtiVyVBvyq9c+vO4CsDmmmEaJLtomT4qLu/W1d6P250wkGos
 vyONSTrZAhHA/KFypms5svnz+33HZjgjx/ZQNv/yAnjqhlsELYdAzbIG5m9ZN5RjtmrV
 MK1z3fXI4mMp/fH51LQX36veoXKOQ/nsONK4+lLrTMqow2Enuzal8/BEPeC6zyUw0/+9
 nU0bWc0Xrfmkrl1rlh17jD6ktEhB+BIg4K0LarN8+mQtp/cTXkp2IBOcDGdyuG3qNMnK
 wBqQ==
X-Gm-Message-State: AOJu0YyFhufn+o/bU4Qg7gYUSDsO04CJVBPS+XYGM+qLXxwCiEsHeF9f
 Csg1GfBD3cHFKHSLl+NuQ67d8ksecCoEwWLRSUI=
X-Google-Smtp-Source: AGHT+IGdLaN3HP/iWBSZeIk4lOvbUSlsJAag338MnLKls3qqeTMUvTUC9l6b9M7EEI1eo4N+ot5GBA==
X-Received: by 2002:a17:907:a057:b0:9a1:c399:14c9 with SMTP id
 gz23-20020a170907a05700b009a1c39914c9mr286813ejc.15.1693513848976; 
 Thu, 31 Aug 2023 13:30:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a1709064a5900b0099bd8c1f67esm1133544ejv.109.2023.08.31.13.30.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/7] target/mips: Convert Loongson DIV.G opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:20 +0200
Message-ID: <20230831203024.87300-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

DIV.G and DDIV.G are very similar. Provide gen_lext_DIV_G() a
'is_double' argument so it can generate DIV.G (divide 32-bit
signed integers).

With this commit we explicit the template used to generate
opcode for 32/64-bit word variants. Next commits will be less
verbose by providing both variants at once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/tcg/godson2.decode    |  1 +
 target/mips/tcg/loong-ext.decode  |  1 +
 target/mips/tcg/loong_translate.c | 28 ++++++++++++++++++++++------
 target/mips/tcg/translate.c       | 26 --------------------------
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 382123cc3e..91940c1263 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -13,4 +13,5 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index 407ca5c78b..e9378abc8e 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -14,4 +14,5 @@
 
 @rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
 
+DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index bb329ef027..d42cdb7d2e 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -25,15 +25,18 @@
  * into general-purpose registers.
  */
 
-static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
+static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt,
+                           bool is_double)
 {
     TCGv t0, t1;
     TCGLabel *l1, *l2, *l3;
 
-    if (TARGET_LONG_BITS != 64) {
-        return false;
+    if (is_double) {
+        if (TARGET_LONG_BITS != 64) {
+            return false;
+        }
+        check_mips_64(s);
     }
-    check_mips_64(s);
 
     if (rd == 0) {
         /* Treat as NOP. */
@@ -49,26 +52,39 @@ static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
 
+    if (!is_double) {
+        tcg_gen_ext32s_tl(t0, t0);
+        tcg_gen_ext32s_tl(t1, t1);
+    }
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
     tcg_gen_movi_tl(cpu_gpr[rd], 0);
     tcg_gen_br(l3);
     gen_set_label(l1);
 
-    tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
+                                        ? LLONG_MIN : INT_MIN, l2);
     tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
     tcg_gen_mov_tl(cpu_gpr[rd], t0);
 
     tcg_gen_br(l3);
     gen_set_label(l2);
     tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
     gen_set_label(l3);
 
     return true;
 }
 
+static bool trans_DIV_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, false);
+}
+
 static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
 {
-    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd);
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd, true);
 }
 
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 42be1689c2..59853f1d87 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -333,7 +333,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_DIV_G_2F    = 0x14 | OPC_SPECIAL2,
     OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
     OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
@@ -371,7 +370,6 @@ enum {
     /* Loongson 2E */
     OPC_MULT_G_2E   = 0x18 | OPC_SPECIAL3,
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
-    OPC_DIV_G_2E    = 0x1A | OPC_SPECIAL3,
     OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
@@ -3623,28 +3621,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_DIV_G_2E:
-    case OPC_DIV_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_ext32s_tl(t0, t0);
-            tcg_gen_ext32s_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, INT_MIN, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1, l2);
-            tcg_gen_mov_tl(cpu_gpr[rd], t0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l3);
-        }
-        break;
     case OPC_DIVU_G_2E:
     case OPC_DIVU_G_2F:
         {
@@ -13674,7 +13650,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MUL:
         gen_arith(ctx, op1, rd, rs, rt);
         break;
-    case OPC_DIV_G_2F:
     case OPC_DIVU_G_2F:
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
@@ -13847,7 +13822,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_DIV_G_2E:
     case OPC_DIVU_G_2E:
     case OPC_MOD_G_2E:
     case OPC_MODU_G_2E:
-- 
2.41.0



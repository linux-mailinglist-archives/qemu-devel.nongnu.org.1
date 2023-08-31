Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0D78F410
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJq-0000AZ-KX; Thu, 31 Aug 2023 16:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJn-0000AR-Js
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:07 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJk-0002oS-O0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:31:07 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso1694348a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513860; x=1694118660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxNrNRgFFV/AAAT6JMiONDW218OhK4/S9sVDVf48+HY=;
 b=uBm1B8HZOpd9/IzCK2m1vEoYdCXdObA4UdIIT7kzU6izbb6upRnsoTaPbvSFPAj0dk
 HQS8njrHgBG4aBkSmkcMH1kvUg61begV/hEsK+xGZqFwYgoA+XyitrJmlX4CnjE48J30
 og4gu3GWMl5zh+/ZjiBcdRB1+42IATbRU0819B698k8gtUIDAzaDvPuZvlO6AuQN20hG
 V+njBjwIWm9io6/8Kq4dcisomRLINUFGgwZxEYNuwY5uRKBZ+bKrUYOG8iu6GKWftw6+
 +IhXfOBYZznBM18cTcQDns0u2+hBLs3NUUmPovMc2I1ZQiwMSG/q0h2l46W1YBWKRELQ
 K4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513860; x=1694118660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxNrNRgFFV/AAAT6JMiONDW218OhK4/S9sVDVf48+HY=;
 b=XEbQThzZMGuWI7+kvH//0mAjQ2nUa2PvD/orEAYABguAikyO0zYZshMQJI/xciNXC6
 MjOq8yGXpJMhtUutZwcklC0zp6CN4gmzrMVLS8xyv8oXTb5H1RAOWjEFEYGJVqxa3uO2
 fncToCQRtGyrP4tcj04uT8v3uaYtFYH96d55vLanPhxkY4Ci1WsgNVmjTJVeFefMCQ+9
 XQjsmj5r8PxSssYCyS1EGbZmbVh6ZIWtvegsOrQHonmZOzqFb9Xku/MMs/JjwmK6jGhh
 grMMXoJzNhUVdj/aVxoilCPDaWlM8NvB84iytaczJ3B001UGy75wF4+btY6odfaE9d9K
 3LBQ==
X-Gm-Message-State: AOJu0Yy43AylxG4mgvRbk522KY8HaXchzdNHB7zr2wlb2zzrOHH+cwot
 zXBsoVpbbKykJ/h9nhAYstrHNzKrbFwN4T+OEws=
X-Google-Smtp-Source: AGHT+IHd092jf10jsSuvAmIgcgXqpDiHM4rWV90HuPGCCyF/Z+0uCyg+8hRUo488zlPQNr7z6heV0A==
X-Received: by 2002:a50:ef13:0:b0:523:102f:3cdd with SMTP id
 m19-20020a50ef13000000b00523102f3cddmr541511eds.19.1693513860447; 
 Thu, 31 Aug 2023 13:31:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 a3-20020aa7cf03000000b0052348d74865sm1182071edy.61.2023.08.31.13.30.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:31:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/7] target/mips: Convert Loongson [D]MOD[U].G opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:22 +0200
Message-ID: <20230831203024.87300-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

- MOD.G - mod 32-bit signed integers
- MODU.G - mod 32-bit unsigned integers
- DMOD.G - mod 64-bit signed integers
- DMODU.G - mod 64-bit unsigned integers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/tcg/godson2.decode    |   5 ++
 target/mips/tcg/loong-ext.decode  |   5 ++
 target/mips/tcg/loong_translate.c | 111 ++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       |  82 ----------------------
 4 files changed, 121 insertions(+), 82 deletions(-)

diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
index 4352d1e5e7..e3bf6b12e4 100644
--- a/target/mips/tcg/godson2.decode
+++ b/target/mips/tcg/godson2.decode
@@ -17,3 +17,8 @@ DIV_G           011111 ..... ..... ..... 00000 011010   @rs_rt_rd
 DIVU_G          011111 ..... ..... ..... 00000 011011   @rs_rt_rd
 DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
 DDIVU_G         011111 ..... ..... ..... 00000 011111   @rs_rt_rd
+
+MOD_G           011111 ..... ..... ..... 00000 100010   @rs_rt_rd
+MODU_G          011111 ..... ..... ..... 00000 100011   @rs_rt_rd
+DMOD_G          011111 ..... ..... ..... 00000 100110   @rs_rt_rd
+DMODU_G         011111 ..... ..... ..... 00000 100111   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
index 77639227a1..d63406e3f4 100644
--- a/target/mips/tcg/loong-ext.decode
+++ b/target/mips/tcg/loong-ext.decode
@@ -18,3 +18,8 @@ DIV_G           011100 ..... ..... ..... 00000 010100   @rs_rt_rd
 DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
 DIVU_G          011100 ..... ..... ..... 00000 010110   @rs_rt_rd
 DDIVU_G         011100 ..... ..... ..... 00000 010111   @rs_rt_rd
+
+MOD_G           011100 ..... ..... ..... 00000 011100   @rs_rt_rd
+DMOD_G          011100 ..... ..... ..... 00000 011101   @rs_rt_rd
+MODU_G          011100 ..... ..... ..... 00000 011110   @rs_rt_rd
+DMODU_G         011100 ..... ..... ..... 00000 011111   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
index 87023696a0..bddf1cb7aa 100644
--- a/target/mips/tcg/loong_translate.c
+++ b/target/mips/tcg/loong_translate.c
@@ -141,6 +141,117 @@ static bool trans_DDIVU_G(DisasContext *s, arg_muldiv *a)
     return gen_lext_DIVU_G(s, a->rt, a->rs, a->rd, true);
 }
 
+static bool gen_lext_MOD_G(DisasContext *s, int rd, int rs, int rt,
+                           bool is_double)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2, *l3;
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
+    l3 = gen_new_label();
+
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
+
+    if (!is_double) {
+        tcg_gen_ext32u_tl(t0, t0);
+        tcg_gen_ext32u_tl(t1, t1);
+    }
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, is_double && TARGET_LONG_BITS == 64
+                                        ? LLONG_MIN : INT_MIN, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
+    gen_set_label(l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_br(l3);
+    gen_set_label(l2);
+    tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l3);
+
+    return true;
+}
+
+static bool trans_MOD_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MOD_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DMOD_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MOD_G(s, a->rt, a->rs, a->rd, true);
+}
+
+static bool gen_lext_MODU_G(DisasContext *s, int rd, int rs, int rt,
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
+    tcg_gen_br(l2);
+    gen_set_label(l1);
+    tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
+    if (!is_double) {
+        tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
+    }
+    gen_set_label(l2);
+
+    return true;
+}
+
+static bool trans_MODU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, false);
+}
+
+static bool trans_DMODU_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_MODU_G(s, a->rt, a->rs, a->rd, true);
+}
+
 bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
 {
     if ((ctx->insn_flags & INSN_LOONGSON2E)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index f1c99a9218..2cfabb3103 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -333,10 +333,6 @@ enum {
     OPC_DMULT_G_2F  = 0x11 | OPC_SPECIAL2,
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
-    OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
-    OPC_DMOD_G_2F   = 0x1d | OPC_SPECIAL2,
-    OPC_MODU_G_2F   = 0x1e | OPC_SPECIAL2,
-    OPC_DMODU_G_2F  = 0x1f | OPC_SPECIAL2,
     /* Misc */
     OPC_CLZ      = 0x20 | OPC_SPECIAL2,
     OPC_CLO      = 0x21 | OPC_SPECIAL2,
@@ -370,10 +366,6 @@ enum {
     OPC_MULTU_G_2E  = 0x19 | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
-    OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
-    OPC_DMOD_G_2E   = 0x26 | OPC_SPECIAL3,
-    OPC_DMODU_G_2E  = 0x27 | OPC_SPECIAL3,
 
     /* MIPS DSP Load */
     OPC_LX_DSP         = 0x0A | OPC_SPECIAL3,
@@ -3617,42 +3609,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         break;
-    case OPC_MOD_G_2E:
-    case OPC_MOD_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, INT_MIN, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1, l2);
-            gen_set_label(l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l3);
-        }
-        break;
-    case OPC_MODU_G_2E:
-    case OPC_MODU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_ext32u_tl(t0, t0);
-            tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
-            gen_set_label(l2);
-        }
-        break;
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
     case OPC_DMULT_G_2F:
@@ -3662,36 +3618,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DMOD_G_2E:
-    case OPC_DMOD_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, t1, 0, l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
-            gen_set_label(l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l3);
-        }
-        break;
-    case OPC_DMODU_G_2E:
-    case OPC_DMODU_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l2);
-            gen_set_label(l1);
-            tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l2);
-        }
-        break;
 #endif
     }
 }
@@ -13619,8 +13545,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_MULT_G_2F:
     case OPC_MULTU_G_2F:
-    case OPC_MOD_G_2F:
-    case OPC_MODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
@@ -13650,8 +13574,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DMOD_G_2F:
-    case OPC_DMODU_G_2F:
         check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
@@ -13787,8 +13709,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 
     op1 = MASK_SPECIAL3(ctx->opcode);
     switch (op1) {
-    case OPC_MOD_G_2E:
-    case OPC_MODU_G_2E:
     case OPC_MULT_G_2E:
     case OPC_MULTU_G_2E:
         /*
@@ -14055,8 +13975,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
 #if defined(TARGET_MIPS64)
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
-    case OPC_DMOD_G_2E:
-    case OPC_DMODU_G_2E:
         check_insn(ctx, INSN_LOONGSON2E);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
-- 
2.41.0



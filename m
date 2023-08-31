Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2878F414
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJb-00008E-NA; Thu, 31 Aug 2023 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJW-000077-5d
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:53 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJR-0002ef-5W
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so148691566b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513843; x=1694118643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKSl6QKl5YP3BJmK7cc1IsXPyIs5XQ30liTp3l8XloU=;
 b=l66NufsxvkoES6CdQjrhAkMlZg7aV5wpJjBTHj2db3OKKOPeEqKEF64VhW82RDagb+
 05F2zQaNezUmp89QLxLxdqL7eSjkJCeZ6zX2knjwBADGJVZhv6SLpijkmwaiyBmA6Eic
 QyTr6rrbqs0LK2ENlvTvG0GykiGavErmxb6EAVNlHBgVXKSK0gau1uipq0iiAFu1qgo3
 PrvNTuafikXn/eTWdCUsVfu7btDdB954RMFoqG9jFj01xvQw74+MhZEzFwn9eVa/hfA+
 uZMpkKnRpz1rp9eYYsU+yElCLBVlCzfDso52MIX1ypgCdTfivmOaWxytUpSsxjHsZePG
 9K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513843; x=1694118643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKSl6QKl5YP3BJmK7cc1IsXPyIs5XQ30liTp3l8XloU=;
 b=UyzVsAGv/UrqNXoLJisFiizrU+xjn2OPBI2FW/cy+J8aQFKU/yI10Bc2EVfhrHlEPE
 oS/N1AhD3lf3bzmJKbkAMGUZgABYDgW5hk5tglpgz9thSgR9H47JGPg649S8QxvaRUUV
 4HhUr8Sb2KskHboMmAqKkup3Bu45bifmB3QrhYKLZqzT/OQYd0co1dkVA0lavKRx4MIs
 BbSOaOEeadxaUN6sXzBLsLz/yRH6YrSnR75s6koPZTQCuCmbxlbjVn+/ZekB7vPF4Efo
 Pd2ShWRc1NmCM/cfGubGxG/cl6Mu/6ZdN5xVCJvbuqpNEHqllhU+uOrOIuFF+gRHaCcr
 6FoQ==
X-Gm-Message-State: AOJu0YzBclxLn/j2Kqoo6FN3QYx2lGYBaSdx5kSbojtjQ9GOtrRpaipz
 3gud53WbhsOeADO+h1Wtuc15BF8yNhcJTzI/POM=
X-Google-Smtp-Source: AGHT+IFSh/z/0Y8ezPXIqOarP5bdQ1iLv8wyAYgInQTlxd8bvcwjrkL1tsyh5czvQTcItZZfAoGN/Q==
X-Received: by 2002:a17:907:a04d:b0:99b:cd1a:a453 with SMTP id
 gz13-20020a170907a04d00b0099bcd1aa453mr280589ejc.3.1693513843347; 
 Thu, 31 Aug 2023 13:30:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a1709067c5400b00999bb1e01dfsm1123067ejp.52.2023.08.31.13.30.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/7] target/mips: Convert Loongson DDIV.G opcodes to
 decodetree
Date: Thu, 31 Aug 2023 22:30:19 +0200
Message-ID: <20230831203024.87300-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Introduce decode_loongson() to decode all Loongson vendor
specific opcodes. Start converting a single opcode: DDIV.G
(divide 64-bit signed integers).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/tcg/translate.h       |  1 +
 target/mips/tcg/godson2.decode    | 16 ++++++
 target/mips/tcg/loong-ext.decode  | 17 +++++++
 target/mips/tcg/loong_translate.c | 85 +++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 26 ++--------
 target/mips/tcg/meson.build       |  3 ++
 6 files changed, 125 insertions(+), 23 deletions(-)
 create mode 100644 target/mips/tcg/godson2.decode
 create mode 100644 target/mips/tcg/loong-ext.decode
 create mode 100644 target/mips/tcg/loong_translate.c

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index db3dc932c7..a2365c3c9a 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -220,6 +220,7 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 bool decode_isa_rel6(DisasContext *ctx, uint32_t insn);
 bool decode_ase_msa(DisasContext *ctx, uint32_t insn);
 bool decode_ext_txx9(DisasContext *ctx, uint32_t insn);
+bool decode_ext_loongson(DisasContext *ctx, uint32_t insn);
 #if defined(TARGET_MIPS64)
 bool decode_ase_lcsr(DisasContext *ctx, uint32_t insn);
 bool decode_ext_tx79(DisasContext *ctx, uint32_t insn);
diff --git a/target/mips/tcg/godson2.decode b/target/mips/tcg/godson2.decode
new file mode 100644
index 0000000000..382123cc3e
--- /dev/null
+++ b/target/mips/tcg/godson2.decode
@@ -0,0 +1,16 @@
+# Godson2 Integer instructions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference:
+#       Godson-2E Software Manual
+#       (Document Number: godson2e-user-manual-V0.6)
+#
+
+&muldiv         rs rt rd
+
+@rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
+
+DDIV_G          011111 ..... ..... ..... 00000 011110   @rs_rt_rd
diff --git a/target/mips/tcg/loong-ext.decode b/target/mips/tcg/loong-ext.decode
new file mode 100644
index 0000000000..407ca5c78b
--- /dev/null
+++ b/target/mips/tcg/loong-ext.decode
@@ -0,0 +1,17 @@
+# Loongson Extension instructions
+#
+# Copyright (C) 2021  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference:
+#       STLS2F01 User Manual
+#       Appendix A: new integer instructions
+#       (Document Number: UM0447)
+#
+
+&muldiv         rs rt rd !extern
+
+@rs_rt_rd       ...... rs:5  rt:5  rd:5  ..... ......   &muldiv
+
+DDIV_G          011100 ..... ..... ..... 00000 010101   @rs_rt_rd
diff --git a/target/mips/tcg/loong_translate.c b/target/mips/tcg/loong_translate.c
new file mode 100644
index 0000000000..bb329ef027
--- /dev/null
+++ b/target/mips/tcg/loong_translate.c
@@ -0,0 +1,85 @@
+/*
+ * MIPS Loongson translation routines
+ *
+ *  Copyright (c) 2004-2005 Jocelyn Mayer
+ *  Copyright (c) 2006 Marius Groeger (FPU operations)
+ *  Copyright (c) 2006 Thiemo Seufer (MIPS32R2 support)
+ *  Copyright (c) 2011 Richard Henderson <rth@twiddle.net>
+ *  Copyright (c) 2021 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "translate.h"
+
+/* Include the auto-generated decoder.  */
+#include "decode-godson2.c.inc"
+#include "decode-loong-ext.c.inc"
+
+/*
+ * Word or double-word Fixed-point instructions.
+ * --------------------------------------------
+ *
+ * Fixed-point multiplies and divisions write only one result
+ * into general-purpose registers.
+ */
+
+static bool gen_lext_DIV_G(DisasContext *s, int rd, int rs, int rt)
+{
+    TCGv t0, t1;
+    TCGLabel *l1, *l2, *l3;
+
+    if (TARGET_LONG_BITS != 64) {
+        return false;
+    }
+    check_mips_64(s);
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
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
+    tcg_gen_movi_tl(cpu_gpr[rd], 0);
+    tcg_gen_br(l3);
+    gen_set_label(l1);
+
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
+    tcg_gen_mov_tl(cpu_gpr[rd], t0);
+
+    tcg_gen_br(l3);
+    gen_set_label(l2);
+    tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
+    gen_set_label(l3);
+
+    return true;
+}
+
+static bool trans_DDIV_G(DisasContext *s, arg_muldiv *a)
+{
+    return gen_lext_DIV_G(s, a->rt, a->rs, a->rd);
+}
+
+bool decode_ext_loongson(DisasContext *ctx, uint32_t insn)
+{
+    if ((ctx->insn_flags & INSN_LOONGSON2E)
+            && decode_godson2(ctx, ctx->opcode)) {
+        return true;
+    }
+    if ((ctx->insn_flags & ASE_LEXT)
+            && decode_loong_ext(ctx, ctx->opcode)) {
+        return true;
+    }
+    return false;
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 19e73aea60..42be1689c2 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -334,7 +334,6 @@ enum {
     OPC_MULTU_G_2F  = 0x12 | OPC_SPECIAL2,
     OPC_DMULTU_G_2F = 0x13 | OPC_SPECIAL2,
     OPC_DIV_G_2F    = 0x14 | OPC_SPECIAL2,
-    OPC_DDIV_G_2F   = 0x15 | OPC_SPECIAL2,
     OPC_DIVU_G_2F   = 0x16 | OPC_SPECIAL2,
     OPC_DDIVU_G_2F  = 0x17 | OPC_SPECIAL2,
     OPC_MOD_G_2F    = 0x1c | OPC_SPECIAL2,
@@ -376,7 +375,6 @@ enum {
     OPC_DIVU_G_2E   = 0x1B | OPC_SPECIAL3,
     OPC_DMULT_G_2E  = 0x1C | OPC_SPECIAL3,
     OPC_DMULTU_G_2E = 0x1D | OPC_SPECIAL3,
-    OPC_DDIV_G_2E   = 0x1E | OPC_SPECIAL3,
     OPC_DDIVU_G_2E  = 0x1F | OPC_SPECIAL3,
     OPC_MOD_G_2E    = 0x22 | OPC_SPECIAL3,
     OPC_MODU_G_2E   = 0x23 | OPC_SPECIAL3,
@@ -3708,25 +3706,6 @@ static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
     case OPC_DMULTU_G_2F:
         tcg_gen_mul_tl(cpu_gpr[rd], t0, t1);
         break;
-    case OPC_DDIV_G_2E:
-    case OPC_DDIV_G_2F:
-        {
-            TCGLabel *l1 = gen_new_label();
-            TCGLabel *l2 = gen_new_label();
-            TCGLabel *l3 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, 0, l1);
-            tcg_gen_movi_tl(cpu_gpr[rd], 0);
-            tcg_gen_br(l3);
-            gen_set_label(l1);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t0, -1LL << 63, l2);
-            tcg_gen_brcondi_tl(TCG_COND_NE, t1, -1LL, l2);
-            tcg_gen_mov_tl(cpu_gpr[rd], t0);
-            tcg_gen_br(l3);
-            gen_set_label(l2);
-            tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
-            gen_set_label(l3);
-        }
-        break;
     case OPC_DDIVU_G_2E:
     case OPC_DDIVU_G_2F:
         {
@@ -13730,7 +13709,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_DMULT_G_2F:
     case OPC_DMULTU_G_2F:
-    case OPC_DDIV_G_2F:
     case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
@@ -14137,7 +14115,6 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
 #if defined(TARGET_MIPS64)
-    case OPC_DDIV_G_2E:
     case OPC_DDIVU_G_2E:
     case OPC_DMULT_G_2E:
     case OPC_DMULTU_G_2E:
@@ -15338,6 +15315,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     if (cpu_supports_isa(env, INSN_VR54XX) && decode_ext_vr54xx(ctx, ctx->opcode)) {
         return;
     }
+    if (decode_ext_loongson(ctx, ctx->opcode)) {
+        return;
+    }
 #if defined(TARGET_MIPS64)
     if (ase_lcsr_available(env) && decode_ase_lcsr(ctx, ctx->opcode)) {
         return;
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index ea7fb582f2..fbb6d6eb40 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -1,4 +1,6 @@
 gen = [
+  decodetree.process('godson2.decode', extra_args: ['--static-decode=decode_godson2']),
+  decodetree.process('loong-ext.decode', extra_args: ['--static-decode=decode_loong_ext']),
   decodetree.process('rel6.decode', extra_args: ['--decode=decode_isa_rel6']),
   decodetree.process('msa.decode', extra_args: '--decode=decode_ase_msa'),
   decodetree.process('tx79.decode', extra_args: '--static-decode=decode_tx79'),
@@ -14,6 +16,7 @@ mips_ss.add(files(
   'fpu_helper.c',
   'ldst_helper.c',
   'lmmi_helper.c',
+  'loong_translate.c',
   'msa_helper.c',
   'msa_translate.c',
   'op_helper.c',
-- 
2.41.0



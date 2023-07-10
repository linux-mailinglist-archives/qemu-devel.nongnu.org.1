Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401F74D5B8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5t-0003w9-Pb; Mon, 10 Jul 2023 08:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5S-0002sW-Bg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:54 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5Q-0004lO-7T
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:53 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b71ee710edso3435093a34.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992430; x=1691584430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQxYbMezeKcP81hnejfiLTemwrNY77nZj5X+R7SzIjI=;
 b=TYkiQhDxOTFjGDo3yGZBTboJeDZcedwkLiRFn7dELDARe23jKojvnR+hXyQlxleMoL
 CRE3kq5CGZHTHiTJiB195LoJFpo+LtbEZdxJRFa3qOWOKgcGZLnRM6lQal9eVpiPQQjk
 i+uKwgRfjFZrll7gqySQdQ+B6EvOdr7UyGNZzvHhj4WJ0bgIo5rkjGaVD8U1piczmYLS
 1BsHMQrz9Ginrk0YdmAa6EenEWsAGO5YM4ybL8TMsKklPbW6CxGrEY2dtDJk/cOozwYT
 4bD/JPNeIrEPp9NaL8ccJoJ2j/SgsPnPsIQiiVPah1V4qEMaSRwClRSEkDrsVQrGEeQS
 DI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992430; x=1691584430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQxYbMezeKcP81hnejfiLTemwrNY77nZj5X+R7SzIjI=;
 b=UMulO5jAdEkmB9UM8lPZJFP7uIXb826qkb6IHMueSg0hrayuggZlUXHhaAcbj9D1r4
 X6AKezasBAD/UWSNcPGHa4mhTobcJYj3SByjYAKwSFPA1/IEchBlSORB8B0PxymQh36d
 B2iol7o/j3AIq2RcVyh85LSgrJKX7F9VkPJ1fixlbNbdG/3U8VsZWY1qQySTM5al1wFk
 vBpfc2jiJzF0ZewXjHdr9u60HGRZdENdg1YmM8DaC0pksWHbMm4dx8wo5efRcmqrz5ZZ
 tk6d3aHjOxrZjO79vwuTS/ESNH7q/ai/jkTAQHFkz5xlhaxwWVkON5JDUDoxTawcWf7L
 ntjg==
X-Gm-Message-State: ABy/qLaHOtdc+yPFb7ztlevRa5DJ22xLAyzOBP4Urn8gERWpj/Xj3dsl
 kM8HmSiXH8HxPq97Tswcr5fXOF+CLB6FMw==
X-Google-Smtp-Source: APBJJlFun4Z8tdBrmwvF5+n3RhwO2aGay6402xuwQ6PHaqkZa5PbhLj6P6hqJn08lKydV72r4zAg3A==
X-Received: by 2002:a9d:751a:0:b0:6b7:45de:d533 with SMTP id
 r26-20020a9d751a000000b006b745ded533mr10560950otk.9.1688992430009; 
 Mon, 10 Jul 2023 05:33:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/54] target/riscv: Add support for Zfbfmin extension
Date: Mon, 10 Jul 2023 22:31:37 +1000
Message-Id: <20230710123205.2441106-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Add trans_* and helper function for Zfbfmin instructions.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230615063302.102409-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                      |  4 ++
 target/riscv/insn32.decode                 |  4 ++
 target/riscv/fpu_helper.c                  | 12 +++++
 target/riscv/translate.c                   |  1 +
 target/riscv/insn_trans/trans_rvbf16.c.inc | 53 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvzfh.c.inc  | 12 ++---
 6 files changed, 80 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvbf16.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 98e97810fd..ef8487f1ee 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1153,3 +1153,7 @@ DEF_HELPER_FLAGS_3(sm4ks, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
 
 /* Zce helper */
 DEF_HELPER_FLAGS_2(cm_jalt, TCG_CALL_NO_WG, tl, env, i32)
+
+/* BF16 functions */
+DEF_HELPER_FLAGS_2(fcvt_bf16_s, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(fcvt_s_bf16, TCG_CALL_NO_RWG, i64, env, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 73d5d1b045..45fdcad185 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -908,3 +908,7 @@ sm4ks       .. 11010 ..... ..... 000 ..... 0110011 @k_aes
 # *** RV32 Zicond Standard Extension ***
 czero_eqz   0000111  ..... ..... 101 ..... 0110011 @r
 czero_nez   0000111  ..... ..... 111 ..... 0110011 @r
+
+# *** Zfbfmin Standard Extension ***
+fcvt_bf16_s       0100010  01000 ..... ... ..... 1010011 @r2_rm
+fcvt_s_bf16       0100000  00110 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 5dd14d8390..eb5ee5c4c9 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -593,3 +593,15 @@ uint64_t helper_fcvt_d_h(CPURISCVState *env, uint64_t rs1)
     float16 frs1 = check_nanbox_h(env, rs1);
     return float16_to_float64(frs1, true, &env->fp_status);
 }
+
+uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint64_t rs1)
+{
+    float32 frs1 = check_nanbox_s(env, rs1);
+    return nanbox_h(env, float32_to_bfloat16(frs1, &env->fp_status));
+}
+
+uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
+{
+    float16 frs1 = check_nanbox_h(env, rs1);
+    return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 98d54c5617..621dd99241 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1095,6 +1095,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvk.c.inc"
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
+#include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
new file mode 100644
index 0000000000..8cafde505f
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -0,0 +1,53 @@
+/*
+ * RISC-V translation routines for the BF16 Standard Extensions.
+ *
+ * Copyright (c) 2020-2023 PLCT Lab
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZFBFMIN(ctx) do { \
+    if (!ctx->cfg_ptr->ext_zfbfmin) { \
+        return false; \
+    } \
+} while (0)
+
+static bool trans_fcvt_bf16_s(DisasContext *ctx, arg_fcvt_bf16_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFBFMIN(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_bf16_s(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+    mark_fs_dirty(ctx);
+    return true;
+}
+
+static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZFBFMIN(ctx);
+
+    TCGv_i64 dest = dest_fpr(ctx, a->rd);
+    TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_bf16(dest, cpu_env, src1);
+    gen_set_fpr_hs(ctx, a->rd, dest);
+    mark_fs_dirty(ctx);
+    return true;
+}
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 74dde37ff7..8b1e2519bb 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -28,8 +28,8 @@
     }                                  \
 } while (0)
 
-#define REQUIRE_ZFHMIN(ctx) do {              \
-    if (!ctx->cfg_ptr->ext_zfhmin) {          \
+#define REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx) do {   \
+    if (!ctx->cfg_ptr->ext_zfhmin && !ctx->cfg_ptr->ext_zfbfmin) { \
         return false;                         \
     }                                         \
 } while (0)
@@ -46,7 +46,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     TCGv t0;
 
     REQUIRE_FPU;
-    REQUIRE_ZFHMIN(ctx);
+    REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     decode_save_opc(ctx);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -69,7 +69,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     TCGv t0;
 
     REQUIRE_FPU;
-    REQUIRE_ZFHMIN(ctx);
+    REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     decode_save_opc(ctx);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -574,7 +574,7 @@ static bool trans_fcvt_h_wu(DisasContext *ctx, arg_fcvt_h_wu *a)
 static bool trans_fmv_x_h(DisasContext *ctx, arg_fmv_x_h *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZFHMIN(ctx);
+    REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     TCGv dest = dest_gpr(ctx, a->rd);
 
@@ -594,7 +594,7 @@ static bool trans_fmv_x_h(DisasContext *ctx, arg_fmv_x_h *a)
 static bool trans_fmv_h_x(DisasContext *ctx, arg_fmv_h_x *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZFHMIN(ctx);
+    REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     TCGv t0 = get_gpr(ctx, a->rs1, EXT_ZERO);
 
-- 
2.40.1



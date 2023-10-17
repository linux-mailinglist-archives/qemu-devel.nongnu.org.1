Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26957CBB37
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNr-0003Tg-7N; Tue, 17 Oct 2023 02:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNo-0003Pn-Dd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-0004k0-JA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so3141623b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523395; x=1698128195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYU619EhmiJiMok1HjhepJqZxdbfU7SP1HHHFGCJg74=;
 b=yVvqIjlm6bFnGU5eEFp6q54BxfV2hE3Z4FZb6rf27hoWKvzOPitoLxu/L/+GrkzYQt
 b8yQOtkoRayire2ahMmf/1wBO1eCujuU5qmUS5rN5Gr5S8mPRq7URJAVuV2kS4uRy8M7
 ZvqAhCJtMiCIr5Y21n/qjoVcB7S/Qr/Jyn5/2nAv522HF0R+m5ZbE5XGVrNQt1YCZbIh
 V2RimTppojvAJy5tSEp9VQERWpTNyHpGbawVpdGnzoki4ZcRl39QlWrVJpv3hv1Vy9l3
 cXx7ejyH0pEmcPerEsvvetqiJkXC800rAXTuOYEpLKqiRBDmWn8hOK58PpQo29HNRd8d
 Y6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523395; x=1698128195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYU619EhmiJiMok1HjhepJqZxdbfU7SP1HHHFGCJg74=;
 b=e/rorElzIzDxTktUk3guWFs0B5tzPLFOVN8GLlRTjnJ22OC0nfsydHS4UditmjXl2j
 dZEcCUwyIsM4AoLhUjYfcVAAxs2j6AQmFHhGO9gXKggYgTOImeoAq51Ik3SnKKRxfZAN
 FkIkLyHurEyAGyaDBTFFmEO2+W45lTj/Wv4AMbR1QiSXfUw3hvBCP791JCZrCeXBxIFF
 j3Bf2QRNNII4jdyyMqbAO1Ub4ZFKNPJjaAAthzCy9ptX4hZzEUwtdJQNUetAdlVHzZFX
 TzxQMTYXylvNvPZlzBCRhIhFDQvXIq+8y3aCoDXF9qxwmTyUGv4rT/XmXhP2ogtsQsts
 1s4g==
X-Gm-Message-State: AOJu0YxdL1KsE37oUGTNHlv07sXoc3+ngbVknPGxeANmLxukoG1zyTBt
 L+RhgwVyrZqTLh6RRiMZjW/Isv+bPX8BwmYtPo8=
X-Google-Smtp-Source: AGHT+IE5Mo8dXtA6uq8NdgnXrqydaSu3myk6fRXg4ecfrbGQPz8mpz3Lvc4gVQ5ECoyoEcRnRlNCQw==
X-Received: by 2002:a05:6a00:21cc:b0:6b1:cc77:4d2 with SMTP id
 t12-20020a056a0021cc00b006b1cc7704d2mr1444785pfj.15.1697523395643; 
 Mon, 16 Oct 2023 23:16:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 60/90] target/sparc: Move ARRAY* to decodetree
Date: Mon, 16 Oct 2023 23:12:14 -0700
Message-Id: <20231017061244.681584-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 ++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fb104e77d1..07a84b109c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -241,6 +241,10 @@ RETRY       10 00001 111110 00000 0 0000000000000
     EDGE32N     10 ..... 110110 ..... 0 0000 1001 .....    @r_r_r
     EDGE32Lcc   10 ..... 110110 ..... 0 0000 1010 .....    @r_r_r
     EDGE32LN    10 ..... 110110 ..... 0 0000 1011 .....    @r_r_r
+
+    ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
+    ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
+    ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5145692885..87f3ab27b1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,6 +72,10 @@ static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
     g_assert_not_reached();
 }
 # endif
+static void gen_helper_array8(TCGv r, TCGv a, TCGv b)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -679,6 +683,18 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+static void gen_op_array16(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 1);
+}
+
+static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4302,6 +4318,22 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv, TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src1 = gen_load_gpr(dc, a->rs1);
+    TCGv src2 = gen_load_gpr(dc, a->rs2);
+
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
+TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
+TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5199,30 +5231,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x009: /* VIS II edge32n */
                 case 0x00a: /* VIS I edge32lcc */
                 case 0x00b: /* VIS II edge32ln */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x010: /* VIS I array8 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x012: /* VIS I array16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x014: /* VIS I array32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1



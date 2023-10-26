Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25577D797B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAh-00071n-Em; Wed, 25 Oct 2023 20:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9d-0002tr-2c
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9P-0008Cf-0Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d1fa1c787so216584a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279780; x=1698884580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9qerMvCajXmsDh07rrL/xuRlXNT8gncm0ZxsFLAfDY=;
 b=d8xzdpiRvz/+7OlP5pvlJBZKuVrTzuu+3FuTKboHeWwABoMszCe2veHKX9gibqJ1z5
 BHNgbp7AVue2UanSihW5/M6vBXn/vZY6gcr6cQVDY89w0b2gGEpnZI/QmH2cXeYJofHe
 bQIfrcxVN2PnUkAUebsoan2NycGc2HTQ7zrlVtFdkteXBvp9FM+vHkcn8F3iTrmdEsS8
 dFsWf4pY1s5yeuzo1i+OK4XKcMDgYVr4+M7FA+YEdu3qZSoF9NOPSHhF2YwjqahnFoqY
 o3pmRCE8X7C/cMxByBt8py82XO764Qj+pj9nGLPGocZOHkAIXTzOzHtk53+Z77KOQwJY
 7mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279780; x=1698884580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9qerMvCajXmsDh07rrL/xuRlXNT8gncm0ZxsFLAfDY=;
 b=cBDIcSi/lboMeCK3g2VmHdO6C3sbxsFc+7Wqdb3OjLVReyXMfcHSAF0CwJ5PR2L0Yu
 XZgye4z71i0Gn0l01Z/yNlxJtYARN3ORz1aBvWU+fK/8xoE25ynd6xzVDxCToNpcM7h1
 hqHGO0W1Fy81CcxOF832y6AcobMVGGsLdR0RkpiDGFoli+fFkTv9P4rcGXruicTZk5ho
 69MGv4xYC2s4tvnYmqTEQiC7a7WDZZFvm/znBmDQV3s56SvVyC1Lt5bM9KI8JyXNFreg
 ivi8h9svnS8lfiXhplIZ7x1+2mU6S9qSb5aAxmSfrLyCmQzAanA0FosXa2L3QTlVZQfa
 d6Ig==
X-Gm-Message-State: AOJu0YxGsjGhswLRNH6GrEZ8v2IEZNa638ewmswBWrbpmzvJ9bcoXyDZ
 uAyrM2JG/aNGN6ZrzN/ipeCWGgO/CZ+7h5S3yEo=
X-Google-Smtp-Source: AGHT+IE1WfP4bDOAEgJx2fkzC/IWf5GknORM0b9OpVAHYHq6EWVDQoGf+dvM+UryUa1ea0Is99g7Ag==
X-Received: by 2002:a17:90a:186:b0:27f:f260:ceaf with SMTP id
 6-20020a17090a018600b0027ff260ceafmr785180pjc.10.1698279780581; 
 Wed, 25 Oct 2023 17:23:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 64/94] target/sparc: Move ARRAY* to decodetree
Date: Wed, 25 Oct 2023 17:15:12 -0700
Message-Id: <20231026001542.1141412-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 57 ++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a9630509bd..b15ede5fd4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,10 @@ RETRY       10 00001 111110 00000 0 0000000000000
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
index 2f38453dc6..d40d664f16 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -722,6 +722,25 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+#ifndef TARGET_SPARC64
+static void gen_helper_array8(TCGv dst, TCGv src1, TCGv src2)
+{
+    g_assert_not_reached();
+}
+#endif
+
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
@@ -4211,6 +4230,22 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
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
@@ -5110,30 +5145,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



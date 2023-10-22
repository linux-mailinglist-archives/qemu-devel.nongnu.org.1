Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973EF7D2743
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx0-0006Uh-Fa; Sun, 22 Oct 2023 19:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwr-00061P-QI
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:33 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwo-0007el-Hl
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:33 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b2e4107f47so2107449b6e.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017609; x=1698622409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A+/aEu5nKFoGGCuyAZNsBHVSALjs1p5PFLe8pYDYdY=;
 b=NN/+ODYesPDwA+30QsMnnehiufVrKiDiIquKuUowVC9b4tzRGgfk4Q1uxsG0p27Lz8
 ok4i5CWJtPtGVMW+Kpm12XumLnkNSqYAMVOZvLo8Z/YyOeb48JwA4ZliqCcq0XoUMBGO
 GCOTYK6BCI6sOtLB0LLy1/OBRyLgVXpoNHA0ODoMIZ+nOw4cGqDx/zd3WBGb2D9OYx1A
 hiRlWybRJtxQGoaI0wpewBd5PaI0S8LNomn1PPxmai83d5EyyC0w0KCqmufWGEduPbIu
 qBgae3r0qSawoDMD9uG8fhhcI09omaGdTl2DaSMJC6hhBk/G4IGbFskQEu+L9qTPlfSw
 qd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017609; x=1698622409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A+/aEu5nKFoGGCuyAZNsBHVSALjs1p5PFLe8pYDYdY=;
 b=F9KlT8BSolFDtr/DGITw2g32To3RVbAF7XPCWe7HH2GYI/Lj6Zh86DVBYc0phjUprg
 AOm/7rkE5du1/8rFwEk4no2SnU6tJv9sOQqkTfRWJvAOX9ozBjmsNYSp/kU6tZXQ48PW
 Huz3xY3JBp7uPNU8iln+XzkBs5HAuunU93uAnU/a3v+OKKijX01bjBtpAxZyHO7cx8uJ
 t8OrBujP00Stkwtx/am5vL5AHgId+Gz4uSMmS+AUlgu7CNdnqMioElwUMR1hzdN4U0PR
 tTD4JM2H2ENJcoZXTlRQF0d1DsX+5N/5SLuBcx1BX0ql0UEFYy7q7tRe5PiEZ7/U/v4S
 cMlQ==
X-Gm-Message-State: AOJu0Ywls65rEd2kaJO3Q7nvprI6vZ80RLiIwKf2Kj6bbPJP9uDVuXyK
 gchCJ9I8x0Xj5ZbzKSVHGOM9jLuxIYtGT+q7f5E=
X-Google-Smtp-Source: AGHT+IF7XXUcrqsfSNveotC//BmOoJlJt7aac46+fZtjvr+gk1Lh7x51QgJvlJ1Ee3PIWNny/Xs7IQ==
X-Received: by 2002:a05:6808:1305:b0:3af:63ad:a610 with SMTP id
 y5-20020a056808130500b003af63ada610mr13198422oiv.14.1698017608981; 
 Sun, 22 Oct 2023 16:33:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 65/94] target/sparc: Move ADDRALIGN* to decodetree
Date: Sun, 22 Oct 2023 16:29:03 -0700
Message-Id: <20231022232932.80507-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b15ede5fd4..f70423895e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -252,6 +252,9 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
+
+    ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
+    ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index be298f185e..6a8835b8cc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2747,18 +2747,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
     }
 }
 
-static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-{
-    TCGv tmp = tcg_temp_new();
-
-    tcg_gen_add_tl(tmp, s1, s2);
-    tcg_gen_andi_tl(dst, tmp, -8);
-    if (left) {
-        tcg_gen_neg_tl(tmp, tmp);
-    }
-    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
-}
-
 static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 {
     TCGv t1, t2, shift;
@@ -4243,6 +4231,36 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_neg_tl(tmp, tmp);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
+TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5145,21 +5163,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x010: /* VIS I array8 */
                 case 0x012: /* VIS I array16 */
                 case 0x014: /* VIS I array32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x01a: /* VIS I alignaddrl */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
                     CHECK_FPU_FEATURE(dc, VIS2);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1



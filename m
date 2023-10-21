Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF6A7D1B16
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eU-00036R-I1; Sat, 21 Oct 2023 01:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eP-0002ow-IF
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eN-00018X-RR
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso1492093b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866550; x=1698471350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb+DvB0lLnt7NappAJ/SRfdu6K3CtLmlY5bIBc8m9M8=;
 b=k7msuq3aa/qSxlCBzAF2U4LxES5NH85y3LVTZE9VSjM9KaMI7shX94fEEeX202xKew
 94+lswDYTiAclmI5ClCNVxekrNUBKCNusiY5KeP+hBid1QVbH1DuU0qufP546UCdY2rW
 wkD0S870OlgxFGTQAIx/zYrkuKMVInUFMWhwz2VVqRAslmcqUVJMGmVjJZZ29g4+wg3f
 FusJ8Chy6HjipmJ4ESjAei5sI34mFswWDeXZhK7cyLadghrb1X5PfLsHPdw/rj9zMOJL
 I+5yq7/wLWOE/IVI2Lnp/XnwfqaTLQtTX1OHjmpnZPji2I1OItRwd7O3KYZJB+Z+1k/h
 dgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866550; x=1698471350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb+DvB0lLnt7NappAJ/SRfdu6K3CtLmlY5bIBc8m9M8=;
 b=G49kYagyjjENBzVVCElM0uerJJ5DM5dFw9+jSctfyeSS5lG/+L+trN/GrnQHnqSI5J
 qvfdIORXcUzSF6OKopkhXepNCT4p0vMdnRWYm1UoRYaK5/hNVcgnZZ4ElG1fofQJh0PP
 DNTJ8GKzPZHihaEqs7Bd9PYkwxu5N4oXrMHFt6lKDjzwljYnNeS/QbJZ7XJcljv6LHMg
 qoO3AKGxtNNtriL0vyblh2iN+Tn4jTJ9NrYZ8rvYOvzMe9uTPmDjJwJq3lKcVIdiQmXf
 Vf0elDH+30KAjaQr/XT9o1qSpDnjiGRJABLTTz++aitfW1MJsemuAxtfpxSU937Ys1Rc
 kcTg==
X-Gm-Message-State: AOJu0Yy5DA5Xp3aV8Cx96+voOzEjcEE38KwcDrLCWoP7ziDuIKTS5i+W
 6l1NMP6R7mtyXHV4mjGeLsh+judeVJBfzdBz9eM=
X-Google-Smtp-Source: AGHT+IHSSke51CN+DLBpMKNk1bEmF56np9aE2m2sUDQyJVumfwOZSW8UCleee9c8pQtu37b9XjJDgg==
X-Received: by 2002:a05:6a20:5481:b0:173:e36c:6d03 with SMTP id
 i1-20020a056a20548100b00173e36c6d03mr4829260pzk.22.1697866550466; 
 Fri, 20 Oct 2023 22:35:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 61/90] target/sparc: Move ADDRALIGN* to decodetree
Date: Fri, 20 Oct 2023 22:31:29 -0700
Message-Id: <20231021053158.278135-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1262b5c7bb..855627b55e 100644
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
index 73c9806119..92a6988fae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2727,18 +2727,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
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
@@ -4352,6 +4340,36 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
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
@@ -5265,21 +5283,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



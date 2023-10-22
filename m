Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F67D2170
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbQ-0004pU-RT; Sun, 22 Oct 2023 02:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaV-000375-0i
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaE-0002LF-VN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:21 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2209381b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954705; x=1698559505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJtaWlcxrarLCoB15zwusHSxvRo75ARkuqoEtKfRk/k=;
 b=nu+GbKga92BzynyFHSL+oeonWve4i+RSowHt3d+1xXQnJa03r19oUQphqncTI6zzqy
 XGJ4Hk19NbNYHcvh26toN1en7jfKM3B5SJ5qai+vbjtmaxVDtdbjKTVT+ISedCBsvFhi
 G0bjTkCzEbRFuCZuzNbuKl1xjFJTgpw29JoGow8oyPB0OtB8fH6nPU5Be4Xjq3DXZpVZ
 EO6EgAWh36RW4kV+sOPXna3eHaqHYod1VpRZkny7ZYZwjR7sIYvmLPV4NxxANeLtmZFX
 v84FfCXgFN/BXfnWzB6zuqK+QRasOzD8HN1gllckoppKsQowzS9M3n1ARe4pKW7YtT6e
 O/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954705; x=1698559505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJtaWlcxrarLCoB15zwusHSxvRo75ARkuqoEtKfRk/k=;
 b=ECgx5xswDhu5IgeB8DFfjZeHmuAm4QLFclsaA9i9vvQFxwPvClYrP5syTmDYJ4BPcT
 zQVJ6g1JM1r+lqqfPeshstd/ZRFaVGBusyLKj4rYreTR6lEts3NK6pcCpY13E0KNsWZ0
 tCo4DwsBWbcVUKx6VhACR+MIGKCVGfqIMuCuvl/gv+xTWB7tcBF2YxUAtviNuwHTc3oN
 XAsIDz+n/+gakfwQhtKaeKZpBox7FeNE22zIQGhcy0mJ587nsKDr5ik8eawXjh+AIgsJ
 CP0yK8PN+Eq0F70mNZ6HNS0nah8jgVLYGFytI1aWzVJZR6aJ+FkJUw95cSrbM5Np/pKP
 goYA==
X-Gm-Message-State: AOJu0Yx+D8laDwUPzLYtY8pYtPih/dQOoOhWi5UOlJE9Q+taQRSmpJuN
 ov+DrJwfiuYQaNENLZiQpL+2O9x65txM86QAZMI=
X-Google-Smtp-Source: AGHT+IE0TsLneqGeatN4EYM4gQN6/TMYINb2LTwMjh0vuMrWNodgWc71ShXj6oOLwhreATloDxdRnQ==
X-Received: by 2002:a05:6a00:2e97:b0:692:a727:1fdd with SMTP id
 fd23-20020a056a002e9700b00692a7271fddmr7680283pfb.4.1697954705086; 
 Sat, 21 Oct 2023 23:05:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 75/90] target/sparc: Move gen_fop_QQQ insns to decodetree
Date: Sat, 21 Oct 2023 23:00:16 -0700
Message-Id: <20231022060031.490251-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move FADDq, FSUBq, FMULq, FDIVq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 52 +++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a429c04980..f18fd99476 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -250,12 +250,16 @@ FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
 FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
+FADDq       10 ..... 110100 ..... 0 0100 0011 .....        @r_r_r
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
 FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
+FSUBq       10 ..... 110100 ..... 0 0100 0111 .....        @r_r_r
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
 FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
+FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
+FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e0990a021..47f4d0b51c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1666,19 +1666,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_QQQ(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_ptr))
-{
-    gen_op_load_fpr_QT0(QFPREG(rs1));
-    gen_op_load_fpr_QT1(QFPREG(rs2));
-
-    gen(tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 static void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -5125,6 +5112,31 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
 
+static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_env))
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT0(QFPREG(a->rs1));
+    gen_op_load_fpr_QT1(QFPREG(a->rs2));
+    func(tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FADDq, ALL, do_env_qqq, a, gen_helper_faddq)
+TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
+TRANS(FMULq, ALL, do_env_qqq, a, gen_helper_fmulq)
+TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5186,23 +5198,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x46: /* fsubd */
                 case 0x4a: /* fmuld */
                 case 0x4e: /* fdivd */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x43: /* faddq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
-                    break;
                 case 0x47: /* fsubq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
-                    break;
                 case 0x4b: /* fmulq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
-                    break;
                 case 0x4f: /* fdivq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fdivq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x69: /* fsmuld */
                     CHECK_FPU_FEATURE(dc, FSMULD);
                     gen_fop_DFF(dc, rd, rs1, rs2, gen_helper_fsmuld);
-- 
2.34.1



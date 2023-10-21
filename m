Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680547D1B43
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ed-0003NL-Pl; Sat, 21 Oct 2023 01:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eb-0003ME-Ho
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:05 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eZ-0001Bs-R2
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:05 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b3ec45d6e9so1049637b6e.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866563; x=1698471363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWQPa1xkvAE0evkU5c5okd/SkRFosIL5vzLP7/DZtnE=;
 b=m181vhPtxuGR3U/rkEuqVOH5QWbc1k7074csyoGd5+qLwrtZlg8dJZuLB9NXzV1Nb8
 JyW2GPX7lbufgtCZQUL4FLaT4+BYh9eOv34JM3DAR/6I/KAIjQLCOr6dtmadXrJyOQCr
 gpkOP9qXHip2oyrh2YNNKxvTu/HqvboYr1IIViTahebG+Lg87gBuXSSkFsRBXwjCixnN
 XpTqC+0AtoixHsqN+vlhrMN5g/RD+kCdMjhQbWP4TU4UNk/KOIc+HbR7EBrbftvqcytG
 iuRqzc1d+bRUHwRgY3gGxC+Qn1N/Y6Fjdnxq/HbqZXhrLK06RkgJXQbuTJCKmLqzPcf2
 IZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866563; x=1698471363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWQPa1xkvAE0evkU5c5okd/SkRFosIL5vzLP7/DZtnE=;
 b=iLvLMpWX/bg0CwW55eOhF67Sv4b9pXZPKCVvs1xKoMkqiOLIrD6OZBRoIDyirweG7z
 ORS0Y9bQFPyLszwyJ22wGyM5LUMWdcery/40CsKxZYlTNk2unPUnBi1UNzyzJg0zjnrk
 6RDxh0LJqoE+KnNpYnbvXp5dJuyywHEPrznMUZRlm5Dq9L4g323IxoWdtjE78LQZAiVA
 yOoSAIv1Z6bcaC0NxhHXzqDz1HjheDFMoDO1mnRtzccZq9zP99t+v2Rcnb3jbEpULHQH
 ZmctqvV1PSEu6wOOyw0ggKOdZ08VueNIqgSU+zwlyuBkMY4nwwpcP9f2uJxkbvmH9I+6
 89fw==
X-Gm-Message-State: AOJu0YxV2YVkuF3tbDKrGvFH5B/Imj33HXKWtNTGU6I5Kt2HXrNU/0+9
 q7i4M9cw7JUeVE+seLm5M47LwLf0ssN1lhURDeg=
X-Google-Smtp-Source: AGHT+IHjgMZVTArnG5BtY6XfxuB2W8yAwYpyQKNDrDJW7JqXnZMUNAqB4IvGPGGyjHrULj9WAKVllg==
X-Received: by 2002:a05:6808:291:b0:3a8:29a9:e4d0 with SMTP id
 z17-20020a056808029100b003a829a9e4d0mr4112224oic.34.1697866562855; 
 Fri, 20 Oct 2023 22:36:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 75/90] target/sparc: Move gen_fop_QQQ insns to decodetree
Date: Fri, 20 Oct 2023 22:31:43 -0700
Message-Id: <20231021053158.278135-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Move FADDq, FSUBq, FMULq, FDIVq.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 52 +++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e616cb1e69..0753bbef2d 100644
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
index 53a42fe1a5..8ce0282e2b 100644
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
@@ -5082,6 +5069,31 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 
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
@@ -5143,23 +5155,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



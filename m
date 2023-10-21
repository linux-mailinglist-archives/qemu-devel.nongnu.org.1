Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060507D1B22
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ef-0003Sh-8M; Sat, 21 Oct 2023 01:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ec-0003Mv-LG
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:06 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ea-0001C5-V7
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:06 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1e9ac336589so1083321fac.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866563; x=1698471363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3dFbMPBfErSyYzkRLjzl07OW9e6RTTV25K8JcLqjoo=;
 b=eQgNqnfPZn5fQSV62LOq707TfmZQUOhxmnvHwJIK4DQtbkBMeRBed7CyyRiWsPG5fl
 RwU0KXkIIyeUQ8RSjNeKAyzCLPfoi6043eMHQ7B9Lnmbj0PbNvhSDk67t/L1SzkZ3eSH
 iezRn69lucQKHRubyy/8Y3yQmsCyMl/0eGLG2ARHsWUPHbBPefjZ+foKTuMW+uHoRVNT
 TOR4+3PqphL88Boy8Xanc/WpLPbfGln3/A23BbtTEfK4tv/ziqAGlPZPUxkdFIV8G9KW
 UtbepssET+9CHrr9woZ+Hhlf74159UwFixkpqWs2HcRX0iY3PUyHYiU17ldp3UUzgJ9G
 rs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866563; x=1698471363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3dFbMPBfErSyYzkRLjzl07OW9e6RTTV25K8JcLqjoo=;
 b=l5wJq7cIChoHX/Hz94JrDLU4sJCa4RliCcS2kp6YvPpFgBcjzhH4MsSR3dacqyvWae
 Tth7j9A2FbZBVgFfPHWsv1/nXAPANzDs/KIaYp892Fo3QGuBP5kNC14Xe4kgNdnY0U7j
 pvJHHarNY13tj0LFj2UYuGz4H1Ed/4GiCCC4HW2Urf3gp3FnXiEcEBC73zoSCDzJex9F
 GkjHw6vfJsFTR2roj2RorTI9nlK04TMWjvFftTlQStIhjm6MCzI4NabbhqzCl0rRDMyH
 guOefYyFcdvNpui7/XlRsK+4uDC3v+gJkPzGcCr65LZc3Ew3Rg+P1SHUyz0IgXMkM+KR
 idxg==
X-Gm-Message-State: AOJu0YwTP7GwVTUN08dox49VfhVnZC2IhHG3gSt6BK5N7RFswlJrvA1q
 a1jNj8xwCds/Crky1pvVlZdtQ9To86kyHuAOlXo=
X-Google-Smtp-Source: AGHT+IEzZV98OP20Y+XoQF4uFeBWi9g2FIOC6jmXMuImOK2BshPazm13IgU4kYRp9NvD4SDihLAoAA==
X-Received: by 2002:a05:6870:ed94:b0:1e9:b2a7:9a38 with SMTP id
 fz20-20020a056870ed9400b001e9b2a79a38mr5150665oab.43.1697866563678; 
 Fri, 20 Oct 2023 22:36:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 76/90] target/sparc: Move FSMULD to decodetree
Date: Fri, 20 Oct 2023 22:31:44 -0700
Message-Id: <20231021053158.278135-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 43 +++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0753bbef2d..54c9c38736 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -260,6 +260,7 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8ce0282e2b..8a3ee221e9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1666,22 +1666,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -5049,6 +5033,28 @@ TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
 TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
 TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
 
+static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (!(dc->def->features & CPU_FEATURE_FSMULD)) {
+        return raise_unimpfpop(dc);
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_fsmuld(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5159,11 +5165,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x47: /* fsubq */
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x69: /* fsmuld */
-                    CHECK_FPU_FEATURE(dc, FSMULD);
-                    gen_fop_DFF(dc, rd, rs1, rs2, gen_helper_fsmuld);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C023F7D7966
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA3-0004So-MV; Wed, 25 Oct 2023 20:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Z-0002LS-IM
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9T-0008E4-Vi
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so1131798b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279786; x=1698884586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+izpcOcVyLZOmdkTPJ82RJ4OWeC+Q1LpqFNyQvH78LU=;
 b=bRIeynCebZyit4PpDa+vss6YiEZY6tyKwUbqZAxhdUh6Se0W550iN+f8oBmKzyhCRx
 DnRg1anOXuOe0pmPqmz3GLa5Ce1G/LrDFqZ46RU8lyqP7z/xUclNb0KXRSl2BTP6TC/V
 K7bhzgHn6TGVBhrjLzWyiu/eWI6BH9sIV+sqWrx34WOm0jCjpIMtG4RfPLLg8lL9O8pk
 gzafpv8GNKg23+4KxZWbHsoMnEHprCJsh4XeDkURHiSXdhxSllBzmCKdwtUKm5C7+te7
 61AzjbugG/9jDlAbdOc1Baq+ZDyQKQsPwO9mUFq3xrWPpQQqNNsJAv67Z0x+suttPnl1
 LlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279786; x=1698884586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+izpcOcVyLZOmdkTPJ82RJ4OWeC+Q1LpqFNyQvH78LU=;
 b=cKECDqkeTg6pMJ9r5/sre/7J5Mh79c9ALZxko02qNQBzxar3B01XGh/ejJPvnugizF
 T2lnjlqh1IHNHJxQ0C0pj6jL7oqaebOak5RDDwMFsvjCplimebjD42DIhSGRXpJFjmNg
 tiGevvAUxv36XWhrSnP8egjWwDP50eK/FQSskQkujdjY0clVcTOFYEgohhzouyEMW6dz
 6PpF/n9oZLmI7iJ5hv849yFBwgArjogiGICpoZ+/Bn+ZGeH3aT8j88zq51ARwSjJy1i/
 zdF4TYo0BLD8SXVXzTZ7bMkGxMNdSg5oHF2otFGWlYfQEK/muvwP3/CFZw2h4niEQoKq
 vunw==
X-Gm-Message-State: AOJu0Yx3jC3piEezXsGb7il3aNVisCYaUSIhnoqhfSEqzHPKxHuuKZ57
 SnoQAxGPqLlxIzC9+3YAbHYLJh6109PFuuycpnU=
X-Google-Smtp-Source: AGHT+IGqqomLmDGzEXQBUP3t92XpHllRfxDL445VNOMHP/uy4WEM/sDCvqjqWY+1ywaDX1tBSdIfJA==
X-Received: by 2002:a17:90b:4d0f:b0:27d:469b:8847 with SMTP id
 mw15-20020a17090b4d0f00b0027d469b8847mr1472981pjb.3.1698279786540; 
 Wed, 25 Oct 2023 17:23:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 72/94] target/sparc: Move PDIST to decodetree
Date: Wed, 25 Oct 2023 17:15:20 -0700
Message-Id: <20231026001542.1141412-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0e29629b5c..42d740ad44 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -277,6 +277,7 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 35fdcfe4c1..40ef395d14 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,6 +72,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
 # define MAXTL_MASK                             0
@@ -1680,21 +1681,6 @@ static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 
     gen_store_fpr_D(dc, rd, dst);
 }
-
-static void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
-                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src0, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    src0 = gen_load_fpr_D(dc, rd);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src0, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
 #endif
 
 static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
@@ -4903,6 +4889,26 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
+                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src0, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = gen_dest_fpr_D(dc, a->rd);
+    src0 = gen_load_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src0, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5312,6 +5318,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x039: /* VIS I fmuld8ulx16 */
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
+                case 0x03e: /* VIS I pdist */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5387,10 +5394,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x03e: /* VIS I pdist */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDDD(dc, rd, rs1, rs2, gen_helper_pdist);
-                    break;
                 case 0x048: /* VIS I faligndata */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
-- 
2.34.1



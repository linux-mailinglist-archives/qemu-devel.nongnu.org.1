Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B49EE7D1AFE
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bL-0007Lg-Ub; Sat, 21 Oct 2023 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b7-0007FN-UG
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:32 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b5-0008Sf-CP
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:29 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3af604c3f8fso1115558b6e.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866346; x=1698471146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foC8PXJXHiVmCLdzU9Kncpr4frxu6s3Go8QawovY8VU=;
 b=bNqLZ1KM9gmaU422Z8/PVRnEK0MBAm48wHn2oJiwScyXIRtmUMc8T30QqHmzfySkqL
 qWRMROFObh/Ni0pNJYj6UP3l9FJCO3vur+inPDlLcR/VgzglSbzmrHgLuSd2tyG2dPNE
 umo89vqgQmrMtBL9F2yrKIOhKm4r93CghwBnGVyxklmIYXBiO7l+LOLJwn6Nqk6c9GJR
 UT/CfqfV6D4itPjviA0lmP0DE38a3JJGNUNpJbwmQmy+UHmvEcnocfHu9GmcgiQdLD1j
 D/CmjVaC3WB1vr2r0ajqzfcJsjORop9WP3NUzY+15Sx7zzdOtAfXhSPP6rBCbitzlVRE
 kjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866346; x=1698471146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foC8PXJXHiVmCLdzU9Kncpr4frxu6s3Go8QawovY8VU=;
 b=XRARgp7c4bZahEUz1HJE7dmGOn5eWYlBI+UjL0FYgl5SOOYtRpy6oxrwvWZ3Ri2lAj
 xP2+O6fgX913aFGSoITFC3J5qj8pcnAalRB/3VSwqYu1JlzmApmd9IcG3A9/6u9UHBZl
 7pR7ZIBx21oHRfoViWS9o2g57IieLwJMpN668Qi/OilnIvshv8SpbVCaq5lhIHZBo1ZC
 lfDRxds2pFnWpUeL9utbsYqGex/GE/RzEgnvkisErVLZgK6wWTmzN77so9+LMD16Limr
 pB63zWeOqJjWShk/ZihhKRkTD1m590kTTdAs3ploNwklVqciR64du2xRaf2I3XZpaBfA
 nG5A==
X-Gm-Message-State: AOJu0YxVfLTKott80axBXHXSfk2pPHOsrJfkLHm722IgHDe28q2pTT6n
 btp3WyEnn6BP4OW8DDE+U9e0rxbhnsEU/iejng0=
X-Google-Smtp-Source: AGHT+IEqzzJg71jMjo0aMQ9NdwkX/3rpPYJ5zu68JQssE8MQHVHAZV1Bjk7mzYPL11RVwhm9a9SxNA==
X-Received: by 2002:a54:4e8c:0:b0:3b2:e624:43a0 with SMTP id
 c12-20020a544e8c000000b003b2e62443a0mr4204559oiy.15.1697866346206; 
 Fri, 20 Oct 2023 22:32:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 32/90] target/sparc: Move UMUL, SMUL to decodetree
Date: Fri, 20 Oct 2023 22:31:00 -0700
Message-Id: <20231021053158.278135-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 21 +++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 694d2c3648..f214baf465 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -167,6 +167,8 @@ XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
 MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
+UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
+SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4ce87f59b9..4744e8caca 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
+#define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
 #define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 
 /* Default case for non jump instructions. */
@@ -4170,6 +4171,8 @@ TRANS(ANDN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
+TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
+TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4660,24 +4663,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xa: /* umul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0xb: /* smul */
-                        CHECK_IU_FEATURE(dc, MUL);
-                        gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0xc: /* subx, V9 subc */
                         gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1



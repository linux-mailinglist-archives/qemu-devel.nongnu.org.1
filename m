Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5D7D1B28
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ef-0003TO-MR; Sat, 21 Oct 2023 01:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ed-0003NA-87
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:07 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eb-0001CR-IV
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:06 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso1082598fac.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866564; x=1698471364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzRw3IXH2U5Pvhy9Syv54cdvqoHUoy4tZ7btkPmAyBg=;
 b=LsqLDfMtRYY6eOMI4CLWiPTQo5slyCjiPeMGYar6ErpUWp57gLTbA+DfCPbNjwf+WA
 7MEpE25y6r1jHsrMAata5qZsWo46psGMavavuyAUssK6xEKq/bstq4Ett+jnFlNbgzkA
 VTuWkGXN2pE+pE3b6FQ+0R2edO5KzMMI4LJHliMrvsUq2GgonY/2g4nl05bfoZ/yhMaO
 GDKVBg10zI3YSdLbQ4/VEvxDEj60wrHWQZSNUwFUzbFyzA4Co9mPVPIelDWh3yAGTq8b
 9a5a6eFhMJmYbxBVg5wiP28UZNj0YblUpiU/TQIU0snd5kpabWa8UqvYZycYHZMn1Jav
 SMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866564; x=1698471364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzRw3IXH2U5Pvhy9Syv54cdvqoHUoy4tZ7btkPmAyBg=;
 b=voJrjGyvLFiGhJK0yiXTz1/XSjX2pSpOQI7Zft2f1E5UwbA5lBZBhZYcZz6H+uLOrS
 NIS9Y+p532KNJlImYyOcxQEqdCwXbl9Ipn91uZxwq73em6h5r2m2mIvFMoyKIf9X/7KT
 N3OL4SPwA0BBhWr9K01I53rSCgm0pEzii0xaWwsiq+z8G/yfMjASLUNTbnzicqAB2K1g
 1woLwR/Ji6ldoxX30EPU7wN+wUb0zitlAKvtRbGTBo+ViJYwPEjZ6XV7CRxzwHyBaGSp
 vaGH2Ls2pWDS4KQwNvvZ4YcGPQDdSpFV5jPqhl2MNq7DgZ+3uWpXLHp+tmtPyJWQnk7a
 lJyQ==
X-Gm-Message-State: AOJu0YwHDJoNCHd3/vW26L5Wot4mQVN7N/Cp+s3T8A10qnDcLQNCzM4v
 hI2NOf38qI1fd2cG5/WTeqfMt7eQOituf8C+4yY=
X-Google-Smtp-Source: AGHT+IFKZZXtqDc1ECoCB7ZjbhQuQM58+02+WlK2UYB5RTfIMlEqlA/aWUnPz/ZIwSvuwF4pGtxUIg==
X-Received: by 2002:a05:6870:6ec9:b0:1ea:1667:6c8f with SMTP id
 qv9-20020a0568706ec900b001ea16676c8fmr4515231oab.50.1697866564414; 
 Fri, 20 Oct 2023 22:36:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 77/90] target/sparc: Move FDMULQ to decodetree
Date: Fri, 20 Oct 2023 22:31:45 -0700
Message-Id: <20231021053158.278135-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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
 target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 54c9c38736..aafbd68867 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -261,6 +261,7 @@ FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
+FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8a3ee221e9..26126467d9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1666,21 +1666,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-
-    gen(tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_fop_DF(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
@@ -5100,6 +5085,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
 TRANS(FMULq, ALL, do_env_qqq, a, gen_helper_fmulq)
 TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
 
+static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_fdmulq(tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5166,11 +5172,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
-- 
2.34.1



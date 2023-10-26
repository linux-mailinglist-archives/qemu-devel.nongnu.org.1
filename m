Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B797D799B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA6-0004uF-Pi; Wed, 25 Oct 2023 20:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9g-000343-Nt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:22 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9b-0008GG-1G
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso302216a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279793; x=1698884593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82K7Y1lkn8cxFHk/aj1abheMJJJzCXuFVAOpX84t3dE=;
 b=qXXQm/VJuc+K2SaNhwFfB+8az7cAEviCEwYd/ogt3eSLsgSaBd0Sf3IGM7GnIHwmEm
 d2xyYkFl9rx0S0SzM+E6XgLxr1graZDyPvmmqBJhkur2qpynM0F+4TEWH0bUiEvDen9u
 dE8zUghLSG6iJRkxN9btYjn/FsTn2WLlSXqBjeKp1WpZMWrIjwGnEO3EEPkdMSsaCXaC
 L7R+JOjbFk3Mxh52t+Paw8HfApctdP0oBA3SnpZr9Kfu8xbodS8h623VllVbLTwe2D21
 Xk2lrziBXzc4hllhe4hNHXxGXptRVU4uw/qaYwGelvDXgu3TfAYoEgyE9Hpi0wuNZ/c6
 UAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279793; x=1698884593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82K7Y1lkn8cxFHk/aj1abheMJJJzCXuFVAOpX84t3dE=;
 b=Zsy+4AqucRFdiHI2Zo+fLvv6TCwqe1uGquxlsl+Z+NBACMtJcwtdEJudzEgoTcmFU3
 gzagjT6W1lqRUtCeWF1T0EsF8EPZn8DOiCUUc++en30iJFY5JEfX5XEJYefUWSSd9lkm
 sg3kHmM/WUGONEEmpHB07Ke1FG88gMBcZctl6DDAXpz3G46ZCcUXkws0MjyCSVCGgfea
 fduPQgPul17JHrSxq+VUyi89IV0L7f06rhE8CaE7Wb4wgp+f5v+w6Pwe4RP3wVVp+pcO
 YluL3GxXXDoIo4kH5vR2BDwLWUYwFgwwIZsv9yMfpB7iQL9ctTo/20jdF26PC/Lsgl/a
 EAeg==
X-Gm-Message-State: AOJu0YytOhBS4RkFJl76Ygufzw5CVk13PHpqTf2kv/h7/C80V+XfYWzB
 1i4oRaAz7X4EwSCfXClWRChZbceChm8cajwLJ1E=
X-Google-Smtp-Source: AGHT+IEr/rqOtOQLHzF9gzsyLB9aNN/ytEkUKlg15+vZAb3amxfjQGYFo9vRmTxVVWPfhuftHxVCUg==
X-Received: by 2002:a05:6a21:3b44:b0:14e:a1f0:a8ea with SMTP id
 zy4-20020a056a213b4400b0014ea1f0a8eamr6524053pzb.3.1698279793472; 
 Wed, 25 Oct 2023 17:23:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 81/94] target/sparc: Move FDMULQ to decodetree
Date: Wed, 25 Oct 2023 17:15:29 -0700
Message-Id: <20231026001542.1141412-111-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index 6817d52ca2..a19d191603 100644
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
index 6626042776..29643768e1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1669,21 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4982,6 +4967,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
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
@@ -5048,11 +5054,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB67D79A7
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA5-0004jr-Ct; Wed, 25 Oct 2023 20:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9c-0002tU-Mq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Y-0008F6-06
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:16 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27d0251d305so222082a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279789; x=1698884589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r4ilrU9iHcD4mE02FqIHVSwcLuS8iY4OK6WJcyFSZw=;
 b=WPDZ5QeTJSaHC/ootlYmbu5YwrjtlKIXVPWaeoWzBPDhCDiEZnJh4vbtp1mmClwsNp
 97caF9/hB6rKnc/SoeBrVoijil0GXmVjMcK6mIGiJqKf4M4NsSfZ20ftb0yXBrtKruZ0
 OGPNsyead+fgbw87G1OF/4uuSTf65cMRaNra2uTMS2JOc1yFaAM8FZ63uricGfmXtCyc
 BrP/AS+PXQfmWk68TPW+fId2mBBJUPpLGut6PRkMofwOnKWfLm1hsJaKu4bbXpW8PQ69
 Vxzs0j/bTubFWCwSjoV4g1aemNnJzWLBwqYLYUf9eYJnDPObjN7kMrKrbdQNDSx47Owx
 AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279789; x=1698884589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5r4ilrU9iHcD4mE02FqIHVSwcLuS8iY4OK6WJcyFSZw=;
 b=oOGZ9sZPvd2VGqRpU0Ab2XaZLyP80xxqG/9YNU8c3QCooEVZw9xuhozgwkYGvo8BoU
 bdID7CNueXbOOa0tBb/K2Kti2bxAJMBQb1JCXmrh8dzSEQjQaYuegCTaEJJ9wEu3lmBU
 irW95rtG3c7dmBqjjuFPyx+oCqhFGYnla2BBRoq2f9055jIotWCBpOS7JBT8igKjvyWR
 8L2gNWnxXA70yO4up2i9rmLRYaGiNQ0wh/Znx7hu/NyBr2YyuOVe1YLe9dq9pSvwhbVB
 TUlm9SArq+g0Fo98uP/XlvyW0OBABGBa6YHsON6/YftYTBbGIrz1nWa3/RsdMymtUvnp
 Ul0w==
X-Gm-Message-State: AOJu0Yyx8ItSQTBhlH3xL+G2bKiShwEywFHnuMIFv6BmtcYZ5BRa2cPO
 KmdrUsdKQJuPkuCX0Q3scL+kk4vFPsOoc34/0MU=
X-Google-Smtp-Source: AGHT+IGDeNa5Cu/XWvdMygFd4LbcpGAdEs8kGOK38Uwup0bpufHU7MyIDP8CyAKMY5xobSbEEPGKfg==
X-Received: by 2002:a17:90b:2b4d:b0:27d:9b7:cc7 with SMTP id
 rr13-20020a17090b2b4d00b0027d09b70cc7mr13713260pjb.24.1698279789652; 
 Wed, 25 Oct 2023 17:23:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 76/94] target/sparc: Move FSQRTq to decodetree
Date: Wed, 25 Oct 2023 17:15:24 -0700
Message-Id: <20231026001542.1141412-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 target/sparc/translate.c  | 38 ++++++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1d766fab21..4cb250265d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -247,6 +247,7 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 307fbc4628..93efdf3383 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1686,18 +1686,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_ptr))
-{
-    gen_op_load_fpr_QT1(QFPREG(rs));
-
-    gen(tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -4845,6 +4833,27 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_qq(DisasContext *dc, arg_r_r *a,
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
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    func(tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -4990,11 +4999,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2a: /* fsqrtd */
                 case 0x82: /* V9 fdtox */
                 case 0x88: /* V9 fxtod */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x41: /* fadds */
                     gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fadds);
                     break;
-- 
2.34.1



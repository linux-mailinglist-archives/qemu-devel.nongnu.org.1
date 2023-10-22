Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BB7D2734
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui07-0007RS-Pu; Sun, 22 Oct 2023 19:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui01-0007Io-Fy
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:49 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhzz-0008QJ-Nb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:49 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dd8304b980so2059993fac.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017806; x=1698622606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgCDOsgarFpD1+4qJ+hi4Fzjw4QHt03pyqrprzUJU6U=;
 b=TMvRocr1dEqNXX367xMqF7fBNqVAoorrWN6b3QkI+j8y7ORWwkajl5VoLxXWRfQzU6
 uVNrjmnQPqKqi1gXqoqj40nDrh35EZowsQSNICqNs4qrYouQVJk/NkjspbJrbkXeXKJu
 ulmH1o9/qnI8D/ETl9EeOaEsOxeClKHd35H2S4b7ePXqwamnGfaQK5+o5eqPp+zCM74K
 G6R1VmT8u0kJR4m5mvJ8MNGVFN6xB2b/CUfiHMq+wX+Y6Nf2jmmU1vZ6FSRCzH3GFMiT
 iAn4H+/7+qNbDqdUYxLmblOOznBRTstL1UfAibv/JDA0q7Y8vh+V3TZdwaVIYPjoNUVS
 QUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017806; x=1698622606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgCDOsgarFpD1+4qJ+hi4Fzjw4QHt03pyqrprzUJU6U=;
 b=Y14l9dxUPwpL1XKQnwk5lRWdZMendlMGxbkOzm5azKVQ75UPZXopzLLZNXaMgzfWS5
 lvtWwTy5fv1fAi6y1k/6KYZoRiVBX+GPZpspXYn7wD6rLGZTAVzhP+jDO4fVkhJDz2wc
 AeQP+SAdRLHpQlEsn7SSv871szEwUgv3Mqsotdcj3TMvW7zwYElkIKKKWhn6w/NuCi7x
 RB6tyvXT92M0se3pSM1zcsBPyFlJdNe/2Gme3EuEhaS69NlchjjGqSQ36mueYqPlPtZG
 9Jjzb/BO5Sz2/keAjwh9vV9DuEOHk5JxpR7MBeJqkN3pO+g9Jo6DZ6swkg28fHcrMSmg
 wO8w==
X-Gm-Message-State: AOJu0Yxulxmt6yik8nNNN+6W7SzYtCe3Gbq0zcCFq5IsY/StB1DB6+S+
 hQzhRrtWcvlFHkfBfA9uKN8LymtTmUF1zebeLMQ=
X-Google-Smtp-Source: AGHT+IGTEWfFpaukWTENBd1xrYbLyRTN+pkvtx+Bt9V0f2T1rYyvSnBJKUmuKPmynD1UxCEeHMTPyg==
X-Received: by 2002:a05:6870:4c16:b0:1ea:137:7dba with SMTP id
 pk22-20020a0568704c1600b001ea01377dbamr9234486oab.10.1698017805778; 
 Sun, 22 Oct 2023 16:36:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 84/94] target/sparc: Move FqTOs, FqTOi to decodetree
Date: Sun, 22 Oct 2023 16:29:22 -0700
Message-Id: <20231022232932.80507-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 48 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index ee9262061b..33f0c738e6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -268,10 +268,12 @@ FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
+FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 14e0082634..5aa854943c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1671,20 +1671,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr))
-{
-    TCGv_i32 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr))
 {
@@ -4779,6 +4765,30 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
 TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
 
+static bool do_env_fq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env))
+{
+    TCGv_i32 dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    dst = gen_dest_fpr_F(dc);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
+TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5060,11 +5070,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc8: /* fitod */
                 case 0xc9: /* fstod */
                 case 0x81: /* V9 fstox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
-                    break;
+                case 0xd3: /* fqtoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5081,10 +5089,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd3: /* fqtoi */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
-                    break;
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
-- 
2.34.1



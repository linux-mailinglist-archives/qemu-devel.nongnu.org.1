Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A27D1B2E
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4hr-0007Fe-12; Sat, 21 Oct 2023 01:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ha-00076s-7r
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:12 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hY-0001W1-Hz
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:09 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-419787a43ebso8145651cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866747; x=1698471547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMTzCeY/hmemmPG/93ZlWXDpgu2CM2QZlX18OaCfFAI=;
 b=RRXjurXAE4wbEKjTaQOUaGcB3aIn1rDUs8XWifRgzP0T+bjBj8OUtSZ+Yxrh/RRJsR
 24zdo84W2chsKzZ3x01c08AHH5qp8Pl+1XYX4jbIhKQsaU0jQVfckuQAAjUm/zv6phSG
 aX0tIsnGVKPQId01WwGFtNo3wxAsuAzcAOxoAYz9K52ktWtbscdx/vawhxRSYVJM6FQz
 13tcqjjXohEZyeqvp4Q5yl4bIEw8g+q0YsveAgAnUwk8RhHlezf+KfON5CMSPSTrYQMt
 4SQsyCgqVxm7Xp2CjbdoDyuPD7yRbn/j0PgfLnGzigPT04G9pL0H2zzdbDzbRcOq4HeP
 n7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866747; x=1698471547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMTzCeY/hmemmPG/93ZlWXDpgu2CM2QZlX18OaCfFAI=;
 b=QPy0+29Ab4kvq1tqamseL1q/1haWonyLEkcCjlpi4VEuRE/WfMxVThDEn93zoRsNVU
 vLdE2AD/gxQL2mVNI0fgFTw65MZPDEEIiQKTvUIKAg2w2RTxCL2E0izKdFTLIbO988VO
 lYslmB54bBM7pHhrDmF7CsxFcUGyoCqDlGp9E9zyYIQU9CEVSgApLX1NlPNSCtee6o4M
 NCakatU3abkcPXM8FHaAd8TpW8aInliWHMvyfh2bti7UcTbJjTgAPTlwiwe+JTuGeJ8b
 rM7DElSS1qVkI4AVNdgDZNSF9kbanAMSANHbT51sD+zq6IZzRVL3NAV5uWt/ZS1FIBrT
 Cn6Q==
X-Gm-Message-State: AOJu0YwDIX+L2ml8L/cic2i8r/Ge+E0St+SgTz0bW9+WFgnq7hwsVpGl
 2u8nBGKT1s1QoMZJKc4sNCrh9t6kYXXjm17Iueg=
X-Google-Smtp-Source: AGHT+IGj/osbJrekeuQnFSxxW6aJ7fMRaQcgtIlhrUYrVDyDyeuMfnRB2Njl4XFyqkw9Oaw4gS6opQ==
X-Received: by 2002:a05:622a:86:b0:41c:cf78:a9df with SMTP id
 o6-20020a05622a008600b0041ccf78a9dfmr4013490qtw.46.1697866747528; 
 Fri, 20 Oct 2023 22:39:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 80/90] target/sparc: Move FqTOs, FqTOi to decodetree
Date: Fri, 20 Oct 2023 22:31:48 -0700
Message-Id: <20231021053158.278135-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
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
 target/sparc/translate.c  | 48 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 3ad598a08b..431152dde9 100644
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
index 0eb56f5fac..fd3ffa1b96 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1668,20 +1668,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4900,6 +4886,30 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
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
@@ -5181,11 +5191,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5202,10 +5210,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



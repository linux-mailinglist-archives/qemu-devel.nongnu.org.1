Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA087CBB00
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:22:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdOG-00045u-2u; Tue, 17 Oct 2023 02:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNt-0003dK-V0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNr-0004pG-3v
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:53 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5892832f8daso4886842a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523410; x=1698128210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vCuq+uuID5Z32hzaclmdSsH09x8KML1p7HKEF5dnuA=;
 b=CqAnKowJVMDawXz/b3myT8j/N7r1AeL9nQJTGEIsDPEkatPQpIAvFY8ddN3zpSQjDS
 /XPNzHRfkwXvLEr+XmKhV7NX75yXKN/+BSKQbK3lOpnxt+UwEU43dk/VTC6YazqVjDD1
 Lnk94VXx+NC1CNdqWGhOrxxZZ92SfbWqY8wJNf1QoXn4rWUTMyLAK5gk3VL7Lf3Q8RJL
 OHVLij5I3CFdkdDqBFGoQOBwbHg6Bak0/KDw60D0pJiV41ORnUab+82V/uIpwA6kzv6H
 H9QAI37TCTdCY/VJf98GjqXFwvmNholkryhrcUVq39ab4JBHqSro1Ri6o0n7h7BA/8xA
 Rvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523410; x=1698128210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vCuq+uuID5Z32hzaclmdSsH09x8KML1p7HKEF5dnuA=;
 b=vg3H1BRTv0tmfvyYJFPM1SM1xy+G++sZo4+kdss+0ZE0zeAlE6t0FyWyFFPIIjjfwu
 XeNL32unOvXT2LXnrdupVOVVDLWXXCtdXnBSj5memt/WRFAZbxm4Iswt4nXdDieHI6dK
 dO7jqqQ3GFOHSM69WKkpW+DEycd9BCmYkwYmz3nyvQ88tkV74EkvKlC0GheoiWR1OtRj
 Zoi0oDyLqj682nHlA7m/ryMazSSAPQlVeUBBKUemdqDG5aXO0hExFHNro36055jFLJqJ
 LO8HpS7tCh58j9zYjJqsPmmcnnVo53osIfqdOfjZj2wSSpkuNpDeOrw1W5evp4q4U1mq
 HNng==
X-Gm-Message-State: AOJu0YwQ6gX0/GMglJMglwcedPGBIcudlGCQj2xX9jUoEcRniARkdgLH
 t4+FQzdHcMoLnm8Hdz6MZBidiUX9dUcldz5x+iY=
X-Google-Smtp-Source: AGHT+IEu242ef3006yGTSZhWMbi0PVft1aPIngoPY5YHBrisntlPc9BdLJEyht0jp3bc0/dVWj7Qfg==
X-Received: by 2002:a17:90a:4b0f:b0:277:61d7:78be with SMTP id
 g15-20020a17090a4b0f00b0027761d778bemr1461000pjh.14.1697523409777; 
 Mon, 16 Oct 2023 23:16:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 75/90] target/sparc: Move gen_fop_QQQ insns to decodetree
Date: Mon, 16 Oct 2023 23:12:29 -0700
Message-Id: <20231017061244.681584-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index a86c9c85f7..0f7d898071 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -243,12 +243,16 @@ FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
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
index a875ca716b..f1bc85c1d7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1624,19 +1624,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -5051,6 +5038,31 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 
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
@@ -5112,23 +5124,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



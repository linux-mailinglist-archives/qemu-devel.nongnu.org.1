Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E77C8F41
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmG-0002FN-05; Fri, 13 Oct 2023 17:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmB-0001vu-Oo
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm9-0001YW-SL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so1117864b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232772; x=1697837572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfcExTbQZjC7MDwfPjo+p9kVf5iN0ZWDbyLyLmyW1WM=;
 b=vRU9zA3JGakmJyF8pdvGzosuxdGwdGyaHVOt3wp0PIjgAn5kOXief2atKhX1YdJAnG
 ZDXkgHoadQ3UdNAq+A1voOOpAfKuS4rZBWw2Io89tyEmsWed5l63tJsGtKt/KX/oD2m2
 YlUhQUkiuIXXZ7HQYt+ZrfKRVPqcVKw0WMxoLcihdvD9CLPA47oRbn+A+JPOs+MP2+bi
 vYyzPGXVDGGFCEPhi9n6surNNqacuI+LXV32io0kuE+0t9W2HjOMnkXsQh4b5ZXg8bZd
 pw6uBkjO0OKe2re4tlXsNZbve6HtuPUsxkYK9XYp6FmDt7OLEJGVZiSwNDvpoBFIUaCy
 M03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232772; x=1697837572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfcExTbQZjC7MDwfPjo+p9kVf5iN0ZWDbyLyLmyW1WM=;
 b=A9aPJYfXUr8UG3DbEZdPJF7xync4R+3f8JJv75qkW8JSKMjJ0GyRxj3RFkbr8VgZxV
 eQmyNkjOGzfzVodas5O0VDY+jM2etYEtpRSd+ZC6KK5+n//9fnxAdmXfiV3CHz3pRUqO
 G4uRfXCjiVgQnhpRNoYLPr8HsZQFdwwEduv/tOcp96UCDnhwN6ARci4doVIvosMoLP7N
 Bd/rO+Q8rbMACiS2fLCgd2Wyvm1RO6OAV9JjEcLGgb13YFN5yHEU0YMpJmR+dKc4mY+N
 tKqlvIepLekBTJ6HvsSGYzVfeQly7nRqqDmv/I+l3PNA46T/bQRpVDnJXfA/89r5E78D
 QjiQ==
X-Gm-Message-State: AOJu0YzvbQY4EA/g5ICzQtRCGSxFMtDF1ymR0RZj+l3KbkO3pFtc61XM
 HpHpmGijmU0WdxfLhaA/6TTvYrsMqwOxySPUSsE=
X-Google-Smtp-Source: AGHT+IHMDJZAup2TxRhMJ0LiX++UchWPyXYqSF6jO3O2R7qCpqDqK4Wy0l3EVOz4F2jAr3VACLUACw==
X-Received: by 2002:a05:6a00:3992:b0:68a:49bc:e0af with SMTP id
 fi18-20020a056a00399200b0068a49bce0afmr30991509pfb.1.1697232772516; 
 Fri, 13 Oct 2023 14:32:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 70/85] target/sparc: Move gen_fop_QQQ insns to decodetree
Date: Fri, 13 Oct 2023 14:28:31 -0700
Message-Id: <20231013212846.165724-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 5c7b918462..036e2b01d4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -244,12 +244,16 @@ FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
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
index b7e0207405..3446821a50 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1539,19 +1539,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4949,6 +4936,31 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 
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
@@ -5010,23 +5022,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



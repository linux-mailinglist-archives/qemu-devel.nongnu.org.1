Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8F7D274A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui03-0007Jc-GO; Sun, 22 Oct 2023 19:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhzy-0007BH-Fv
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:46 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhzw-0008Ps-GJ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:46 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b40d5ea323so455205b6e.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017803; x=1698622603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrVlKVyNd2l5wYBBKIkgncgg1kklwGbfmWWbVDx6LP0=;
 b=A/v9BeURTth/189KHQb0wjbFVVTAWSl/UG3rgXAvAAULV9Eq2mRIJsW9ss9cjmyh3g
 B5CQKBeQhpjIy3ycsqtrI7/dq1Qr0j/RMmJGspB3Opr0lyNjeKKvT1QdZpbcsrA/Pv9z
 88qNKOZjKA8Vpg81Im/bH/QltkQAA8PPeXBljSxzfbn5WziJNR3KqzmIL7ZrywXBub2/
 3GUu7KtWaA4qFakOC1tlRn1dfYo4yCk7FSW+GpIyZelCCFEdVP34kiIz4gFdHD6sHzEA
 PTIRYVr21SsDPfarl5jmrWzVU9rAGs7n1HfLo9eG1C9zzOGSoZDff3ME34fDYPi3O56S
 JYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017803; x=1698622603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrVlKVyNd2l5wYBBKIkgncgg1kklwGbfmWWbVDx6LP0=;
 b=Hhjb1K0/wINFtmE3sIHTdXUZDfZQHZ0iPl1BxuCqbpOn7QI32ICacRpHdw1xHWCG5b
 KHgSuucQ1EL31K4fuQMshfdHYIzeaB/mzrTfhybkp8CihSUna99sdYISPE0GtH5iimqG
 lkVMJ/cbt9CXCEFmj4XrhnzlJn+yI9uY0edNL+cOHw/uFMkxY2XYGxzhcTanbIvzBY2h
 fRdogOvtJlm5515FNdl06YKoA9nAw+kqn2eEtJZBHG/FIE8yoxJkMzAhFMLcXrkQXgQY
 kpQf9PnXY+eDq93rS+jKOkFmck11LybiEfHJrL0MVcFS3UP+rrKD8N44kq6H6fxewqBP
 2zpg==
X-Gm-Message-State: AOJu0YxO851kMKgWxo+ThkMbC5Qo2LyININchxAlXH0vb9nZl1ad0KdZ
 ANT1g1H3jZDcXUqZuOmRP8AqdBLGAr+EfshpTS0=
X-Google-Smtp-Source: AGHT+IEXGS3qgqENbAWTMGTi/V++F4OtDrb9XZlzJGsN6vPsC10tuQY28XKpT4QbeLkv2uWoctKeeg==
X-Received: by 2002:a05:6808:1313:b0:3a1:df16:2eed with SMTP id
 y19-20020a056808131300b003a1df162eedmr10122020oiv.30.1698017803139; 
 Sun, 22 Oct 2023 16:36:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 81/94] target/sparc: Move FDMULQ to decodetree
Date: Sun, 22 Oct 2023 16:29:19 -0700
Message-Id: <20231022232932.80507-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
index 5dc177fb39..88857dc2cd 100644
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
@@ -4979,6 +4964,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
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
@@ -5045,11 +5051,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



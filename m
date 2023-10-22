Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F77D216F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRar-0003BB-Jq; Sun, 22 Oct 2023 02:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaM-0002U7-R3
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaJ-0002Ll-9E
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso2205584b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954706; x=1698559506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/OoPUbu2ZGrfTLxWlxfpsWJVf4tG57sXC/NTuWxRmA=;
 b=J6qN+911tApA/kwkZNDrykNfDz+J6eSzNwcKYuHQ3+VUYZtyhb38sRd52hqrfM+Jc9
 1jvTpEzHqNFcvnsERXBzJt8AImfFNBh06OTgMeZxwiSkouqB2V4wt8iN9wktIPsEIk1C
 w5iehnPlU7k0vgaSqv6hIPANFaxYjL6yEmGJpo1dKazx89mwnWP6Ij9qqujtDU2YA5La
 gKjWH3yIt8xVIbv8oIHDqX5U0PxrS1KAAY5v5CzaZ/7vq0pyQs+6ZTVIZ/SohQTotawE
 rGFMVETL/XpTUOpiNBjMZJJ1K7XDN7540r/UG/51BRyDiMnbAtUM7X8X1UYPhaT6Tmxw
 qKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954706; x=1698559506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/OoPUbu2ZGrfTLxWlxfpsWJVf4tG57sXC/NTuWxRmA=;
 b=R1KyCxJS1mFVrBm+EtH8dK5bnXZIJoSbOKdXDztd1pk4wDO+LorCniBtBB7NPXKtik
 YvDU81Yxsl3tk+NneTwfh8yFD3zP9+YjCdnPALDmacQgK2odVE1KNJEB15t4h5jIIrMH
 ZMfECr9g/l/M6IXOnc6Sf0kYPIDUDL0VAx6aHYTtcHkMYOL9VLSYj0qkr+n1+QLGOVyD
 rDnT9KY2fES+vOwTafhHVhD8wfNEtnHvUOpAj7namUtyZHJMPZz87OIRB0c+AsLURUKu
 Tfobe6mthi+ULEs+YTLYyU1OypAtGp5a9KRxaB9U2S9NUQaUCZLHDUP7VsN25TNPCcCp
 yUWw==
X-Gm-Message-State: AOJu0Yw+Lt4X7Q806cKDYYd6ZslKOGF6aicttvzqRF4+Iu/4mFsqGDUK
 4sYd4bnH09vP6oz5Pe6Kb5G/h0hEQXowxxWgK+s=
X-Google-Smtp-Source: AGHT+IHn2vH4OtLyAUWoO2p3TGdd7AL9qcwrfObTKdY8s+v9sEndjRwPX6Iytl9AwWhUPpb6OIQ93A==
X-Received: by 2002:a05:6a00:24c6:b0:690:1c1b:aefd with SMTP id
 d6-20020a056a0024c600b006901c1baefdmr6932561pfv.5.1697954706528; 
 Sat, 21 Oct 2023 23:05:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 77/90] target/sparc: Move FDMULQ to decodetree
Date: Sat, 21 Oct 2023 23:00:18 -0700
Message-Id: <20231022060031.490251-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 4a6f25bdf1..6a7788133a 100644
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
@@ -5143,6 +5128,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
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
@@ -5209,11 +5215,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



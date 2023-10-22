Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43D7D272A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhxB-0007Ln-Dl; Sun, 22 Oct 2023 19:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx0-0006Yp-GO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:43 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhww-0007m3-PP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:42 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-357a69dde08so12569345ab.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017617; x=1698622417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSkr670dWCMla1g5k1vldrpAiDAaJi+iUVFF0kQ5xUw=;
 b=AuCp+lh489K94WJYVpThuKtq4uDeFa1KqT317JIS1qfO9gGflPZTzD3xlM74NETC69
 BkqJOt09WsERfhKWQBqtBHsz8IITVjdPr4VgX99RTar9YJF4BVWOowKw14b8IAuSE47a
 5C5CxC60O+A1aNuYO8c5pZAxs31TW8ytIR1RAGQpY2sv4cbs5+EGvndh/s7Xdeb3ogfy
 Ny6BGlbgkiC/W53qmlXFuqXZlfMPZzmTxaxqpj+zbnXiDKoASYWIATx7T6w9UC4ZuSwj
 Eja/onJg6TtkW5hEYZiA6FqGpYKOpspRWWceAPStGeZkOSU+LJDrVXbH740+isCnFMr2
 Wz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017617; x=1698622417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSkr670dWCMla1g5k1vldrpAiDAaJi+iUVFF0kQ5xUw=;
 b=EKKNu3nBxfkx10sSJRCyXYBeSY6ykjwMinLgq3eH2ZeUri0iqBmlcYOzIAT/wgI/bV
 qFXm79akTBkLKJnrrfEoR3qI6NAudufFMSqGLIArVlMDq0825JeFV0199+ghkYQsjuQO
 KJM2CWjK5I8TNCCgEvKU9p114B3tMJHrCP5+hqXi7VYV5rqxx3V4XEQOEp6c3GvRBQ/n
 8PgQxBqZkWmpSQlDW5w3Cjaw0mNXvf9I22fdpNpLJ2ktp2ZyMUosHcXmwl6n1c8eNH2P
 XqVeKKzlA+ger3wutGtQL+2MO+u34AK5JE1pMuzg13Sa8Ft+CVEIy4vV70pYrDMFoRKn
 +ANA==
X-Gm-Message-State: AOJu0YxlLQNUT/EFQPLQA8y2hlcI2CCUkwK7CoFssdsJOul3nbehnp9b
 AF5KK2XdYYIKVmlSO5ZnryEACxgA2yEEgPnN4Dg=
X-Google-Smtp-Source: AGHT+IHwYSMHW+Sl8SHIUSlyWnRCoVPPm90DOPTo8buCF1TvU+O9zV5j/9VCOVnOFvQvR6AS1gU5ZA==
X-Received: by 2002:a92:de07:0:b0:357:a180:6b74 with SMTP id
 x7-20020a92de07000000b00357a1806b74mr8055101ilm.27.1698017617484; 
 Sun, 22 Oct 2023 16:33:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 75/94] target/sparc: Move gen_fop_DD insns to decodetree
Date: Sun, 22 Oct 2023 16:29:13 -0700
Message-Id: <20231022232932.80507-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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

Move FSQRTd, FxTOd, FdTOx.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 50 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 85464285b7..1d766fab21 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -246,6 +246,9 @@ FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index db964002b7..45da3e9dfc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -63,6 +63,7 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
@@ -72,6 +73,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
@@ -1669,20 +1671,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static void gen_fop_DD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 dst, src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4832,6 +4820,28 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
 TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
 TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
 
+static bool do_env_dd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+{
+    TCGv_i64 dst, src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
+TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
+TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -4974,10 +4984,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x29: /* fsqrts */
                 case 0xc4: /* fitos */
                 case 0xd1: /* fstoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
-                    break;
+                case 0x82: /* V9 fdtox */
+                case 0x88: /* V9 fxtod */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
@@ -5082,9 +5092,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                     gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
                     break;
-                case 0x82: /* V9 fdtox */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fdtox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
@@ -5092,9 +5099,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x84: /* V9 fxtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
                     break;
-                case 0x88: /* V9 fxtod */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fxtod);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DE7D7993
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAO-0005eA-HZ; Wed, 25 Oct 2023 20:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9k-0003EH-3n
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:25 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9e-0008Gm-E4
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:22 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d2b814912so252985a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279795; x=1698884595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5ov1/Ws58A6tJgu37c7vPdUN8+EpdwR2VU2PLSJwVY=;
 b=lJWzDqDiEl6UH27RJfec5tLuDYg/zPLqerdX3WmG3rrsOCH0vCdHERBKPwtPkARiRB
 SH7ORi8uYnQgpmmkVrlsWD5V/RdePaRXawh4jMwMi5Hb/ot2gdbhQsJdhlBsdoRcWDbD
 LAij+nbCoCw/hrPyC6GG0W4PGWrsAS5GS6wfVwvAmlWUsQNpSqvn0+ou7+37wEAPb2dN
 slWNfUBvfAa8RBKuGz9FnuZ3oVjD6RMk9NtKTknRaaSj9ym+3xNCGvpVse+Oh+uIF7Cd
 llZB6R4kEZiPafM/vyHvO4LBUCjSQ367TA+XC/vv0rmcyugiKHnH09KNMcBR/8A8eiGX
 Yw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279795; x=1698884595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5ov1/Ws58A6tJgu37c7vPdUN8+EpdwR2VU2PLSJwVY=;
 b=DZlGyl6Q4j9sUXAdoeJyNRfPnv3C4GWsS1EaJLNb8dFrPowKZhad72jkCvr8m4dEVB
 dnfyr9KoVmIUL6xAfKRyrsc1Kv3z0iDRpWrK4Q2IT2dgJpCmSsQb7f46AOSdqz1/4a2T
 A4Pj+wxwLMY3VwAWnwiWYqFvPxA+M0xtRqavDjTpBXe9RkKTrEwydcomL82QwOywDYwI
 2u2eueMYKG/1pxpAkkimj1gHoKyJTaVs4vDKDKNlS9WKvxk1oo3x7FkjqJutMqnjdJ3c
 Rd99xj9gRWu+Ovo9ZU9VySzEF+bxUjExzUnwN5UGdojUxttmUq9i2GCUhupcFCNMBrQl
 kHFg==
X-Gm-Message-State: AOJu0YwnKj9B6l8Q+eBK8gA88N1rRnk0rJlvRXlAe8EYerhO2xU/bKaa
 6QRK7GcD/UwvkXoAOkM8he6UbDh9KCVd0LGSMTA=
X-Google-Smtp-Source: AGHT+IEAFzW2o6TE6yRNHYk3MXUOmqMqHokyaWXLkulVOERxMY0gIvR3pKFb7IdJhabh/gonrh4skA==
X-Received: by 2002:a17:90a:7543:b0:268:1355:b03e with SMTP id
 q61-20020a17090a754300b002681355b03emr14570195pjk.38.1698279794915; 
 Wed, 25 Oct 2023 17:23:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 83/94] target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
Date: Wed, 25 Oct 2023 17:15:31 -0700
Message-Id: <20231026001542.1141412-113-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Note that gen_ne_fop_DF was incorrectly named and does pass env.
The two sets of helpers should have been unified.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 67 ++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index faf2bcef83..ee9262061b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -262,11 +262,14 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6c1dcf6472..e71b41e196 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -73,6 +73,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
@@ -1670,37 +1671,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-#ifdef TARGET_SPARC64
-static void gen_fop_DF(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
-static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4768,6 +4738,29 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_df(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
+TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
+TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
+
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
 {
@@ -5067,17 +5060,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc6: /* fdtos */
                 case 0xd2: /* fdtoi */
                 case 0x84: /* V9 fxtos */
+                case 0xc8: /* fitod */
+                case 0xc9: /* fstod */
+                case 0x81: /* V9 fstox */
                     g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
                     break;
-                case 0xc8: /* fitod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fitod);
-                    break;
-                case 0xc9: /* fstod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fstod);
-                    break;
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5111,9 +5101,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x81: /* V9 fstox */
-                    gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-- 
2.34.1



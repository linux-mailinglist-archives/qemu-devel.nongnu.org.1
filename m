Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 617267D798B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAa-0006g3-Sa; Wed, 25 Oct 2023 20:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9k-0003FO-5L
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9e-0008Gv-Nh
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:23 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so242953a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279796; x=1698884596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KotDm1ccWcjMGj47lWKXfQ3MeQ3vl4Hk13goI3+D2k=;
 b=gsCKmAClRETZfwE1AIhEaOAuA3XToKPhIrsXh2TLKsE2z40uUZMoC+M3WJZs4VLbwx
 qISQZETHoNz1RiAdA4XBsewNXhs7qs2Mr51jxkj4efPWBQ8SoekYyMVTPJGCTBLusoKw
 SiswlzZpTbmfGfAAPahdEHuKBot2N69+rirL92dIiYNXvn8LcHwvEiYsfi6ALUh2zrVM
 D740TPu66TvDZv8y2y7IL3BCY9nRkznXK/aAYu0GxqU8PxmFE6vGHDuPp3WohJQy/C1j
 2fNPFH6D6Nb0nqF5QnJ58PB+kxrh3krHtbIDC2drCDuuQuXvmyVgYoKHwCQLMz3Dukdl
 MezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279796; x=1698884596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KotDm1ccWcjMGj47lWKXfQ3MeQ3vl4Hk13goI3+D2k=;
 b=oQ24/IQQYccxE2GGdcoFoRwG0pgdHjfTiIPQ2pEh7E91Bl2A161ooxRVk0ArqX0GwH
 GQADga8dg9Rrsx0Qpg2UaJ0De+RKie3dqWA2Aw3cyhXzpWu3LmFJqPzXTY3UMpGL8tcY
 bIp/AMTNxWZW6lJWIKV6HSB4fcWRZYHiSmFHtHcRIzFDus79soLisfRWqdvzPjBlzovy
 f5pPW+b0sHDYbtDU+wcr4UuI/Obv/LvKvXPgTOaHBrg8X4uTnEWsF/WrClgs4zVxsA0B
 wJQ3/maArJlADn6zNSckSrjvnoKcw9bUK7sbl1kqcyDBtc8s4OZzfk30oQJdAjP5GKJt
 u8pQ==
X-Gm-Message-State: AOJu0YwdLTbuh7oR+bpmUNiuEoejW1wEBOihA6+EDY2NUn4hmsIZIB1Q
 /8J9laRf2xlnG/ZZF+w9ITn6zhVZ4dy6YT7xWfY=
X-Google-Smtp-Source: AGHT+IF96ROOsIMCVbbQTSc5BzciwyeOqrL7Hr2zSFVicbvt2u3INNWCOs5TyWHpcGx+bJEo0JpGvQ==
X-Received: by 2002:a17:90a:1983:b0:27d:3f93:c148 with SMTP id
 3-20020a17090a198300b0027d3f93c148mr15818438pji.13.1698279796248; 
 Wed, 25 Oct 2023 17:23:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 85/94] target/sparc: Move FqTOd, FqTOx to decodetree
Date: Wed, 25 Oct 2023 17:15:33 -0700
Message-Id: <20231026001542.1141412-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/sparc/translate.c  | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 33f0c738e6..7b65b31f89 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -264,6 +264,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
@@ -271,6 +272,7 @@ FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 37405df926..39da3f1705 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -73,6 +73,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
@@ -1671,20 +1672,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr))
-{
-    TCGv_i64 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i32))
 {
@@ -4792,6 +4779,30 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
+static bool do_env_dq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 dst;
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
+    dst = gen_dest_fpr_D(dc, a->rd);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
+TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5075,11 +5086,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                 case 0xc7: /* fqtos */
                 case 0xd3: /* fqtoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
-                    break;
+                case 0x83: /* V9 fqtox */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
@@ -5105,10 +5114,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x83: /* V9 fqtox */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1



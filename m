Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63417D7965
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoCk-0003q6-N8; Wed, 25 Oct 2023 20:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCg-0003bi-Cz
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCe-0000Xu-7z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27db9fdec16so238068a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279982; x=1698884782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlDQR2RS1X5QFIGEv7Zn93QeQqX1awIw1sbXo7EVy3E=;
 b=DzBDDQM0mSVvtFSzl2pUm5Swwj2XTEg71rVDea3lmPTT5rEYyLadYjqVgp3RhvwzE8
 Qtj0BDUfMdyUabzLVQ9/6v17qY5yQrNMdl4JT49v2puo99UKtOjhwz9bUkNpxK+RuOhz
 3jMqbvpog3SOTvGdRB/EkwtTh5O+dGjOf3R14pN1hCd4U/y9wOcT+ifjvOo6cng+Xk1w
 W7W8Sq8NkBTF3JIw7/i8vlBpwHXRVeJaKScL3QGyWZjYu7qJey/+Lu2oaUVaDkjDGscw
 atJHI52Up95inwIadktUI2VwEl5AR56DB9gmGy7OLsnNIdVpI9NqMhUMMJ11QrOuXwFH
 e+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279982; x=1698884782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlDQR2RS1X5QFIGEv7Zn93QeQqX1awIw1sbXo7EVy3E=;
 b=EVgrB3Dqag61GW/UFDWBAKvoB0yEoeq56qdLm1qKqjV8nRMKFHrriCpNfCvV5O7ODy
 ua9mf7OVKNTc7CQT874SBButLeQz/aAJllVSuZ2RESTi95INiZLOYJ9ykfDrc8eZkovy
 1rV1JTiMECX/hE6qSj57/qHH5+7ubbJpaxirAxKZnmPrmT+X6G2sKkhVVA/2t0biqyiY
 n7YGrzyr6K5ucJKRAR97P6LtDjBfrohNDQC2yBNcl++hXV2sSsaw8+gq+g0R2TfGRV8p
 FBtUr1olDUP6C4kt0UM6PutmmzkXqzsrRIBy5326NFF5YwL9RO19OoocmH8KrWtp86Ru
 Zh+w==
X-Gm-Message-State: AOJu0YwM8ELAVbLMyPzkfEFAA10l2m4YhY5CjP8cFTDR502LFa/HD7JI
 +KqFqKNh5MGA57iUZW3quRI1+ZZ/ByKeI+uq7CY=
X-Google-Smtp-Source: AGHT+IGEK3IUChWOb1HUKAWrLl4TZybsBt3kjPoEN1dOTCFHtKx7+Hcz0T3fsKPXWYu9xiDE1Llfew==
X-Received: by 2002:a17:90a:9f06:b0:27d:a015:a783 with SMTP id
 n6-20020a17090a9f0600b0027da015a783mr13125374pjp.35.1698279981710; 
 Wed, 25 Oct 2023 17:26:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gv24-20020a17090b11d800b00262ca945cecsm438134pjb.54.2023.10.25.17.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:26:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 91/94] target/sparc: Move FPCMP* to decodetree
Date: Wed, 25 Oct 2023 17:15:39 -0700
Message-Id: <20231026001542.1141412-121-richard.henderson@linaro.org>
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
 target/sparc/insns.decode |  9 ++++
 target/sparc/translate.c  | 90 +++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f197bb0b36..781c3cd7f7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -327,6 +327,15 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_r_r
+    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_r_r
+    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_r_r
+    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_r_r
+    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_r_r
+    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_r_r
+    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_r_r
+    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_r_r
+
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @r_r_r
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @r_r_r
     FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ddde64dfb4..3ee1015cc4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -64,6 +64,14 @@
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
 # define gen_helper_fabsq                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpgt32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmple16             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmple32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpne16             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpne32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
@@ -4947,6 +4955,34 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 src1, src2;
+    TCGv dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FPCMPLE16, VIS1, do_rdd, a, gen_helper_fcmple16)
+TRANS(FPCMPNE16, VIS1, do_rdd, a, gen_helper_fcmpne16)
+TRANS(FPCMPGT16, VIS1, do_rdd, a, gen_helper_fcmpgt16)
+TRANS(FPCMPEQ16, VIS1, do_rdd, a, gen_helper_fcmpeq16)
+
+TRANS(FPCMPLE32, VIS1, do_rdd, a, gen_helper_fcmple32)
+TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
+TRANS(FPCMPGT32, VIS1, do_rdd, a, gen_helper_fcmpgt32)
+TRANS(FPCMPEQ32, VIS1, do_rdd, a, gen_helper_fcmpeq32)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
@@ -5229,11 +5265,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
+                TCGv_i64 cpu_src1_64, cpu_dst_64;
                 TCGv_i32 cpu_dst_32;
-                TCGv cpu_dst = tcg_temp_new();
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rs1 = GET_FIELD(insn, 13, 17);
                 int rs2 = GET_FIELD(insn, 27, 31);
                 int rd = GET_FIELD(insn, 2, 6);
 
@@ -5309,63 +5343,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x03a: /* VIS I fpack32 */
                 case 0x048: /* VIS I faligndata */
                 case 0x04c: /* VIS II bshuffle */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmple16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x022: /* VIS I fcmpne16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpne16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x024: /* VIS I fcmple32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmple32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x026: /* VIS I fcmpne32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpne32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x028: /* VIS I fcmpgt16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpgt16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02a: /* VIS I fcmpeq16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpeq16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02c: /* VIS I fcmpgt32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpgt32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02e: /* VIS I fcmpeq32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpeq32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x03b: /* VIS I fpack16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-- 
2.34.1



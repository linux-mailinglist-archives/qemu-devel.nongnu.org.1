Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B388C7D1B25
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4hx-0007ic-2t; Sat, 21 Oct 2023 01:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hh-0007Ac-86
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hf-0001YT-EI
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c77449a6daso12654015ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866754; x=1698471554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkiYuQnjUm3QFZ8tEmqnGR8pUMxStx7fWDZeLFbpEfY=;
 b=xUOBlpcWXPhBwtcqpFsYT/KEaK21LS+A4VYWz8og3UIRiwmoqSB7NxXY9e+kdE4maL
 6l/oK3kotGsCtwrjWXrIBwa/03pt20c6sALEkt8VGUcLX/WPP98AbtumFB8+MT7vbCAS
 2k+M2XkjahQVsSOmrQeDtny2Xsu7+RRtXhIoCUxdOlugts1XPTmkkEv9vovjqCM6ZdWL
 OiPbcI86wMjkNWTJiQC8YMo+s/QhHYR47hTL5BaXa1gY1y+YNVL45cqdhLS48+BCaV3H
 k6oaf4nq+ohlN+yJzBC/CfmDtEuOwLMelJWfDTlwHFOFcZFkIEYqddn0VmiVJs1MdOnv
 Deiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866754; x=1698471554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkiYuQnjUm3QFZ8tEmqnGR8pUMxStx7fWDZeLFbpEfY=;
 b=upCXdPB02GuoE8P9FDhmwmszkeBV/Sgp2NrnMntk2wnlu9OC50PPf5VTlKlScshqZE
 6aFwXLabKmShdVicAV4YWOFdKPNq3LI9U0IRSgjkB5BQc9BWVniHJufVC4+YJow+aw1q
 iEC9FYOiM9ZwduK94eJv0RstHzPC9nAzpEvdxxXo9HEUUnklvOnYYOJk2SGtuA94MwLb
 WitCD4pvuLhSq6viNYLqxYidqsoy8rPJbjn6y3UC7he+PFe2rbkOLzY7KNSmIyqaKCHs
 7VOpM2jgFkLel3Df2BIECnbNBCWA/4aoLBqq+oEnR8u2/BIUmRDdRWaoUAaCIdTNg3qp
 lbHw==
X-Gm-Message-State: AOJu0YyyCg/rH6kc8BIquZj6QoJ4rzCYvG3D5qz2faEk2x7s+q2ZuEoh
 6/ESjxPBLYb/SOJvIQQoHGi9GhV8ST5zUZ9oAxY=
X-Google-Smtp-Source: AGHT+IEIvmV5PLOHmaenQ024nxyTF6AD8zHr605l7nUCPM1d/x+N7mctk42wXKkxN5U8AkUzST9nAA==
X-Received: by 2002:a17:902:ef8e:b0:1c7:2697:ec0a with SMTP id
 iz14-20020a170902ef8e00b001c72697ec0amr4153973plb.30.1697866754053; 
 Fri, 20 Oct 2023 22:39:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 87/90] target/sparc: Move FPCMP* to decodetree
Date: Fri, 20 Oct 2023 22:31:55 -0700
Message-Id: <20231021053158.278135-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/sparc/insns.decode |  9 ++++
 target/sparc/translate.c  | 94 +++++++++++++++++----------------------
 2 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1af7bb05b3..f557371e56 100644
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
index 5f706bce58..cf70837e05 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -77,7 +77,14 @@
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
-#define gen_helper_fsqrtq               ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpeq16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpne16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmple16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpgt16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpeq32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpne32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmple32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpgt32             ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -5065,6 +5072,37 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+#ifdef TARGET_SPARC64
+    TCGv_i64 dst, src1, src2;
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
+#else
+    g_assert_not_reached();
+#endif
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
@@ -5347,11 +5385,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
 
@@ -5427,63 +5463,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



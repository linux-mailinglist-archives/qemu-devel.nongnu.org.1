Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02247D2732
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui09-0007e1-Vs; Sun, 22 Oct 2023 19:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui07-0007aO-1M
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui04-0008Sr-S7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:54 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so2743435b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017811; x=1698622611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clHdPvVHqlgLO1rrHzLrpHURBAaotB3FsnBjwuvMWcA=;
 b=vKKshEbrzP6xwwRUQEkASGEA33asRnFxhPnwvlXtbyIcF2o890lD1ccbL2ck+x+M/R
 4jwVjgwOEsYei0bD965epFGP/M1G7k+9AWE942wvb3dU68hw6PocP519ZZy4xbmLF+Dd
 64LrOKFPNG2MIl0x2NpsrIMXNa8wbAQLrW29XrUGduKcp3XiDwh7u/wRugSgMYCryZ4o
 hIcF2+8jrEtWAIdgabQeUkPdHoJ1ErMISyzEJXvkeKP2uh2xHjZDIlFyqxKuTwPPwztK
 DgU0Mh3mdW/iLpKXIbGemqVVmdjcd3q+GjlxefuO3wegghm2IJZOdSvruO2R8BqFKJVw
 wpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017811; x=1698622611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clHdPvVHqlgLO1rrHzLrpHURBAaotB3FsnBjwuvMWcA=;
 b=hzr7jqU+JlBfzAmixJgvRgyRiesZTzQ4YKLp2dmEmTd1zABQixvOwjGK6wUlkJa8I8
 Hs9yuAvPgQW5nryLRwu5SfbLhyAZbYSCcAaoK5lOjFAJh/X1rRcZfmoG96U8vA7UBBxz
 V0MGuPk98y1Rx03uASZii00agXYtRUR9mAbn8WgFv/cyHySV3LZViYdmOV2dJWeKFuWu
 U6VgUNFPrnyZ2hjIf2NXOGtQjs2oy6qvOCyxbSsm2B3z8m4/T0prAGYGpz3P+gmFvJXJ
 TeOyjTOq/xkReOh1h3tzXUgePplr1lFP1F2/IfV7l0839yQgeEhqDP+yJw0Hrx5PBnep
 QJCA==
X-Gm-Message-State: AOJu0Yw7wybDbxNTrjUbDdh9i1Rpemqe7Y/V8glY76z/JkQTEoORxNF/
 B4IiSpBiJqMlHKHQsf2y5KpyG4m3G6ByDXjfKZU=
X-Google-Smtp-Source: AGHT+IHrUtxO7hcS4f16CKeSe1ShECgv7Fag3D8T99OjGGUgNVea5I+JIcMklXpYUPWsdGXCiEKCWA==
X-Received: by 2002:a05:6a00:238b:b0:6be:314c:16cb with SMTP id
 f11-20020a056a00238b00b006be314c16cbmr9718098pfc.10.1698017811530; 
 Sun, 22 Oct 2023 16:36:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 91/94] target/sparc: Move FPCMP* to decodetree
Date: Sun, 22 Oct 2023 16:29:29 -0700
Message-Id: <20231022232932.80507-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
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
index 8ba07fac2f..42347ac8c0 100644
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
@@ -4944,6 +4952,34 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
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
@@ -5226,11 +5262,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
 
@@ -5306,63 +5340,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



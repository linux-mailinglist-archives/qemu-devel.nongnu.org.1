Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A47C8F6F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmA-0001f8-IW; Fri, 13 Oct 2023 17:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm1-0000Yz-TW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:45 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlz-0001Sq-Kz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:45 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3af608eb367so1653338b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232762; x=1697837562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVwTAxjBVGaVmARt3JYTS8tXu7JfiqUj1WKbp4TzCzA=;
 b=OXkM4if1wezc3hqsF+l+sdh/O0lw2uY2LymL/ylsStiPqmDPm98hz4rAINurcHjJRU
 XWmk7Na/L53vbGDpjP4dm/8M+kKe4ajaGuP1d8ZZ0DRjSY+H6n8XMytbgZxOtO/+NhsV
 xCJGrPY5umElwHaCrWz7rKTMK0gEtWdQ13FDmsh4lxEHRoWuoF9CpnQla1wvwH90PRI0
 sXl5tx6aT6kHj6DkmU2iCPPkACyKvBWDvOK/DyMR1Ap6s0wOmkXYqC9jqaTjhXC7gnaD
 m7dc49eBmijH/jAYBaiYvM3eqs1lZzUmzk3pVB70WYN7BV1en9E83AFiMWhuw8u1L4y9
 7QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232762; x=1697837562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BVwTAxjBVGaVmARt3JYTS8tXu7JfiqUj1WKbp4TzCzA=;
 b=iT8teXxScGGfVte2MkLH9oflV7dRu6I5BC96iRTe2dWksW5U679qVeaoBJDZ4dSU7O
 9/LTsnK7gxM0NUGK6X8g9ijkezqmt7/89fv4gAF1e6yCAZo57rskWrAlilt8AlbT2/4Y
 04KnYJQGVTA1KxTD70IpM6iM+Xm5nRHKDkt6D4cL607BufgTuOka5wXMkoZ7ulmUxBSe
 zNDxkBvAGkt9gao8pAooTEX5Ml/GQKrCq45+VGFRxn+JulUwdZC8ME56FAELts0xZp7G
 ArbQGR3mXJzBH/KB9wUWIagPm1lFLyWPHGmb5/cxPE2c79pzvh8vHNBgZ15cq3wvKhpU
 NdFA==
X-Gm-Message-State: AOJu0YzrGVv79BjkoLgnZCh/pVzZOw+onYYRKfeiHalrwQCjdx38tbKD
 EFl9ZcvPl9e00e064R5MsFePjU+ZtDN1ZJvw6Lg=
X-Google-Smtp-Source: AGHT+IHiw1NUwq3JgYZhR4uWkkk1aDZrSzzKpVGnFpiox4S1ZXHX1uaj8mD3ZIkxQ6IsphC920k4qQ==
X-Received: by 2002:a05:6808:1a27:b0:3ad:c476:9ad9 with SMTP id
 bk39-20020a0568081a2700b003adc4769ad9mr37400963oib.4.1697232762414; 
 Fri, 13 Oct 2023 14:32:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 59/85] target/sparc: Move FMOVD, FNEGD, FABSD, FSRC*D,
 FNOT*D to decodetree
Date: Fri, 13 Oct 2023 14:28:20 -0700
Message-Id: <20231013212846.165724-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
 target/sparc/insns.decode |  7 ++++
 target/sparc/translate.c  | 73 +++++++++++++++++----------------------
 2 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2072930bd7..362aa00300 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -233,8 +233,11 @@ DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
 FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
+FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @r_r2
 FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
+FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
+FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 
 {
   [
@@ -260,9 +263,13 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
+    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @r_r2  # FSRC2d
     FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
+    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @r_r1  # FNOT1d
     FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
+    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2fe193b6d..0a1ebb62e3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -54,6 +54,8 @@
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fnegd                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
@@ -1526,21 +1528,6 @@ static void gen_fop_DD(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_ne_fop_DD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4831,6 +4818,28 @@ TRANS(FABSs, ALL, do_ff, a, gen_helper_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_dd(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVd, 64, do_dd, a, tcg_gen_mov_i64)
+TRANS(FNEGd, 64, do_dd, a, gen_helper_fnegd)
+TRANS(FABSd, 64, do_dd, a, gen_helper_fabsd)
+TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
+TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4874,6 +4883,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x1: /* fmovs */
                 case 0x5: /* fnegs */
                 case 0x9: /* fabss */
+                case 0x2: /* V9 fmovd */
+                case 0x6: /* V9 fnegd */
+                case 0xa: /* V9 fabsd */
                     g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
                     gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
@@ -4976,24 +4988,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
                     break;
 #ifdef TARGET_SPARC64
-                case 0x2: /* V9 fmovd */
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
-                    break;
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_move_Q(dc, rd, rs2);
                     break;
-                case 0x6: /* V9 fnegd */
-                    gen_ne_fop_DD(dc, rd, rs2, gen_helper_fnegd);
-                    break;
                 case 0x7: /* V9 fnegq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fnegq);
                     break;
-                case 0xa: /* V9 fabsd */
-                    gen_ne_fop_DD(dc, rd, rs2, gen_helper_fabsd);
-                    break;
                 case 0xb: /* V9 fabsq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
@@ -5206,6 +5208,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x06b: /* VIS I fnot1s */
                 case 0x075: /* VIS I fsrc1s */
                 case 0x079: /* VIS I fsrc2s */
+                case 0x066: /* VIS I fnot2 */
+                case 0x06a: /* VIS I fnot1 */
+                case 0x074: /* VIS I fsrc1 */
+                case 0x078: /* VIS I fsrc2 */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5389,10 +5395,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_andc_i32);
                     break;
-                case 0x066: /* VIS I fnot2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DD(dc, rd, rs2, tcg_gen_not_i64);
-                    break;
                 case 0x068: /* VIS I fandnot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
@@ -5401,10 +5403,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs2, rs1, tcg_gen_andc_i32);
                     break;
-                case 0x06a: /* VIS I fnot1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DD(dc, rd, rs1, tcg_gen_not_i64);
-                    break;
                 case 0x06c: /* VIS I fxor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
@@ -5437,10 +5435,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_eqv_i32);
                     break;
-                case 0x074: /* VIS I fsrc1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
                 case 0x076: /* VIS I fornot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5450,11 +5444,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_orc_i32);
                     break;
-                case 0x078: /* VIS I fsrc2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
-                    break;
                 case 0x07a: /* VIS I fornot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5907D2716
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwx-0006Su-Ov; Sun, 22 Oct 2023 19:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhws-00062y-8v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:34 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwn-0007dS-Oh
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so2144821b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017607; x=1698622407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vo8yaTLehQVXnbKnM509UZLbODZ3AeY/H9jXFfZSv1I=;
 b=mVNQB+heNgMK2+BR8K4cGOIq7s8vB22qxCFFATQ8P4Ey2NGj+ORMIxRfG5Z+INyRhe
 J2bKWXgiZf4DnG8X8Am5L2Uzn2+6zYc0r+V2gLr4T9TXvWHdk/ST9vR3fZ6A4AQdVQem
 XFLQ86S0NQ1yi7WXT0Ism9mxERqY/cEzoB628anA+r8XtB+RocZBJSHI9FYKtr3coX1o
 FXKemH2bbdrV4aTj0YvIyn72/LocFtFlrgHpbN6fQORBgQLDNWh05mt5MCL/yIC/VSpB
 2d/VaCWoTV+BTyzxJivLLlhwfC1NgCQOzu27u7PtoSpL29yDmfWiv1spC8AY+7x5+P8V
 KMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017607; x=1698622407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vo8yaTLehQVXnbKnM509UZLbODZ3AeY/H9jXFfZSv1I=;
 b=k+bKL0sThvCPx3b9kw0KEe2Lkro/6c9WWeXfuABThjxzym/hIndOT+xod9NY5HICU2
 3FCIKgsinY1A30aV1pkj/ybhy6ZKAk74dHzfqKYJJY15M5eMVvEnaO4KAfbnNr+IHNAx
 Y8AAZZjnNFlNCsrqJ9yDyrGgwk7sY/IgrhTVeDq353Y9nNBEGkzo1cuO3N3/g57oQbzy
 nxj3iBV3UykwS5f/S6GjWyipMR3WD6tOhm1ZhIuoike5MiFYpee7hq9h7j6PncKk1O2r
 yPwwY9/YQ7DRXtb7Vihf4dvBxsKZZre4uc9mDgdamVMgVWZgOIkDCaaBXxmDa79vaJXg
 riMA==
X-Gm-Message-State: AOJu0YymjIhoofqtMwM2NcpsqO7EBHlkjUNbadGbPK/7LhNdpTCpvlrT
 jS3Uq9AflKLC73A6on5n65wjD7rdk+EDm4BbQ44=
X-Google-Smtp-Source: AGHT+IEBZF4nCG+3DSccpkuGXDbHUl99eEPLl68e2dWJdtIpvRVGL9i2dsgrV+9RmDehMviDKKU7+w==
X-Received: by 2002:a05:6a00:84e:b0:6bd:e39c:aad5 with SMTP id
 q14-20020a056a00084e00b006bde39caad5mr5651897pfk.15.1698017607250; 
 Sun, 22 Oct 2023 16:33:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 63/94] target/sparc: Move EDGE* to decodetree
Date: Sun, 22 Oct 2023 16:29:01 -0700
Message-Id: <20231022232932.80507-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/sparc/insns.decode |  22 +++-
 target/sparc/translate.c  | 271 ++++++++++++++++----------------------
 2 files changed, 133 insertions(+), 160 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5df3b1add4..a9630509bd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -35,6 +35,9 @@ CALL    01 i:s30
 @r_r_ri_cc0 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=0
 @r_r_ri_cc1 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=1
 
+&r_r_r      rd rs1 rs2
+@r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -231,7 +234,24 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
-NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+{
+  [
+    EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
+    EDGE8N      10 ..... 110110 ..... 0 0000 0001 .....    @r_r_r
+    EDGE8Lcc    10 ..... 110110 ..... 0 0000 0010 .....    @r_r_r
+    EDGE8LN     10 ..... 110110 ..... 0 0000 0011 .....    @r_r_r
+    EDGE16cc    10 ..... 110110 ..... 0 0000 0100 .....    @r_r_r
+    EDGE16N     10 ..... 110110 ..... 0 0000 0101 .....    @r_r_r
+    EDGE16Lcc   10 ..... 110110 ..... 0 0000 0110 .....    @r_r_r
+    EDGE16LN    10 ..... 110110 ..... 0 0000 0111 .....    @r_r_r
+    EDGE32cc    10 ..... 110110 ..... 0 0000 1000 .....    @r_r_r
+    EDGE32N     10 ..... 110110 ..... 0 0000 1001 .....    @r_r_r
+    EDGE32Lcc   10 ..... 110110 ..... 0 0000 1010 .....    @r_r_r
+    EDGE32LN    10 ..... 110110 ..... 0 0000 1011 .....    @r_r_r
+  ]
+  NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
+}
+
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
 ##
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8075593237..5197f1a806 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2728,93 +2728,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
     }
 }
 
-static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
-                     int width, bool cc, bool left)
-{
-    TCGv lo1, lo2;
-    uint64_t amask, tabl, tabr;
-    int shift, imask, omask;
-
-    if (cc) {
-        tcg_gen_mov_tl(cpu_cc_src, s1);
-        tcg_gen_mov_tl(cpu_cc_src2, s2);
-        tcg_gen_sub_tl(cpu_cc_dst, s1, s2);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUB);
-        dc->cc_op = CC_OP_SUB;
-    }
-
-    /* Theory of operation: there are two tables, left and right (not to
-       be confused with the left and right versions of the opcode).  These
-       are indexed by the low 3 bits of the inputs.  To make things "easy",
-       these tables are loaded into two constants, TABL and TABR below.
-       The operation index = (input & imask) << shift calculates the index
-       into the constant, while val = (table >> index) & omask calculates
-       the value we're looking for.  */
-    switch (width) {
-    case 8:
-        imask = 0x7;
-        shift = 3;
-        omask = 0xff;
-        if (left) {
-            tabl = 0x80c0e0f0f8fcfeffULL;
-            tabr = 0xff7f3f1f0f070301ULL;
-        } else {
-            tabl = 0x0103070f1f3f7fffULL;
-            tabr = 0xfffefcf8f0e0c080ULL;
-        }
-        break;
-    case 16:
-        imask = 0x6;
-        shift = 1;
-        omask = 0xf;
-        if (left) {
-            tabl = 0x8cef;
-            tabr = 0xf731;
-        } else {
-            tabl = 0x137f;
-            tabr = 0xfec8;
-        }
-        break;
-    case 32:
-        imask = 0x4;
-        shift = 0;
-        omask = 0x3;
-        if (left) {
-            tabl = (2 << 2) | 3;
-            tabr = (3 << 2) | 1;
-        } else {
-            tabl = (1 << 2) | 3;
-            tabr = (3 << 2) | 2;
-        }
-        break;
-    default:
-        abort();
-    }
-
-    lo1 = tcg_temp_new();
-    lo2 = tcg_temp_new();
-    tcg_gen_andi_tl(lo1, s1, imask);
-    tcg_gen_andi_tl(lo2, s2, imask);
-    tcg_gen_shli_tl(lo1, lo1, shift);
-    tcg_gen_shli_tl(lo2, lo2, shift);
-
-    tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
-    tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
-    tcg_gen_andi_tl(lo1, lo1, omask);
-    tcg_gen_andi_tl(lo2, lo2, omask);
-
-    amask = -8;
-    if (AM_CHECK(dc)) {
-        amask &= 0xffffffffULL;
-    }
-    tcg_gen_andi_tl(s1, s1, amask);
-    tcg_gen_andi_tl(s2, s2, amask);
-
-    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
-    tcg_gen_and_tl(lo2, lo2, lo1);
-    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
-}
-
 static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
 {
     TCGv tmp = tcg_temp_new();
@@ -2877,6 +2790,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_64(C)      true
 # define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
+# define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
+# define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2887,6 +2802,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_64(C)      false
 # define avail_GL(C)      false
 # define avail_HYPV(C)    false
+# define avail_VIS1(C)    false
+# define avail_VIS2(C)    false
 #endif
 
 /* Default case for non jump instructions. */
@@ -4184,6 +4101,113 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADD, NULL, NULL, gen_op_mulscc);
 }
 
+static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
+                     int width, bool cc, bool left)
+{
+    TCGv dst, s1, s2, lo1, lo2;
+    uint64_t amask, tabl, tabr;
+    int shift, imask, omask;
+
+    dst = gen_dest_gpr(dc, a->rd);
+    s1 = gen_load_gpr(dc, a->rs1);
+    s2 = gen_load_gpr(dc, a->rs2);
+
+    if (cc) {
+        tcg_gen_mov_tl(cpu_cc_src, s1);
+        tcg_gen_mov_tl(cpu_cc_src2, s2);
+        tcg_gen_sub_tl(cpu_cc_dst, s1, s2);
+        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUB);
+        dc->cc_op = CC_OP_SUB;
+    }
+
+    /*
+     * Theory of operation: there are two tables, left and right (not to
+     * be confused with the left and right versions of the opcode).  These
+     * are indexed by the low 3 bits of the inputs.  To make things "easy",
+     * these tables are loaded into two constants, TABL and TABR below.
+     * The operation index = (input & imask) << shift calculates the index
+     * into the constant, while val = (table >> index) & omask calculates
+     * the value we're looking for.
+     */
+    switch (width) {
+    case 8:
+        imask = 0x7;
+        shift = 3;
+        omask = 0xff;
+        if (left) {
+            tabl = 0x80c0e0f0f8fcfeffULL;
+            tabr = 0xff7f3f1f0f070301ULL;
+        } else {
+            tabl = 0x0103070f1f3f7fffULL;
+            tabr = 0xfffefcf8f0e0c080ULL;
+        }
+        break;
+    case 16:
+        imask = 0x6;
+        shift = 1;
+        omask = 0xf;
+        if (left) {
+            tabl = 0x8cef;
+            tabr = 0xf731;
+        } else {
+            tabl = 0x137f;
+            tabr = 0xfec8;
+        }
+        break;
+    case 32:
+        imask = 0x4;
+        shift = 0;
+        omask = 0x3;
+        if (left) {
+            tabl = (2 << 2) | 3;
+            tabr = (3 << 2) | 1;
+        } else {
+            tabl = (1 << 2) | 3;
+            tabr = (3 << 2) | 2;
+        }
+        break;
+    default:
+        abort();
+    }
+
+    lo1 = tcg_temp_new();
+    lo2 = tcg_temp_new();
+    tcg_gen_andi_tl(lo1, s1, imask);
+    tcg_gen_andi_tl(lo2, s2, imask);
+    tcg_gen_shli_tl(lo1, lo1, shift);
+    tcg_gen_shli_tl(lo2, lo2, shift);
+
+    tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
+    tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
+    tcg_gen_andi_tl(lo1, lo1, omask);
+    tcg_gen_andi_tl(lo2, lo2, omask);
+
+    amask = address_mask_i(dc, -8);
+    tcg_gen_andi_tl(s1, s1, amask);
+    tcg_gen_andi_tl(s2, s2, amask);
+
+    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
+    tcg_gen_and_tl(lo2, lo2, lo1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
+
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(EDGE8cc, VIS1, gen_edge, a, 8, 1, 0)
+TRANS(EDGE8Lcc, VIS1, gen_edge, a, 8, 1, 1)
+TRANS(EDGE16cc, VIS1, gen_edge, a, 16, 1, 0)
+TRANS(EDGE16Lcc, VIS1, gen_edge, a, 16, 1, 1)
+TRANS(EDGE32cc, VIS1, gen_edge, a, 32, 1, 0)
+TRANS(EDGE32Lcc, VIS1, gen_edge, a, 32, 1, 1)
+
+TRANS(EDGE8N, VIS2, gen_edge, a, 8, 0, 0)
+TRANS(EDGE8LN, VIS2, gen_edge, a, 8, 0, 1)
+TRANS(EDGE16N, VIS2, gen_edge, a, 16, 0, 0)
+TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
+TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
+TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5072,89 +5096,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
                 switch (opf) {
                 case 0x000: /* VIS I edge8cc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 8, 1, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x001: /* VIS II edge8n */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 8, 0, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x002: /* VIS I edge8lcc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 8, 1, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x003: /* VIS II edge8ln */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 8, 0, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x004: /* VIS I edge16cc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 16, 1, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x005: /* VIS II edge16n */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 16, 0, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x006: /* VIS I edge16lcc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 16, 1, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x007: /* VIS II edge16ln */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 16, 0, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x008: /* VIS I edge32cc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 32, 1, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x009: /* VIS II edge32n */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 32, 0, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x00a: /* VIS I edge32lcc */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 32, 1, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x00b: /* VIS II edge32ln */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_edge(dc, cpu_dst, cpu_src1, cpu_src2, 32, 0, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x010: /* VIS I array8 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1



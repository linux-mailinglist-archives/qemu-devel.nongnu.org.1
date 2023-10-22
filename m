Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE17D214E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRb3-0004GM-SW; Sun, 22 Oct 2023 02:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa7-000155-90
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:59 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa2-0002Gg-04
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:58 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57babef76deso1344453eaf.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954691; x=1698559491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5QqxOgFXORgACa6u4z9brFJBZqP6gkgM5cgRFzA2GU=;
 b=E/wVPkgAtVgtSEEnbXJDRz3bM11OSLevcpMg2O8GFZMyr6PfbCdDFq3UL910gaMX+g
 1dG9RbPXaL2AI1FKGb3YFCI3qEm9y+YpVhwvD/ZwpWtBlzrOuNwMQuPrFMnGpNtB3/+5
 NLGFy2kQlQhM4k/oyH0CLHiSkV3tPhGLC31HyBFrF2IqO94H8Da8WVWGW1dfVhy7dsAG
 sZ24BRrfK5HWSqO6OV0ZGlOw7YP4hsFzYLT13CYPfxtZC6vECcH2XLNr6y+DwPGEuq+A
 CeWYSb49EFDR1pSR0hZy05BcapmVlnzfKbzF571/f/zdFV6/QvRitpr8wRKqEY6/OCak
 VPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954691; x=1698559491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5QqxOgFXORgACa6u4z9brFJBZqP6gkgM5cgRFzA2GU=;
 b=jjhdvTQvktce6y9RfxzcIpl7s+Ys57mpTcSjN3KexGiYrwhzxLiyH93z3YJkC60ltj
 OuujMn2Qm2sRKCN2HwTJOCJR6GUCfkgHwYQI72YTvFxCSn33npsv4hvwLsfidIdTZV9C
 TQ4s1ectU4TELhpJffM0UrBdCmyxa5aEp/uoTLH12na3gWGwvbTs+3hzfSJD3oPHYscB
 5AN+sjyLBBl1v6VoIrg9cea/gJ2kqby8hxoWKlOG12QAyh7iHQPOy9GpAapmZlc5JjQK
 tJ1TOKflzcr8dcov3JSolGQp0/8JnN3PHszHQT4G47iHI5p2oXqQFiIh+O4ZUkRUpL2n
 N5ag==
X-Gm-Message-State: AOJu0YzabOICjQVXYpdIaqp4O1LJk2ILOxIREhMHlrZkG7TWK78OFcM+
 Nf+4nzl4hbgXMey3ULBpMSlUez+PWMs1D/4agZk=
X-Google-Smtp-Source: AGHT+IHYmByCuMOaiKYEguBuoP1+Ogg0KrHvH7pwqizyJRW5L4r1IUhEy9bSfpS3vgUJsbDliUtFDA==
X-Received: by 2002:a05:6358:33a6:b0:134:fdfc:4319 with SMTP id
 i38-20020a05635833a600b00134fdfc4319mr6770229rwd.20.1697954691120; 
 Sat, 21 Oct 2023 23:04:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 59/90] target/sparc: Move EDGE* to decodetree
Date: Sat, 21 Oct 2023 23:00:00 -0700
Message-Id: <20231022060031.490251-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
 target/sparc/insns.decode |  22 +++-
 target/sparc/translate.c  | 269 ++++++++++++++++----------------------
 2 files changed, 131 insertions(+), 160 deletions(-)

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
index df15ff0ee6..eeb22d64c9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2713,93 +2713,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
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
@@ -2866,6 +2779,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 #define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
 #define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
+#define avail_VIS1(C)     ((C)->def->features & CPU_FEATURE_VIS1)
+#define avail_VIS2(C)     ((C)->def->features & CPU_FEATURE_VIS2)
 
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
@@ -4341,6 +4256,113 @@ static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
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
@@ -5240,89 +5262,18 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
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



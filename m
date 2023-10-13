Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70A7C8F4D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPpG-0008Oi-8W; Fri, 13 Oct 2023 17:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpE-0008Mj-NL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpC-0002TJ-I7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso386774b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232961; x=1697837761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTuM+cibe/8knLsb5O58pRmotx2tfANjvS16KT8WOS0=;
 b=QzGcAs1FCFDwsn+ke7Hdo5SUOVKdklj2hvX9FEMhZfCZga3I5ZVDIH8nwgNH4fH7TD
 m0z39gQgUeQdvNaMUZlrm6ifrtdBWDEw0CtpBAIW5dpR/xJPDJYCruxgwQxhZW+frR4t
 /kNzapG0LGng9YEKWoUeoncP3VOs7XE1C8fxDUYX/AnsqC3xu/6ZUi6T5NNGX17KRN2z
 ACNAqgCmww/PqEJ7KlHqt+3wEOw6/XTrbsO+SL4KOrO8h7bPZYVL3fXVkjftdOBVCTid
 6zvPZMcZPqrjAAB1BefHk9cCUe0HtnbdcnjK9r0TrA0T24vaU4HwzYCAXE0tP+OsQJk8
 Q/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232961; x=1697837761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTuM+cibe/8knLsb5O58pRmotx2tfANjvS16KT8WOS0=;
 b=Gh8gohWWdxDleUFc4IWMIea826in2h94mqZOCD8FMT4jnWPOPIJqfgydqSN7LzQ254
 /faUOxHseoQjSY0W+JavnArl/c8KWuA9v90np+k9c23fTYvTKsK1IXNdtHPXGK+kzL2j
 Up8f0bUzIfj4I5Qu5UfTjMN/++1+aQ2JhIwFfzvIxUDlXp42VfBkG4KIRFG1CIy0X6Xu
 l0L8pGs2RotUmzm0n/9Q0ToArdR+qd+axn7nPUR+kkuSzHMp3YpdxwNATBmIm0iejuzI
 IBh3YztUFqRu0MNGm+s9boBgbf+pvb3KOvfsa9/Ha/DL57pN1DDgir4X4pJB1jF4FYHN
 WGJg==
X-Gm-Message-State: AOJu0Yy5qIueZV+uVk/QjT8m4R8xihNP3tKuEuWsaM2Z6Qw6g1tdkNf6
 titgMorcDbkYHs1R7eJfF0eKMkRlbdZ7v61RIdk=
X-Google-Smtp-Source: AGHT+IEdsGPTyQBx9Jqm8Z+1nPlfe+Efbk3x+5oVtHuTxo45I1iSy3qed6b5td7Go1sohc5c8xIbFg==
X-Received: by 2002:a05:6a00:4784:b0:68f:c1e0:a2c4 with SMTP id
 dh4-20020a056a00478400b0068fc1e0a2c4mr1672320pfb.3.1697232961059; 
 Fri, 13 Oct 2023 14:36:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b0068790c41ca2sm1123984pfb.27.2023.10.13.14.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 80/85] target/sparc: Move FMOVR, FMOVcc, FMOVfcc to decodetree
Date: Fri, 13 Oct 2023 14:28:41 -0700
Message-Id: <20231013212846.165724-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/sparc/insns.decode |  12 +++
 target/sparc/translate.c  | 189 +++++++++++++++-----------------------
 2 files changed, 88 insertions(+), 113 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8f953a6af6..5e8d456ab2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -278,6 +278,18 @@ FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
 
+FMOVscc     10 rd:5  110101 0 cond:4 1 cc:1 0 000001 rs2:5
+FMOVdcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000010 rs2:5
+FMOVqcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000011 rs2:5
+
+FMOVsfcc    10 rd:5  110101 0 cond:4 0 cc:2   000001 rs2:5
+FMOVdfcc    10 rd:5  110101 0 cond:4 0 cc:2   000010 rs2:5
+FMOVqfcc    10 rd:5  110101 0 cond:4 0 cc:2   000011 rs2:5
+
+FMOVRs      10 rd:5  110101 rs1:5    0 cond:3  00101 rs2:5
+FMOVRd      10 rd:5  110101 rs1:5    0 cond:3  00110 rs2:5
+FMOVRq      10 rd:5  110101 rs1:5    0 cond:3  00111 rs2:5
+
 {
   [
     EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c16d572c88..2ecaa82de5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2296,15 +2296,9 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     }
 }
 
-#ifdef TARGET_SPARC64
-static TCGv get_src1(DisasContext *dc, unsigned int insn)
-{
-    unsigned int rs1 = GET_FIELD(insn, 13, 17);
-    return gen_load_gpr(dc, rs1);
-}
-
 static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
+#ifdef TARGET_SPARC64
     TCGv_i32 c32, zero, dst, s1, s2;
 
     /* We have two choices here: extend the 32 bit data and use movcond_i64,
@@ -2327,19 +2321,27 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
     tcg_gen_movcond_i32(TCG_COND_NE, dst, c32, zero, s1, s2);
 
     gen_store_fpr_F(dc, rd, dst);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
+#ifdef TARGET_SPARC64
     TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
     tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, cmp->c2,
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
     gen_store_fpr_D(dc, rd, dst);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
+#ifdef TARGET_SPARC64
     int qd = QFPREG(rd);
     int qs = QFPREG(rs);
 
@@ -2349,8 +2351,12 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
                         cpu_fpr[qs / 2 + 1], cpu_fpr[qd / 2 + 1]);
 
     gen_update_fprs_dirty(dc, qd);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
+#ifdef TARGET_SPARC64
 static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
@@ -5036,6 +5042,69 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     return advance_pc(dc);
 }
 
+static bool do_fmovr(DisasContext *dc, arg_FMOVRs *a, bool is_128,
+                     void (*func)(DisasContext *, DisasCompare *, int, int))
+{
+    DisasCompare cmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (is_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    func(dc, &cmp, a->rd, a->rs2);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVRs, 64, do_fmovr, a, false, gen_fmovs)
+TRANS(FMOVRd, 64, do_fmovr, a, false, gen_fmovd)
+TRANS(FMOVRq, 64, do_fmovr, a, true, gen_fmovq)
+
+static bool do_fmovcc(DisasContext *dc, arg_FMOVscc *a, bool is_128,
+                      void (*func)(DisasContext *, DisasCompare *, int, int))
+{
+    DisasCompare cmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (is_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_compare(&cmp, a->cc, a->cond, dc);
+    func(dc, &cmp, a->rd, a->rs2);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVscc, 64, do_fmovcc, a, false, gen_fmovs)
+TRANS(FMOVdcc, 64, do_fmovcc, a, false, gen_fmovd)
+TRANS(FMOVqcc, 64, do_fmovcc, a, true, gen_fmovq)
+
+static bool do_fmovfcc(DisasContext *dc, arg_FMOVsfcc *a, bool is_128,
+                       void (*func)(DisasContext *, DisasCompare *, int, int))
+{
+    DisasCompare cmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (is_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_fcompare(&cmp, a->cc, a->cond);
+    func(dc, &cmp, a->rd, a->rs2);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVsfcc, 64, do_fmovfcc, a, false, gen_fmovs)
+TRANS(FMOVdfcc, 64, do_fmovfcc, a, false, gen_fmovd)
+TRANS(FMOVqfcc, 64, do_fmovfcc, a, true, gen_fmovq)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5069,9 +5138,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             if (xop == 0x34) {   /* FPU Operations */
                 goto illegal_insn; /* in decodetree */
             } else if (xop == 0x35) {   /* FPU Operations */
-#ifdef TARGET_SPARC64
-                int cond;
-#endif
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
                 }
@@ -5080,110 +5146,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 rs2 = GET_FIELD(insn, 27, 31);
                 xop = GET_FIELD(insn, 18, 26);
 
-#ifdef TARGET_SPARC64
-#define FMOVR(sz)                                                  \
-                do {                                               \
-                    DisasCompare cmp;                              \
-                    cond = GET_FIELD_SP(insn, 10, 12);             \
-                    cpu_src1 = get_src1(dc, insn);                 \
-                    gen_compare_reg(&cmp, cond, cpu_src1);         \
-                    gen_fmov##sz(dc, &cmp, rd, rs2);               \
-                } while (0)
-
-                if ((xop & 0x11f) == 0x005) { /* V9 fmovsr */
-                    FMOVR(s);
-                    break;
-                } else if ((xop & 0x11f) == 0x006) { // V9 fmovdr
-                    FMOVR(d);
-                    break;
-                } else if ((xop & 0x11f) == 0x007) { // V9 fmovqr
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    FMOVR(q);
-                    break;
-                }
-#undef FMOVR
-#endif
                 switch (xop) {
-#ifdef TARGET_SPARC64
-#define FMOVCC(fcc, sz)                                                 \
-                    do {                                                \
-                        DisasCompare cmp;                               \
-                        cond = GET_FIELD_SP(insn, 14, 17);              \
-                        gen_fcompare(&cmp, fcc, cond);                  \
-                        gen_fmov##sz(dc, &cmp, rd, rs2);                \
-                    } while (0)
-
-                    case 0x001: /* V9 fmovscc %fcc0 */
-                        FMOVCC(0, s);
-                        break;
-                    case 0x002: /* V9 fmovdcc %fcc0 */
-                        FMOVCC(0, d);
-                        break;
-                    case 0x003: /* V9 fmovqcc %fcc0 */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(0, q);
-                        break;
-                    case 0x041: /* V9 fmovscc %fcc1 */
-                        FMOVCC(1, s);
-                        break;
-                    case 0x042: /* V9 fmovdcc %fcc1 */
-                        FMOVCC(1, d);
-                        break;
-                    case 0x043: /* V9 fmovqcc %fcc1 */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(1, q);
-                        break;
-                    case 0x081: /* V9 fmovscc %fcc2 */
-                        FMOVCC(2, s);
-                        break;
-                    case 0x082: /* V9 fmovdcc %fcc2 */
-                        FMOVCC(2, d);
-                        break;
-                    case 0x083: /* V9 fmovqcc %fcc2 */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(2, q);
-                        break;
-                    case 0x0c1: /* V9 fmovscc %fcc3 */
-                        FMOVCC(3, s);
-                        break;
-                    case 0x0c2: /* V9 fmovdcc %fcc3 */
-                        FMOVCC(3, d);
-                        break;
-                    case 0x0c3: /* V9 fmovqcc %fcc3 */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(3, q);
-                        break;
-#undef FMOVCC
-#define FMOVCC(xcc, sz)                                                 \
-                    do {                                                \
-                        DisasCompare cmp;                               \
-                        cond = GET_FIELD_SP(insn, 14, 17);              \
-                        gen_compare(&cmp, xcc, cond, dc);               \
-                        gen_fmov##sz(dc, &cmp, rd, rs2);                \
-                    } while (0)
-
-                    case 0x101: /* V9 fmovscc %icc */
-                        FMOVCC(0, s);
-                        break;
-                    case 0x102: /* V9 fmovdcc %icc */
-                        FMOVCC(0, d);
-                        break;
-                    case 0x103: /* V9 fmovqcc %icc */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(0, q);
-                        break;
-                    case 0x181: /* V9 fmovscc %xcc */
-                        FMOVCC(1, s);
-                        break;
-                    case 0x182: /* V9 fmovdcc %xcc */
-                        FMOVCC(1, d);
-                        break;
-                    case 0x183: /* V9 fmovqcc %xcc */
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        FMOVCC(1, q);
-                        break;
-#undef FMOVCC
-#endif
                     case 0x51: /* fcmps, V9 %fcc */
                         cpu_src1_32 = gen_load_fpr_F(dc, rs1);
                         cpu_src2_32 = gen_load_fpr_F(dc, rs2);
-- 
2.34.1



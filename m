Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6317C8F0E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiN-0006C5-TV; Fri, 13 Oct 2023 17:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiM-0006Bu-Cv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:58 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiK-0000QF-Np
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:58 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so98682439f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232535; x=1697837335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzbBWpNu9rSQuA2zQaNV3iAGOwXCcC+rGphgO9YguDs=;
 b=u8y5o5EbILdnK4YWnjtbATvtXctWR+vgCEdXAfONCwcj0nk34rmW3OJtHL40OrwHGG
 WfFhzEsN4OsLC3eGLruXnE9f2cyEPWvL/FEP2dU2uYIQJBG0RQPng5ecayu0SdGhDy28
 CvRFMRQsHPxv9q2CUaCHq8OTJKk/qIfgjjiwhR1tJzqml64aPBCOykHzJGxXFBZILPNp
 UQoQT3iACieCB8pPRY62+VjoVgh7GJy0LTVcScnrNKlbb3Ni3gmq/jji+wYCYE1QVr6N
 DVPBblE7no1Hl3HdJAZUSpIO6ikWfRnZQrXXMUV92+EpTk+mX7FEemH7PFDu1rSPOV68
 mVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232535; x=1697837335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzbBWpNu9rSQuA2zQaNV3iAGOwXCcC+rGphgO9YguDs=;
 b=DBI9c6HYcpnS6tYDBH6yo2eUhfKHgQVxctzwGRX5kRDUoYVVHWkEtPjTLefCK7K+Pa
 EuJjWSMfuxSpT/f/YGWHDexK5ubLnen33h99wia/B3PhtWwnuhRuWu4x6uzxGyADohaw
 xyIgXJ4kEMajLGR32/vyM90ndi1MmESRU7PUrz0k1/gn4R+xo/OPBuEGg0FXkd4ZmPYp
 ZcOvSn/aHeLbFinAGD+qXx5wUQU//Phqe4JDNNzXLsQ7cZaPYBv/XhnHQYAKf1d1Vc0j
 0uWhZmtU1pdHlwWa+/jc+0rwNcXN6Fwtt/mZBS2BzRR0PmwAbK0QTp4EUyYt3mfPtj5q
 v1bw==
X-Gm-Message-State: AOJu0YwmLHDUXNDTMItFABc4rCI7dX16wnuZuYhLsSb0UsGXyFka9iYR
 HZfebo9UWyyzrFs5Svi5KFXLOwnu205cnOL0sxM=
X-Google-Smtp-Source: AGHT+IGrp+w1VXqwtEvXXifDKd4X88X3zO3aijxuBgBzuw2e5k9SAZvzt1n10hrP1lm+89PrMLkPHQ==
X-Received: by 2002:a05:6e02:1aa4:b0:34f:b296:168d with SMTP id
 l4-20020a056e021aa400b0034fb296168dmr37352150ilv.26.1697232535587; 
 Fri, 13 Oct 2023 14:28:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 08/85] target/sparc: Move BPr to decodetree
Date: Fri, 13 Oct 2023 14:27:29 -0700
Message-Id: <20231013212846.165724-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd35.google.com
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
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 70 ++++++++++++++++-----------------------
 2 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 15cd975f4e..838f4cdb1d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -7,4 +7,7 @@
 BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
 Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
 
+%d16    20:s2 0:14
+BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=%d16
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 125015fe1e..f72e6eb756 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1292,14 +1292,13 @@ static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
     }
 }
 
-#ifdef TARGET_SPARC64
 // Inverted logic
-static const int gen_tcg_cond_reg[8] = {
-    -1,
+static const TCGCond gen_tcg_cond_reg[8] = {
+    TCG_COND_NEVER,  /* reserved */
     TCG_COND_NE,
     TCG_COND_GT,
     TCG_COND_GE,
-    -1,
+    TCG_COND_NEVER,  /* reserved */
     TCG_COND_EQ,
     TCG_COND_LE,
     TCG_COND_LT,
@@ -1313,16 +1312,6 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
     cmp->c2 = tcg_constant_tl(0);
 }
 
-static void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
-{
-    DisasCompare cmp;
-    gen_compare_reg(&cmp, cond, r_src);
-
-    /* The interface is to return a boolean in r_dst.  */
-    tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-}
-#endif
-
 static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
 {
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
@@ -1362,24 +1351,6 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
 }
 
 #ifdef TARGET_SPARC64
-static void do_branch_reg(DisasContext *dc, int32_t offset, uint32_t insn,
-                          TCGv r_reg)
-{
-    unsigned int cond = GET_FIELD_SP(insn, 25, 27), a = (insn & (1 << 29));
-    target_ulong target = dc->pc + offset;
-
-    if (unlikely(AM_CHECK(dc))) {
-        target &= 0xffffffffULL;
-    }
-    flush_cond(dc);
-    gen_cond_reg(cpu_cond, cond, r_reg);
-    if (a) {
-        gen_branch_a(dc, target);
-    } else {
-        gen_branch_n(dc, target);
-    }
-}
-
 static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
     switch (fccno) {
@@ -3022,6 +2993,31 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 TRANS(BPcc,  64, do_bpcc, a)
 TRANS(Bicc, ALL, do_bpcc, a)
 
+static bool trans_BPr(DisasContext *dc, arg_BPr *a)
+{
+    target_long target;
+    DisasCompare cmp;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    if (gen_tcg_cond_reg[a->cond] == TCG_COND_NEVER) {
+        return false;
+    }
+
+    target = dc->pc + a->i * 4;
+    if (unlikely(AM_CHECK(dc))) {
+        target &= 0xffffffffULL;
+    }
+
+    flush_cond(dc);
+
+    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
+
+    return advance_jump_cond(dc, a->a, target);
+}
+
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
 {
     target_long target = dc->pc + a->i * 4;
@@ -3065,15 +3061,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             case 0x1:           /* V9 BPcc */
                 g_assert_not_reached(); /* in decodetree */
             case 0x3:           /* V9 BPr */
-                {
-                    target = GET_FIELD_SP(insn, 0, 13) |
-                        (GET_FIELD_SP(insn, 20, 21) << 14);
-                    target = sign_extend(target, 16);
-                    target <<= 2;
-                    cpu_src1 = get_src1(dc, insn);
-                    do_branch_reg(dc, target, insn, cpu_src1);
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x5:           /* V9 FBPcc */
                 {
                     int cc = GET_FIELD_SP(insn, 20, 21);
-- 
2.34.1



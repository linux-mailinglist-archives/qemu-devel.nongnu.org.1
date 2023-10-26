Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F280F7D79BE
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2x-0007Ho-8H; Wed, 25 Oct 2023 20:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2p-000743-P0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-0004sS-Lg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso2037525ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279366; x=1698884166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKN37OBBkB+L9M8Uud4wSltlqA9gDCBy4N29LWBC2UM=;
 b=gb8OB9vd+OqAgyJ52POzt2CgjmEixh99F2rpkWmZwzl2RCesMU5yeNslCz4aRj+TYv
 TMbQAYEG7Yn8PxYrcyxCgokWVRtAJBb8E3r1lLDNG3ceM/tfZgZRSfvvFWAa8wLpiMgR
 rPNo00voahOsKWBebfWKV6let9l/Or8kfJJOaXwuygIdmyd3AtKCNGIY553YZ2/l83hm
 fioYQNPhkjaNyH7E1BulAObj0VZVCTXua0guX+zCZFJLoFMDzSC+fExM6yfYmJBBqiYc
 G+oPHmWMWe0O9DKLod+zA2l1NGsKNpZW6Bur25Q2FvHcUDY4jK3RamhZXSEhxfI9jDew
 22mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279366; x=1698884166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKN37OBBkB+L9M8Uud4wSltlqA9gDCBy4N29LWBC2UM=;
 b=mfdwOcoghu8ApA5qRjnBPYTFaJezLSWjThBVvtLycwgfnHXlVpRcPHBUybGPAgjt7y
 E3tphL1fEFnIsd3pn4+Z5HejzRKWIjh9r3d+ITSjASXTOyD1RTHk1v3xh00yO/Ne3t5l
 HvZg1C1LiKSjpp3p30OmeY5dVJ8eVsptloqzyvmgPmQ3H1BZpnbW8J+w4lXBBDMPeAhf
 PTQJGfmy3x8epHRz4dM03vZ5zLQ5yyQL/QZLk1CfV0LO58Px6ut8Ku/bYWTJ840yzMax
 83VshH810nV64W8APQjecmgACXp1WP1h6d2VO5DtRYq3KjEwipBzdTbxyw6ldpm2FFi+
 6U9w==
X-Gm-Message-State: AOJu0YwpI+nFYUvyOGtpM8Ki8LddflZ34+HHKdKWrVEZr0AVuLtKd1+5
 nN2YKrwORaszIVqfCl/43SwWqqopp6EPBOwlwX8=
X-Google-Smtp-Source: AGHT+IGFSBjgb0e9HeTFi96NeK+4yx1SrGeV96zggynyRV0JfoUmTZQfVsq/sKwlKgv45zHMA/BhWw==
X-Received: by 2002:a17:902:eccb:b0:1c9:ba18:785c with SMTP id
 a11-20020a170902eccb00b001c9ba18785cmr17910028plh.25.1698279366306; 
 Wed, 25 Oct 2023 17:16:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 14/94] target/sparc: Move BPr to decodetree
Date: Wed, 25 Oct 2023 17:14:06 -0700
Message-Id: <20231026001542.1141412-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 63 ++++++++++++++-------------------------
 2 files changed, 25 insertions(+), 41 deletions(-)

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
index 92ea6bab6b..2d08c81821 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1336,14 +1336,13 @@ static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
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
@@ -1357,16 +1356,6 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
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
@@ -1406,24 +1395,6 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
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
@@ -3063,6 +3034,24 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 TRANS(Bicc, ALL, do_bpcc, a)
 TRANS(BPcc,  64, do_bpcc, a)
 
+static bool trans_BPr(DisasContext *dc, arg_BPr *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+    DisasCompare cmp;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    if (gen_tcg_cond_reg[a->cond] == TCG_COND_NEVER) {
+        return false;
+    }
+
+    flush_cond(dc);
+    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
+    return advance_jump_cond(dc, a->a, target);
+}
+
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
@@ -3102,15 +3091,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



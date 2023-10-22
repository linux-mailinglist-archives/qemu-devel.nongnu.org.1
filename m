Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512A7D2149
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW5-0000X2-Ra; Sun, 22 Oct 2023 02:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW3-0000VS-1b
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW1-0001XZ-BX
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-694ed847889so1793777b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954444; x=1698559244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJuNpMjdlDyXqaeom2c3v8J1CgmGjKoFqjHBWEKYq9c=;
 b=jpTeNVVQm2Kkl1UWaI7vwPWVvwbaKHS7UufazOxoGzG6MP/3p3g5CoXYRtgpVYlq9N
 b3nAFCVj4kg6T0iinHPIMihMOwRry3m7uVr8ueOn+BNmiBtTB05emscmEjV1D09X83zu
 gFHOgaKe13j1HMQs13KN6eNSmKpIpNPYgp0gVCBhofDsI8XuTPiKfhKYE8YLdAhI5cv2
 1EV/YqMwmgW7alcPrJQph6f3W9oFJXHMIi/tzulzQG52Jcnf1aolWp4N7CNLW5GIj2vt
 ml2Fm+iPdebvVAdxl1L0sEl2/AdkmT0qnqaS8+h2Fz7bXuteXAhBqg1iAe1291+uiukO
 2nsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954444; x=1698559244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJuNpMjdlDyXqaeom2c3v8J1CgmGjKoFqjHBWEKYq9c=;
 b=P8EcrY4VRBYd0P9BWZpkdcSJZ0LosJUOtMFQjUyQSzO5Q2ZxS3KFq1sorV2QpJgFJ7
 EmJUqo+gBitq66j5JXyoqP67UMb8jL9eWt2LkYcAxb/Tl4Cgsx/jAqqvVDt4rJJbWZAC
 UmFNjJu1gW5tjswilY348J3ADSSmGS91mGyBUJi2IkLpOvLRytIFyh4pLXDQJyCNJGW3
 m9JDZjdkMh4WbggM2hzYPJPpZ46CHOTr+z+bD7qskUaJA1bA4E3oLMymYzgY7yE7w4sZ
 canY28PdT1Cuxvt5YYA4FtK1+w400ajuP+uXvKiPGtqdZjYhSxnzbEsE8ni4WUKjIdd5
 MI7Q==
X-Gm-Message-State: AOJu0YwHy2GgJs9YPONv1f3y+tm5GjdvlJTYbvpbWzalnLB0qA65bfLr
 Drb6tZ3G21MAp5rt86qJp+FvONXZ/2wCZ38mEnE=
X-Google-Smtp-Source: AGHT+IFft0ZrMXlMUluyO82VR/SACVYS3ddgplvdaW57ykpDdi4WradB3XbTvQSC/WLUUaQ6opz84w==
X-Received: by 2002:a17:902:d4c6:b0:1ca:15ad:1c6 with SMTP id
 o6-20020a170902d4c600b001ca15ad01c6mr4671697plg.33.1697954443976; 
 Sat, 21 Oct 2023 23:00:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 13/90] target/sparc: Move BPr to decodetree
Date: Sat, 21 Oct 2023 22:59:14 -0700
Message-Id: <20231022060031.490251-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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



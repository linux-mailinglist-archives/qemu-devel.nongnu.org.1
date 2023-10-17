Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CC7CBB27
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKA-0000C4-8E; Tue, 17 Oct 2023 02:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK8-00009M-9Y
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK6-0003rc-GA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso3474861b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523177; x=1698127977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aScXEhTMvdzDj5fSq3h8j0/JjPyqPLvXUvhxDxk8h58=;
 b=NnoT5UFbuOx/ri2sBnxAfj4C0mI1Ci09x7gdBaiJQEknucpq8FDc1F+IGABd0UBJPO
 sVY2qrColDs7qmgxLKPi7VWuL9CzV/ToTlkHm5juONUf+ogmChkGzVu2ha5xMWrD4xdA
 WhoNjmAfhJK3EYvLJNS38dv3CewXYGZKeRuzFnOso1K9Xdnbo9v0vBBW22+dW7nTCJic
 1pVaEAM1Ta/LpGJVNXgG+FLO1ELOV99iQSZM6ydlScisgVYS7kE88wbb2jEpwj8XaiII
 EQS9rM90++Pl+9utjWG9KpmXXq5G+HGfjKmWfTCXiumTt9rh17l09SGk3pQYQn6F5rgS
 KfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523177; x=1698127977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aScXEhTMvdzDj5fSq3h8j0/JjPyqPLvXUvhxDxk8h58=;
 b=pyYf3yTn1h2qw4elXDGPeetNhTONJLPmf0+PVsV7mTf81lj3nzi3qkfT4ajDz5q//d
 BiWIe45FliU8LHMcM0CDaRItlH8ACVe9kd8WT6Ty06+l7GxtkCPynhqkmvKKpNqme6e+
 YozlVdkz7/Gu+u/g05VCmSDA7dVvqBp3XMdcaPcmsO17CepW0iYoZuIAfw4eJrz6TAHy
 B1kDSGL0SFttccyml6vU6u50FDnk9QL67edQjXYCFB7s47xv1Cnd1H6cTFY3XTjwzVgY
 +AErZEWaQ9o1+BgqJFsotVY3nu6C3F0WHoWhD1OrU90WfI0L+zGrwOfnVqKZApSc9n+t
 CGuw==
X-Gm-Message-State: AOJu0YxmqhjWKqLVdY5wQYvcK898mijyt2OFoZOHb1ZPfAz3Pu0cJbcY
 f5fAVrcZE1SWMjKzg9I5YQgITc3HgPP5ronBxRk=
X-Google-Smtp-Source: AGHT+IFBjQaulliWAP9CJZVyPurLe1iSmZTUa61K6OlGGxwjxJcoYsB80zwZcFn57pHdBLHiA8QmGg==
X-Received: by 2002:a05:6a20:914e:b0:160:83e1:712f with SMTP id
 x14-20020a056a20914e00b0016083e1712fmr1318902pzc.23.1697523177282; 
 Mon, 16 Oct 2023 23:12:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/90] target/sparc: Move BPr to decodetree
Date: Mon, 16 Oct 2023 23:11:27 -0700
Message-Id: <20231017061244.681584-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 7e14070322..a3c86b22d1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1331,14 +1331,13 @@ static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
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
@@ -1352,16 +1351,6 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
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
@@ -1401,24 +1390,6 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
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
@@ -3061,6 +3032,31 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
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
@@ -3104,15 +3100,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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



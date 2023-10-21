Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1D7D1AE9
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4av-0007BG-9A; Sat, 21 Oct 2023 01:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4at-00079s-5C
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ar-0008NB-HC
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1259297b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866331; x=1698471131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJuNpMjdlDyXqaeom2c3v8J1CgmGjKoFqjHBWEKYq9c=;
 b=S5AruiEWN/15ANWzKWRsuIE/ffSNRSPeHfJMU6BPU6QN/Y4ntEV2UTOvuAAGl1Dr0k
 qAOm5JdVqkX4ycJAF+cAfujscuv48IvEF2P/Yl/3SVaSj/FRl82ZK4JHA2JEBmaSgy69
 B/hS1RTx7c5w/3QfN7wW65Sch26AniJLYfc2nGezGKMnPj49vCp216svRfweiOk4Ky7F
 5EzQJMdCpUKc9j7Kpnn7jGuiKb+Qdeac1ksSUhhVjyln6STM0eV9gE85VX4U4XgIZkHl
 j+eX3pCahb52JNVDFaupA0ZRHpsrAn3airFFOqEvsB6gXUvoS21FXgzWcAUhXB30L9XO
 AV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866331; x=1698471131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJuNpMjdlDyXqaeom2c3v8J1CgmGjKoFqjHBWEKYq9c=;
 b=PbghHSI6/Dbb2MCPCy8c/HMgdt7bXD19SN2AyvH4DGpnJeSg4gVf7lC/WIvzCfMWWV
 WIP36f4vS1fr60LXfPuKA4EVqhQGOIz4ctQd6SAS2UVQXtOl2fHDUsB4EqCoksv9n0l9
 RgasH6VCHmtwovXj9c+1hXOxIm2F9IYPDNFf2Xn0UDX5Gnu1WAcm4z3CM7ilUAhu/hum
 z5FXaAfy5AU8xn+gz/etCEnwJFvzo1cectTZ4p8n80ds0xDWbq1yPG5BxPnl1zwI5O2L
 6alP6pR8Z6tHRy65VLPjzHFN82knwFQ1ZfVvosnrFb54+AfRHKLYy5+iRP5oIHVI3Wn7
 EuLA==
X-Gm-Message-State: AOJu0YxwKCJxfmRk5i70b7WonM10jTqnrLsmMaAevX5FWrl6SqAPPmG6
 abBNolaVftw+BSg15UkrhuLOnFVmFkwlZmZEjqg=
X-Google-Smtp-Source: AGHT+IGeQMOYonEodglijF8sCO41rrMrnterdUKZnV5xfqOjkncTUbgiESfc0+uCrlzxQdleZiulkw==
X-Received: by 2002:a05:6a00:99e:b0:6be:265:1bf5 with SMTP id
 u30-20020a056a00099e00b006be02651bf5mr4005461pfg.24.1697866330706; 
 Fri, 20 Oct 2023 22:32:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 13/90] target/sparc: Move BPr to decodetree
Date: Fri, 20 Oct 2023 22:30:41 -0700
Message-Id: <20231021053158.278135-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
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



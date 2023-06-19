Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5777359A3
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsu-0000e1-HM; Mon, 19 Jun 2023 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsi-0000Zk-0o
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsg-0002Ba-02
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f904dcc1e2so24314345e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184960; x=1689776960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7l+ZsA3tEJ7e9mj81PR383GnadYfBL0LIimUCD7qHwo=;
 b=jOrIJqJ5tvNmD4yrdsLz6lFIfcw/rdZASyequoaNAXChvdvm9h14cL4fhIl/w7LPbR
 bbm/R07jRHUA4l7hpsI1ZCL41jFS+KLUsSAM+K56sCfdbDXeY7FOF3S+PQOrQBK25JQF
 o4xWPzd/aojMKKqTxIt+zJX1c+GSaYaYcnoBxCowU7CwXUPLPnFU5P142N7VzlQab2RJ
 G3/l5UhFeFSKwAf5Q7QmAMT0J8AQeHCtg6UBGfjRpo392rbZCb1l6eu8giio2UvdMYlE
 mbAZZ54cZlk4nTcSpW+pnRdUxNWAINJnW++kZPKcdtY8FIH62JogBMP/tUEmK85ZJ3io
 BeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184960; x=1689776960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7l+ZsA3tEJ7e9mj81PR383GnadYfBL0LIimUCD7qHwo=;
 b=hGqnYasZhJ3PNhgPSrRe8g46DRsoioIlkymoMGeiKNcjHJ33Yrga36IwU/r0rn/roM
 A//FxaM9D0+gmMWzK/PIgyhkJEOYaoJ+V4b0tn4Aa7EUdCffqx2+eVyJb15muzjLV3Sh
 EyFSWmgojRXXid2ib7tUCEnCQCqgpez3Mmpwj16yr7/bCU2Q5vYfrapxQvpQoECcNr6h
 3au/bfq4fErufuv6dSoVUXsQ7GsCmBbgy3Dd5n2b0cMiMLQRKqqeBLpkytaZqwcZ5CrX
 wwbYywBzsSda/kZ56Uj/s1brBCW1GDjJ7L2RT4bq5KI8bozGbYYK/L+7Zpw1M4V1LJDv
 XRgQ==
X-Gm-Message-State: AC+VfDxigg1QexwF0wchagc8G3UPhHuii5xCO4VSs2gm6C3sr/wSWzuh
 Mj0ulhufTdvQ07ltNXOtDVgMCvauQQq1B9bJpx4=
X-Google-Smtp-Source: ACHHUZ75mBCVtX2rwHmEBpFQw0oPWU2Fm16bsHZDzGFm9yZmx43UB3Z+lR6lqy3Iwe2bvDlEx5DxuA==
X-Received: by 2002:a05:600c:2905:b0:3f9:b535:381b with SMTP id
 i5-20020a05600c290500b003f9b535381bmr377665wmd.35.1687184960432; 
 Mon, 19 Jun 2023 07:29:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] target/arm: Convert MSR (reg), MRS, SYS,
 SYSL to decodetree
Date: Mon, 19 Jun 2023 15:28:50 +0100
Message-Id: <20230619142914.963184-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert MSR (reg), MRS, SYS, SYSL to decodetree.  For QEMU these are
all essentially the same instruction (system register access).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-7-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/a64.decode      |  8 ++++++++
 target/arm/tcg/translate-a64.c | 32 +++++---------------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4f94a08907b..c49215cca8d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -207,3 +207,11 @@ MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
 MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
 MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
 MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
+
+# MRS, MSR (register), SYS, SYSL. These are all essentially the
+# same instruction as far as QEMU is concerned.
+# NB: op0 is bits [20:19], but op0=0b00 is other insns, so we have
+# to hand-decode it.
+SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 op0=1
+SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 op0=2
+SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 op0=3
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8c57b48d81f..74a389da4a7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2122,7 +2122,7 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
  * These are all essentially the same insn in 'read' and 'write'
  * versions, with varying op0 fields.
  */
-static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
+static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
@@ -2307,28 +2307,10 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     }
 }
 
-/* System
- *  31                 22 21  20 19 18 16 15   12 11    8 7   5 4    0
- * +---------------------+---+-----+-----+-------+-------+-----+------+
- * | 1 1 0 1 0 1 0 1 0 0 | L | op0 | op1 |  CRn  |  CRm  | op2 |  Rt  |
- * +---------------------+---+-----+-----+-------+-------+-----+------+
- */
-static void disas_system(DisasContext *s, uint32_t insn)
+static bool trans_SYS(DisasContext *s, arg_SYS *a)
 {
-    unsigned int l, op0, op1, crn, crm, op2, rt;
-    l = extract32(insn, 21, 1);
-    op0 = extract32(insn, 19, 2);
-    op1 = extract32(insn, 16, 3);
-    crn = extract32(insn, 12, 4);
-    crm = extract32(insn, 8, 4);
-    op2 = extract32(insn, 5, 3);
-    rt = extract32(insn, 0, 5);
-
-    if (op0 == 0) {
-        unallocated_encoding(s);
-        return;
-    }
-    handle_sys(s, insn, l, op0, op1, op2, crn, crm, rt);
+    handle_sys(s, a->l, a->op0, a->op1, a->op2, a->crn, a->crm, a->rt);
+    return true;
 }
 
 /* Exception generation
@@ -2435,11 +2417,7 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
     switch (extract32(insn, 25, 7)) {
     case 0x6a: /* Exception generation / System */
         if (insn & (1 << 24)) {
-            if (extract32(insn, 22, 2) == 0) {
-                disas_system(s, insn);
-            } else {
-                unallocated_encoding(s);
-            }
+            unallocated_encoding(s);
         } else {
             disas_exc(s, insn);
         }
-- 
2.34.1



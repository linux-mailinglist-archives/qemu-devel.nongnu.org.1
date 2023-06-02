Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C24177206AE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574t-0003AP-Tk; Fri, 02 Jun 2023 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574s-00038y-1L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574o-0003S2-Mx
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f68fc6b479so21648565e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721149; x=1688313149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2eo472r8J3U7OZYtDc9uvjFKt5zEODMaDr+F6ZoZiNU=;
 b=RrXxNu9X7PUp+GDmBbhv2yDMm08UbEZtD9LktHFoMRFIUF+N9f2Q44dq2pIT+Mji3k
 aFCXfaeB6sOM01Tc961y7DJsvLHWWAtV3tpDAnm5Wj5wqiBYF0J0pEz4+B96v0tZCPBE
 UdyvlHIqPmI6FJsM3fQ2y/Y5zwl4m1E74N65lRKUizfxhcC4JAn+KstgJ4OLA/0bQa/F
 z8n3zL8ZbyGowvyuPHKEPHnkN0EnDUCWlaHlsX7SneGSUwgZNDNrfYTNUwT3p1EKbt8v
 CeTYtdr17YqY2JRErjl88wyLxOuVIBSI55gDQgDWMbcMbEf63QREz4+CX6+L4ABu7dDM
 At0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721149; x=1688313149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2eo472r8J3U7OZYtDc9uvjFKt5zEODMaDr+F6ZoZiNU=;
 b=iBT6Kdt+SLXcbGFoUPFq24pXg1D+PILhxES3YYQ1cJvq1R2Lc1tGF+wKjqKhVRb+Lf
 AeHBUwVnzFAZ3z9ZBw+sJ26LaTd4ag3cRuvp6Vt2f+NCaQsLZW9nlLiXa8o+hQE1FTTP
 R18DIQlnjZ6/06SLKyX4pSSCueVZQZmUS1SKQxZ9NkvkxZswQfOQjUIxsMBR574mxyfx
 IO1rargzrtzbwJosVQmmS6pkaqaVfcUgKRQV9A7VIUj+mtYbsAFLjfV7pm88V5idg/9L
 R2BhBM1KsTRBL1XtHxCjG6ZHJdqnsu1/bPlRKzP1JfEhdSoKxOEh+VsbJSJNqD9OcJ28
 ZgtQ==
X-Gm-Message-State: AC+VfDz289zf1SzXSvf3nJRK+Hv/cGnFbv8djWGNnhpn0Kd3kHxJ1wgP
 az4OLdaFn93MA/9EWoAQsyLgag==
X-Google-Smtp-Source: ACHHUZ6iz4GzI2FviRJM78uHqHxd4Vr+k/3/DCiXA4yHM3bT5HYmjr0j30dSy6Am8nByqO5uzfR1bA==
X-Received: by 2002:a7b:cb88:0:b0:3f6:f56:5e82 with SMTP id
 m8-20020a7bcb88000000b003f60f565e82mr2469414wmi.3.1685721149101; 
 Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/20] target/arm: Convert MSR (reg), MRS, SYS,
 SYSL to decodetree
Date: Fri,  2 Jun 2023 16:52:09 +0100
Message-Id: <20230602155223.2040685-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/tcg/a64.decode      |  8 ++++++++
 target/arm/tcg/translate-a64.c | 32 +++++---------------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a645dac8d26..e1a120ea4c0 100644
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
index bdc1ee18cdc..8e4d3676992 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2070,7 +2070,7 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
  * These are all essentially the same insn in 'read' and 'write'
  * versions, with varying op0 fields.
  */
-static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
+static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
@@ -2254,28 +2254,10 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
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
@@ -2382,11 +2364,7 @@ static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A049720695
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574s-00039E-R0; Fri, 02 Jun 2023 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574p-00036m-LJ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574m-0003Qq-FM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso22542835e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721147; x=1688313147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8bAEGzOfvPGfWDyJXndBi9fppWOebMwnl9nEal6GFOc=;
 b=TpR+HfWXkgqWhgSsT49f6tSIT4thDd82wglrzPiEtqmWhZvM8TpBRtEdpd3hZJeXAl
 DO83oLAknQ5q/34oEop/qY1Mg3hbqw1RYTVeElpjGvTLNYs3c8SnMYyxMZ4KyYi1cdkn
 qhoGrP5ADe6NPNxmyqLCfLg0xC1jBypPQ5hJDI1/qtn6jw0zpEI+NGMuvk/eXgN5uaQq
 0mOJ+vAEBFPz9V4x1wHN6JUQOQV0aTG2GKrUAf8k7RFAlYmdzQ6f/7LbVBUmJGUoA+GO
 Y68S/rjEow1aJ4RYvWkm07Vu9QiWsIu4as2WNFPdjtq9bBDpGKn9VDlRzutNjGS4dog/
 2Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721147; x=1688313147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bAEGzOfvPGfWDyJXndBi9fppWOebMwnl9nEal6GFOc=;
 b=JeQLnSxBKWpxbh6pmxF6N80RPIkSIpSNXlmNsNxEH/c8/pXCAQkskjwiQ2PaS2ysdE
 iAQ4HaORoks5UOxCoeT94jREcld6kuyPRkHgwzknk8icG+gdcB5y6RHo0HQ/uLEhu/a3
 z8/rRcgsTNAY9DXbG5M45sTe20mg8zv9qKPp82vC6juw510D1hNFCKQyy9ftpXfVfT+e
 tb8BvLqUCJbN7Jz6eoA2q75HXeQ0pCFasjfQJAP6DtQVJ/0JoqG8o5671kIm4PH+J1Du
 bFzK+syfoZ5WLeluTEriRfiqqgow0aABflWNcwH6tPeA/7PR3MM01tjxDUCTNJGASBrk
 4brQ==
X-Gm-Message-State: AC+VfDwwKw2P4pDuYXOlmEq51jyhpUQNLxG5+gXxHYwz7rPALStG+tuX
 oYj10GYYbef9aQ6bwJtcb9zRHviH4bngCU8FR3g=
X-Google-Smtp-Source: ACHHUZ5tKkC/I9DOn7HWaceSx6x9eL5tQ1w2Olsmg6guaDbmEfW3d8ccORU9DyijQBtkK57aDV3nqg==
X-Received: by 2002:a05:600c:3798:b0:3f6:244:55df with SMTP id
 o24-20020a05600c379800b003f6024455dfmr2448989wmr.29.1685721147077; 
 Fri, 02 Jun 2023 08:52:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/20] target/arm: Convert hint instruction space to decodetree
Date: Fri,  2 Jun 2023 16:52:05 +0100
Message-Id: <20230602155223.2040685-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Convert the various instructions in the hint instruction space
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  31 ++++
 target/arm/tcg/translate-a64.c | 277 ++++++++++++++++++---------------
 2 files changed, 185 insertions(+), 123 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 12a310d0a31..1efd436e175 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -150,3 +150,34 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
 # the processor is in halting debug state (which we don't implement).
 # The pattern is listed here as documentation.
 # DRPS            1101011 0101 11111 000000 11111 00000
+
+# Hint instruction group
+{
+  [
+    YIELD       1101 0101 0000 0011 0010 0000 001 11111
+    WFE         1101 0101 0000 0011 0010 0000 010 11111
+    WFI         1101 0101 0000 0011 0010 0000 011 11111
+    # We implement WFE to never block, so our SEV/SEVL are NOPs
+    # SEV       1101 0101 0000 0011 0010 0000 100 11111
+    # SEVL      1101 0101 0000 0011 0010 0000 101 11111
+    # Our DGL is a NOP because we don't merge memory accesses anyway.
+    # DGL       1101 0101 0000 0011 0010 0000 110 11111
+    XPACLRI     1101 0101 0000 0011 0010 0000 111 11111
+    PACIA1716   1101 0101 0000 0011 0010 0001 000 11111
+    PACIB1716   1101 0101 0000 0011 0010 0001 010 11111
+    AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
+    AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
+    ESB         1101 0101 0000 0011 0010 0010 000 11111
+    PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
+    PACIASP     1101 0101 0000 0011 0010 0011 001 11111
+    PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
+    PACIBSP     1101 0101 0000 0011 0010 0011 011 11111
+    AUTIAZ      1101 0101 0000 0011 0010 0011 100 11111
+    AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
+    AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
+    AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+  ]
+  # The canonical NOP has CRm == op2 == 0, but all of the space
+  # that isn't specifically allocated to an instruction must NOP
+  NOP           1101 0101 0000 0011 0010 ---- --- 11111
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 075553e15f5..ecc4b9c1bd3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1594,133 +1594,167 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     return true;
 }
 
-/* HINT instruction group, including various allocated HINTs */
-static void handle_hint(DisasContext *s, uint32_t insn,
-                        unsigned int op1, unsigned int op2, unsigned int crm)
+static bool trans_NOP(DisasContext *s, arg_NOP *a)
 {
-    unsigned int selector = crm << 3 | op2;
+    return true;
+}
 
-    if (op1 != 3) {
-        unallocated_encoding(s);
-        return;
+static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
+{
+    /*
+     * When running in MTTCG we don't generate jumps to the yield and
+     * WFE helpers as it won't affect the scheduling of other vCPUs.
+     * If we wanted to more completely model WFE/SEV so we don't busy
+     * spin unnecessarily we would need to do something more involved.
+     */
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        s->base.is_jmp = DISAS_YIELD;
     }
+    return true;
+}
 
-    switch (selector) {
-    case 0b00000: /* NOP */
-        break;
-    case 0b00011: /* WFI */
-        s->base.is_jmp = DISAS_WFI;
-        break;
-    case 0b00001: /* YIELD */
-        /* When running in MTTCG we don't generate jumps to the yield and
-         * WFE helpers as it won't affect the scheduling of other vCPUs.
-         * If we wanted to more completely model WFE/SEV so we don't busy
-         * spin unnecessarily we would need to do something more involved.
+static bool trans_WFI(DisasContext *s, arg_WFI *a)
+{
+    s->base.is_jmp = DISAS_WFI;
+    return true;
+}
+
+static bool trans_WFE(DisasContext *s, arg_WFI *a)
+{
+    /*
+     * When running in MTTCG we don't generate jumps to the yield and
+     * WFE helpers as it won't affect the scheduling of other vCPUs.
+     * If we wanted to more completely model WFE/SEV so we don't busy
+     * spin unnecessarily we would need to do something more involved.
+     */
+    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
+        s->base.is_jmp = DISAS_WFE;
+    }
+    return true;
+}
+
+static bool trans_XPACLRI(DisasContext *s, arg_XPACLRI *a)
+{
+    if (s->pauth_active) {
+        gen_helper_xpaci(cpu_X[30], cpu_env, cpu_X[30]);
+    }
+    return true;
+}
+
+static bool trans_PACIA1716(DisasContext *s, arg_PACIA1716 *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+    }
+    return true;
+}
+
+static bool trans_PACIB1716(DisasContext *s, arg_PACIB1716 *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+    }
+    return true;
+}
+
+static bool trans_AUTIA1716(DisasContext *s, arg_AUTIA1716 *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+    }
+    return true;
+}
+
+static bool trans_AUTIB1716(DisasContext *s, arg_AUTIB1716 *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+    }
+    return true;
+}
+
+static bool trans_ESB(DisasContext *s, arg_ESB *a)
+{
+    /* Without RAS, we must implement this as NOP. */
+    if (dc_isar_feature(aa64_ras, s)) {
+        /*
+         * QEMU does not have a source of physical SErrors,
+         * so we are only concerned with virtual SErrors.
+         * The pseudocode in the ARM for this case is
+         *   if PSTATE.EL IN {EL0, EL1} && EL2Enabled() then
+         *      AArch64.vESBOperation();
+         * Most of the condition can be evaluated at translation time.
+         * Test for EL2 present, and defer test for SEL2 to runtime.
          */
-        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            s->base.is_jmp = DISAS_YIELD;
+        if (s->current_el <= 1 && arm_dc_feature(s, ARM_FEATURE_EL2)) {
+            gen_helper_vesb(cpu_env);
         }
-        break;
-    case 0b00010: /* WFE */
-        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-            s->base.is_jmp = DISAS_WFE;
-        }
-        break;
-    case 0b00100: /* SEV */
-    case 0b00101: /* SEVL */
-    case 0b00110: /* DGH */
-        /* we treat all as NOP at least for now */
-        break;
-    case 0b00111: /* XPACLRI */
-        if (s->pauth_active) {
-            gen_helper_xpaci(cpu_X[30], cpu_env, cpu_X[30]);
-        }
-        break;
-    case 0b01000: /* PACIA1716 */
-        if (s->pauth_active) {
-            gen_helper_pacia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
-        }
-        break;
-    case 0b01010: /* PACIB1716 */
-        if (s->pauth_active) {
-            gen_helper_pacib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
-        }
-        break;
-    case 0b01100: /* AUTIA1716 */
-        if (s->pauth_active) {
-            gen_helper_autia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
-        }
-        break;
-    case 0b01110: /* AUTIB1716 */
-        if (s->pauth_active) {
-            gen_helper_autib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
-        }
-        break;
-    case 0b10000: /* ESB */
-        /* Without RAS, we must implement this as NOP. */
-        if (dc_isar_feature(aa64_ras, s)) {
-            /*
-             * QEMU does not have a source of physical SErrors,
-             * so we are only concerned with virtual SErrors.
-             * The pseudocode in the ARM for this case is
-             *   if PSTATE.EL IN {EL0, EL1} && EL2Enabled() then
-             *      AArch64.vESBOperation();
-             * Most of the condition can be evaluated at translation time.
-             * Test for EL2 present, and defer test for SEL2 to runtime.
-             */
-            if (s->current_el <= 1 && arm_dc_feature(s, ARM_FEATURE_EL2)) {
-                gen_helper_vesb(cpu_env);
-            }
-        }
-        break;
-    case 0b11000: /* PACIAZ */
-        if (s->pauth_active) {
-            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30],
-                             tcg_constant_i64(0));
-        }
-        break;
-    case 0b11001: /* PACIASP */
-        if (s->pauth_active) {
-            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
-        }
-        break;
-    case 0b11010: /* PACIBZ */
-        if (s->pauth_active) {
-            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30],
-                             tcg_constant_i64(0));
-        }
-        break;
-    case 0b11011: /* PACIBSP */
-        if (s->pauth_active) {
-            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
-        }
-        break;
-    case 0b11100: /* AUTIAZ */
-        if (s->pauth_active) {
-            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30],
-                             tcg_constant_i64(0));
-        }
-        break;
-    case 0b11101: /* AUTIASP */
-        if (s->pauth_active) {
-            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
-        }
-        break;
-    case 0b11110: /* AUTIBZ */
-        if (s->pauth_active) {
-            gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30],
-                             tcg_constant_i64(0));
-        }
-        break;
-    case 0b11111: /* AUTIBSP */
-        if (s->pauth_active) {
-            gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
-        }
-        break;
-    default:
-        /* default specified as NOP equivalent */
-        break;
     }
+    return true;
+}
+
+static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30], tcg_constant_i64(0));
+    }
+    return true;
+}
+
+static bool trans_PACIASP(DisasContext *s, arg_PACIASP *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+    }
+    return true;
+}
+
+static bool trans_PACIBZ(DisasContext *s, arg_PACIBZ *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30], tcg_constant_i64(0));
+    }
+    return true;
+}
+
+static bool trans_PACIBSP(DisasContext *s, arg_PACIBSP *a)
+{
+    if (s->pauth_active) {
+        gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+    }
+    return true;
+}
+
+static bool trans_AUTIAZ(DisasContext *s, arg_AUTIAZ *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30], tcg_constant_i64(0));
+    }
+    return true;
+}
+
+static bool trans_AUTIASP(DisasContext *s, arg_AUTIASP *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+    }
+    return true;
+}
+
+static bool trans_AUTIBZ(DisasContext *s, arg_AUTIBZ *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30], tcg_constant_i64(0));
+    }
+    return true;
+}
+
+static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
+{
+    if (s->pauth_active) {
+        gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+    }
+    return true;
 }
 
 static void gen_clrex(DisasContext *s, uint32_t insn)
@@ -2246,9 +2280,6 @@ static void disas_system(DisasContext *s, uint32_t insn)
             return;
         }
         switch (crn) {
-        case 2: /* HINT (including allocated hints like NOP, YIELD, etc) */
-            handle_hint(s, insn, op1, op2, crm);
-            break;
         case 3: /* CLREX, DSB, DMB, ISB */
             handle_sync(s, insn, op1, op2, crm);
             break;
-- 
2.34.1



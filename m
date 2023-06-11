Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D472B2BE
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVb-0006Nv-2E; Sun, 11 Jun 2023 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUg-0005ph-FW
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:50 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUc-0000Ru-7Z
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so24670405e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499236; x=1689091236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tdjaSXSdLsKu4MO87YZyRq3fS44rsN7i4e3GLBzxGpI=;
 b=GrAVhpesV/vOpDjAWBgmbsaQ5nB9zyuAeSUVrjO8t3X9dgp3KaHoCnVpyN6UWwuyHD
 jt5hB59yssTkT73UOElTRWlB7PIup/lcuighshQvSNT9Gy4YrLWze1fW2SjwDzqjudJf
 9WSvLYDvVLjUROz5iFFQnCii/4nroQlG/QPxcpfw5LMJxFr9nRDsGW1b89/DHk4o2gNz
 HrGezyof+9TRUxA6MOj6G5XGQm4wwpemw1CuvCaQ3nJbVAxstDe+kAEFiSfT8zKQnC7C
 lKnFJESyCN5J1jdYHCL/bSX9hAKfSyKCTGgEoEHaT5fckYeY/Cn0tnA88q2YTM8DNQZ5
 wBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499236; x=1689091236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdjaSXSdLsKu4MO87YZyRq3fS44rsN7i4e3GLBzxGpI=;
 b=E4KZmsShagSzkQLYPI20HjjtZk9uVxzhBe8suMsOkTNN9hYs4UQsbBZonUgYLvew7A
 Z9yi6MIKFTXEzwbiMaCUyq4+pV6FBwVjfnfYde77cU+u8GrwCitSJOKW69bcd8elSjuB
 9IpR19zqy1oTBDpO9zWpAXLsd2WepQfavEL/mOW/VYn/yqqVG/i0Oqda6DgKx+GXo0s8
 UTqXRyNq3Qmuej9Ccerd5gKuILXwxCltL2p7a8pnYsM65KP3RmI226LZj2QslUQKyQOe
 jRfcQ/2BhQP+HfE7+FXv2DyUDYfjzgzMb29sis9KRiWkixsV8zU/3/Ai6r61JWwKAHrs
 oaLw==
X-Gm-Message-State: AC+VfDwl129BfqzlxSr3X0Z3yiNWwp8eNvvLKOE7lXYn/l/Jan39iJfn
 44Z8AcnUwKR9NRoxfZAkYLV0ug==
X-Google-Smtp-Source: ACHHUZ7kRqF8I5kYzxdmnYFFypm5F+tISPZNd+8utzo3V5vyIFNo+wxEQJ6nhmYfDu1M5P97cvWc2Q==
X-Received: by 2002:a7b:cc82:0:b0:3f6:f4b:38bd with SMTP id
 p2-20020a7bcc82000000b003f60f4b38bdmr4487715wma.8.1686499236652; 
 Sun, 11 Jun 2023 09:00:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/23] target/arm: Convert hint instruction space to
 decodetree
Date: Sun, 11 Jun 2023 17:00:14 +0100
Message-Id: <20230611160032.274823-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-3-peter.maydell@linaro.org
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
index 1108f8287b8..eb8addac1b3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1649,133 +1649,167 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
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
@@ -2302,9 +2336,6 @@ static void disas_system(DisasContext *s, uint32_t insn)
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



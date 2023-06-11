Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0E72B2B9
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVi-0006b1-Ah; Sun, 11 Jun 2023 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUl-0005rT-9t
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUg-0000Sq-17
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30e3caa6aa7so3446314f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499239; x=1689091239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hv0rchOEEfJPVEoDeEXmaUe1CECfSOxYqHxG0bO7LPk=;
 b=S+ijqPSiTZH+6QFKDNA8RgF8SqtkXJcXHWed9aHAqAWaktXrPTq4+cpVH7MbzZekIB
 3/dRxe8dHM+NKHkLjXJlduSx9b7fIg/Ae0VtRrzWkl6MYMfLTXo6fN5F0ZPxmq7seZ5a
 IZysjIDbPLim8XEjwkwnWK1ud28uayY32jtk3nSktlf5N3N97RyqtDyoPof/bJg4zeM2
 SKhRldNbCPUDiZKlcdijPrkWKCTDaiMxiD9jl+mBY26nmcFAuT13//mYWg4Wd2R3Iel1
 ms6iN+1K5j8d9y/ie66ALvG+sINUW0cZEy1TzYx+66HJ+Td32pyRkScF0yU7ePiilEHO
 b9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499239; x=1689091239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv0rchOEEfJPVEoDeEXmaUe1CECfSOxYqHxG0bO7LPk=;
 b=Qz+h3TKlffeo8uPKLcAsWvj7bAsP5T2XROzrsJbxdlUxL3S5hvdoBnf1qKdfAJkjQ7
 Zera64/RwizalTSZv9bm56PlnHpDiY5x0s5tdJKBkkP6fes9c8R0OmiNfAAu/wu2yRjl
 fuSqXls4idNknom0FzDe81ppWhETpsj0XBXMTreuV2eLQ0irMbuQ3iX20NmaUd19FXKN
 vkIYcWmxAhSYTCvFyQQhLqy0aij1hvbBSTEZrIiE9XRzn/KD14m3GqM8I4KUWhCiQhDp
 s14ioyX0KzVjGGZ8mKwiGN2o/rxRZi6nIbn3UIAwbU4v8L84bf1loMz2lAx7kKbIl3dB
 Fb6A==
X-Gm-Message-State: AC+VfDyQjnRnl1S6tmJQN5wX/Z4d/VXYA/ic3ZZDeguzYZggokEfyM3X
 5m9hPKwcEFoSjRGLv3TR5LLpwQ==
X-Google-Smtp-Source: ACHHUZ6FSkhxML4Kjce/5jdPAqiXZdwQbOwj8praYb0knYgOhtNRVOiJHK6ia5MWhFR6wIJrCDD/og==
X-Received: by 2002:a5d:6a03:0:b0:309:44ed:ccff with SMTP id
 m3-20020a5d6a03000000b0030944edccffmr3110523wru.1.1686499239342; 
 Sun, 11 Jun 2023 09:00:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/23] target/arm: Convert exception generation
 instructions to decodetree
Date: Sun, 11 Jun 2023 17:00:19 +0100
Message-Id: <20230611160032.274823-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Convert the exception generation instructions SVC, HVC, SMC, BRK and
HLT to decodetree.

The old decoder decoded the halting-debug insnns DCPS1, DCPS2 and
DCPS3 just in order to then make them UNDEF; as with DRPS, we don't
bother to decode them, but document the patterns in a64.decode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-8-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  15 +++
 target/arm/tcg/translate-a64.c | 173 ++++++++++++---------------------
 2 files changed, 79 insertions(+), 109 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c49215cca8d..eeaca08ae83 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -215,3 +215,18 @@ MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
 SYS             1101 0101 00 l:1 01 op1:3 crn:4 crm:4 op2:3 rt:5 op0=1
 SYS             1101 0101 00 l:1 10 op1:3 crn:4 crm:4 op2:3 rt:5 op0=2
 SYS             1101 0101 00 l:1 11 op1:3 crn:4 crm:4 op2:3 rt:5 op0=3
+
+# Exception generation
+
+@i16            .... .... ... imm:16           ... .. &i
+SVC             1101 0100 000 ................ 000 01 @i16
+HVC             1101 0100 000 ................ 000 10 @i16
+SMC             1101 0100 000 ................ 000 11 @i16
+BRK             1101 0100 001 ................ 000 00 @i16
+HLT             1101 0100 010 ................ 000 00 @i16
+# These insns always UNDEF unless in halting debug state, which
+# we don't implement. So we don't need to decode them. The patterns
+# are listed here as documentation.
+# DCPS1         1101 0100 101 ................ 000 01 @i16
+# DCPS2         1101 0100 101 ................ 000 10 @i16
+# DCPS3         1101 0100 101 ................ 000 11 @i16
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 74a389da4a7..a2a71b4062f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2313,119 +2313,77 @@ static bool trans_SYS(DisasContext *s, arg_SYS *a)
     return true;
 }
 
-/* Exception generation
- *
- *  31             24 23 21 20                     5 4   2 1  0
- * +-----------------+-----+------------------------+-----+----+
- * | 1 1 0 1 0 1 0 0 | opc |          imm16         | op2 | LL |
- * +-----------------------+------------------------+----------+
- */
-static void disas_exc(DisasContext *s, uint32_t insn)
+static bool trans_SVC(DisasContext *s, arg_i *a)
 {
-    int opc = extract32(insn, 21, 3);
-    int op2_ll = extract32(insn, 0, 5);
-    int imm16 = extract32(insn, 5, 16);
-    uint32_t syndrome;
-
-    switch (opc) {
-    case 0:
-        /* For SVC, HVC and SMC we advance the single-step state
-         * machine before taking the exception. This is architecturally
-         * mandated, to ensure that single-stepping a system call
-         * instruction works properly.
-         */
-        switch (op2_ll) {
-        case 1:                                                     /* SVC */
-            syndrome = syn_aa64_svc(imm16);
-            if (s->fgt_svc) {
-                gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
-                break;
-            }
-            gen_ss_advance(s);
-            gen_exception_insn(s, 4, EXCP_SWI, syndrome);
-            break;
-        case 2:                                                     /* HVC */
-            if (s->current_el == 0) {
-                unallocated_encoding(s);
-                break;
-            }
-            /* The pre HVC helper handles cases when HVC gets trapped
-             * as an undefined insn by runtime configuration.
-             */
-            gen_a64_update_pc(s, 0);
-            gen_helper_pre_hvc(cpu_env);
-            gen_ss_advance(s);
-            gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(imm16), 2);
-            break;
-        case 3:                                                     /* SMC */
-            if (s->current_el == 0) {
-                unallocated_encoding(s);
-                break;
-            }
-            gen_a64_update_pc(s, 0);
-            gen_helper_pre_smc(cpu_env, tcg_constant_i32(syn_aa64_smc(imm16)));
-            gen_ss_advance(s);
-            gen_exception_insn_el(s, 4, EXCP_SMC, syn_aa64_smc(imm16), 3);
-            break;
-        default:
-            unallocated_encoding(s);
-            break;
-        }
-        break;
-    case 1:
-        if (op2_ll != 0) {
-            unallocated_encoding(s);
-            break;
-        }
-        /* BRK */
-        gen_exception_bkpt_insn(s, syn_aa64_bkpt(imm16));
-        break;
-    case 2:
-        if (op2_ll != 0) {
-            unallocated_encoding(s);
-            break;
-        }
-        /* HLT. This has two purposes.
-         * Architecturally, it is an external halting debug instruction.
-         * Since QEMU doesn't implement external debug, we treat this as
-         * it is required for halting debug disabled: it will UNDEF.
-         * Secondly, "HLT 0xf000" is the A64 semihosting syscall instruction.
-         */
-        if (semihosting_enabled(s->current_el == 0) && imm16 == 0xf000) {
-            gen_exception_internal_insn(s, EXCP_SEMIHOST);
-        } else {
-            unallocated_encoding(s);
-        }
-        break;
-    case 5:
-        if (op2_ll < 1 || op2_ll > 3) {
-            unallocated_encoding(s);
-            break;
-        }
-        /* DCPS1, DCPS2, DCPS3 */
-        unallocated_encoding(s);
-        break;
-    default:
-        unallocated_encoding(s);
-        break;
+    /*
+     * For SVC, HVC and SMC we advance the single-step state
+     * machine before taking the exception. This is architecturally
+     * mandated, to ensure that single-stepping a system call
+     * instruction works properly.
+     */
+    uint32_t syndrome = syn_aa64_svc(a->imm);
+    if (s->fgt_svc) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
+        return true;
     }
+    gen_ss_advance(s);
+    gen_exception_insn(s, 4, EXCP_SWI, syndrome);
+    return true;
 }
 
-/* Branches, exception generating and system instructions */
-static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
+static bool trans_HVC(DisasContext *s, arg_i *a)
 {
-    switch (extract32(insn, 25, 7)) {
-    case 0x6a: /* Exception generation / System */
-        if (insn & (1 << 24)) {
-            unallocated_encoding(s);
-        } else {
-            disas_exc(s, insn);
-        }
-        break;
-    default:
+    if (s->current_el == 0) {
         unallocated_encoding(s);
-        break;
+        return true;
     }
+    /*
+     * The pre HVC helper handles cases when HVC gets trapped
+     * as an undefined insn by runtime configuration.
+     */
+    gen_a64_update_pc(s, 0);
+    gen_helper_pre_hvc(cpu_env);
+    /* Architecture requires ss advance before we do the actual work */
+    gen_ss_advance(s);
+    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), 2);
+    return true;
+}
+
+static bool trans_SMC(DisasContext *s, arg_i *a)
+{
+    if (s->current_el == 0) {
+        unallocated_encoding(s);
+        return true;
+    }
+    gen_a64_update_pc(s, 0);
+    gen_helper_pre_smc(cpu_env, tcg_constant_i32(syn_aa64_smc(a->imm)));
+    /* Architecture requires ss advance before we do the actual work */
+    gen_ss_advance(s);
+    gen_exception_insn_el(s, 4, EXCP_SMC, syn_aa64_smc(a->imm), 3);
+    return true;
+}
+
+static bool trans_BRK(DisasContext *s, arg_i *a)
+{
+    gen_exception_bkpt_insn(s, syn_aa64_bkpt(a->imm));
+    return true;
+}
+
+static bool trans_HLT(DisasContext *s, arg_i *a)
+{
+    /*
+     * HLT. This has two purposes.
+     * Architecturally, it is an external halting debug instruction.
+     * Since QEMU doesn't implement external debug, we treat this as
+     * it is required for halting debug disabled: it will UNDEF.
+     * Secondly, "HLT 0xf000" is the A64 semihosting syscall instruction.
+     */
+    if (semihosting_enabled(s->current_el == 0) && a->imm == 0xf000) {
+        gen_exception_internal_insn(s, EXCP_SEMIHOST);
+    } else {
+        unallocated_encoding(s);
+    }
+    return true;
 }
 
 /*
@@ -14188,9 +14146,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0xa: case 0xb: /* Branch, exception generation and system insns */
-        disas_b_exc_sys(s, insn);
-        break;
     case 0x4:
     case 0x6:
     case 0xc:
-- 
2.34.1



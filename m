Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7A720694
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574v-0003CJ-Pq; Fri, 02 Jun 2023 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574t-0003AD-3q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574p-0003SG-0d
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso22543415e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721149; x=1688313149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YSnpw6zs5zZnKAA2d+Gsz/pFbi8gBmglbDw3R5ffAAE=;
 b=VoBoIokizXRyK0S6OZ57irpBKij3cFKfDgX9tImrj3L+Tsy7XpepiPjjhRRlgh8Vw9
 GseTz7GXa9eRbXTZ+gmyi9Nu3dJE9apZLYuqp1ZXAFBro2e4GxgMbWyomJQre/neAaJf
 inVauwbk5fMqb6lj5ndZxRWmV5fODtCrL1+dXxjdg3uomBe02j8auVFwaVG2PfFhOnl0
 JFsuugX5uRS2MfJJmcqf1TK6t2/+QXXAOstBibX7HPIfr8AlDl+urt6ljL01kKbhTM6o
 +MdgsPcqHsI6XjcbF+8i1MYGFTIo1CWu0u2WrYqC8CFwSM0xWpegvvVgNKSt8b+ISQLb
 fsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721149; x=1688313149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSnpw6zs5zZnKAA2d+Gsz/pFbi8gBmglbDw3R5ffAAE=;
 b=Ed7fcS0iB6r+T3NJyfKRzk5E2qHQYgB/zsWFJpCscGvjjcu+cxs1wcnqnoMpWTWzoW
 wYYocZZWJv9MrJlSmq099GYhbYehc9HgnB4uIA3q9RO10AZF/jsb/aGsDxPYiciDOzx6
 oD8y+UlD8SLqjYh3tHov6Mm/DGGRQ5wjve2Kf/7zUUaA6U2xMipAny57vaKZpzLu/+6e
 6gu+8mQRKeHQFE2JYC9LMKmYNfA1vNeelB9I072qq/x/NkSPS6uMVsc1pqFMrKlo3Gcf
 1+lXJz54cfIkT4rORAgzswdsEaIP6bH6cpogZvIm263W3A5WzbHOK4WLgiM621RI3QhT
 LIWA==
X-Gm-Message-State: AC+VfDyMpUUqWeiafXW4zckmcCLiWFDFCyEg16ksRezTNGh8fy8mUxHf
 ZWde0e2VqcdSxZGeZC+JLGStf6kp6liEvzIwLdg=
X-Google-Smtp-Source: ACHHUZ6buzGpIv2fws9GhVrltxc5pEE+OattbTJ/Wj+IMWCw0uB5ClT7te4rO3aXI/bPm8DFodf+jA==
X-Received: by 2002:a05:600c:b42:b0:3f1:7581:eaaf with SMTP id
 k2-20020a05600c0b4200b003f17581eaafmr2258724wmr.4.1685721149504; 
 Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/20] target/arm: Convert exception generation instructions
 to decodetree
Date: Fri,  2 Jun 2023 16:52:10 +0100
Message-Id: <20230602155223.2040685-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 target/arm/tcg/a64.decode      |  15 +++
 target/arm/tcg/translate-a64.c | 173 ++++++++++++---------------------
 2 files changed, 79 insertions(+), 109 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e1a120ea4c0..aba27047b56 100644
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
index 8e4d3676992..94410f6ece5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2260,119 +2260,77 @@ static bool trans_SYS(DisasContext *s, arg_SYS *a)
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
@@ -14035,9 +13993,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F26735997
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsm-0000cY-7M; Mon, 19 Jun 2023 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsi-0000aD-Q0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:24 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsg-0002C8-Jv
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:24 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f867700f36so2395275e87.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184961; x=1689776961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hv0rchOEEfJPVEoDeEXmaUe1CECfSOxYqHxG0bO7LPk=;
 b=yN8zbjoZ01J/E/bTph9yxu/8RGmfJw99jLqBMAPzKZ6YSINjZ0gzbZnsO0N3ptWqpD
 Tf8+UtoNz9P16zVSA/xvHPwGF1jqm7ZVTeBm1YU9kVrw2k1J4qvUauz66Bt0G+RR2K9b
 xxEaCY5oCfnyeF/1ku6TMIq2VVrPOpdfRT+v8bbhBMhw2QVgghFX5KsgX5pHxgcCqlJ9
 9X5a3jXj63f8O3cojGbEGwheykPg08OXa7GCC9I1PLaxzpdL5KSvMzz53FN7LMB1bz/b
 kNjjvllVKYGZXMjOO6aN4Fu2IiLZgFTmFMi8f/LKV5XSwewmn5Ev/E8O8CGWuvnF/eqU
 /JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184961; x=1689776961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv0rchOEEfJPVEoDeEXmaUe1CECfSOxYqHxG0bO7LPk=;
 b=jqkkuzhHaf5ChQ0Qjq79j4NFjz1unuIQSiw5zxolMTyAssbvtomQCWoI2CPWXO0ccT
 3DY9+0xfCCFXWdzV8RlsW9oKQDo473dqYuiqmZFwoRiQOrlyKQfJ16Ghlb6nldpFIDVJ
 ZpnVJv7sj7g6R+PcHWGfK2ZhjYZnBNS/EiziOM/dOSIU6NetabRrTZwBRbNsdLw0waSY
 ZHvqZ0ASZ9JdepKNHYsvJmyr8O0X1EWJ7i+cXG8CWmB2fyyGRHWKgCWkch4ERwFLp9mQ
 X2HN0xYC7dsiEMxwkoGP5fdUrRpT8juAHfejLdjRjdFNGCSVsqWrmrrJ5GfCBeMpKVZQ
 KtJA==
X-Gm-Message-State: AC+VfDwiOT40YmteGBKMRXrMqImR7BYwwPvpe7tcKoAppiCmjIX+OPJv
 Q0Bs5XPi3m9WHWGh0LUetKpsmrLdzeDBfDr7dlU=
X-Google-Smtp-Source: ACHHUZ5j3f1v/s90ClXfwrZfFWOnhsgmnt5EvtdNpyqajDhjyUktr9h8T5m4Q5Ev3MbdSgXtuyyfZA==
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id
 q1-20020a19f201000000b004f742de3a8fmr4899376lfh.56.1687184960929; 
 Mon, 19 Jun 2023 07:29:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] target/arm: Convert exception generation instructions to
 decodetree
Date: Mon, 19 Jun 2023 15:28:51 +0100
Message-Id: <20230619142914.963184-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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



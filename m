Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F60735988
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtC-0000e9-NZ; Mon, 19 Jun 2023 10:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsh-0000Zf-RX
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsf-0002BO-NI
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f90b8acefeso15540665e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184960; x=1689776960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gOvf60YN74xnTNfixpVWMsKoOKc9WSdyaA7UMG2RTxA=;
 b=xv9Eiv/myW9IUryTAgiBc+HclQ0xq+GHKtMIpSvu4BMxblovgA+a5Caz3w63zWI7ys
 LJN1Bj4wKAUj59vEx6BFPdOrUFJFwViI6vQiqkHyby/ieFPXHuxvcViDnRRVX3TB1WS4
 y7mVeuNAxVQNJexRN+HDLuM+ztECKLVdH2G6EsuNjtDUToHh3dpnhwAVgeIlDoautklC
 rpl9/bRr3I4pDcAzCrRbH/qsGOY9ZfbZAeYH6R9e5KDd98MS7Pauj1JjDtlxLESQhrkZ
 0pIrZfu01FobuuTzEtwt6YMGFeNO0r2yoqN0Xl1pnxRXjHM1Ojfrh5aSLFYFt17SIF3C
 7sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184960; x=1689776960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOvf60YN74xnTNfixpVWMsKoOKc9WSdyaA7UMG2RTxA=;
 b=gRgjML9qoXsnSkodJH8/ZRqoMoVYrOP8AzqoH16HTIUfI7jylSiSa7Y68Q6UPfJ0Bf
 t0nK95GmkekNRbRDsLp+3QISFCcYiHOTxVBCm2lRG45MfobI2lDPZbA4ZK+qpMY9VKSn
 kTZTo0LKP4tfAt1O5ZAmZxcGhbPy8CwE+cG/xuqx2iQvmpdYSkBcx6Jo3r5KfIvJ8cR8
 Ptch4X5vNSYhKiD/9V4AJVZ5H1O4lN8hxk6o31jL4j0JDKsy+u2WOPsJxIskfmbGgCHj
 NQq8nDTV3SXfxoTDGi65OtfR3XdEEKZ4q1H1qe392B1oekZxIO+8uSTvwnprSH3K6re0
 SLmw==
X-Gm-Message-State: AC+VfDzNUlGVIjcvgcY0ji52TJVo3Vr1jII39IHZeCx7SgS2q2rhoqOC
 fzDq8laTWFuAY0pmdMLPVuEikIeMq2HhvISCr3E=
X-Google-Smtp-Source: ACHHUZ7WZ/dgysny3z0GtkzLGIz6T8Nz4KhTq2L7E2k3t5VyJFEDEjgApDW+26ieUY02FF1JA3NUkQ==
X-Received: by 2002:a05:600c:2245:b0:3f7:f584:579b with SMTP id
 a5-20020a05600c224500b003f7f584579bmr6978590wmm.9.1687184960003; 
 Mon, 19 Jun 2023 07:29:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] target/arm: Convert MSR (immediate) to decodetree
Date: Mon, 19 Jun 2023 15:28:49 +0100
Message-Id: <20230619142914.963184-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
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

Convert the MSR (immediate) insn to decodetree. Our implementation
has basically no commonality between the different destinations,
so we decode the destination register in a64.decode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-6-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  13 ++
 target/arm/tcg/translate-a64.c | 251 ++++++++++++++++-----------------
 2 files changed, 136 insertions(+), 128 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index fd23fc3e0ff..4f94a08907b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -194,3 +194,16 @@ SB              1101 0101 0000 0011 0011 0000 111 11111
 CFINV           1101 0101 0000 0 000 0100 0000 000 11111
 XAFLAG          1101 0101 0000 0 000 0100 0000 001 11111
 AXFLAG          1101 0101 0000 0 000 0100 0000 010 11111
+
+# These are architecturally all "MSR (immediate)"; we decode the destination
+# register too because there is no commonality in our implementation.
+@msr_i          .... .... .... . ... .... imm:4 ... .....
+MSR_i_UAO       1101 0101 0000 0 000 0100 .... 011 11111 @msr_i
+MSR_i_PAN       1101 0101 0000 0 000 0100 .... 100 11111 @msr_i
+MSR_i_SPSEL     1101 0101 0000 0 000 0100 .... 101 11111 @msr_i
+MSR_i_SBSS      1101 0101 0000 0 011 0100 .... 001 11111 @msr_i
+MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
+MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
+MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
+MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
+MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c1b02b96183..8c57b48d81f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1927,124 +1927,130 @@ static bool trans_AXFLAG(DisasContext *s, arg_AXFLAG *a)
     return true;
 }
 
-/* MSR (immediate) - move immediate to processor state field */
-static void handle_msr_i(DisasContext *s, uint32_t insn,
-                         unsigned int op1, unsigned int op2, unsigned int crm)
+static bool trans_MSR_i_UAO(DisasContext *s, arg_i *a)
 {
-    int op = op1 << 3 | op2;
-
-    /* End the TB by default, chaining is ok.  */
-    s->base.is_jmp = DISAS_TOO_MANY;
-
-    switch (op) {
-    case 0x03: /* UAO */
-        if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
-            goto do_unallocated;
-        }
-        if (crm & 1) {
-            set_pstate_bits(PSTATE_UAO);
-        } else {
-            clear_pstate_bits(PSTATE_UAO);
-        }
-        gen_rebuild_hflags(s);
-        break;
-
-    case 0x04: /* PAN */
-        if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
-            goto do_unallocated;
-        }
-        if (crm & 1) {
-            set_pstate_bits(PSTATE_PAN);
-        } else {
-            clear_pstate_bits(PSTATE_PAN);
-        }
-        gen_rebuild_hflags(s);
-        break;
-
-    case 0x05: /* SPSel */
-        if (s->current_el == 0) {
-            goto do_unallocated;
-        }
-        gen_helper_msr_i_spsel(cpu_env, tcg_constant_i32(crm & PSTATE_SP));
-        break;
-
-    case 0x19: /* SSBS */
-        if (!dc_isar_feature(aa64_ssbs, s)) {
-            goto do_unallocated;
-        }
-        if (crm & 1) {
-            set_pstate_bits(PSTATE_SSBS);
-        } else {
-            clear_pstate_bits(PSTATE_SSBS);
-        }
-        /* Don't need to rebuild hflags since SSBS is a nop */
-        break;
-
-    case 0x1a: /* DIT */
-        if (!dc_isar_feature(aa64_dit, s)) {
-            goto do_unallocated;
-        }
-        if (crm & 1) {
-            set_pstate_bits(PSTATE_DIT);
-        } else {
-            clear_pstate_bits(PSTATE_DIT);
-        }
-        /* There's no need to rebuild hflags because DIT is a nop */
-        break;
-
-    case 0x1e: /* DAIFSet */
-        gen_helper_msr_i_daifset(cpu_env, tcg_constant_i32(crm));
-        break;
-
-    case 0x1f: /* DAIFClear */
-        gen_helper_msr_i_daifclear(cpu_env, tcg_constant_i32(crm));
-        /* For DAIFClear, exit the cpu loop to re-evaluate pending IRQs.  */
-        s->base.is_jmp = DISAS_UPDATE_EXIT;
-        break;
-
-    case 0x1c: /* TCO */
-        if (dc_isar_feature(aa64_mte, s)) {
-            /* Full MTE is enabled -- set the TCO bit as directed. */
-            if (crm & 1) {
-                set_pstate_bits(PSTATE_TCO);
-            } else {
-                clear_pstate_bits(PSTATE_TCO);
-            }
-            gen_rebuild_hflags(s);
-            /* Many factors, including TCO, go into MTE_ACTIVE. */
-            s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
-        } else if (dc_isar_feature(aa64_mte_insn_reg, s)) {
-            /* Only "instructions accessible at EL0" -- PSTATE.TCO is WI.  */
-            s->base.is_jmp = DISAS_NEXT;
-        } else {
-            goto do_unallocated;
-        }
-        break;
-
-    case 0x1b: /* SVCR* */
-        if (!dc_isar_feature(aa64_sme, s) || crm < 2 || crm > 7) {
-            goto do_unallocated;
-        }
-        if (sme_access_check(s)) {
-            int old = s->pstate_sm | (s->pstate_za << 1);
-            int new = (crm & 1) * 3;
-            int msk = (crm >> 1) & 3;
-
-            if ((old ^ new) & msk) {
-                /* At least one bit changes. */
-                gen_helper_set_svcr(cpu_env, tcg_constant_i32(new),
-                                    tcg_constant_i32(msk));
-            } else {
-                s->base.is_jmp = DISAS_NEXT;
-            }
-        }
-        break;
-
-    default:
-    do_unallocated:
-        unallocated_encoding(s);
-        return;
+    if (!dc_isar_feature(aa64_uao, s) || s->current_el == 0) {
+        return false;
     }
+    if (a->imm & 1) {
+        set_pstate_bits(PSTATE_UAO);
+    } else {
+        clear_pstate_bits(PSTATE_UAO);
+    }
+    gen_rebuild_hflags(s);
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_PAN(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_pan, s) || s->current_el == 0) {
+        return false;
+    }
+    if (a->imm & 1) {
+        set_pstate_bits(PSTATE_PAN);
+    } else {
+        clear_pstate_bits(PSTATE_PAN);
+    }
+    gen_rebuild_hflags(s);
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_SPSEL(DisasContext *s, arg_i *a)
+{
+    if (s->current_el == 0) {
+        return false;
+    }
+    gen_helper_msr_i_spsel(cpu_env, tcg_constant_i32(a->imm & PSTATE_SP));
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_SBSS(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_ssbs, s)) {
+        return false;
+    }
+    if (a->imm & 1) {
+        set_pstate_bits(PSTATE_SSBS);
+    } else {
+        clear_pstate_bits(PSTATE_SSBS);
+    }
+    /* Don't need to rebuild hflags since SSBS is a nop */
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_DIT(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_dit, s)) {
+        return false;
+    }
+    if (a->imm & 1) {
+        set_pstate_bits(PSTATE_DIT);
+    } else {
+        clear_pstate_bits(PSTATE_DIT);
+    }
+    /* There's no need to rebuild hflags because DIT is a nop */
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_TCO(DisasContext *s, arg_i *a)
+{
+    if (dc_isar_feature(aa64_mte, s)) {
+        /* Full MTE is enabled -- set the TCO bit as directed. */
+        if (a->imm & 1) {
+            set_pstate_bits(PSTATE_TCO);
+        } else {
+            clear_pstate_bits(PSTATE_TCO);
+        }
+        gen_rebuild_hflags(s);
+        /* Many factors, including TCO, go into MTE_ACTIVE. */
+        s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
+        return true;
+    } else if (dc_isar_feature(aa64_mte_insn_reg, s)) {
+        /* Only "instructions accessible at EL0" -- PSTATE.TCO is WI.  */
+        return true;
+    } else {
+        /* Insn not present */
+        return false;
+    }
+}
+
+static bool trans_MSR_i_DAIFSET(DisasContext *s, arg_i *a)
+{
+    gen_helper_msr_i_daifset(cpu_env, tcg_constant_i32(a->imm));
+    s->base.is_jmp = DISAS_TOO_MANY;
+    return true;
+}
+
+static bool trans_MSR_i_DAIFCLEAR(DisasContext *s, arg_i *a)
+{
+    gen_helper_msr_i_daifclear(cpu_env, tcg_constant_i32(a->imm));
+    /* Exit the cpu loop to re-evaluate pending IRQs. */
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
+    return true;
+}
+
+static bool trans_MSR_i_SVCR(DisasContext *s, arg_MSR_i_SVCR *a)
+{
+    if (!dc_isar_feature(aa64_sme, s) || a->mask == 0) {
+        return false;
+    }
+    if (sme_access_check(s)) {
+        int old = s->pstate_sm | (s->pstate_za << 1);
+        int new = a->imm * 3;
+
+        if ((old ^ new) & a->mask) {
+            /* At least one bit changes. */
+            gen_helper_set_svcr(cpu_env, tcg_constant_i32(new),
+                                tcg_constant_i32(a->mask));
+            s->base.is_jmp = DISAS_TOO_MANY;
+        }
+    }
+    return true;
 }
 
 static void gen_get_nzcv(TCGv_i64 tcg_rt)
@@ -2319,18 +2325,7 @@ static void disas_system(DisasContext *s, uint32_t insn)
     rt = extract32(insn, 0, 5);
 
     if (op0 == 0) {
-        if (l || rt != 31) {
-            unallocated_encoding(s);
-            return;
-        }
-        switch (crn) {
-        case 4: /* MSR (immediate) */
-            handle_msr_i(s, insn, op1, op2, crm);
-            break;
-        default:
-            unallocated_encoding(s);
-            break;
-        }
+        unallocated_encoding(s);
         return;
     }
     handle_sys(s, insn, l, op0, op1, op2, crn, crm, rt);
-- 
2.34.1



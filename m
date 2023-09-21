Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0B7A985F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcQ-00023W-TN; Thu, 21 Sep 2023 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcP-00022Z-88
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcL-0007gF-4O
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4053c6f0d55so552145e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317851; x=1695922651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=agiLXpKMvtdbqhZ2UJ0uU0nE66S4BmzY7JC9reZnd9A=;
 b=adbmXJN8S12gwY4utLdQZdh86+EA/Fs2JS+t3ILDsZTch8zdV/wnPsaszLlN3UmiBw
 r9q9vz0Z5E5/48qAoyTye51DiFYAnvSWDKwz8Z2kzmeOTU0zkycKqJqmtCGLPWEV8+eN
 Ov6RbNrQdReM2+dZTRCPSSv4DAa903kmohqPTsNzwIuTkCn3fXXcSpG1w86ElwsXxkEn
 kqEvXn3kE3QaxLC+P876/uZLv/UpNw9L7l+BgWN6ZkPuQLiWBkHdLOUbccIl8SzWUiJ9
 OOvoi9KL+VoSvujLGVWFHRr6HKLKwcSmUIHI/qfE64yESWkriIj6EKlPee4Na+z0STKb
 rtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317851; x=1695922651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agiLXpKMvtdbqhZ2UJ0uU0nE66S4BmzY7JC9reZnd9A=;
 b=l0YSRp+cH7RnZmzed7GEEsCMwyIx37GOxS2XFHMWqYzPnlfDowhzf06v7aFizYcSFc
 Wxn9sozY3t8jc+KI1BOch/MIESuMh1RUtfxfMMXC/ySA86fXd3/hDQW/U3tvLZqeit76
 65rPgCzQ4SPqHNoFRnzs1/gEDV1bSK7aGVsdDrP0BnUhbHoVvGN8mI5FnwZT76OA/Ns+
 Udp/j4z26W1G8rjVXvaAU+RRkkB0zH5klh1QcbHFwRlYoqNoFiEt0cvuUs4ENLyTPEPR
 ExvUc7NdS0cN5DOBxLWQOwrLypeOW34L0s/W6cDu9SJpjXB6GTzOW3VyhYNB3+T+ilD2
 XzFg==
X-Gm-Message-State: AOJu0Yx1YDnuudqWRFJkxmcfuxcnL07FkY/0m3yCfveDVbJVwZkLf5kH
 M4wRIkUfWuuzLkqsUNihbxJkSTOu3131tTI2OIc=
X-Google-Smtp-Source: AGHT+IE3vZTQ2kfevFPnHIlR8GUxPULncRkmgh0ACqbSg4m8ctL/2cGMt8kNGHF6QNZByILs5H81Ug==
X-Received: by 2002:a1c:ed04:0:b0:401:daf2:2737 with SMTP id
 l4-20020a1ced04000000b00401daf22737mr5544341wmh.30.1695317850617; 
 Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/30] target/arm: Implement the SET* instructions
Date: Thu, 21 Sep 2023 18:37:07 +0100
Message-Id: <20230921173720.3250581-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Implement the SET* instructions which collectively implement a
"memset" operation.  These come in a set of three, eg SETP
(prologue), SETM (main), SETE (epilogue), and each of those has
different flavours to indicate whether memory accesses should be
unpriv or non-temporal.

This commit does not include the "memset with tag setting"
SETG* instructions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-8-peter.maydell@linaro.org
---
 target/arm/tcg/helper-a64.h    |   4 +
 target/arm/tcg/a64.decode      |  16 ++
 target/arm/tcg/helper-a64.c    | 344 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  49 +++++
 4 files changed, 413 insertions(+)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 57cfd68569e..7ce5d2105ad 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -117,3 +117,7 @@ DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
 DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
+
+DEF_HELPER_3(setp, void, env, i32, i32)
+DEF_HELPER_3(setm, void, env, i32, i32)
+DEF_HELPER_3(sete, void, env, i32, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 71113173020..c2a97328eeb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -554,3 +554,19 @@ LDGM            11011001 11 1 ......... 00 ..... ..... @ldst_tag_mult p=0 w=0
 STZ2G           11011001 11 1 ......... 01 ..... ..... @ldst_tag p=1 w=1
 STZ2G           11011001 11 1 ......... 10 ..... ..... @ldst_tag p=0 w=0
 STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
+
+# Memory operations (memset, memcpy, memmove)
+# Each of these comes in a set of three, eg SETP (prologue), SETM (main),
+# SETE (epilogue), and each of those has different flavours to
+# indicate whether memory accesses should be unpriv or non-temporal.
+# We don't distinguish temporal and non-temporal accesses, but we
+# do need to report it in syndrome register values.
+
+# Memset
+&set rs rn rd unpriv nontemp
+# op2 bit 1 is nontemporal bit
+@set         .. ......... rs:5 .. nontemp:1 unpriv:1 .. rn:5 rd:5 &set
+
+SETP            00 011001110 ..... 00 . . 01 ..... ..... @set
+SETM            00 011001110 ..... 01 . . 01 ..... ..... @set
+SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0cf56f6dc44..24ae5ecf32e 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -968,3 +968,347 @@ void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
     arm_cpu_do_unaligned_access(env_cpu(env), addr, access_type,
                                 mmu_idx, GETPC());
 }
+
+/* Memory operations (memset, memmove, memcpy) */
+
+/*
+ * Return true if the CPY* and SET* insns can execute; compare
+ * pseudocode CheckMOPSEnabled(), though we refactor it a little.
+ */
+static bool mops_enabled(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+
+    if (el < 2 &&
+        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE) &&
+        !(arm_hcrx_el2_eff(env) & HCRX_MSCEN)) {
+        return false;
+    }
+
+    if (el == 0) {
+        if (!el_is_in_host(env, 0)) {
+            return env->cp15.sctlr_el[1] & SCTLR_MSCEN;
+        } else {
+            return env->cp15.sctlr_el[2] & SCTLR_MSCEN;
+        }
+    }
+    return true;
+}
+
+static void check_mops_enabled(CPUARMState *env, uintptr_t ra)
+{
+    if (!mops_enabled(env)) {
+        raise_exception_ra(env, EXCP_UDEF, syn_uncategorized(),
+                           exception_target_el(env), ra);
+    }
+}
+
+/*
+ * Return the target exception level for an exception due
+ * to mismatched arguments in a FEAT_MOPS copy or set.
+ * Compare pseudocode MismatchedCpySetTargetEL()
+ */
+static int mops_mismatch_exception_target_el(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+
+    if (el > 1) {
+        return el;
+    }
+    if (el == 0 && (arm_hcr_el2_eff(env) & HCR_TGE)) {
+        return 2;
+    }
+    if (el == 1 && (arm_hcrx_el2_eff(env) & HCRX_MCE2)) {
+        return 2;
+    }
+    return 1;
+}
+
+/*
+ * Check whether an M or E instruction was executed with a CF value
+ * indicating the wrong option for this implementation.
+ * Assumes we are always Option A.
+ */
+static void check_mops_wrong_option(CPUARMState *env, uint32_t syndrome,
+                                    uintptr_t ra)
+{
+    if (env->CF != 0) {
+        syndrome |= 1 << 17; /* Set the wrong-option bit */
+        raise_exception_ra(env, EXCP_UDEF, syndrome,
+                           mops_mismatch_exception_target_el(env), ra);
+    }
+}
+
+/*
+ * Return the maximum number of bytes we can transfer starting at addr
+ * without crossing a page boundary.
+ */
+static uint64_t page_limit(uint64_t addr)
+{
+    return TARGET_PAGE_ALIGN(addr + 1) - addr;
+}
+
+/*
+ * Perform part of a memory set on an area of guest memory starting at
+ * toaddr (a dirty address) and extending for setsize bytes.
+ *
+ * Returns the number of bytes actually set, which might be less than
+ * setsize; the caller should loop until the whole set has been done.
+ * The caller should ensure that the guest registers are correct
+ * for the possibility that the first byte of the set encounters
+ * an exception or watchpoint. We guarantee not to take any faults
+ * for bytes other than the first.
+ */
+static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
+                         uint64_t setsize, uint32_t data, int memidx,
+                         uint32_t *mtedesc, uintptr_t ra)
+{
+    void *mem;
+
+    setsize = MIN(setsize, page_limit(toaddr));
+    if (*mtedesc) {
+        uint64_t mtesize = mte_mops_probe(env, toaddr, setsize, *mtedesc);
+        if (mtesize == 0) {
+            /* Trap, or not. All CPU state is up to date */
+            mte_check_fail(env, *mtedesc, toaddr, ra);
+            /* Continue, with no further MTE checks required */
+            *mtedesc = 0;
+        } else {
+            /* Advance to the end, or to the tag mismatch */
+            setsize = MIN(setsize, mtesize);
+        }
+    }
+
+    toaddr = useronly_clean_ptr(toaddr);
+    /*
+     * Trapless lookup: returns NULL for invalid page, I/O,
+     * watchpoints, clean pages, etc.
+     */
+    mem = tlb_vaddr_to_host(env, toaddr, MMU_DATA_STORE, memidx);
+
+#ifndef CONFIG_USER_ONLY
+    if (unlikely(!mem)) {
+        /*
+         * Slow-path: just do one byte write. This will handle the
+         * watchpoint, invalid page, etc handling correctly.
+         * For clean code pages, the next iteration will see
+         * the page dirty and will use the fast path.
+         */
+        cpu_stb_mmuidx_ra(env, toaddr, data, memidx, ra);
+        return 1;
+    }
+#endif
+    /* Easy case: just memset the host memory */
+    memset(mem, data, setsize);
+    return setsize;
+}
+
+typedef uint64_t StepFn(CPUARMState *env, uint64_t toaddr,
+                        uint64_t setsize, uint32_t data,
+                        int memidx, uint32_t *mtedesc, uintptr_t ra);
+
+/* Extract register numbers from a MOPS exception syndrome value */
+static int mops_destreg(uint32_t syndrome)
+{
+    return extract32(syndrome, 10, 5);
+}
+
+static int mops_srcreg(uint32_t syndrome)
+{
+    return extract32(syndrome, 5, 5);
+}
+
+static int mops_sizereg(uint32_t syndrome)
+{
+    return extract32(syndrome, 0, 5);
+}
+
+/*
+ * Return true if TCMA and TBI bits mean we need to do MTE checks.
+ * We only need to do this once per MOPS insn, not for every page.
+ */
+static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
+{
+    int bit55 = extract64(ptr, 55, 1);
+
+    /*
+     * Note that tbi_check() returns true for "access checked" but
+     * tcma_check() returns true for "access unchecked".
+     */
+    if (!tbi_check(desc, bit55)) {
+        return false;
+    }
+    return !tcma_check(desc, bit55, allocation_tag_from_addr(ptr));
+}
+
+/*
+ * For the Memory Set operation, our implementation chooses
+ * always to use "option A", where we update Xd to the final
+ * address in the SETP insn, and set Xn to be -(bytes remaining).
+ * On SETM and SETE insns we only need update Xn.
+ *
+ * @env: CPU
+ * @syndrome: syndrome value for mismatch exceptions
+ * (also contains the register numbers we need to use)
+ * @mtedesc: MTE descriptor word
+ * @stepfn: function which does a single part of the set operation
+ * @is_setg: true if this is the tag-setting SETG variant
+ */
+static void do_setp(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
+                    StepFn *stepfn, bool is_setg, uintptr_t ra)
+{
+    /* Prologue: we choose to do up to the next page boundary */
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint8_t data = env->xregs[rs];
+    uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
+    uint64_t toaddr = env->xregs[rd];
+    uint64_t setsize = env->xregs[rn];
+    uint64_t stagesetsize, step;
+
+    check_mops_enabled(env, ra);
+
+    if (setsize > INT64_MAX) {
+        setsize = INT64_MAX;
+    }
+
+    if (!mte_checks_needed(toaddr, mtedesc)) {
+        mtedesc = 0;
+    }
+
+    stagesetsize = MIN(setsize, page_limit(toaddr));
+    while (stagesetsize) {
+        env->xregs[rd] = toaddr;
+        env->xregs[rn] = setsize;
+        step = stepfn(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
+        toaddr += step;
+        setsize -= step;
+        stagesetsize -= step;
+    }
+    /* Insn completed, so update registers to the Option A format */
+    env->xregs[rd] = toaddr + setsize;
+    env->xregs[rn] = -setsize;
+
+    /* Set NZCV = 0000 to indicate we are an Option A implementation */
+    env->NF = 0;
+    env->ZF = 1; /* our env->ZF encoding is inverted */
+    env->CF = 0;
+    env->VF = 0;
+    return;
+}
+
+void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_setp(env, syndrome, mtedesc, set_step, false, GETPC());
+}
+
+static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
+                    StepFn *stepfn, bool is_setg, uintptr_t ra)
+{
+    /* Main: we choose to do all the full-page chunks */
+    CPUState *cs = env_cpu(env);
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint8_t data = env->xregs[rs];
+    uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
+    uint64_t setsize = -env->xregs[rn];
+    uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
+    uint64_t step, stagesetsize;
+
+    check_mops_enabled(env, ra);
+
+    /*
+     * We're allowed to NOP out "no data to copy" before the consistency
+     * checks; we choose to do so.
+     */
+    if (env->xregs[rn] == 0) {
+        return;
+    }
+
+    check_mops_wrong_option(env, syndrome, ra);
+
+    /*
+     * Our implementation will work fine even if we have an unaligned
+     * destination address, and because we update Xn every time around
+     * the loop below and the return value from stepfn() may be less
+     * than requested, we might find toaddr is unaligned. So we don't
+     * have an IMPDEF check for alignment here.
+     */
+
+    if (!mte_checks_needed(toaddr, mtedesc)) {
+        mtedesc = 0;
+    }
+
+    /* Do the actual memset: we leave the last partial page to SETE */
+    stagesetsize = setsize & TARGET_PAGE_MASK;
+    while (stagesetsize > 0) {
+        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        toaddr += step;
+        setsize -= step;
+        stagesetsize -= step;
+        env->xregs[rn] = -setsize;
+        if (stagesetsize > 0 && unlikely(cpu_loop_exit_requested(cs))) {
+            cpu_loop_exit_restore(cs, ra);
+        }
+    }
+}
+
+void HELPER(setm)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_setm(env, syndrome, mtedesc, set_step, false, GETPC());
+}
+
+static void do_sete(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
+                    StepFn *stepfn, bool is_setg, uintptr_t ra)
+{
+    /* Epilogue: do the last partial page */
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint8_t data = env->xregs[rs];
+    uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
+    uint64_t setsize = -env->xregs[rn];
+    uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
+    uint64_t step;
+
+    check_mops_enabled(env, ra);
+
+    /*
+     * We're allowed to NOP out "no data to copy" before the consistency
+     * checks; we choose to do so.
+     */
+    if (setsize == 0) {
+        return;
+    }
+
+    check_mops_wrong_option(env, syndrome, ra);
+
+    /*
+     * Our implementation has no address alignment requirements, but
+     * we do want to enforce the "less than a page" size requirement,
+     * so we don't need to have the "check for interrupts" here.
+     */
+    if (setsize >= TARGET_PAGE_SIZE) {
+        raise_exception_ra(env, EXCP_UDEF, syndrome,
+                           mops_mismatch_exception_target_el(env), ra);
+    }
+
+    if (!mte_checks_needed(toaddr, mtedesc)) {
+        mtedesc = 0;
+    }
+
+    /* Do the actual memset */
+    while (setsize > 0) {
+        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        toaddr += step;
+        setsize -= step;
+        env->xregs[rn] = -setsize;
+    }
+}
+
+void HELPER(sete)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_sete(env, syndrome, mtedesc, set_step, false, GETPC());
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 24afd929144..bb7b15cb6cb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3962,6 +3962,55 @@ TRANS_FEAT(STZG, aa64_mte_insn_reg, do_STG, a, true, false)
 TRANS_FEAT(ST2G, aa64_mte_insn_reg, do_STG, a, false, true)
 TRANS_FEAT(STZ2G, aa64_mte_insn_reg, do_STG, a, true, true)
 
+typedef void SetFn(TCGv_env, TCGv_i32, TCGv_i32);
+
+static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
+{
+    int memidx;
+    uint32_t syndrome, desc = 0;
+
+    /*
+     * UNPREDICTABLE cases: we choose to UNDEF, which allows
+     * us to pull this check before the CheckMOPSEnabled() test
+     * (which we do in the helper function)
+     */
+    if (a->rs == a->rn || a->rs == a->rd || a->rn == a->rd ||
+        a->rd == 31 || a->rn == 31) {
+        return false;
+    }
+
+    memidx = get_a64_user_mem_index(s, a->unpriv);
+
+    /*
+     * We pass option_a == true, matching our implementation;
+     * we pass wrong_option == false: helper function may set that bit.
+     */
+    syndrome = syn_mop(true, false, (a->nontemp << 1) | a->unpriv,
+                       is_epilogue, false, true, a->rd, a->rs, a->rn);
+
+    if (s->mte_active[a->unpriv]) {
+        /* We may need to do MTE tag checking, so assemble the descriptor */
+        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
+        /* SIZEM1 and ALIGN we leave 0 (byte write) */
+    }
+    /* The helper function always needs the memidx even with MTE disabled */
+    desc = FIELD_DP32(desc, MTEDESC, MIDX, memidx);
+
+    /*
+     * The helper needs the register numbers, but since they're in
+     * the syndrome anyway, we let it extract them from there rather
+     * than passing in an extra three integer arguments.
+     */
+    fn(cpu_env, tcg_constant_i32(syndrome), tcg_constant_i32(desc));
+    return true;
+}
+
+TRANS_FEAT(SETP, aa64_mops, do_SET, a, false, gen_helper_setp)
+TRANS_FEAT(SETM, aa64_mops, do_SET, a, false, gen_helper_setm)
+TRANS_FEAT(SETE, aa64_mops, do_SET, a, true, gen_helper_sete)
+
 typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
 
 static bool gen_rri(DisasContext *s, arg_rri_sf *a,
-- 
2.34.1



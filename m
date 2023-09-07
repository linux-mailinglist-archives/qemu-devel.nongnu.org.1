Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEF79764C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:05:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHUC-00013V-Uu; Thu, 07 Sep 2023 12:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU9-0000zH-3Z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:04:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTz-000229-82
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:04:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so11609055e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102630; x=1694707430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WEi5U+9+EVifF18HjGG9+OI2e5irSfTUPjkky56c2m8=;
 b=AkpK8VMEfsVFZ5WE2fNsPE+zju2PFAfKgBOcHGW50B8ielboURHiGQUsQz7yAX9r2J
 pzj0uuY154OjKYbNfOuB2ME5rK01aphgncZgcz2aBr9xVVjOAf26wq9bfcUdrpWAyB7w
 1OeLkD7q2HDvRoCVENp0Un9+5bY96bAT9aTpy41uhirM5WrSDyk9A+JcRdRtA+iZZbkV
 Mh5Y0xVOJ/7fSw9Dd41xC6YWrjcz78minAgnjBQ3aM4M/CqiIpImpa5o8VV7d9Q5HKk2
 JiGxiKnNFyyODOR9XNcuY8N4G7uTPNfXgYN0rcY7mJEOPi++BTpt/wO8Yv5gYpiLDWiO
 iXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102630; x=1694707430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEi5U+9+EVifF18HjGG9+OI2e5irSfTUPjkky56c2m8=;
 b=bzQv13CFIK6TbyTduAxJAZiSEMth/MtPfpBY3afcdz61fEp28ntORuHE3eowZlAvVe
 McIOdZCo34/mFIEE0D4KbSo1dm7zxtWSj4ztri7hEuqqLoiiOFBlcEGvwLQ5/2Dr7Nso
 EmSM36sjeKOoLAl79hAQY3e7GzFEySoAVzqacCf5nsgisPbiL1NuQImCFZ1VkgCEF184
 QAGAAQnqm3wp2QdZr+PQkvvrdsCVG8VtPpGwhS9kHsfeLH8a2zcQ815heXXB7miAbOKO
 p8TESZRp77LrYD9GizCdiH9YK+ujj2G3U85W3QhLJVx4nVvL2z53+mkoLeYEzpsAEUtK
 uHUw==
X-Gm-Message-State: AOJu0YwoFMAUJWX4flrkYWw+QhylKCmKKb70iDmEIjXKNnGmLjEvnMhZ
 kdmRw5IakHv71eQqZzyMWVRFETHgJteMNu6uqho=
X-Google-Smtp-Source: AGHT+IHUxmcFQm6QfV+xm/TEOZsidm0BjXhhN1jIj0Ci7Fv0Hg6uFzZke91e78zlQ/kB1WWYTpxtNA==
X-Received: by 2002:a05:600c:2611:b0:401:1066:53e4 with SMTP id
 h17-20020a05600c261100b00401106653e4mr96842wma.38.1694102629734; 
 Thu, 07 Sep 2023 09:03:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 13/14] target/arm: Implement the CPY* instructions
Date: Thu,  7 Sep 2023 17:03:39 +0100
Message-Id: <20230907160340.260094-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The FEAT_MOPS CPY* instructions implement memory copies. These
come in both "always forwards" (memcpy-style) and "overlap OK"
(memmove-style) flavours.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   4 +
 target/arm/tcg/a64.decode      |  12 +
 target/arm/tcg/helper-a64.c    | 413 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  57 +++++
 4 files changed, 486 insertions(+)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 1daadc81cfe..8d4ce2e3b31 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -117,3 +117,7 @@ DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
 DEF_HELPER_3(setp, void, env, i32, i32)
 DEF_HELPER_3(setm, void, env, i32, i32)
 DEF_HELPER_3(sete, void, env, i32, i32)
+
+DEF_HELPER_5(cpyp, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(cpym, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(cpye, void, env, i32, i32, i32, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 46caeb59fe5..8ddf96542a9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -574,3 +574,15 @@ SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
 SETGP           00 011101110 ..... 00 . . 01 ..... ..... @set
 SETGM           00 011101110 ..... 01 . . 01 ..... ..... @set
 SETGE           00 011101110 ..... 10 . . 01 ..... ..... @set
+
+# Memmove/Memcopy: the move bit is 1 for the CPY insns which
+# allow overlapping src/dest and copy in the correct direction,
+# and 0 for the CPYF insns which always copy forwards.
+#
+# options has the nontemporal and unpriv bits for src and dest
+&cpy rs rn rd options move
+@cpy            .. ... move:1 ..... rs:5 options:4 .. rn:5 rd:5 &cpy
+
+CPYP            00 011 . 01000 ..... .... 01 ..... ..... @cpy
+CPYM            00 011 . 01010 ..... .... 01 ..... ..... @cpy
+CPYE            00 011 . 01100 ..... .... 01 ..... ..... @cpy
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 96780067262..581fdbfd91a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1048,6 +1048,15 @@ static uint64_t page_limit(uint64_t addr)
     return TARGET_PAGE_ALIGN(addr + 1) - addr;
 }
 
+/*
+ * Return the number of bytes we can copy starting from addr and working
+ * backwards without crossing a page boundary.
+ */
+static uint64_t page_limit_rev(uint64_t addr)
+{
+    return (addr & ~TARGET_PAGE_MASK) + 1;
+}
+
 /*
  * Perform part of a memory set on an area of guest memory starting at
  * toaddr (a dirty address) and extending for setsize bytes.
@@ -1371,3 +1380,407 @@ void HELPER(sete)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
         env->xregs[rn] = -setsize;
     }
 }
+
+/*
+ * Perform part of a memory copy from the guest memory at fromaddr
+ * and extending for copysize bytes, to the guest memory at
+ * toaddr. Both addreses are dirty.
+ *
+ * Returns the number of bytes actually set, which might be less than
+ * copysize; the caller should loop until the whole copy has been done.
+ * The caller should ensure that the guest registers are correct
+ * for the possibility that the first byte of the copy encounters
+ * an exception or watchpoint. We guarantee not to take any faults
+ * for bytes other than the first.
+ */
+static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
+                          uint64_t copysize, int wmemidx, int rmemidx,
+                          uint32_t *wdesc, uint32_t *rdesc, uintptr_t ra)
+{
+    void *rmem;
+    void *wmem;
+
+    /* Don't cross a page boundary on either source or destination */
+    copysize = MIN(copysize, page_limit(toaddr));
+    copysize = MIN(copysize, page_limit(fromaddr));
+    /*
+     * Handle MTE tag checks: either handle the tag mismatch for byte 0,
+     * or else copy up to but not including the byte with the mismatch.
+     */
+    if (*rdesc) {
+        uint64_t mtesize = mte_mops_probe(env, fromaddr, copysize, *rdesc);
+        if (mtesize == 0) {
+            mte_check_fail(env, *rdesc, fromaddr, ra);
+            *rdesc = 0;
+        } else {
+            copysize = MIN(copysize, mtesize);
+        }
+    }
+    if (*wdesc) {
+        uint64_t mtesize = mte_mops_probe(env, toaddr, copysize, *wdesc);
+        if (mtesize == 0) {
+            mte_check_fail(env, *wdesc, toaddr, ra);
+            *wdesc = 0;
+        } else {
+            copysize = MIN(copysize, mtesize);
+        }
+    }
+
+    toaddr = useronly_clean_ptr(toaddr);
+    fromaddr = useronly_clean_ptr(fromaddr);
+    /* Trapless lookup of whether we can get a host memory pointer */
+    wmem = tlb_vaddr_to_host(env, toaddr, MMU_DATA_STORE, wmemidx);
+    rmem = tlb_vaddr_to_host(env, fromaddr, MMU_DATA_LOAD, rmemidx);
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * If we don't have host memory for both source and dest then just
+     * do a single byte copy. This will handle watchpoints, invalid pages,
+     * etc correctly. For clean code pages, the next iteration will see
+     * the page dirty and will use the fast path.
+     */
+    if (unlikely(!rmem || !wmem)) {
+        uint8_t byte;
+        if (rmem) {
+            byte = *(uint8_t *)rmem;
+        } else {
+            byte = cpu_ldub_mmuidx_ra(env, fromaddr, rmemidx, ra);
+        }
+        if (wmem) {
+            *(uint8_t *)wmem = byte;
+        } else {
+            cpu_stb_mmuidx_ra(env, toaddr, byte, wmemidx, ra);
+        }
+        return 1;
+    }
+#endif
+    /* Easy case: just memmove the host memory */
+    memmove(wmem, rmem, copysize);
+    return copysize;
+}
+
+/*
+ * Do part of a backwards memory copy. Here toaddr and fromaddr point
+ * to the *last* byte to be copied.
+ */
+static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
+                              uint64_t fromaddr,
+                              uint64_t copysize, int wmemidx, int rmemidx,
+                              uint32_t *wdesc, uint32_t *rdesc, uintptr_t ra)
+{
+    void *rmem;
+    void *wmem;
+
+    /* Don't cross a page boundary on either source or destination */
+    copysize = MIN(copysize, page_limit_rev(toaddr));
+    copysize = MIN(copysize, page_limit_rev(fromaddr));
+
+    /*
+     * Handle MTE tag checks: either handle the tag mismatch for byte 0,
+     * or else copy up to but not including the byte with the mismatch.
+     */
+    if (*rdesc) {
+        uint64_t mtesize = mte_mops_probe_rev(env, fromaddr, copysize, *rdesc);
+        if (mtesize == 0) {
+            mte_check_fail(env, *rdesc, fromaddr, ra);
+            *rdesc = 0;
+        } else {
+            copysize = MIN(copysize, mtesize);
+        }
+    }
+    if (*wdesc) {
+        uint64_t mtesize = mte_mops_probe_rev(env, toaddr, copysize, *wdesc);
+        if (mtesize == 0) {
+            mte_check_fail(env, *wdesc, toaddr, ra);
+            *wdesc = 0;
+        } else {
+            copysize = MIN(copysize, mtesize);
+        }
+    }
+
+    toaddr = useronly_clean_ptr(toaddr);
+    fromaddr = useronly_clean_ptr(fromaddr);
+    /* Trapless lookup of whether we can get a host memory pointer */
+    wmem = tlb_vaddr_to_host(env, toaddr, MMU_DATA_STORE, wmemidx);
+    rmem = tlb_vaddr_to_host(env, fromaddr, MMU_DATA_LOAD, rmemidx);
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * If we don't have host memory for both source and dest then just
+     * do a single byte copy. This will handle watchpoints, invalid pages,
+     * etc correctly. For clean code pages, the next iteration will see
+     * the page dirty and will use the fast path.
+     */
+    if (unlikely(!rmem || !wmem)) {
+        uint8_t byte;
+        if (rmem) {
+            byte = *(uint8_t *)rmem;
+        } else {
+            byte = cpu_ldub_mmuidx_ra(env, fromaddr, rmemidx, ra);
+        }
+        if (wmem) {
+            *(uint8_t *)wmem = byte;
+        } else {
+            cpu_stb_mmuidx_ra(env, toaddr, byte, wmemidx, ra);
+        }
+        return 1;
+    }
+#endif
+    /*
+     * Easy case: just memmove the host memory. Note that wmem and
+     * rmem here point to the *last* byte to copy.
+     */
+    memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
+    return copysize;
+}
+
+/*
+ * for the Memory Copy operation, our implementation chooses always
+ * to use "option A", where we update Xd and Xs to the final addresses
+ * in the CPYP insn, and then in CPYM and CPYE only need to update Xn.
+ *
+ * @env: CPU
+ * @syndrome: syndrome value for mismatch exceptions
+ * (also contains the register numbers we need to use)
+ * @wdesc: MTE descriptor for the writes (destination)
+ * @rdesc: MTE descriptor for the reads (source)
+ * @move: true if this is CPY (memmove), false for CPYF (memcpy forwards)
+ */
+void HELPER(cpyp)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
+                  uint32_t rdesc, uint32_t move)
+{
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
+    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
+    bool forwards = true;
+    uintptr_t ra = GETPC();
+    uint64_t toaddr = env->xregs[rd];
+    uint64_t fromaddr = env->xregs[rs];
+    uint64_t copysize = env->xregs[rn];
+    uint64_t stagecopysize, step;
+
+    check_mops_enabled(env, ra);
+
+    if (copysize > 0x007FFFFFFFFFFFFFULL) {
+        copysize = 0x007FFFFFFFFFFFFFULL;
+    }
+
+    if (move) {
+        /*
+         * Copy backwards if necessary. The direction for a non-overlapping
+         * copy is IMPDEF; we choose forwards.
+         */
+        uint64_t fs = extract64(fromaddr, 0, 56);
+        uint64_t ts = extract64(toaddr, 0, 56);
+        uint64_t fe = extract64(fromaddr + copysize, 0, 56);
+
+        if (fs < ts && fe > ts) {
+            forwards = false;
+        }
+    }
+
+    if (!mte_checks_needed(fromaddr, rdesc)) {
+        rdesc = 0;
+    }
+    if (!mte_checks_needed(toaddr, wdesc)) {
+        wdesc = 0;
+    }
+
+    if (forwards) {
+        stagecopysize = MIN(copysize, page_limit(toaddr));
+        stagecopysize = MIN(stagecopysize, page_limit(fromaddr));
+        while (stagecopysize) {
+            env->xregs[rd] = toaddr;
+            env->xregs[rs] = fromaddr;
+            env->xregs[rn] = copysize;
+            step = copy_step(env, toaddr, fromaddr, stagecopysize,
+                             wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            toaddr += step;
+            fromaddr += step;
+            copysize -= step;
+            stagecopysize -= step;
+        }
+        /* Insn completed, so update registers to the Option A format */
+        env->xregs[rd] = toaddr + copysize;
+        env->xregs[rs] = fromaddr + copysize;
+        env->xregs[rn] = -copysize;
+    } else {
+        /*
+         * In a reverse copy the to and from addrs in Xs and Xd are the start
+         * of the range, but it's more convenient for us to work with pointers
+         * to the last byte being copied.
+         */
+        toaddr += copysize - 1;
+        fromaddr += copysize - 1;
+        stagecopysize = MIN(copysize, page_limit_rev(toaddr));
+        stagecopysize = MIN(stagecopysize, page_limit_rev(fromaddr));
+        while (stagecopysize) {
+            env->xregs[rn] = copysize;
+            step = copy_step_rev(env, toaddr, fromaddr, stagecopysize,
+                                 wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            copysize -= step;
+            stagecopysize -= step;
+            toaddr -= step;
+            fromaddr -= step;
+        }
+        /*
+         * Insn completed, so update registers to the Option A format.
+         * For a reverse copy this is no different to the CPYP input format.
+         */
+        env->xregs[rn] = copysize;
+    }
+
+    /* Set NZCV = 0000 to indicate we are an Option A implementation */
+    env->NF = 0;
+    env->ZF = 1; /* our env->ZF encoding is inverted */
+    env->CF = 0;
+    env->VF = 0;
+    return;
+}
+
+void HELPER(cpym)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
+                  uint32_t rdesc, uint32_t move)
+{
+    /* Main: we choose to copy until less than a page remaining */
+    CPUState *cs = env_cpu(env);
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
+    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
+    uintptr_t ra = GETPC();
+    bool forwards;
+    uint64_t toaddr, fromaddr, copysize, step;
+
+    check_mops_enabled(env, ra);
+
+    /* We choose to NOP out "no data to copy" before consistency checks */
+    if (env->xregs[rn] == 0) {
+        return;
+    }
+
+    check_mops_wrong_option(env, syndrome, ra);
+
+    if ((int64_t)env->xregs[rn] < 0) {
+        forwards = true;
+        toaddr = env->xregs[rd] + env->xregs[rn];
+        fromaddr = env->xregs[rs] + env->xregs[rn];
+        copysize = -env->xregs[rn];
+    } else {
+        forwards = false;
+        copysize = env->xregs[rn];
+        /* This toaddr and fromaddr point to the *last* byte to copy */
+        toaddr = env->xregs[rd] + copysize - 1;
+        fromaddr = env->xregs[rs] + copysize - 1;
+    }
+
+    if (!mte_checks_needed(fromaddr, rdesc)) {
+        rdesc = 0;
+    }
+    if (!mte_checks_needed(toaddr, wdesc)) {
+        wdesc = 0;
+    }
+
+    /* Our implementation has no particular parameter requirements for CPYM */
+
+    /* Do the actual memmove */
+    if (forwards) {
+        while (copysize >= TARGET_PAGE_SIZE) {
+            step = copy_step(env, toaddr, fromaddr, copysize,
+                             wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            toaddr += step;
+            fromaddr += step;
+            copysize -= step;
+            env->xregs[rn] = -copysize;
+            if (copysize >= TARGET_PAGE_SIZE &&
+                unlikely(cpu_loop_exit_requested(cs))) {
+                cpu_loop_exit_restore(cs, ra);
+            }
+        }
+    } else {
+        while (copysize >= TARGET_PAGE_SIZE) {
+            step = copy_step_rev(env, toaddr, fromaddr, copysize,
+                                 wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            toaddr -= step;
+            fromaddr -= step;
+            copysize -= step;
+            env->xregs[rn] = copysize;
+            if (copysize >= TARGET_PAGE_SIZE &&
+                unlikely(cpu_loop_exit_requested(cs))) {
+                cpu_loop_exit_restore(cs, ra);
+            }
+        }
+    }
+}
+
+void HELPER(cpye)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
+                  uint32_t rdesc, uint32_t move)
+{
+    /* Epilogue: do the last partial page */
+    int rd = mops_destreg(syndrome);
+    int rs = mops_srcreg(syndrome);
+    int rn = mops_sizereg(syndrome);
+    uint32_t rmemidx = FIELD_EX32(rdesc, MTEDESC, MIDX);
+    uint32_t wmemidx = FIELD_EX32(wdesc, MTEDESC, MIDX);
+    uintptr_t ra = GETPC();
+    bool forwards;
+    uint64_t toaddr, fromaddr, copysize, step;
+
+    check_mops_enabled(env, ra);
+
+    /* We choose to NOP out "no data to copy" before consistency checks */
+    if (env->xregs[rn] == 0) {
+        return;
+    }
+
+    check_mops_wrong_option(env, syndrome, ra);
+
+    if ((int64_t)env->xregs[rn] < 0) {
+        forwards = true;
+        toaddr = env->xregs[rd] + env->xregs[rn];
+        fromaddr = env->xregs[rs] + env->xregs[rn];
+        copysize = -env->xregs[rn];
+    } else {
+        forwards = false;
+        copysize = env->xregs[rn];
+        /* This toaddr and fromaddr point to the *last* byte to copy */
+        toaddr = env->xregs[rd] + copysize - 1;
+        fromaddr = env->xregs[rs] + copysize - 1;
+    }
+
+    if (!mte_checks_needed(fromaddr, rdesc)) {
+        rdesc = 0;
+    }
+    if (!mte_checks_needed(toaddr, wdesc)) {
+        wdesc = 0;
+    }
+
+    /* Check the size; we don't want to have do a check-for-interrupts */
+    if (copysize >= TARGET_PAGE_SIZE) {
+        raise_exception_ra(env, EXCP_UDEF, syndrome,
+                           mops_mismatch_exception_target_el(env), ra);
+    }
+
+    /* Do the actual memmove */
+    if (forwards) {
+        while (copysize > 0) {
+            step = copy_step(env, toaddr, fromaddr, copysize,
+                             wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            toaddr += step;
+            fromaddr += step;
+            copysize -= step;
+            env->xregs[rn] = -copysize;
+        }
+    } else {
+        while (copysize > 0) {
+            step = copy_step_rev(env, toaddr, fromaddr, copysize,
+                                 wmemidx, rmemidx, &wdesc, &rdesc, ra);
+            toaddr -= step;
+            fromaddr -= step;
+            copysize -= step;
+            env->xregs[rn] = copysize;
+        }
+    }
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 131a15bed2f..600698d4e76 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4009,6 +4009,63 @@ TRANS_FEAT(SETGP, aa64_mops, do_SET, a, false, true, gen_helper_setp)
 TRANS_FEAT(SETGM, aa64_mops, do_SET, a, false, true, gen_helper_setm)
 TRANS_FEAT(SETGE, aa64_mops, do_SET, a, true, true, gen_helper_sete)
 
+typedef void CpyFn(TCGv_env, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+
+static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
+{
+    int rmemidx, wmemidx;
+    uint32_t syndrome, rdesc = 0, wdesc = 0;
+    bool wunpriv = extract32(a->options, 0, 1);
+    bool runpriv = extract32(a->options, 1, 1);
+
+    /*
+     * UNPREDICTABLE cases: we choose to UNDEF, which allows
+     * us to pull this check before the CheckMOPSEnabled() test
+     * (which we do in the helper function)
+     */
+    if (a->rs == a->rn || a->rs == a->rd || a->rn == a->rd ||
+        a->rd == 31 || a->rs == 31 || a->rn == 31) {
+        return false;
+    }
+
+    rmemidx = get_a64_user_mem_index(s, runpriv);
+    wmemidx = get_a64_user_mem_index(s, wunpriv);
+
+    /*
+     * We pass option_a == true, matching our implementation;
+     * we pass wrong_option == false: helper function may set that bit.
+     */
+    syndrome = syn_mop(false, false, a->options, is_epilogue,
+                       false, true, a->rd, a->rs, a->rn);
+
+    /* If we need to do MTE tag checking, assemble the descriptors */
+    if (s->mte_active[runpriv]) {
+        rdesc = FIELD_DP32(rdesc, MTEDESC, TBI, s->tbid);
+        rdesc = FIELD_DP32(rdesc, MTEDESC, TCMA, s->tcma);
+    }
+    if (s->mte_active[wunpriv]) {
+        wdesc = FIELD_DP32(wdesc, MTEDESC, TBI, s->tbid);
+        wdesc = FIELD_DP32(wdesc, MTEDESC, TCMA, s->tcma);
+        wdesc = FIELD_DP32(wdesc, MTEDESC, WRITE, true);
+    }
+    /* The helper function needs these parts of the descriptor regardless */
+    rdesc = FIELD_DP32(rdesc, MTEDESC, MIDX, rmemidx);
+    wdesc = FIELD_DP32(wdesc, MTEDESC, MIDX, wmemidx);
+
+    /*
+     * The helper needs the register numbers, but since they're in
+     * the syndrome anyway, we let it extract them from there rather
+     * than passing in an extra three integer arguments.
+     */
+    fn(cpu_env, tcg_constant_i32(syndrome), tcg_constant_i32(wdesc),
+       tcg_constant_i32(rdesc), tcg_constant_i32(a->move));
+    return true;
+}
+
+TRANS_FEAT(CPYP, aa64_mops, do_CPY, a, false, gen_helper_cpyp)
+TRANS_FEAT(CPYM, aa64_mops, do_CPY, a, false, gen_helper_cpym)
+TRANS_FEAT(CPYE, aa64_mops, do_CPY, a, true, gen_helper_cpye)
+
 typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
 
 static bool gen_rri(DisasContext *s, arg_rri_sf *a,
-- 
2.34.1



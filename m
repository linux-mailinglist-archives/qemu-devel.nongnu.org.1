Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC679D33F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg413-0008Ss-UN; Tue, 12 Sep 2023 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40r-0008Gc-2x
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40l-0003rM-9z
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so5609459f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527486; x=1695132286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oMzPBnHkJEk4I1sTfs7iYXVAv7BO9UDWeNUPlFOQw40=;
 b=pwc9mIsTTE0JFcK+mY2D5Fs6sLyQtvYnZ2WYyflZfkHogfTdSwysGwl4UiFsyeIQfe
 RLNhGhxPkP/ttFld7srhEOwYL1sKNkbLQD6ZYw4Vgmip5Taw6FgFGx/WxjfD7ZPBrY+X
 QcjGjpNX5Ycx525Nsy1pxCKwd6h5PbX9xGZuZowaGgF8uTCbeNoiv0xgGNizEwe8N3HB
 2uO11W1RnZJlxRO8fRdmaZwUZmOkoS7AcnTFwkMPwPzfQ27Pa7rEen86+mFHvsDyQsJ/
 Ub2iCP7/o03rA13jic+cHILFu6kRXev7M+rQ8S9HzkMAEFf1CN1T96ahgodZ69Cbnt0t
 gMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527486; x=1695132286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMzPBnHkJEk4I1sTfs7iYXVAv7BO9UDWeNUPlFOQw40=;
 b=lc31Omm9n6muCCaKU4HFkwnR6Xx1kPiywRSi54C07HiN1azzMQOu2BaIf55WTrxMd5
 kWVcINh9qoM8Eks4zye6lx7zpxrcWeycVoNB8+I3+PDu6dhg3LAUcKSrvmAe4n3GF67H
 8eOelUleXk3nczh//Td4GV+YjtZoUylCjBrr8DuLlqsiVJvX9DkKyG2W608kqNaYp5cW
 4McxMKCb5FaFeEyDL+ojl/ZN3w09+F47tAxPak2whE7/sg9xuFb7vq3E2xPjTr5bhqbq
 ewg603WXg4Kg+ouIpEtEyanjG1cDyLCZ7Ca0VZZiaOCR/qcChFHGwrT6Ol9tY3w8KVbH
 W8Ew==
X-Gm-Message-State: AOJu0YxCjyT/0V/KWlMXZSgeCMvY0KKu1fsndP1hMQmy7B/ntVJCn8L9
 ka9eF0J7cYkvgovyfMZI4uTlRQ==
X-Google-Smtp-Source: AGHT+IGEfzBrKRp10FMl9Ih2ufgRFFZhhNCLcZYOG0njOZN9+XeFzz0864CR2Nekq7nRkAEU++QxJg==
X-Received: by 2002:adf:ecc8:0:b0:314:1ca4:dbd9 with SMTP id
 s8-20020adfecc8000000b003141ca4dbd9mr10171512wro.27.1694527484873; 
 Tue, 12 Sep 2023 07:04:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] target/arm: Implement the SETG* instructions
Date: Tue, 12 Sep 2023 15:04:31 +0100
Message-Id: <20230912140434.1333369-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The FEAT_MOPS SETG* instructions are very similar to the SET*
instructions, but as well as setting memory contents they also
set the MTE tags. They are architecturally required to operate
on tag-granule aligned regions only.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: - separate helper functions calling do_setp/setm/sete
    - use cpu_st16_mmu()
---
 target/arm/internals.h         | 10 ++++
 target/arm/tcg/helper-a64.h    |  3 ++
 target/arm/tcg/a64.decode      |  5 ++
 target/arm/tcg/helper-a64.c    | 86 ++++++++++++++++++++++++++++++++--
 target/arm/tcg/mte_helper.c    | 40 ++++++++++++++++
 target/arm/tcg/translate-a64.c | 20 +++++---
 6 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a70a7fd50f6..642f77df29b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1300,6 +1300,16 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
 void mte_check_fail(CPUARMState *env, uint32_t desc,
                     uint64_t dirty_ptr, uintptr_t ra);
 
+/**
+ * mte_mops_set_tags: Set MTE tags for a portion of a FEAT_MOPS operation
+ * @env: CPU env
+ * @dirty_ptr: Start address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross page boundary)
+ * @desc: MTEDESC descriptor word
+ */
+void mte_mops_set_tags(CPUARMState *env, uint64_t dirty_ptr, uint64_t size,
+                       uint32_t desc);
+
 static inline int allocation_tag_from_addr(uint64_t ptr)
 {
     return extract64(ptr, 56, 4);
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 7ce5d2105ad..10a99107124 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -121,3 +121,6 @@ DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
 DEF_HELPER_3(setp, void, env, i32, i32)
 DEF_HELPER_3(setm, void, env, i32, i32)
 DEF_HELPER_3(sete, void, env, i32, i32)
+DEF_HELPER_3(setgp, void, env, i32, i32)
+DEF_HELPER_3(setgm, void, env, i32, i32)
+DEF_HELPER_3(setge, void, env, i32, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c2a97328eeb..a202faa17bc 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -570,3 +570,8 @@ STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
 SETP            00 011001110 ..... 00 . . 01 ..... ..... @set
 SETM            00 011001110 ..... 01 . . 01 ..... ..... @set
 SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
+
+# Like SET, but also setting MTE tags
+SETGP           00 011101110 ..... 00 . . 01 ..... ..... @set
+SETGM           00 011101110 ..... 01 . . 01 ..... ..... @set
+SETGE           00 011101110 ..... 10 . . 01 ..... ..... @set
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 24ae5ecf32e..2cf89184d77 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1103,6 +1103,50 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
     return setsize;
 }
 
+/*
+ * Similar, but setting tags. The architecture requires us to do this
+ * in 16-byte chunks. SETP accesses are not tag checked; they set
+ * the tags.
+ */
+static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
+                              uint64_t setsize, uint32_t data, int memidx,
+                              uint32_t *mtedesc, uintptr_t ra)
+{
+    void *mem;
+    uint64_t cleanaddr;
+
+    setsize = MIN(setsize, page_limit(toaddr));
+
+    cleanaddr = useronly_clean_ptr(toaddr);
+    /*
+     * Trapless lookup: returns NULL for invalid page, I/O,
+     * watchpoints, clean pages, etc.
+     */
+    mem = tlb_vaddr_to_host(env, cleanaddr, MMU_DATA_STORE, memidx);
+
+#ifndef CONFIG_USER_ONLY
+    if (unlikely(!mem)) {
+        /*
+         * Slow-path: just do one write. This will handle the
+         * watchpoint, invalid page, etc handling correctly.
+         * The architecture requires that we do 16 bytes at a time,
+         * and we know both ptr and size are 16 byte aligned.
+         * For clean code pages, the next iteration will see
+         * the page dirty and will use the fast path.
+         */
+        uint64_t repldata = data * 0x0101010101010101ULL;
+        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
+        cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), oi16, ra);
+        mte_mops_set_tags(env, toaddr, 16, *mtedesc);
+        return 16;
+    }
+#endif
+    /* Easy case: just memset the host memory */
+    memset(mem, data, setsize);
+    mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
+    return setsize;
+}
+
 typedef uint64_t StepFn(CPUARMState *env, uint64_t toaddr,
                         uint64_t setsize, uint32_t data,
                         int memidx, uint32_t *mtedesc, uintptr_t ra);
@@ -1141,6 +1185,18 @@ static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
     return !tcma_check(desc, bit55, allocation_tag_from_addr(ptr));
 }
 
+/* Take an exception if the SETG addr/size are not granule aligned */
+static void check_setg_alignment(CPUARMState *env, uint64_t ptr, uint64_t size,
+                                 uint32_t memidx, uintptr_t ra)
+{
+    if ((size != 0 && !QEMU_IS_ALIGNED(ptr, TAG_GRANULE)) ||
+        !QEMU_IS_ALIGNED(size, TAG_GRANULE)) {
+        arm_cpu_do_unaligned_access(env_cpu(env), ptr, MMU_DATA_STORE,
+                                    memidx, ra);
+
+    }
+}
+
 /*
  * For the Memory Set operation, our implementation chooses
  * always to use "option A", where we update Xd to the final
@@ -1171,9 +1227,14 @@ static void do_setp(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
 
     if (setsize > INT64_MAX) {
         setsize = INT64_MAX;
+        if (is_setg) {
+            setsize &= ~0xf;
+        }
     }
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(is_setg)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
@@ -1203,6 +1264,11 @@ void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     do_setp(env, syndrome, mtedesc, set_step, false, GETPC());
 }
 
+void HELPER(setgp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_setp(env, syndrome, mtedesc, set_step_tags, true, GETPC());
+}
+
 static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
                     StepFn *stepfn, bool is_setg, uintptr_t ra)
 {
@@ -1237,7 +1303,9 @@ static void do_setm(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
      * have an IMPDEF check for alignment here.
      */
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(is_setg)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
@@ -1260,6 +1328,11 @@ void HELPER(setm)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     do_setm(env, syndrome, mtedesc, set_step, false, GETPC());
 }
 
+void HELPER(setgm)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_setm(env, syndrome, mtedesc, set_step_tags, true, GETPC());
+}
+
 static void do_sete(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
                     StepFn *stepfn, bool is_setg, uintptr_t ra)
 {
@@ -1295,7 +1368,9 @@ static void do_sete(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
                            mops_mismatch_exception_target_el(env), ra);
     }
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(is_setg)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
@@ -1312,3 +1387,8 @@ void HELPER(sete)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
 {
     do_sete(env, syndrome, mtedesc, set_step, false, GETPC());
 }
+
+void HELPER(setge)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
+{
+    do_sete(env, syndrome, mtedesc, set_step_tags, true, GETPC());
+}
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 1cb61cea7af..66a80eeb950 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1041,3 +1041,43 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
         return n * TAG_GRANULE - (ptr - tag_first);
     }
 }
+
+void mte_mops_set_tags(CPUARMState *env, uint64_t ptr, uint64_t size,
+                       uint32_t desc)
+{
+    int mmu_idx, tag_count;
+    uint64_t ptr_tag;
+    void *mem;
+
+    if (!desc) {
+        /* Tags not actually enabled */
+        return;
+    }
+
+    mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    /* True probe: this will never fault */
+    mem = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE, size,
+                                   MMU_DATA_STORE, true, 0);
+    if (!mem) {
+        return;
+    }
+
+    /*
+     * We know that ptr and size are both TAG_GRANULE aligned; store
+     * the tag from the pointer value into the tag memory.
+     */
+    ptr_tag = allocation_tag_from_addr(ptr);
+    tag_count = size / TAG_GRANULE;
+    if (ptr & TAG_GRANULE) {
+        /* Not 2*TAG_GRANULE-aligned: store tag to first nibble */
+        store_tag1_parallel(TAG_GRANULE, mem, ptr_tag);
+        mem++;
+        tag_count--;
+    }
+    memset(mem, ptr_tag | (ptr_tag << 4), tag_count / 2);
+    if (tag_count & 1) {
+        /* Final trailing unaligned nibble */
+        mem += tag_count / 2;
+        store_tag1_parallel(0, mem, ptr_tag);
+    }
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index da4aabbaf4e..27bb3039b4d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3964,11 +3964,16 @@ TRANS_FEAT(STZ2G, aa64_mte_insn_reg, do_STG, a, true, true)
 
 typedef void SetFn(TCGv_env, TCGv_i32, TCGv_i32);
 
-static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
+static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
+                   bool is_setg, SetFn fn)
 {
     int memidx;
     uint32_t syndrome, desc = 0;
 
+    if (is_setg && !dc_isar_feature(aa64_mte, s)) {
+        return false;
+    }
+
     /*
      * UNPREDICTABLE cases: we choose to UNDEF, which allows
      * us to pull this check before the CheckMOPSEnabled() test
@@ -3985,10 +3990,10 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
      * We pass option_a == true, matching our implementation;
      * we pass wrong_option == false: helper function may set that bit.
      */
-    syndrome = syn_mop(true, false, (a->nontemp << 1) | a->unpriv,
+    syndrome = syn_mop(true, is_setg, (a->nontemp << 1) | a->unpriv,
                        is_epilogue, false, true, a->rd, a->rs, a->rn);
 
-    if (s->mte_active[a->unpriv]) {
+    if (is_setg ? s->ata[a->unpriv] : s->mte_active[a->unpriv]) {
         /* We may need to do MTE tag checking, so assemble the descriptor */
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
@@ -4007,9 +4012,12 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
     return true;
 }
 
-TRANS_FEAT(SETP, aa64_mops, do_SET, a, false, gen_helper_setp)
-TRANS_FEAT(SETM, aa64_mops, do_SET, a, false, gen_helper_setm)
-TRANS_FEAT(SETE, aa64_mops, do_SET, a, true, gen_helper_sete)
+TRANS_FEAT(SETP, aa64_mops, do_SET, a, false, false, gen_helper_setp)
+TRANS_FEAT(SETM, aa64_mops, do_SET, a, false, false, gen_helper_setm)
+TRANS_FEAT(SETE, aa64_mops, do_SET, a, true, false, gen_helper_sete)
+TRANS_FEAT(SETGP, aa64_mops, do_SET, a, false, true, gen_helper_setgp)
+TRANS_FEAT(SETGM, aa64_mops, do_SET, a, false, true, gen_helper_setgm)
+TRANS_FEAT(SETGE, aa64_mops, do_SET, a, true, true, gen_helper_setge)
 
 typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
 
-- 
2.34.1



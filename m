Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8BB79763F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU8-0000xf-3o; Thu, 07 Sep 2023 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU6-0000w7-7r
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTx-00021G-VL
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401f503b529so12803745e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102628; x=1694707428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZiBORTdM6TOex5Ch3MUky9TLBNrJWLAnvWc+DvHI30=;
 b=XDwqtFDeW/RImtPelMadJaVAtRvVwdlvU1V4sRHzqc9iz7l1uq8XKLyu3rigbT0RH2
 KfrMqZySbOnpj7ocH0BtPQZQfKGMNrGU7I83EMZBncEn88e5IQvWI74yuF6WGoEWWx2f
 8Y/mPm3FojE1K+RwwMveywlQCe3zzXDVq5+pphJBuQV9vFr1tNJ136vg7aYZB/ifMIbp
 gLvVORzjKTbPSUDbDDFgAqQIsrSlmUyH7+Un2LUtZz4poPmHerIuLCXT6PypKtQeRCfA
 qv0SIqS2ux2/SEgGzwE6DqQeC/rN0Mq89RTFAt4QHs+aCicEv1lslXgk64FmE8uVVRMR
 TCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102628; x=1694707428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZiBORTdM6TOex5Ch3MUky9TLBNrJWLAnvWc+DvHI30=;
 b=EU9ggS2VT172GtdVUdOufl/L9Q1gyoGuAtoA4fSomHlK2r0yQjfqo3g9PMeU6qEuIc
 bBSq6Rq90fnrIAKGdmq//IATN3dDXU0i0ozBdm2XXCsNWpW2fmtmSSEZ/9Xq45KWr8h9
 XnxCkNfFivUwXBXQ08vfEtETTKhjILxBX+/YDl1djByMGBC9zYO5Z7xL6D9rF9zqJRsf
 BDmtge5n8QJDIlzbfk0JPuDT8iHp/rWQ8kTCmr2p/IpgqkoYFT908cX2dPGO0bSjr8y9
 CZqj8v6IH+TNJWE7ke2lQif70qlH4aLTgoh7PqybkzinGb8NScA3d4OeCxlObFFuYYaR
 Pu2Q==
X-Gm-Message-State: AOJu0YwV0nug9SG0iuvV19jo/4HtBEjHrBf+TpSxoEbtYyTYFV+Q+8tx
 6Ni8PEILW9u3THriVEhUHX9+vg==
X-Google-Smtp-Source: AGHT+IGxdJ5BI8+AtfYKuqik4OXPQ2wl+NhDeF43WuVd82wkIrLju6SzrjeIGQVdzUCIGvI0la1ygA==
X-Received: by 2002:adf:e4c3:0:b0:317:5b1b:1a40 with SMTP id
 v3-20020adfe4c3000000b003175b1b1a40mr5168682wrm.49.1694102628574; 
 Thu, 07 Sep 2023 09:03:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/14] target/arm: Implement the SETG* instructions
Date: Thu,  7 Sep 2023 17:03:37 +0100
Message-Id: <20230907160340.260094-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The FEAT_MOPS SETG* instructions are very similar to the SET*
instructions, but as well as setting memory contents they also
set the MTE tags. They are architecturally required to operate
on tag-granule aligned regions only.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h         | 10 ++++
 target/arm/tcg/a64.decode      |  5 ++
 target/arm/tcg/helper-a64.c    | 92 +++++++++++++++++++++++++++++++---
 target/arm/tcg/mte_helper.c    | 40 +++++++++++++++
 target/arm/tcg/translate-a64.c | 20 +++++---
 5 files changed, 155 insertions(+), 12 deletions(-)

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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8cddc207a6f..46caeb59fe5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -569,3 +569,8 @@ STZ2G           11011001 11 1 ......... 11 ..... ..... @ldst_tag p=0 w=1
 SETP            00 011001110 ..... 00 . . 01 ..... ..... @set
 SETM            00 011001110 ..... 01 . . 01 ..... ..... @set
 SETE            00 011001110 ..... 10 . . 01 ..... ..... @set
+
+# Like SET, but also setting MTE tags
+SETGP           00 011101110 ..... 00 . . 01 ..... ..... @set
+SETGM           00 011101110 ..... 01 . . 01 ..... ..... @set
+SETGE           00 011101110 ..... 10 . . 01 ..... ..... @set
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 73169eb0b56..96780067262 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1103,6 +1103,54 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
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
+        cpu_stq_mmuidx_ra(env, toaddr, repldata, memidx, ra);
+        cpu_stq_mmuidx_ra(env, toaddr + 8, repldata, memidx, ra);
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
+typedef uint64_t StepFn(CPUARMState *env, uint64_t toaddr,
+                        uint64_t setsize, uint32_t data,
+                        int memidx, uint32_t *mtedesc, uintptr_t ra);
+
 /* Extract register numbers from a MOPS exception syndrome value */
 static int mops_destreg(uint32_t syndrome)
 {
@@ -1119,6 +1167,11 @@ static int mops_sizereg(uint32_t syndrome)
     return extract32(syndrome, 0, 5);
 }
 
+static bool mops_is_setg(uint32_t syndrome)
+{
+    return extract32(syndrome, 23, 1);
+}
+
 /*
  * Return true if TCMA and TBI bits mean we need to do MTE checks.
  * We only need to do this once per MOPS insn, not for every page.
@@ -1137,6 +1190,18 @@ static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
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
@@ -1154,20 +1219,27 @@ void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
+    bool set_tags = mops_is_setg(syndrome);
     uint8_t data = env->xregs[rs];
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
     uint64_t toaddr = env->xregs[rd];
     uint64_t setsize = env->xregs[rn];
     uint64_t stagesetsize, step;
     uintptr_t ra = GETPC();
+    StepFn *stepfn = set_tags ? set_step_tags : set_step;
 
     check_mops_enabled(env, ra);
 
     if (setsize > INT64_MAX) {
         setsize = INT64_MAX;
+        if (set_tags) {
+            setsize &= ~0xf;
+        }
     }
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(set_tags)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
@@ -1175,7 +1247,7 @@ void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     while (stagesetsize) {
         env->xregs[rd] = toaddr;
         env->xregs[rn] = setsize;
-        step = set_step(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
+        step = stepfn(env, toaddr, stagesetsize, data, memidx, &mtedesc, ra);
         toaddr += step;
         setsize -= step;
         stagesetsize -= step;
@@ -1199,12 +1271,14 @@ void HELPER(setm)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
+    bool set_tags = mops_is_setg(syndrome);
     uint8_t data = env->xregs[rs];
     uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
     uint64_t setsize = -env->xregs[rn];
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
     uint64_t step, stagesetsize;
     uintptr_t ra = GETPC();
+    StepFn *stepfn = set_tags ? set_step_tags : set_step;
 
     check_mops_enabled(env, ra);
 
@@ -1226,14 +1300,16 @@ void HELPER(setm)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
      * have an IMPDEF check for alignment here.
      */
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(set_tags)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
     /* Do the actual memset: we leave the last partial page to SETE */
     stagesetsize = setsize & TARGET_PAGE_MASK;
     while (stagesetsize > 0) {
-        step = set_step(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
         toaddr += step;
         setsize -= step;
         stagesetsize -= step;
@@ -1250,12 +1326,14 @@ void HELPER(sete)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
     int rd = mops_destreg(syndrome);
     int rs = mops_srcreg(syndrome);
     int rn = mops_sizereg(syndrome);
+    bool set_tags = mops_is_setg(syndrome);
     uint8_t data = env->xregs[rs];
     uint64_t toaddr = env->xregs[rd] + env->xregs[rn];
     uint64_t setsize = -env->xregs[rn];
     uint32_t memidx = FIELD_EX32(mtedesc, MTEDESC, MIDX);
     uint64_t step;
     uintptr_t ra = GETPC();
+    StepFn *stepfn = set_tags ? set_step_tags : set_step;
 
     check_mops_enabled(env, ra);
 
@@ -1279,13 +1357,15 @@ void HELPER(sete)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
                            mops_mismatch_exception_target_el(env), ra);
     }
 
-    if (!mte_checks_needed(toaddr, mtedesc)) {
+    if (unlikely(set_tags)) {
+        check_setg_alignment(env, toaddr, setsize, memidx, ra);
+    } else if (!mte_checks_needed(toaddr, mtedesc)) {
         mtedesc = 0;
     }
 
     /* Do the actual memset */
     while (setsize > 0) {
-        step = set_step(env, toaddr, setsize, data, memidx, &mtedesc, ra);
+        step = stepfn(env, toaddr, setsize, data, memidx, &mtedesc, ra);
         toaddr += step;
         setsize -= step;
         env->xregs[rn] = -setsize;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0065012be19..d934f89bebb 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1040,3 +1040,43 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
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
index 366ddde57f7..131a15bed2f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3954,11 +3954,16 @@ TRANS_FEAT(STZ2G, aa64_mte_insn_reg, do_STG, a, true, true)
 
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
@@ -3975,10 +3980,10 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
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
@@ -3997,9 +4002,12 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue, SetFn fn)
     return true;
 }
 
-TRANS_FEAT(SETP, aa64_mops, do_SET, a, false, gen_helper_setp)
-TRANS_FEAT(SETM, aa64_mops, do_SET, a, false, gen_helper_setm)
-TRANS_FEAT(SETE, aa64_mops, do_SET, a, true, gen_helper_sete)
+TRANS_FEAT(SETP, aa64_mops, do_SET, a, false, false, gen_helper_setp)
+TRANS_FEAT(SETM, aa64_mops, do_SET, a, false, false, gen_helper_setm)
+TRANS_FEAT(SETE, aa64_mops, do_SET, a, true, false, gen_helper_sete)
+TRANS_FEAT(SETGP, aa64_mops, do_SET, a, false, true, gen_helper_setp)
+TRANS_FEAT(SETGM, aa64_mops, do_SET, a, false, true, gen_helper_setm)
+TRANS_FEAT(SETGE, aa64_mops, do_SET, a, true, true, gen_helper_sete)
 
 typedef void ArithTwoOp(TCGv_i64, TCGv_i64, TCGv_i64);
 
-- 
2.34.1



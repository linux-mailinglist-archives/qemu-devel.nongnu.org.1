Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C079763E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU6-0000w1-DZ; Thu, 07 Sep 2023 12:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU3-0000u0-Dz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTw-00020g-Gj
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31dca134c83so1068124f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102627; x=1694707427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJw3JLPILyaoZeMHMFoxBuLHWlgQhlRFClPLCm9EsO8=;
 b=ZatUdvuEtNQISXPEoXmdcaWOGpUIgI0Kp5w4yyKPUwiJUTRhd676FnbP1cAEyZ+oJJ
 WN95+lpIQZDhHGq8jlCMc0CTNEDYRCssGByhk8nqtKOxWVRqX0Jh+DCUhGynqHoZ4cwH
 Q1d0cK0dkb2B5jY7hG0m4I86BdU/xYY/nCMuY7oNtN7YOMDIpeRpmNsWyKV2Xh/KdkXB
 8Jc62lsPG94gBx4dW75JDqOhYm9vlmfv+pdcPR9KkSL2uzcaVZXrM0D+EWOttUiamIMq
 voMbRlZE+qIXV4CXtCTKnRE9AMxuHjJpM43tbxmttB2XRUZE3rjXm1lusWy+mtTuXA2R
 KHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102627; x=1694707427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJw3JLPILyaoZeMHMFoxBuLHWlgQhlRFClPLCm9EsO8=;
 b=XaHDbYLSqMd//WPaUNDg9ZC/Cy2MHtLY7cdRbMi0CiVgrLapDS43gz79r43yZa3352
 8/0IJwp2BmouhupROGs//FtQXaM3HmGnyyuwf+SoT1gmUhl24L1IaOZtoEbixwr66Otq
 TEPvyG+O9M3ztMJEEVaJoNtWDYV3xCxh7JRqDNx8MNHOGAu73L4GU7ugtcPx1a3IpJFH
 hsbhjjEZY2gpxsvwXuNqLK1zcaNPBHQklLglkhr/0OAVJF5Gq5Evdrx4XqCeMV7P2aw0
 tvXaDI6U3kRxEEngm4SCB9A+G+Tkujf3uhGl0/sYdQfFqrhTETorMit5saxqIlxmlxvk
 qNrg==
X-Gm-Message-State: AOJu0YwBcu9EJjbEWGmEwxUv4oYJQtEwDjW090z5Oi6KPR5C9ZUCfqDh
 0HsEnzO0YY+hcjqWgTQx5CjccQ==
X-Google-Smtp-Source: AGHT+IE7bvtNxbDy2JBxfoBg9V8MNoGdXrRwLhVKQlzrW0Xb2qlOb7C+5QYJBDZS7Av/MdBVQ4kcrg==
X-Received: by 2002:adf:e5c7:0:b0:319:6ae0:cae5 with SMTP id
 a7-20020adfe5c7000000b003196ae0cae5mr4312679wrn.70.1694102627127; 
 Thu, 07 Sep 2023 09:03:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/14] target/arm: Implement MTE tag-checking functions for
 FEAT_MOPS
Date: Thu,  7 Sep 2023 17:03:34 +0100
Message-Id: <20230907160340.260094-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The FEAT_MOPS instructions need a couple of helper routines that
check for MTE tag failures:
 * mte_mops_probe() checks whether there is going to be a tag
   error in the next up-to-a-page worth of data
 * mte_check_fail() is an existing function to record the fact
   of a tag failure, which we need to make global so we can
   call it from helper-a64.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h      | 28 +++++++++++++++++++
 target/arm/tcg/mte_helper.c | 54 +++++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5f5393b25c4..a70a7fd50f6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1272,6 +1272,34 @@ FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
 
+/**
+ * mte_mops_probe: Check where the next MTE failure is for a FEAT_MOPS operation
+ * @env: CPU env
+ * @ptr: start address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross a page boundary)
+ * @desc: MTEDESC descriptor word (0 means no MTE checks)
+ * Returns: the size of the region that can be copied without hitting
+ *          an MTE tag failure
+ *
+ * Note that we assume that the caller has already checked the TBI
+ * and TCMA bits with mte_checks_needed() and an MTE check is definitely
+ * required.
+ */
+uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
+                        uint32_t desc);
+
+/**
+ * mte_check_fail: Record an MTE tag check failure
+ * @env: CPU env
+ * @desc: MTEDESC descriptor word
+ * @dirty_ptr: Failing dirty address
+ * @ra: TCG retaddr
+ *
+ * This may never return (if the MTE tag checks are configured to fault).
+ */
+void mte_check_fail(CPUARMState *env, uint32_t desc,
+                    uint64_t dirty_ptr, uintptr_t ra);
+
 static inline int allocation_tag_from_addr(uint64_t ptr)
 {
     return extract64(ptr, 56, 4);
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 884d88848aa..0065012be19 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -616,8 +616,8 @@ static void mte_async_check_fail(CPUARMState *env, uint64_t dirty_ptr,
 }
 
 /* Record a tag check failure.  */
-static void mte_check_fail(CPUARMState *env, uint32_t desc,
-                           uint64_t dirty_ptr, uintptr_t ra)
+void mte_check_fail(CPUARMState *env, uint32_t desc,
+                    uint64_t dirty_ptr, uintptr_t ra)
 {
     int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     ARMMMUIdx arm_mmu_idx = core_to_aa64_mmu_idx(mmu_idx);
@@ -990,3 +990,53 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
  done:
     return useronly_clean_ptr(ptr);
 }
+
+uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
+                        uint32_t desc)
+{
+    int mmu_idx, tag_count;
+    uint64_t ptr_tag, tag_first, tag_last;
+    void *mem;
+    bool w = FIELD_EX32(desc, MTEDESC, WRITE);
+    uint32_t n;
+
+    mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    /* True probe; this will never fault */
+    mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
+                                   w ? MMU_DATA_STORE : MMU_DATA_LOAD,
+                                   size, MMU_DATA_LOAD, true, 0);
+    if (!mem) {
+        return size;
+    }
+
+    /*
+     * TODO: checkN() is not designed for checks of the size we expect
+     * for FEAT_MOPS operations, so we should implement this differently.
+     * Maybe we should do something like
+     *   if (region start and size are aligned nicely) {
+     *      do direct loads of 64 tag bits at a time;
+     *   } else {
+     *      call checkN()
+     *   }
+     */
+    /* Round the bounds to the tag granule, and compute the number of tags. */
+    ptr_tag = allocation_tag_from_addr(ptr);
+    tag_first = QEMU_ALIGN_DOWN(ptr, TAG_GRANULE);
+    tag_last = QEMU_ALIGN_DOWN(ptr + size - 1, TAG_GRANULE);
+    tag_count = ((tag_last - tag_first) / TAG_GRANULE) + 1;
+    n = checkN(mem, ptr & TAG_GRANULE, ptr_tag, tag_count);
+    if (likely(n == tag_count)) {
+        return size;
+    }
+
+    /*
+     * Failure; for the first granule, it's at @ptr. Otherwise
+     * it's at the first byte of the nth granule. Calculate how
+     * many bytes we can access without hitting that failure.
+     */
+    if (n == 0) {
+        return 0;
+    } else {
+        return n * TAG_GRANULE - (ptr - tag_first);
+    }
+}
-- 
2.34.1



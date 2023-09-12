Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54D79D32B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg414-0008UR-PR; Tue, 12 Sep 2023 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40q-0008GT-SA
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40k-0003rR-Tv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fa666000dso2247695f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527487; x=1695132287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S+8+Et63yYSKmNFzWkggTY5fobUvz34RO94xWiLCiyk=;
 b=NM/3t5nL2XKJtBmQauRoHQS61eewxLBSP4wq3ctcEIkfjvQe07JLVXLcikcnWyCZ9Q
 kcP1psmMF7RInuC+uLDRKbJDb9LfyQJFzUq8Yogrgs1LubXv/AMze1CTef8WjoPnt4bN
 6o8j+ymuxt6rqSrS1JPW8ydyzyzpHL3Nn1kmw6pC7Qc+3lz/DKrElfDt4sjcMIQQlg38
 QCep4df76kTbx17JmKrVDmZp+P28KQDU0IUx2qwspYsXd66VwMOEQQdiCyWcCk949hPu
 wjyFpZ0WV5J+3mWZjWGEyz555S8XYrDo99iZ0cA/ZKWRXbbXrN5LDZ1Z5eCVPjEgJnAT
 yBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527487; x=1695132287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+8+Et63yYSKmNFzWkggTY5fobUvz34RO94xWiLCiyk=;
 b=YqsrOtnHWCA2pcW4yHDCD7adBxaenU4un9fEfBqrQu7NsWxtnS0gwS0accBoGwfCC9
 JZzeWn5Mjet0UDBeoLRdghLVM/1LmOsDmU3BF2S81F1m4vRHL1YyW40/D0zoKpCOs3Qe
 oQbdb/YRQaL9hI7O3DTaYXyLb3vUKS6aPHpxWCbZuuSwfsDg0mdrcd3Icr5cDc2lnLdH
 2ItM/Ja5pyoRBz1+TMB0xqmNd8lc2sfIYQyOuYZsplVCcU7QiqF6hHDOCTr1FRc3mzUM
 spAK+T8RYgQYx6DAuRolfbNaAcE3AG/rFEevtxZyDXGlRRbh6rwHOMe2TSsyZ2fntUQw
 EpHA==
X-Gm-Message-State: AOJu0YxiK1KmnUxImBmndze+hec2xsjcVIVFaPfAvlWxyXEmljOzwe+O
 LeP6yFfkG/ORnhM0L991k//D7g==
X-Google-Smtp-Source: AGHT+IHMNjXd8bS6Ey2BfybsCpbITKckJYnwvuq+9YcZiz6vyzB3oAM4ezrQXAqtylokaF3fwhXdkQ==
X-Received: by 2002:adf:e50b:0:b0:317:5b32:b2c3 with SMTP id
 j11-20020adfe50b000000b003175b32b2c3mr9613927wrm.6.1694527486196; 
 Tue, 12 Sep 2023 07:04:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] target/arm: Implement MTE tag-checking functions for
 FEAT_MOPS copies
Date: Tue, 12 Sep 2023 15:04:32 +0100
Message-Id: <20230912140434.1333369-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The FEAT_MOPS memory copy operations need an extra helper routine
for checking for MTE tag checking failures beyond the ones we
already added for memory set operations:
 * mte_mops_probe_rev() does the same job as mte_mops_probe(), but
   it checks tags starting at the provided address and working
   backwards, rather than forwards

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      | 17 +++++++
 target/arm/tcg/mte_helper.c | 99 +++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 642f77df29b..1dd9182a54a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1288,6 +1288,23 @@ uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
 uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
                         uint32_t desc);
 
+/**
+ * mte_mops_probe_rev: Check where the next MTE failure is for a FEAT_MOPS
+ *                     operation going in the reverse direction
+ * @env: CPU env
+ * @ptr: *end* address of memory region (dirty pointer)
+ * @size: length of region (guaranteed not to cross a page boundary)
+ * @desc: MTEDESC descriptor word (0 means no MTE checks)
+ * Returns: the size of the region that can be copied without hitting
+ *          an MTE tag failure
+ *
+ * Note that we assume that the caller has already checked the TBI
+ * and TCMA bits with mte_checks_needed() and an MTE check is definitely
+ * required.
+ */
+uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
+                            uint32_t desc);
+
 /**
  * mte_check_fail: Record an MTE tag check failure
  * @env: CPU env
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 66a80eeb950..2dd7eb3edbf 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -734,6 +734,55 @@ static int checkN(uint8_t *mem, int odd, int cmp, int count)
     return n;
 }
 
+/**
+ * checkNrev:
+ * @tag: tag memory to test
+ * @odd: true to begin testing at tags at odd nibble
+ * @cmp: the tag to compare against
+ * @count: number of tags to test
+ *
+ * Return the number of successful tests.
+ * Thus a return value < @count indicates a failure.
+ *
+ * This is like checkN, but it runs backwards, checking the
+ * tags starting with @tag and then the tags preceding it.
+ * This is needed by the backwards-memory-copying operations.
+ */
+static int checkNrev(uint8_t *mem, int odd, int cmp, int count)
+{
+    int n = 0, diff;
+
+    /* Replicate the test tag and compare.  */
+    cmp *= 0x11;
+    diff = *mem-- ^ cmp;
+
+    if (!odd) {
+        goto start_even;
+    }
+
+    while (1) {
+        /* Test odd tag. */
+        if (unlikely((diff) & 0xf0)) {
+            break;
+        }
+        if (++n == count) {
+            break;
+        }
+
+    start_even:
+        /* Test even tag. */
+        if (unlikely((diff) & 0x0f)) {
+            break;
+        }
+        if (++n == count) {
+            break;
+        }
+
+        diff = *mem-- ^ cmp;
+    }
+    return n;
+}
+
 /**
  * mte_probe_int() - helper for mte_probe and mte_check
  * @env: CPU environment
@@ -1042,6 +1091,56 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
     }
 }
 
+uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
+                            uint32_t desc)
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
+     * TODO: checkNrev() is not designed for checks of the size we expect
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
+    tag_first = QEMU_ALIGN_DOWN(ptr - (size - 1), TAG_GRANULE);
+    tag_last = QEMU_ALIGN_DOWN(ptr, TAG_GRANULE);
+    tag_count = ((tag_last - tag_first) / TAG_GRANULE) + 1;
+    n = checkNrev(mem, ptr & TAG_GRANULE, ptr_tag, tag_count);
+    if (likely(n == tag_count)) {
+        return size;
+    }
+
+    /*
+     * Failure; for the first granule, it's at @ptr. Otherwise
+     * it's at the last byte of the nth granule. Calculate how
+     * many bytes we can access without hitting that failure.
+     */
+    if (n == 0) {
+        return 0;
+    } else {
+        return (n - 1) * TAG_GRANULE + ((ptr + 1) - tag_last);
+    }
+}
+
 void mte_mops_set_tags(CPUARMState *env, uint64_t ptr, uint64_t size,
                        uint32_t desc)
 {
-- 
2.34.1



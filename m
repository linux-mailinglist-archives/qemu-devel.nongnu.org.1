Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B04207A9856
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcX-00027L-GW; Thu, 21 Sep 2023 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcQ-00023p-Md
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcL-0007gn-BG
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-404fbfac998so14384895e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317852; x=1695922652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=upH12SmRbnaLss30rJEzko05r7OrsC+sJ2ABHXeFrBE=;
 b=REXJL6AqyArYFFdYoD07TmAnQFwYw2U3YaleDV8iL0HPwOstT/bdfrpIX2LNQbWILO
 KIJb+UrkWtKIKsP5jyl2BlL4lOz9XwU9/jUxrqazj3CZuk3x+zFYKf2o7VYqOlZN4LS2
 SimVb5keXjNYcRP1oXrV72sThd5grfI2+VPN9LYQR2wow2SiXAEKNiQYjFENEUa17b8Z
 UqEwaiU0N+HH1QC3P/N3NUrhKE/2KMwmjvEnNhp423n5BcWxv2IPHBbOr+JJTo+iOMPv
 xjrX7HUedORhU4LaobSELNnpA8F1XWtB/eFoBoqRj6opdQ4SR/pZSQl9x2TI3YkRzarr
 1OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317852; x=1695922652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upH12SmRbnaLss30rJEzko05r7OrsC+sJ2ABHXeFrBE=;
 b=rcIW7oE9MqJVM5ix0Zu4URDLby0gwFvbIqmkd0VdPmw8uUXuz4f1v2ACieuDrktNbo
 S5zaFIBUI9/WmmI2LH6It+cQZn0Gk58ta+DbKSL1HfA995pXRiWU8WLGZ6ucxIDiBG8x
 Sl+GB9uUYDqRXi4pD9cKWmt/OXSj9BYkhgYYq6Zp73vCELjdP5yWU+qao6fATL2KCjn5
 uZ6KZ7/X129+nFtB/deAzs9RKqANo9etR67msHTGNMQyBEeoJLL3oX18djm+1qpBCVNw
 mJkna5B+jXwMdZwfdkA7MdKQpnnfIu7QpqMg4lQ3jyvDZgmiX38A6mKUU2oMZOyp5hEh
 ixmQ==
X-Gm-Message-State: AOJu0YxmtReCEEORLLalht7k7IcgOnB5+wqjVGyjKEM10BwZlblvLTyt
 SnoYQtoMtUanBCnGNWIdEJgtSAXZyfbQvxPU+R0=
X-Google-Smtp-Source: AGHT+IHxwuZ4TsnGok6GHyZi4cSLbHEp7r1jgTMPwCJgAUPGET01hWvmb8kvZAlLT/wVEhA4gF0m2g==
X-Received: by 2002:a05:600c:378c:b0:3fb:a102:6d7a with SMTP id
 o12-20020a05600c378c00b003fba1026d7amr5164527wmr.28.1695317851923; 
 Thu, 21 Sep 2023 10:37:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/30] target/arm: Implement MTE tag-checking functions for
 FEAT_MOPS copies
Date: Thu, 21 Sep 2023 18:37:10 +0100
Message-Id: <20230921173720.3250581-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Message-id: 20230912140434.1333369-11-peter.maydell@linaro.org
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



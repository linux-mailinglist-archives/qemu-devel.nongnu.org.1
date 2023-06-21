Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B9738399
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo7-0006l4-MO; Wed, 21 Jun 2023 08:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnm-0006am-OK
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:10 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnk-0000GT-GX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:10 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f8777caaa1so3543010e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349946; x=1689941946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVkh9ElQYXuU3m7U9rfp/idF7Etsc4zRDhZIcGQ6L9k=;
 b=Qc5NLrDSwlYFEPq4zNu0+JIY6fc7XE4P2WAMz0NRGPVLKeG6z+C6p7eKjwMmAJox/3
 EzCkAvVSLH3j8JhwYoMoY+f5HrIaRooqyIX97/jnd0HdSGEkasDRCa08EQjm3S6HxaHq
 fzdjxRyujskX0DpoxWXrNerc9svB0s1f/e7OgbEPijnaAxlc8yoaqmj6NRfi/kx3fEgP
 QtpvmSx0gd8m0oJZDuv6HbqaadceXDmti0q4p/brJ/y3FhNO7ZQ2IrwLvsLYWflbIYn9
 k3F2qOsisy5ayrglw57ksAbY6a9Bo6R/wNUYrON6ZH4YowRz8sXYZD2x0WmsXwhjemZc
 degQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349946; x=1689941946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVkh9ElQYXuU3m7U9rfp/idF7Etsc4zRDhZIcGQ6L9k=;
 b=gezZy/93wE3RiU1R1u/jwAoc7UAjEPQ0ac8L71MCrZ3H1xHPl9jSO5PUjm4ZmVFOv8
 xjX/ZZV6JbGAiqCf+pTtcbl7n39CakQtbRJF9Y0/3K4QnM2eePmrAgaZ4912DUZEXHd0
 7ZUizKyBjEqJ4TeK/9OsOqNK0txajS/y46tQF8rKW00/g9N3XiwBhMzsaUao5yGcUThs
 vw+n9FZoqsLpW9CQ73x2SEymYTL6m42qmFoON0tL1p6n9QOCWVJzvDnzD0Fc6KYK2njk
 ubGxmof62beaWN8vvHoCWaqtpz4VBf9u6XoL7p0mZLLUuFxhXkkEfKfK5Xi7DZ9NcrZP
 G7XA==
X-Gm-Message-State: AC+VfDyeE4RHDvpqGgCuqplAPpxWYzvqxN1VxYODKgsP19zl9wILak8g
 o6kxCNQ05qrYlakD+GX4J88pYGy0tsX2aLCh5dPVbGaW
X-Google-Smtp-Source: ACHHUZ6z4T8uieM9PftboOfd+HmuWPYvjh96G4Yi0IFDgthcPg2xoh4UvMDpLaRnId5hvw44wmX87A==
X-Received: by 2002:a05:6512:32a8:b0:4f8:673c:3f26 with SMTP id
 q8-20020a05651232a800b004f8673c3f26mr6233750lfe.68.1687349946572; 
 Wed, 21 Jun 2023 05:19:06 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 2/9] accel/tcg: Move TLB_WATCHPOINT to TLB_SLOW_FLAGS_MASK
Date: Wed, 21 Jun 2023 14:18:55 +0200
Message-Id: <20230621121902.1392277-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

This frees up one bit of the primary tlb flags without
impacting the TLB_NOTDIRTY logic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  8 ++++----
 accel/tcg/cputlb.c     | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4422f4bb07..b5618613cc 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -325,8 +325,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
 #define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
 /* Set if TLB entry writes ignored.  */
@@ -338,7 +336,7 @@ CPUArchState *cpu_copy(CPUArchState *env);
  */
 #define TLB_FLAGS_MASK \
     (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_WATCHPOINT | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
 
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
@@ -346,8 +344,10 @@ CPUArchState *cpu_copy(CPUArchState *env);
  */
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP            (1 << 0)
+/* Set if TLB entry contains a watchpoint.  */
+#define TLB_WATCHPOINT       (1 << 1)
 
-#define TLB_SLOW_FLAGS_MASK  TLB_BSWAP
+#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b40ce5ea0f..152c4e9994 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1984,7 +1984,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
          */
         goto stop_the_world;
     }
-    /* Collect TLB_WATCHPOINT for read. */
+    /* Collect tlb flags for read. */
     tlb_addr |= tlbe->addr_read;
 
     /* Notice an IO access or a needs-MMU-lookup access */
@@ -2001,9 +2001,19 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         notdirty_write(env_cpu(env), addr, size, full, retaddr);
     }
 
-    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-        cpu_check_watchpoint(env_cpu(env), addr, size, full->attrs,
-                             BP_MEM_READ | BP_MEM_WRITE, retaddr);
+    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
+        int wp_flags = 0;
+
+        if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
+            wp_flags |= BP_MEM_WRITE;
+        }
+        if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
+            wp_flags |= BP_MEM_READ;
+        }
+        if (wp_flags) {
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 full->attrs, wp_flags, retaddr);
+        }
     }
 
     return hostaddr;
-- 
2.34.1



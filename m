Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D5A97606
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 21:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQf-0000S1-TJ; Tue, 22 Apr 2025 15:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOy-0005AO-LU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOw-000744-5C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so69454475ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350525; x=1745955325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+jTPRxzefHutS8rakDU7HuiolaxKbTM9MImwBgIvjk=;
 b=qjxfzInsVCRSEyrhhf0fZx+hXJg4VP6RVkVJbQ6+DtEziTQNwCpatSEdZfNmtu1+cy
 6rY0Fz3UxA1BsE42ddzkj6iqx9WRA4de3i2ZI1O9PQ4UgakD8vEbYiyMNLNkF5Qvmq5C
 WItH1pfWXvC0c3yJrX35lChBPVMfllcys590TpEDASSRtFyYpzmemawpA5S8VYGKCLRl
 v4p3x4j7Z9LLIPK3yMRmo7N55rejfN5pHiybYjExaMwJx0ctJ/5ERCvljSJriUf/NJgk
 bnyKi/ajxo89FO9rLXchEgVLWzTWOuCfv9eLL2VNK4FY+7m6hKZk1m+0GFKQJM/6gwBT
 Z0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350525; x=1745955325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+jTPRxzefHutS8rakDU7HuiolaxKbTM9MImwBgIvjk=;
 b=H/4rdhXMlt6b0ux1jrXq2E+TcRSs3tzjk7GUNF9JT8nCbMbnWlqYpR3n7hbnhOqUXl
 pBoICZv1+zPh3NilbHsxe8vW4r7peJ+hRpY1XmVL4cYj3aWh0kACHLHpS607UjQPetU0
 odnSXXydnsvs6tJaUYN0R9CDpEorlJn7B3faWJ5G04cQsDdbFBR+555Y0hasgg3IV4m5
 JrSQfDzs+2aT6yr0u2Wa3YeTgEhQr2JZ5s7lOVmR/FfoyBKPy1QfJJ+sDbj2Qi/smHBx
 QHfzvbMzc8FSQWzLKG3q79e3dRZ0h8DuMI4t05P4egakwQnIx87W3J+3arQLiaLdOcwG
 cX3Q==
X-Gm-Message-State: AOJu0YxuJNO/8awk1dPnf+jhxFv5Jjvk4WrXhPJzIDqGniGEMj/lfqhU
 jaeCiy6OBilSCSrsI0YhuRVsdI0rprf9JUrMBe2M4ptkyIZWU6BtCl0eaV1YBUPW+P4YxbFj3VL
 a
X-Gm-Gg: ASbGnctweIHgNJufIqG3axqqgH4h29U4u8f1s/+5IJI1R/PlHQJsQoRgZKLM9UBebv1
 o9hAsxKOtAItRJTxE2NUnuKslJWeDMK4HXfefXYBPZtrpbYfHn7OoKsljHwv4+Pzi6snb2J2eW8
 qNEUb5GcswlRMr7NZ/XBnlpSn2MPNim00ichkx/A0XXicPl5Hhk7XWoJfHkh5lZHxAt/tDmiJVy
 wkiTrmoWWBQSiJH05JT1u1TTWOUwK4yGPsjWXMGFUPJvHD5vg82IB02SgZf/r0Vr26JSQgMpE4x
 F/6uZcS4A6KkPhib646dLAmwzTpAtaeOBq6W9c/dBMYdIoEME8RvvPtmLFhmKeOGqobbDTwxkjk
 =
X-Google-Smtp-Source: AGHT+IHNQAIqC/9clq17SVx904+csE/jL0cA+lGCrwDPaPh4vKO1sgGSBAK9cpmroGLrDMmtKzuv9g==
X-Received: by 2002:a17:902:cf0d:b0:21f:2a2:3c8b with SMTP id
 d9443c01a7336-22c5337ce31mr257595055ad.11.1745350524788; 
 Tue, 22 Apr 2025 12:35:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 098/147] include/exec: Redefine tlb-flags with absolute values
Date: Tue, 22 Apr 2025 12:27:27 -0700
Message-ID: <20250422192819.302784-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Don't base the values on TARGET_PAGE_BITS_MIN, but do verify
that TLB_FLAGS_MASK does not overlap minimum page size.
All targets now have the same placement for these flags,
simplifying mmu management when we enable heterogenus systems.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 68 +++++++++++++++++++---------------------
 accel/tcg/cputlb.c       |  2 ++
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 54a6bae768..357e79095c 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -19,54 +19,29 @@
 #ifndef TLB_FLAGS_H
 #define TLB_FLAGS_H
 
-#include "exec/cpu-defs.h"
+/*
+ * Flags returned for lookup of a TLB virtual address.
+ */
 
 #ifdef CONFIG_USER_ONLY
 
 /*
- * Allow some level of source compatibility with softmmu.  We do not
- * support any of the more exotic features, so only invalid pages may
- * be signaled by probe_access_flags().
+ * Allow some level of source compatibility with softmmu.
+ * Invalid is set when the page does not have requested permissions.
+ * MMIO is set when we want the target helper to use the functional
+ * interface for load/store so that plugins see the access.
  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
-#define TLB_WATCHPOINT      0
+#define TLB_INVALID_MASK     (1 << 0)
+#define TLB_MMIO             (1 << 1)
+#define TLB_WATCHPOINT       0
 
 #else
 
-/*
- * Flags stored in the low bits of the TLB virtual address.
- * These are defined so that fast path ram access is all zeros.
- * The flags all must be between TARGET_PAGE_BITS and
- * maximum address alignment bit.
- *
- * Use TARGET_PAGE_BITS_MIN so that these bits are constant
- * when TARGET_PAGE_BITS_VARY is in effect.
- *
- * The count, if not the placement of these bits is known
- * to tcg/tcg-op-ldst.c, check_max_alignment().
- */
-/* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
-/*
- * Set if TLB entry references a clean RAM page.  The iotlb entry will
- * contain the page physical address.
- */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
-
-/*
- * Use this mask to check interception with an alignment mask
- * in a TCG backend.
- */
-#define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
-
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
  * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
  */
+
 /* Set if TLB entry requires byte swap.  */
 #define TLB_BSWAP            (1 << 0)
 /* Set if TLB entry contains a watchpoint.  */
@@ -82,6 +57,27 @@
     (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
      TLB_DISCARD_WRITE | TLB_MMIO)
 
+/*
+ * Flags stored in CPUTLBEntry.addr_idx[x].
+ * These must be above the largest alignment (64 bytes),
+ * and below the smallest page size (1024 bytes).
+ * This leaves bits [9:6] available for use.
+ */
+
+/* Zero if TLB entry is valid.  */
+#define TLB_INVALID_MASK     (1 << 6)
+/* Set if TLB entry references a clean RAM page.  */
+#define TLB_NOTDIRTY         (1 << 7)
+/* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
+#define TLB_FORCE_SLOW       (1 << 8)
+
+/*
+ * Use this mask to check interception with an alignment mask
+ * in a TCG backend.
+ */
+#define TLB_FLAGS_MASK \
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
+
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a717f357d5..39314e86f3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -49,6 +49,8 @@
 #endif
 #include "tcg/tcg-ldst.h"
 
+QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
+
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
 /* #define DEBUG_TLB_LOG */
-- 
2.43.0



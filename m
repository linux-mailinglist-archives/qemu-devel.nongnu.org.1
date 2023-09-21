Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61617A9861
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcc-0002AX-8Z; Thu, 21 Sep 2023 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcZ-00028x-KI
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcJ-0007g0-AN
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso8330315e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317849; x=1695922649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cApx3eQTNx/NXklzfkHdVWI6Q+C1GtZo1CUTP5Shfvo=;
 b=rxApj94iMdkHB6PKMl/G1hTUcbFMTUvmIz4yxeKnqtEGln5rml/gQNBfOIRlsORsny
 2ngXLr+QrN+tSJNPUnXiwQbGvNlHRoKZIQHtJZEr1PlgXE1TdoCcBp3z0Cyh1xaFYR5v
 hk9c8Ks+VY3+qTwx/+4tNVFyhSbwGHK5JC/G4aRwl1N0I29aTruhEROe3dACCcTJaQUN
 aV25lbr/thi+XIniLUbtrReGbrLli2BMo5X8r5OtkIPalnHzjpGiRSEeWUYAP1ZyUKFJ
 wWfYVSDMvinIB3KFnEjIti/nfYakpXNUo3H/BONucmvtAh4sga+3vNTQr+JaEO+N4Znd
 /Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317849; x=1695922649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cApx3eQTNx/NXklzfkHdVWI6Q+C1GtZo1CUTP5Shfvo=;
 b=ifoWW85i278vh0C78WHWxzmG9B4+v7Z5tE+a1w2PUbr00q954J6OieUy1Yw+7q2zei
 Fz7q3fPJ/tsZxXDE+FlV788EQOd2Q/11X9Ig36ZgSGcLDS6Ja4kRMIpbwP4GybMnDs4c
 /W+LUu1VlEiLOgs393Q2VsoDA1chjdNNdrgFl2hrtQ6qWXwzVZ8Om7qJDNx7/doxY0+U
 CK/mazunZExLxmLxIQm9WBECOdPAX7s5xBJ8XPDGSHYSGkSvhxr6Bd+yZfk1DkttXPd+
 t6uZMTRC5Y7NU6RXT7DJWa7uHpMaEXxv6TomP+BBc4737Qj0BPQwv5J1ADlC2QfTC8pS
 CPtQ==
X-Gm-Message-State: AOJu0Yzlz7st9IBZdubkKRvBFC2tTC7Czu4nTRhdZyGtNJvzDqf1Lq0y
 EWJz4P/JRAwG9bAnnVSPJAxiMiV4uAS1OCJpdS4=
X-Google-Smtp-Source: AGHT+IFdqhtSZeOcyl0FLK9q9S1BtNrP3IsPLKbH7+CANgs8C9N8BwjRCSexWhriyRYCN9haxSHQgw==
X-Received: by 2002:a7b:c850:0:b0:402:ea8c:ea57 with SMTP id
 c16-20020a7bc850000000b00402ea8cea57mr249083wml.7.1695317849606; 
 Thu, 21 Sep 2023 10:37:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/30] target/arm: New function allocation_tag_mem_probe()
Date: Thu, 21 Sep 2023 18:37:05 +0100
Message-Id: <20230921173720.3250581-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For the FEAT_MOPS operations, the existing allocation_tag_mem()
function almost does what we want, but it will take a watchpoint
exception even for an ra == 0 probe request, and it requires that the
caller guarantee that the memory is accessible.  For FEAT_MOPS we
want a function that will not take any kind of exception, and will
return NULL for the not-accessible case.

Rename allocation_tag_mem() to allocation_tag_mem_probe() and add an
extra 'probe' argument that lets us distinguish these cases;
allocation_tag_mem() is now a wrapper that always passes 'false'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230912140434.1333369-6-peter.maydell@linaro.org
---
 target/arm/tcg/mte_helper.c | 48 ++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index e2494f73cf3..303bcc7fd84 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -50,13 +50,14 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
 }
 
 /**
- * allocation_tag_mem:
+ * allocation_tag_mem_probe:
  * @env: the cpu environment
  * @ptr_mmu_idx: the addressing regime to use for the virtual address
  * @ptr: the virtual address for which to look up tag memory
  * @ptr_access: the access to use for the virtual address
  * @ptr_size: the number of bytes in the normal memory access
  * @tag_access: the access to use for the tag memory
+ * @probe: true to merely probe, never taking an exception
  * @ra: the return address for exception handling
  *
  * Our tag memory is formatted as a sequence of little-endian nibbles.
@@ -65,15 +66,25 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
  * for the higher addr.
  *
  * Here, resolve the physical address from the virtual address, and return
- * a pointer to the corresponding tag byte.  Exit with exception if the
- * virtual address is not accessible for @ptr_access.
+ * a pointer to the corresponding tag byte.
  *
  * If there is no tag storage corresponding to @ptr, return NULL.
+ *
+ * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
+ * three options:
+ * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
+ *     accessible, and do not take watchpoint traps. The calling code must
+ *     handle those cases in the right priority compared to MTE traps.
+ * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
+ *     that the page is going to be accessible. We will take watchpoint traps.
+ * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
+ *     traps and watchpoint traps.
+ * (probe = true, ra != 0 is invalid and will assert.)
  */
-static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
-                                   uint64_t ptr, MMUAccessType ptr_access,
-                                   int ptr_size, MMUAccessType tag_access,
-                                   uintptr_t ra)
+static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                         uint64_t ptr, MMUAccessType ptr_access,
+                                         int ptr_size, MMUAccessType tag_access,
+                                         bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     uint64_t clean_ptr = useronly_clean_ptr(ptr);
@@ -81,6 +92,8 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
     uint8_t *tags;
     uintptr_t index;
 
+    assert(!(probe && ra));
+
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
@@ -111,12 +124,16 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
      * exception for inaccessible pages, and resolves the virtual address
      * into the softmmu tlb.
      *
-     * When RA == 0, this is for mte_probe.  The page is expected to be
-     * valid.  Indicate to probe_access_flags no-fault, then assert that
-     * we received a valid page.
+     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
+     * Indicate to probe_access_flags no-fault, then either return NULL
+     * for the pure probe, or assert that we received a valid page for the
+     * no-fault-expected probe.
      */
     flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
                               ra == 0, &host, &full, ra);
+    if (probe && (flags & TLB_INVALID_MASK)) {
+        return NULL;
+    }
     assert(!(flags & TLB_INVALID_MASK));
 
     /* If the virtual page MemAttr != Tagged, access unchecked. */
@@ -157,7 +174,7 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
     }
 
     /* Any debug exception has priority over a tag check exception. */
-    if (unlikely(flags & TLB_WATCHPOINT)) {
+    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
         int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
         assert(ra != 0);
         cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
@@ -199,6 +216,15 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
 #endif
 }
 
+static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
+                                   uint64_t ptr, MMUAccessType ptr_access,
+                                   int ptr_size, MMUAccessType tag_access,
+                                   uintptr_t ra)
+{
+    return allocation_tag_mem_probe(env, ptr_mmu_idx, ptr, ptr_access,
+                                    ptr_size, tag_access, false, ra);
+}
+
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 {
     uint16_t exclude = extract32(rm | env->cp15.gcr_el1, 0, 16);
-- 
2.34.1



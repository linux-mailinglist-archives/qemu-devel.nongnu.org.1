Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFD79D32D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg418-00008n-8B; Tue, 12 Sep 2023 10:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40l-0008Cs-UX
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40d-0003qD-8k
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313e742a787so3586496f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527480; x=1695132280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1EL7OiWD9A0VKuolOshZyjZ0Z6pN9Kqa/FPwzECxhk=;
 b=eSYmUH1qm07IE+JQVdD1GLSqHmcBVWc9ikwtZXrKqF1WfAZcgNYp7vXb6QwlCZV/uI
 3/zWahF/QirsdCuXt+F9BUfvyRlxHdHxI5kbB2YACkmYM6F4lCesBI+nZOfYcumJ5nUj
 b35WNUXIlBlhJ+mvuy+uqCIb6i4TGCD2ZtICn/GE6l4ruVHYXL8aUJ/qPUGa/x2ZHURp
 XglHwwa2/nnXt1Mu02FmPsD0orqpFqSULUxlETCIYtqF93tv7J9DgaXHkieUfXpsGec7
 SS2pKIyjuhtnjRpotwKirhsLhPRqX0IWmJ4JtyuCrlTVWbPOe3EYPTrrMx9ddJwLJHBB
 Eb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527480; x=1695132280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1EL7OiWD9A0VKuolOshZyjZ0Z6pN9Kqa/FPwzECxhk=;
 b=UKaUIWnuA4qvHg1BgURcxtMdl5mLyfPF8Y4bjVB/fcs9lcR9MXNjP5Ad6uWVWS1VnS
 UvLRUWyzBZh2XblYsYZmFgA9bbUFYng+Bw1nqbA1fzEytJ6PwyywsldNM4kCV6AMuXMt
 3DpTo/jnOvBJEZDV1GJINuecLcFJki/ToCKeD02jSTVQf8dryMwfCLjs2wrNC+O7Wb0c
 V+UMMGC8PQVZEC1HEJCeBEZQSm0PR9Bx7oZpcV36QfWA+meUeMe359xiKQsUZIvvY4/w
 IwPAFHvIdt4d58yp43BUIWkbUC5/SRm4YEXBS9SsisOvj4SK8zH+8rdxzozXaAi90uN0
 QHOA==
X-Gm-Message-State: AOJu0YxRS2zOKSJPXDlJtFYOWxKEoPR6K9gCXcsWJhDr2KJdq+qyaeIL
 lWs8tnNprijtnS1gB6CDV/hPQw==
X-Google-Smtp-Source: AGHT+IHebKWNiycVJy/JvW++Srh6TmF0Ykuz+YbWlTbN/nhoRycYvsc4n3FUXIFRyWj8iAhE6dpNWg==
X-Received: by 2002:a5d:440f:0:b0:314:c6b:b9a2 with SMTP id
 z15-20020a5d440f000000b003140c6bb9a2mr2019596wrq.13.1694527480383; 
 Tue, 12 Sep 2023 07:04:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] target/arm: New function allocation_tag_mem_probe()
Date: Tue, 12 Sep 2023 15:04:27 +0100
Message-Id: <20230912140434.1333369-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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



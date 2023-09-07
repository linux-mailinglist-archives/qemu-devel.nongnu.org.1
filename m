Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8BF797657
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU0-0000qF-OJ; Thu, 07 Sep 2023 12:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTx-0000n6-Es
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTs-0001zP-Kr
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso12776465e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102623; x=1694707423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8m5icjeF5vZve4z3WoLSuIqNh+siNBItyQ3fYuboyLo=;
 b=uPhTbWF+AI3wprjC+Qoql5/fkU0x2NByp/xw1JzzmTB8mcafgxNU3N/8ouJaQXTI3N
 5kvzDOc+V6ryS+fGpHaoj6041fTfRP8Cbl6+XnImuhGkEOc/ZPG2vKkhvq8UhMcgjnlq
 yI6FahRdCUIQXXpDrR1cMExyfoBFSHgAtGphlGk41buNZcHfNejhqz1gD5WftEA0Sgee
 RMBegd92CCwhELMsPiaJw51QrVE8i9aU+wu9DfPDXtTJFAKnQq5dibJk17zj6uQ5UPg/
 /qQXd/60WbdDW7jowr5K0Tskg88GYr/YsISf8Mmu3ryKZFFTZv4Cge5soNKP2S8tGzAN
 hYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102623; x=1694707423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8m5icjeF5vZve4z3WoLSuIqNh+siNBItyQ3fYuboyLo=;
 b=Ttg3gKcPgnQus539o9cfWI+VVV2d/zVsmbhRaSd2fODuS72Riidaf5AMVK0jJq1HDu
 CIX4uhGvrf6rjTsyHwmrFFyeNZwPO+32niJblODqfMHwt3snd2mJn8p8nb8BzXeEzhM3
 Miea+dBJvS6k9PNwr6qdoA5sGuHIU2twVziVqGPexl1sjKjoNA/R1S2n1iCvyA419QuG
 fdydlTwXEvc+wXX5AEkaO9IsRft0RPoqR4fo5QsEcKexPWoSrp1LWHh3jQrANtcbamsd
 bELhuetp3F6qbacPnyuKnrF+/ta8KBK6g4oaz0PzPHDUyNW6PXh6SRzgfEgAxie/28vm
 n7Lg==
X-Gm-Message-State: AOJu0YxWAWj4i7bMzi5s2kFYvqiEuOvq+jw8XUwwlf42ijmB7kcKxw4u
 Lc+Yr2FMbdCg2Zaez9ag9MNFkA==
X-Google-Smtp-Source: AGHT+IFwzfqHii+Id8KFWm+XKEp2ByElcbvsb8OOmbTw7VvO8OaoLE8swu4WsbaXHlexC073loid8w==
X-Received: by 2002:a5d:6208:0:b0:31c:6591:d41e with SMTP id
 y8-20020a5d6208000000b0031c6591d41emr5119382wru.37.1694102623052; 
 Thu, 07 Sep 2023 09:03:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/14] target/arm: Remove unused allocation_tag_mem() argument
Date: Thu,  7 Sep 2023 17:03:27 +0100
Message-Id: <20230907160340.260094-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The allocation_tag_mem() function takes an argument tag_size,
but it never uses it. Remove the argument. In mte_probe_int()
in particular this also lets us delete the code computing
the value we were passing in.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 42 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index b23d11563ab..e2494f73cf3 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -57,7 +57,6 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
  * @ptr_access: the access to use for the virtual address
  * @ptr_size: the number of bytes in the normal memory access
  * @tag_access: the access to use for the tag memory
- * @tag_size: the number of bytes in the tag memory access
  * @ra: the return address for exception handling
  *
  * Our tag memory is formatted as a sequence of little-endian nibbles.
@@ -69,15 +68,12 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
  * a pointer to the corresponding tag byte.  Exit with exception if the
  * virtual address is not accessible for @ptr_access.
  *
- * The @ptr_size and @tag_size values may not have an obvious relation
- * due to the alignment of @ptr, and the number of tag checks required.
- *
  * If there is no tag storage corresponding to @ptr, return NULL.
  */
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
-                                   int tag_size, uintptr_t ra)
+                                   uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     uint64_t clean_ptr = useronly_clean_ptr(ptr);
@@ -275,7 +271,7 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 
     /* Trap if accessing an invalid page.  */
     mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD, 1,
-                             MMU_DATA_LOAD, 1, GETPC());
+                             MMU_DATA_LOAD, GETPC());
 
     /* Load if page supports tags. */
     if (mem) {
@@ -329,7 +325,7 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
 
     /* Trap if accessing an invalid page.  */
     mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, TAG_GRANULE,
-                             MMU_DATA_STORE, 1, ra);
+                             MMU_DATA_STORE, ra);
 
     /* Store if page supports tags. */
     if (mem) {
@@ -372,10 +368,10 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
     if (ptr & TAG_GRANULE) {
         /* Two stores unaligned mod TAG_GRANULE*2 -- modify two bytes. */
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
-                                  TAG_GRANULE, MMU_DATA_STORE, 1, ra);
+                                  TAG_GRANULE, MMU_DATA_STORE, ra);
         mem2 = allocation_tag_mem(env, mmu_idx, ptr + TAG_GRANULE,
                                   MMU_DATA_STORE, TAG_GRANULE,
-                                  MMU_DATA_STORE, 1, ra);
+                                  MMU_DATA_STORE, ra);
 
         /* Store if page(s) support tags. */
         if (mem1) {
@@ -387,7 +383,7 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
     } else {
         /* Two stores aligned mod TAG_GRANULE*2 -- modify one byte. */
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
-                                  2 * TAG_GRANULE, MMU_DATA_STORE, 1, ra);
+                                  2 * TAG_GRANULE, MMU_DATA_STORE, ra);
         if (mem1) {
             tag |= tag << 4;
             qatomic_set(mem1, tag);
@@ -435,8 +431,7 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD,
-                                 gm_bs_bytes, MMU_DATA_LOAD,
-                                 gm_bs_bytes / (2 * TAG_GRANULE), ra);
+                                 gm_bs_bytes, MMU_DATA_LOAD, ra);
 
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
@@ -495,8 +490,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
 
     /* Trap if accessing an invalid page.  */
     tag_mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
-                                 gm_bs_bytes, MMU_DATA_LOAD,
-                                 gm_bs_bytes / (2 * TAG_GRANULE), ra);
+                                 gm_bs_bytes, MMU_DATA_LOAD, ra);
 
     /*
      * Tag store only happens if the page support tags,
@@ -552,7 +546,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
     ptr &= -dcz_bytes;
 
     mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, dcz_bytes,
-                             MMU_DATA_STORE, tag_bytes, ra);
+                             MMU_DATA_STORE, ra);
     if (mem) {
         int tag_pair = (val & 0xf) * 0x11;
         memset(mem, tag_pair, tag_bytes);
@@ -732,8 +726,7 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     int mmu_idx, ptr_tag, bit55;
     uint64_t ptr_last, prev_page, next_page;
     uint64_t tag_first, tag_last;
-    uint64_t tag_byte_first, tag_byte_last;
-    uint32_t sizem1, tag_count, tag_size, n, c;
+    uint32_t sizem1, tag_count, n, c;
     uint8_t *mem1, *mem2;
     MMUAccessType type;
 
@@ -763,19 +756,14 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     tag_last = QEMU_ALIGN_DOWN(ptr_last, TAG_GRANULE);
     tag_count = ((tag_last - tag_first) / TAG_GRANULE) + 1;
 
-    /* Round the bounds to twice the tag granule, and compute the bytes. */
-    tag_byte_first = QEMU_ALIGN_DOWN(ptr, 2 * TAG_GRANULE);
-    tag_byte_last = QEMU_ALIGN_DOWN(ptr_last, 2 * TAG_GRANULE);
-
     /* Locate the page boundaries. */
     prev_page = ptr & TARGET_PAGE_MASK;
     next_page = prev_page + TARGET_PAGE_SIZE;
 
     if (likely(tag_last - prev_page < TARGET_PAGE_SIZE)) {
         /* Memory access stays on one page. */
-        tag_size = ((tag_byte_last - tag_byte_first) / (2 * TAG_GRANULE)) + 1;
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, sizem1 + 1,
-                                  MMU_DATA_LOAD, tag_size, ra);
+                                  MMU_DATA_LOAD, ra);
         if (!mem1) {
             return 1;
         }
@@ -783,14 +771,12 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         n = checkN(mem1, ptr & TAG_GRANULE, ptr_tag, tag_count);
     } else {
         /* Memory access crosses to next page. */
-        tag_size = (next_page - tag_byte_first) / (2 * TAG_GRANULE);
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, type, next_page - ptr,
-                                  MMU_DATA_LOAD, tag_size, ra);
+                                  MMU_DATA_LOAD, ra);
 
-        tag_size = ((tag_byte_last - next_page) / (2 * TAG_GRANULE)) + 1;
         mem2 = allocation_tag_mem(env, mmu_idx, next_page, type,
                                   ptr_last - next_page + 1,
-                                  MMU_DATA_LOAD, tag_size, ra);
+                                  MMU_DATA_LOAD, ra);
 
         /*
          * Perform all of the comparisons.
@@ -918,7 +904,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     (void) probe_write(env, ptr, 1, mmu_idx, ra);
     mem = allocation_tag_mem(env, mmu_idx, align_ptr, MMU_DATA_STORE,
-                             dcz_bytes, MMU_DATA_LOAD, tag_bytes, ra);
+                             dcz_bytes, MMU_DATA_LOAD, ra);
     if (!mem) {
         goto done;
     }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B4772B34
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EY-0007QR-OH; Mon, 07 Aug 2023 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EQ-00076o-Ke
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EO-0002ig-Bg
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso42278575ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426239; x=1692031039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KKkyXS5jRgs+egnpTlRzEnIYCcJirPHC6HFXR682UI=;
 b=dtwX2AuAhgsFHuE8mkaF6mD16xLgxmQeqyAqMH/P6CGJ6DhMLPwVk0/nlj90OpvtYn
 0krER0vFjks8+h4KKd0b9PE1X/Adtrhc8JTOhWFRTHIGdcq5TfL/No+XAlIczSbiREEO
 IRBxZvfvqFtiv71Sa+AhxLvN3eaBoukzw3f6hE5/w3Wc/12eyFz5rKeW4lLMb2gR040G
 UKe4HMAbAn6yIPFvEd+9NrpqWaSqlUZmSS4xsWGDXFElz+wfiNNbDx4QpqUd2U6vwEM7
 rlbGODJEDP8qC1KltgDxBp/hD1cRX4u1yikbmVkoEvKgZdjDlRDsXcHFX+aI5CoCeJ7b
 rjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426239; x=1692031039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KKkyXS5jRgs+egnpTlRzEnIYCcJirPHC6HFXR682UI=;
 b=i42TLdoX7/n6h9BYgl1ZnjDhfcLvKwLec1CisyFKPOgVZseCVkzNMLLM+cfg3u86d3
 s/I+pww4zq0izku/uCd7m94aDBAPKAoxRWWHq+ElqMMQGgKcX2UNehbsZapxHQ5WkHZ+
 VAzAffbUoN6r/vuz4Z6DWwxQCQjWJLHvERhCO1LXM8BO9KKXBuKY096wBE2YRPd7n61U
 bblds2P0KIu8Aod8di8FIpRJb+ty8uHX69xmUOcjaYS3dxhxEpQpydKXAMm/taFRW/jo
 V3KFE1nanZF/RcLWQJTRA7vIIl82ozrQaUXWkcy5NlkYyFvkmz1aE7eyi2ICKg6AgdK2
 JGCw==
X-Gm-Message-State: AOJu0Yx336DluZ5ZIiqyGQkyGNtrp8/7qbwJ2PM3+m7MWUeej538Zit7
 M/Aq7XvWrUedhfQ7frknKBEm4SzsrJ9azUzkwoQ=
X-Google-Smtp-Source: AGHT+IGJsRt4lQKirJfJ0KXYKftdVvCHvj4C3a3eHQ8gdDQO4OImHKu0qqsS5giVeVDup8ZGchY1VQ==
X-Received: by 2002:a17:902:7604:b0:1b9:cb8b:3bd3 with SMTP id
 k4-20020a170902760400b001b9cb8b3bd3mr10515345pll.31.1691426239003; 
 Mon, 07 Aug 2023 09:37:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 14/14] linux-user: Rewrite non-fixed
 probe_guest_base
Date: Mon,  7 Aug 2023 09:37:05 -0700
Message-Id: <20230807163705.9848-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
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

Use pgb_addr_set to probe for all of the guest addresses,
not just the main executable.  Handle the identity map
specially and separately from the search.

If /proc/self/maps is available, utilize the full power
of the interval tree search, rather than a linear search
through the address list.

If /proc/self/maps is not available, increase the skip
between probes so that we do not probe every single page
of the host address space.  Choose 1 MiB for 32-bit hosts
(max 4k probes) and 1 GiB for 64-bit hosts (possibly a
large number of probes, but the large step makes it more
likely to find empty space quicker).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 311 ++++++++++++++++---------------------------
 1 file changed, 115 insertions(+), 196 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 33c74be3af..ffea900308 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2686,220 +2686,143 @@ static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
 }
 
 /**
- * pgd_find_hole_fallback: potential mmap address
- * @guest_size: size of available space
- * @brk: location of break
- * @align: memory alignment
+ * pgb_find_fallback:
  *
- * This is a fallback method for finding a hole in the host address
- * space if we don't have the benefit of being able to access
- * /proc/self/map. It can potentially take a very long time as we can
- * only dumbly iterate up the host address space seeing if the
- * allocation would work.
+ * This is a fallback method for finding holes in the host address space
+ * if we don't have the benefit of being able to access /proc/self/map.
+ * It can potentially take a very long time as we can only dumbly iterate
+ * up the host address space seeing if the allocation would work.
  */
-static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
-                                        long align, uintptr_t offset)
+static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,
+                                   uintptr_t brk)
 {
-    uintptr_t base;
+    /* TODO: come up with a better estimate of how much to skip. */
+    uintptr_t skip = sizeof(uintptr_t) == 4 ? MiB : GiB;
 
-    /* Start (aligned) at the bottom and work our way up */
-    base = ROUND_UP(mmap_min_addr, align);
-
-    while (true) {
-        uintptr_t align_start, end;
-        align_start = ROUND_UP(base, align);
-        end = align_start + guest_size + offset;
-
-        /* if brk is anywhere in the range give ourselves some room to grow. */
-        if (align_start <= brk && brk < end) {
-            base = brk + (16 * MiB);
-            continue;
-        } else if (align_start + guest_size < align_start) {
-            /* we have run out of space */
+    for (uintptr_t base = skip; ; base += skip) {
+        base = ROUND_UP(base, align);
+        if (pgb_try_mmap_set(ga, base, brk)) {
+            return base;
+        }
+        if (base >= -skip) {
             return -1;
-        } else {
-            int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE |
-                MAP_FIXED_NOREPLACE;
-            void * mmap_start = mmap((void *) align_start, guest_size,
-                                     PROT_NONE, flags, -1, 0);
-            if (mmap_start != MAP_FAILED) {
-                munmap(mmap_start, guest_size);
-                if (mmap_start == (void *) align_start) {
-                    return (uintptr_t) mmap_start + offset;
-                }
-            }
-            base += qemu_host_page_size;
         }
     }
 }
 
-/* Return value for guest_base, or -1 if no hole found. */
-static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_size,
-                               long align, uintptr_t offset)
+static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
+                               IntervalTreeRoot *root)
 {
-    IntervalTreeRoot *maps;
-    IntervalTreeNode *iter;
-    uintptr_t this_start, this_end, next_start, brk;
-    intptr_t ret = -1;
+    for (int i = ga->nbounds - 1; i >= 0; --i) {
+        uintptr_t s = base + ga->bounds[i][0];
+        uintptr_t l = base + ga->bounds[i][1];
+        IntervalTreeNode *n;
+
+        if (l < s) {
+            /* Wraparound. Skip to advance S to 0. */
+            return -s;
+        }
+
+        n = interval_tree_iter_first(root, s, l);
+        if (n != NULL) {
+            /* Conflict.  Skip to advance S to LAST + 1. */
+            return n->last - s + 1;
+        }
+    }
+    return 0;  /* success */
+}
+
+static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
+                                uintptr_t align, uintptr_t brk)
+{
+    uintptr_t last = mmap_min_addr;
+    uintptr_t base, skip;
+
+    while (true) {
+        base = ROUND_UP(last, align);
+        if (base < last) {
+            return -1;
+        }
+
+        skip = pgb_try_itree(ga, base, root);
+        if (skip == 0) {
+            break;
+        }
+
+        last = base + skip;
+        if (last < base) {
+            return -1;
+        }
+    }
+
+    /*
+     * We've chosen 'base' based on holes in the interval tree,
+     * but we don't yet know if it is a valid host address.
+     * Because it is the first matching hole, if the host addresses
+     * are invalid we know there are no further matches.
+     */
+    return pgb_try_mmap_set(ga, base, brk) ? base : -1;
+}
+
+static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
+                        uintptr_t guest_hiaddr, uintptr_t align)
+{
+    IntervalTreeRoot *root;
+    uintptr_t brk, ret;
+    PGBAddrs ga;
 
     assert(QEMU_IS_ALIGNED(guest_loaddr, align));
 
-    maps = read_self_maps();
+    /* Try the identity map first. */
+    if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
+        brk = (uintptr_t)sbrk(0);
+        if (pgb_try_mmap_set(&ga, 0, brk)) {
+            guest_base = 0;
+            return;
+        }
+    }
+
+    /*
+     * Rebuild the address set for non-identity map.
+     * This differs in the mapping of the guest NULL page.
+     */
+    pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, false);
+
+    root = read_self_maps();
 
     /* Read brk after we've read the maps, which will malloc. */
     brk = (uintptr_t)sbrk(0);
 
-    if (!maps) {
-        return pgd_find_hole_fallback(guest_size, brk, align, offset);
-    }
-
-    /* The first hole is before the first map entry. */
-    this_start = mmap_min_addr;
-
-    for (iter = interval_tree_iter_first(maps, 0, -1);
-         iter;
-         this_start = next_start,
-         iter = interval_tree_iter_next(iter, 0, -1)) {
-        MapInfo *info = container_of(iter, MapInfo, itree);
-        uintptr_t align_start, hole_size;
-
-        this_end = info->itree.start;
-        next_start = info->itree.last + 1;
-        align_start = ROUND_UP(this_start + offset, align);
-
-        /* Skip holes that are too small. */
-        if (align_start >= this_end) {
-            continue;
-        }
-        hole_size = this_end - align_start;
-        if (hole_size < guest_size) {
-            continue;
-        }
-
-        /* If this hole contains brk, give ourselves some room to grow. */
-        if (this_start <= brk && brk < this_end) {
-            hole_size -= guest_size;
-            if (sizeof(uintptr_t) == 8 && hole_size >= 1 * GiB) {
-                align_start += 1 * GiB;
-            } else if (hole_size >= 16 * MiB) {
-                align_start += 16 * MiB;
-            } else {
-                align_start = (this_end - guest_size) & -align;
-                if (align_start < this_start) {
-                    continue;
-                }
-            }
-        }
-
-        /* Record the lowest successful match. */
-        if (ret < 0) {
-            ret = align_start;
-        }
-        /* If this hole contains the identity map, select it. */
-        if (align_start <= guest_loaddr &&
-            guest_loaddr + guest_size <= this_end) {
-            ret = 0;
-        }
-        /* If this hole ends above the identity map, stop looking. */
-        if (this_end >= guest_loaddr) {
-            break;
-        }
-    }
-    free_self_maps(maps);
-    return ret;
-}
-
-static void pgb_static(const char *image_name, abi_ulong orig_loaddr,
-                       abi_ulong orig_hiaddr, long align)
-{
-    uintptr_t loaddr = orig_loaddr;
-    uintptr_t hiaddr = orig_hiaddr;
-    uintptr_t offset = 0;
-    uintptr_t addr;
-
-    loaddr &= -align;
-    if (HI_COMMPAGE) {
+    if (!root) {
+        ret = pgb_find_fallback(&ga, align, brk);
+    } else {
         /*
-         * Extend the allocation to include the commpage.
-         * For a 64-bit host, this is just 4GiB; for a 32-bit host we
-         * need to ensure there is space bellow the guest_base so we
-         * can map the commpage in the place needed when the address
-         * arithmetic wraps around.
+         * Reserve the area close to the host brk.
+         * This will be freed with the rest of the tree.
          */
-        if (sizeof(uintptr_t) == 8 || loaddr >= 0x80000000u) {
-            hiaddr = UINT32_MAX;
-        } else {
-            offset = -(HI_COMMPAGE & -align);
-        }
-    } else if (LO_COMMPAGE != -1) {
-        loaddr = MIN(loaddr, LO_COMMPAGE & -align);
+        IntervalTreeNode *b = g_new0(IntervalTreeNode, 1);
+        b->start = brk;
+        b->last = brk + 16 * MiB - 1;
+        interval_tree_insert(b, root);
+
+        ret = pgb_find_itree(&ga, root, align, brk);
+        free_self_maps(root);
     }
 
-    addr = pgb_find_hole(loaddr, hiaddr - loaddr + 1, align, offset);
-    if (addr == -1) {
-        /*
-         * If HI_COMMPAGE, there *might* be a non-consecutive allocation
-         * that can satisfy both.  But as the normal arm32 link base address
-         * is ~32k, and we extend down to include the commpage, making the
-         * overhead only ~96k, this is unlikely.
-         */
-        error_report("%s: Unable to allocate %#zx bytes of "
-                     "virtual address space", image_name,
-                     (size_t)(hiaddr - loaddr));
-        exit(EXIT_FAILURE);
-    }
-
-    guest_base = addr;
-}
-
-static void pgb_dynamic(const char *image_name, long align)
-{
-    /*
-     * The executable is dynamic and does not require a fixed address.
-     * All we need is a commpage that satisfies align.
-     * If we do not need a commpage, leave guest_base == 0.
-     */
-    if (HI_COMMPAGE) {
-        uintptr_t addr, commpage;
-
-        /* 64-bit hosts should have used reserved_va. */
-        assert(sizeof(uintptr_t) == 4);
-
-        /*
-         * By putting the commpage at the first hole, that puts guest_base
-         * just above that, and maximises the positive guest addresses.
-         */
-        commpage = HI_COMMPAGE & -align;
-        addr = pgb_find_hole(commpage, -commpage, align, 0);
-        assert(addr != -1);
-        guest_base = addr;
-    }
-}
-
-static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
-                            abi_ulong guest_hiaddr, long align)
-{
-    int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
-    void *addr, *test;
-
-    /* Widen the "image" to the entire reserved address space. */
-    pgb_static(image_name, 0, reserved_va, align);
-
-    /* osdep.h defines this as 0 if it's missing */
-    flags |= MAP_FIXED_NOREPLACE;
-
-    /* Reserve the memory on the host. */
-    assert(guest_base != 0);
-    test = g2h_untagged(0);
-    addr = mmap(test, reserved_va + 1, PROT_NONE, flags, -1, 0);
-    if (addr == MAP_FAILED || addr != test) {
-        error_report("Unable to reserve 0x%lx bytes of virtual address "
-                     "space at %p (%s) for use as guest address space (check your "
-                     "virtual memory ulimit setting, mmap_min_addr or reserve less "
-                     "using qemu-user's -R option)",
-                     reserved_va + 1, test, strerror(errno));
+    if (ret == -1) {
+        int w = TARGET_LONG_BITS / 4;
+
+        error_report("%s: Unable to find a guest_base to satisfy all "
+                     "guest address mapping requirements", image_name);
+
+        for (int i = 0; i < ga.nbounds; ++i) {
+            error_printf("  %0*" PRIx64 "-%0*" PRIx64 "\n",
+                         w, (uint64_t)ga.bounds[i][0],
+                         w, (uint64_t)ga.bounds[i][1]);
+        }
         exit(EXIT_FAILURE);
     }
+    guest_base = ret;
 }
 
 void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
@@ -2927,12 +2850,8 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
     if (have_guest_base) {
         pgb_fixed(image_name, guest_loaddr, guest_hiaddr, align);
-    } else if (reserved_va) {
-        pgb_reserved_va(image_name, guest_loaddr, guest_hiaddr, align);
-    } else if (guest_loaddr) {
-        pgb_static(image_name, guest_loaddr, guest_hiaddr, align);
     } else {
-        pgb_dynamic(image_name, align);
+        pgb_dynamic(image_name, guest_loaddr, guest_hiaddr, align);
     }
 
     /* Reserve and initialize the commpage. */
-- 
2.34.1



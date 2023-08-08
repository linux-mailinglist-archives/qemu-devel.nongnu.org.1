Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCD774C8A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTx5-0007ki-O1; Tue, 08 Aug 2023 17:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx4-0007kJ-66
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTx1-0005xy-Vi
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso52337615ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528951; x=1692133751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2nTqtcYhBLl6XhGtj8nvtR1cExXc+DDI9B9XR2Hu/Y=;
 b=J9Q9fhQfLebBFCuIEtC/cEZCSJPNvEbGbtoJvjE1kzh/TVRaQ6A0q2QaV4jlJqAdWC
 ZvhUDGZDmJxalxxKBqkCXrA1WVMCZzeLnvn2IK9BVqq/iGXg96eg5OzFDQ0sNqthLGNY
 hTzQrLnqNwM+U1UClmQwv+oIfqmEbfPNbboaAONp6h/RBUvl6rKblFOrcD9SO0bBlz+6
 VvtuxMJj+NAmZoXIxYvJB3iulG5n8ZCIuflOuSUhsgd6QDpZIY86UUOqEKRIDaUldaYQ
 D0aNNdC817E0fUX4ygQQ3n62gyS/l5pQGH3y6JB4Y7z9KASVUUusdKBSnCeTkcbxoUcL
 jIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528951; x=1692133751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2nTqtcYhBLl6XhGtj8nvtR1cExXc+DDI9B9XR2Hu/Y=;
 b=dazUSnN+jLtRRF8OwvVGi/8mJjYwh3Lx+9De9jtUUP1Z6uubYyiQdUCc7bEtLuDO9H
 tqVy36ZJbtno7JXdRkbQCS+RoIGVEyfPrd9Z42Oly+rU85lCdoQhVSww2OHR/najUOeV
 r8Pp7lte/nRpd43A6UOxd27bf4751EdC1AfOHKOMp1EoPlQdFQMNpJGE/ATO9Dzci53I
 w9zb9x98dn63pSQBv79lqHvW+8ccyL0hyaX2jaxiPei6vh+/WuW4NWlc6OfT8VKBT354
 aiIFgtue38SSnj8UbmVlLmchcIVOMCp6onV5pIjsE20yIJsPmFHg7jV52dxBzubA4Aau
 shRw==
X-Gm-Message-State: AOJu0Yw50gil53v9YcKovaqDO4bnIh8cwFaC0mfHpsWtpr++W+6/9NDt
 Q3BbWa35WYfZ9ZI1h0E2pvu/uPepzDpKfsZZFMk=
X-Google-Smtp-Source: AGHT+IHhEtRmHiJMIk9H8H9oxIlsVqbn7/M3KmPwkdPck+oouqq/aY82Ln1H8eW7jPeGA1eZ4YpQzg==
X-Received: by 2002:a17:903:32c2:b0:1bb:9b29:20d9 with SMTP id
 i2-20020a17090332c200b001bb9b2920d9mr897575plr.20.1691528950647; 
 Tue, 08 Aug 2023 14:09:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/14] linux-user: Rewrite non-fixed probe_guest_base
Date: Tue,  8 Aug 2023 14:08:56 -0700
Message-Id: <20230808210856.95568-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 311 ++++++++++++++++---------------------------
 1 file changed, 115 insertions(+), 196 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5f9dd5b31..ac03beb01b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2683,220 +2683,143 @@ static void pgb_fixed(const char *image_name, uintptr_t guest_loaddr,
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
+            /* Wraparound. Skip to advance S to mmap_min_addr. */
+            return mmap_min_addr - s;
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
@@ -2924,12 +2847,8 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
 
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



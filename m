Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B47902E9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzJ-0007HP-Ce; Fri, 01 Sep 2023 16:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyy-00072T-Rj
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyw-0001z1-Cw
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so2043122b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600984; x=1694205784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBIoNdfoCHZlUDPCS1YWUY+gLgz0IIKwqu+6lqO6x2g=;
 b=cqmqm+t8zxwfMnKFLZywxt32QgcMoIQKMf0GpxzCC6uzMvQmwai9Yz7VKxRJE4jTLP
 wyTz1Qvmcrz+JYXPZMr7hpE5t4Aa3ZIzMRXdIhyaYlf9na/pcuXavnJBkXZim5ha7F0S
 lkSMY7N1j5goOF4wbDrDuhF4e89s47kmuXCfWRSmKZcMN7OuluyVZSqjanO1J3gbSD3k
 WFIUcynexuOT/KzKTT1Pl/BTTHJfD016JMKRHBtGEyBWfoPONiEq2Zv51/vhRckgjU1D
 WK9RLEkOAEROutbpZz0owkDHL1un+5h/I2yZypNcA71bqD517UvycTYpaSi6UVPFsAkx
 Nnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600984; x=1694205784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBIoNdfoCHZlUDPCS1YWUY+gLgz0IIKwqu+6lqO6x2g=;
 b=K0eBu5MBhzWOPQSUJp26TzMQgrmLBwBD9kSbnolj4akrq+/RXe90SMyebCuUYoxJbi
 f42SyA8wRyDlu1Wph8rEF/glY75m6LqctqGOTj51V4eJSWsthxxcknCfGOK8swfUckmz
 tilFfJ6bgmYG2lkyKcKliOhq14KF9MFSEuS1OQ+6f0BCuscetpJ2oSRtLLu6fG8wx0s/
 03bJJOgNe19JqPlssw0EHJvnqeBu4ywXi3Y/Ff22lURmcPyM0BAUGJwYhVGSNNasfPJx
 QulMxne3ko8zXsFBVCUipa6e/jKeWshAJE9HUab1e+gaLsVF3xG4DmZWKVmmRad3+XIh
 dnaw==
X-Gm-Message-State: AOJu0YyZK9WOkx2YjMfv0HL9QdJ3NOw6LU4rV8YW1ZZfZbWCu0Trdjwn
 G3IzqZKW0tYvOoNMmvIXKV1S7rIAY1u7DrntGDs=
X-Google-Smtp-Source: AGHT+IFEMimFJVZPSpR8SWMNciDyv+sWqSeYYhdwm8PRMOY1EmC6ufLa0Vn9MP+RCgzJzbhsq3qAdw==
X-Received: by 2002:a05:6a00:398e:b0:68a:4dc3:dbb9 with SMTP id
 fi14-20020a056a00398e00b0068a4dc3dbb9mr4254998pfb.28.1693600984435; 
 Fri, 01 Sep 2023 13:43:04 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:43:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 13/13] linux-user: Track shm regions with an interval tree
Date: Fri,  1 Sep 2023 13:42:51 -0700
Message-Id: <20230901204251.137307-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Remove the fixed size shm_regions[] array.
Remove references when other mappings completely remove
or replace a region.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 81 +++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 44116c014b..8eaf57b208 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -24,18 +24,11 @@
 #include "user-internals.h"
 #include "user-mmap.h"
 #include "target_mman.h"
+#include "qemu/interval-tree.h"
 
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
-#define N_SHM_REGIONS  32
-
-static struct shm_region {
-    abi_ulong start;
-    abi_ulong size;
-    bool in_use;
-} shm_regions[N_SHM_REGIONS];
-
 void mmap_lock(void)
 {
     if (mmap_lock_count++ == 0) {
@@ -73,6 +66,44 @@ void mmap_fork_end(int child)
     }
 }
 
+/* Protected by mmap_lock. */
+static IntervalTreeRoot shm_regions;
+
+static void shm_region_add(abi_ptr start, abi_ptr last)
+{
+    IntervalTreeNode *i = g_new0(IntervalTreeNode, 1);
+
+    i->start = start;
+    i->last = last;
+    interval_tree_insert(i, &shm_regions);
+}
+
+static abi_ptr shm_region_find(abi_ptr start)
+{
+    IntervalTreeNode *i;
+
+    for (i = interval_tree_iter_first(&shm_regions, start, start); i;
+         i = interval_tree_iter_next(i, start, start)) {
+        if (i->start == start) {
+            return i->last;
+        }
+    }
+    return 0;
+}
+
+static void shm_region_rm_complete(abi_ptr start, abi_ptr last)
+{
+    IntervalTreeNode *i, *n;
+
+    for (i = interval_tree_iter_first(&shm_regions, start, last); i; i = n) {
+        n = interval_tree_iter_next(i, start, last);
+        if (i->start >= start && i->last <= last) {
+            interval_tree_remove(i, &shm_regions);
+            g_free(i);
+        }
+    }
+}
+
 /*
  * Validate target prot bitmask.
  * Return the prot bitmask for the host in *HOST_PROT.
@@ -729,6 +760,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             page_set_flags(passthrough_last + 1, last, page_flags);
         }
     }
+    shm_region_rm_complete(start, last);
  the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
@@ -826,6 +858,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     mmap_lock();
     mmap_reserve_or_unmap(start, len);
     page_set_flags(start, start + len - 1, 0);
+    shm_region_rm_complete(start, start + len - 1);
     mmap_unlock();
 
     return 0;
@@ -915,8 +948,10 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         new_addr = h2g(host_addr);
         prot = page_get_flags(old_addr);
         page_set_flags(old_addr, old_addr + old_size - 1, 0);
+        shm_region_rm_complete(old_addr, old_addr + old_size - 1);
         page_set_flags(new_addr, new_addr + new_size - 1,
                        prot | PAGE_VALID | PAGE_RESET);
+        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
     }
     mmap_unlock();
     return new_addr;
@@ -1045,6 +1080,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
 
     WITH_MMAP_LOCK_GUARD() {
         void *host_raddr;
+        abi_ulong last;
 
         if (shmaddr) {
             host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
@@ -1066,19 +1102,14 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
             return get_errno(-1);
         }
         raddr = h2g(host_raddr);
+        last = raddr + shm_info.shm_segsz - 1;
 
-        page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
+        page_set_flags(raddr, last,
                        PAGE_VALID | PAGE_RESET | PAGE_READ |
                        (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
 
-        for (int i = 0; i < N_SHM_REGIONS; i++) {
-            if (!shm_regions[i].in_use) {
-                shm_regions[i].in_use = true;
-                shm_regions[i].start = raddr;
-                shm_regions[i].size = shm_info.shm_segsz;
-                break;
-            }
-        }
+        shm_region_rm_complete(raddr, last);
+        shm_region_add(raddr, last);
     }
 
     /*
@@ -1102,23 +1133,17 @@ abi_long target_shmdt(abi_ulong shmaddr)
     /* shmdt pointers are always untagged */
 
     WITH_MMAP_LOCK_GUARD() {
-        int i;
-
-        for (i = 0; i < N_SHM_REGIONS; ++i) {
-            if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-                break;
-            }
-        }
-        if (i == N_SHM_REGIONS) {
+        abi_ulong last = shm_region_find(shmaddr);
+        if (last == 0) {
             return -TARGET_EINVAL;
         }
 
         rv = get_errno(shmdt(g2h_untagged(shmaddr)));
         if (rv == 0) {
-            abi_ulong size = shm_regions[i].size;
+            abi_ulong size = last - shmaddr + 1;
 
-            shm_regions[i].in_use = false;
-            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            page_set_flags(shmaddr, last, 0);
+            shm_region_rm_complete(shmaddr, last);
             mmap_reserve_or_unmap(shmaddr, size);
         }
     }
-- 
2.34.1



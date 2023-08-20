Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80529782004
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpHY-0004yk-O3; Sun, 20 Aug 2023 16:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHV-0004xF-OM
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:17 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXpHT-0007kk-9l
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:44:17 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso2202182a34.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692564254; x=1693169054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UN+H+/GfTniCDQqNqoi86BdHI3S12YJ9y5ScYnnODH0=;
 b=CxCjfDjMg+WEGWFKC6MY8TWAL6WjSzrsbcDmjQj6XF3hi4Qgsz+pqWv2q4/Iew0qIQ
 8XJ6qUyQc6HrD6oaN8Ydee+6TLmA2X74u93dipKhxxdjbZWAo7VQIl0f2/F3AU0igFj+
 7OUQ1HrUavDwPvDXOmurOLrKlU5uc/qhBGn0o/sIMWTO/FT1vEjS4hzme05JooO9HApc
 1TGnGeZYkEKBwGmRRi6rUF7ShYqLpehFJypubUxPb6WJpBPdbMYAVF3KgJfMuUPHmcCI
 46FMX6miXNnPn8SZIro+H32dhY8/XtU1UIFyhFtFKpL6/hp//xW4uCaxRU4IK9IZOkFl
 ChQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692564254; x=1693169054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UN+H+/GfTniCDQqNqoi86BdHI3S12YJ9y5ScYnnODH0=;
 b=lK4kxo+U8UqW42UclF+t7mhGY5fbo2OtPqx4GVH4nXVQf05gCSEhRJjeVqKn8hJRym
 G8Mtyt15R3yXYIMath4OCU4iZGx/qfBhvM3i57xcPac76IT6J5u1TcjKfdiWBp2x5OEI
 cztvxygwPbzFGBLCemOGZii5dthm5sCguXu4LZLW8PbbWvGce1SAojEaZUeDlSUdmoD4
 wcWSCVvNZvDMIBfytF0YRdX6tY3nYGcjYvpx1pc3jXhr0EjWRlAT4qHliKdUo0PiwHJZ
 d1qTvBvSEysk+cW0tt+elKU8qRcumKFMS35/oM9IU8N3rIgBBYazL3Wfg0TVCNVWz6uD
 b6uQ==
X-Gm-Message-State: AOJu0YyS0V/kjp06rYcWSZyUFvU6p3wcl/g0X9NvUnzm/PWiTPElL11X
 mvBbDC9GpJ2wfYJ62IFMp9sKC19NBYVudCEdWRA=
X-Google-Smtp-Source: AGHT+IEusVR/EhK3aTYp4l+/i6Pv9XNBtaX/FqCN1ZkZzXp6RoSZd+xBApkr/gx85+jhZglAbyx77w==
X-Received: by 2002:a05:6870:b524:b0:1bb:a227:7008 with SMTP id
 v36-20020a056870b52400b001bba2277008mr6454963oap.3.1692564253964; 
 Sun, 20 Aug 2023 13:44:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa78c07000000b0064fde7ae1ffsm1430149pfd.38.2023.08.20.13.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 13:44:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	imp@bsdimp.com,
	kariem.taha2.7@gmail.com
Subject: [PATCH 4/4] linux-user: Track shm regions with an interval tree
Date: Sun, 20 Aug 2023 13:44:08 -0700
Message-Id: <20230820204408.327348-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820204408.327348-1-richard.henderson@linaro.org>
References: <20230820204408.327348-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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



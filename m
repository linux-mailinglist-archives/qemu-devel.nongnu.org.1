Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAD786470
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykQ-0000V2-PR; Wed, 23 Aug 2023 21:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykP-0000Qv-H8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:53 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykN-0000Sm-2s
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso3647145a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838969; x=1693443769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UN+H+/GfTniCDQqNqoi86BdHI3S12YJ9y5ScYnnODH0=;
 b=OmIoDg8z1OjtcnAW2jF/7FS2KO+ERxDBZ96xWzyHurHPJQrMrFvSlXvWTOGQOWDd4G
 qOH94u+TkJ/bwhVkPFsrx8yYmWG7ZWfHc+RU4CUvA69cAnG2l/nCuFTo1dKerpsZ1WRy
 Yh7LNkEXiCgDrox+wDWGTaNwOEKLb9RX7wUzyWwBVAJZWt902ypLQyk1zJID/XitUyIf
 9HuctgRO+eIUkn8YrsJtaE63fuxRbJLBGKXxqJxcSNS3AblkbxtsTACgxlBisoWmZ6Ow
 AIGUxMJZ4Pqi0ve5/IRJB2NTRw6ZE4SKPJ4CC5fKYXDCGjgCyfLtDgzTCwXlfIt8Jxvm
 7k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838969; x=1693443769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UN+H+/GfTniCDQqNqoi86BdHI3S12YJ9y5ScYnnODH0=;
 b=RmnohysdnzkMAaqsiN9QlAh6a5H3Zi1zbKk9lQ3T+/W+dOjcgbnTmWqeq7bhUGWwLk
 vAkt/J3bDNhPOAkp35HumtXl1z8Yp1XtY6DhA2GiFoS4QQTtj8GSVvH3zDikDgy2FLsz
 e33gOpOF2tugAho8XVdD9Q5XMr1jY0oo1DBMizH8yHtNMnBxki7rALb7UlZLqPkblobz
 gBLMIJ9oHJwWwedcagjMEvW/OtkmgMCo9KrNtu2Xz+CsG7SWzUWfk/aIbZC77wOjv0UM
 ttnqRpI7aV6fTZ3hN0Mz1yD+FFnDaC2j3B+1Q0YXb/F/XBJOyQXRwPE3VT5T9Ea8wQcA
 7HDA==
X-Gm-Message-State: AOJu0YwhzVPRwSOBzUmE03UfZf4GL0ywMf68RDZoy3k7pjM6ykRQthpz
 gNc6lnS7VW9MpaJLW2FCi6JgUQ3jXgY6ip0Gv18=
X-Google-Smtp-Source: AGHT+IFGOwhPb0tp2gvGCMfGSBEQdXxyU87HV6wtyE9gncPKj+BYT3zv51B5a1ZIhErgM3+Xu6uVHg==
X-Received: by 2002:a05:6a21:3b4a:b0:14b:8023:33b3 with SMTP id
 zy10-20020a056a213b4a00b0014b802333b3mr3451667pzb.19.1692838969324; 
 Wed, 23 Aug 2023 18:02:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] linux-user: Track shm regions with an interval tree
Date: Wed, 23 Aug 2023 18:02:37 -0700
Message-Id: <20230824010237.1379735-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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



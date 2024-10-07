Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D399373D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 21:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtEp-0005Br-Ay; Mon, 07 Oct 2024 15:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEm-0005A5-7l; Mon, 07 Oct 2024 15:17:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEj-0004An-Bw; Mon, 07 Oct 2024 15:17:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EE0CE9624B;
 Mon,  7 Oct 2024 22:16:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C17E814F72B;
 Mon,  7 Oct 2024 22:16:55 +0300 (MSK)
Received: (nullmailer pid 2592743 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 14/32] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
Date: Mon,  7 Oct 2024 22:16:31 +0300
Message-Id: <20241007191654.2592616-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

As reported by Peter, we might be leaking memory when removing the
highest RAMBlock (in the weird ram_addr_t space), and adding a new one.

We will fail to realize that we already allocated bitmaps for more
dirty memory blocks, and effectively discard the pointers to them.

Fix it by getting rid of last_ram_page() and by remembering the number
of dirty memory blocks that have been allocated already.

While at it, let's use "unsigned int" for the number of blocks, which
should be sufficient until we reach ~32 exabytes.

Looks like this leak was introduced as we switched from using a single
bitmap_zero_extend() to allocating multiple bitmaps:
bitmap_zero_extend() relies on g_renew() which should have taken care of
this.

Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20240828090743.128647-1-david@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit b84f06c2bee727b3870b4eeccbe3a45c5aea14c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2ad2a81acc..d9cfe530be 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -50,6 +50,7 @@ typedef struct RAMList {
     /* RCU-enabled, writes protected by the ramlist lock. */
     QLIST_HEAD(, RAMBlock) blocks;
     DirtyMemoryBlocks *dirty_memory[DIRTY_MEMORY_NUM];
+    unsigned int num_dirty_blocks;
     uint32_t version;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
 } RAMList;
diff --git a/system/physmem.c b/system/physmem.c
index 971bfa0855..d71a2b1bbd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1534,18 +1534,6 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     return offset;
 }
 
-static unsigned long last_ram_page(void)
-{
-    RAMBlock *block;
-    ram_addr_t last = 0;
-
-    RCU_READ_LOCK_GUARD();
-    RAMBLOCK_FOREACH(block) {
-        last = MAX(last, block->offset + block->max_length);
-    }
-    return last >> TARGET_PAGE_BITS;
-}
-
 static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
 {
     int ret;
@@ -1799,13 +1787,11 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 }
 
 /* Called with ram_list.mutex held */
-static void dirty_memory_extend(ram_addr_t old_ram_size,
-                                ram_addr_t new_ram_size)
+static void dirty_memory_extend(ram_addr_t new_ram_size)
 {
-    ram_addr_t old_num_blocks = DIV_ROUND_UP(old_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
-    ram_addr_t new_num_blocks = DIV_ROUND_UP(new_ram_size,
-                                             DIRTY_MEMORY_BLOCK_SIZE);
+    unsigned int old_num_blocks = ram_list.num_dirty_blocks;
+    unsigned int new_num_blocks = DIV_ROUND_UP(new_ram_size,
+                                               DIRTY_MEMORY_BLOCK_SIZE);
     int i;
 
     /* Only need to extend if block count increased */
@@ -1837,6 +1823,8 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
             g_free_rcu(old_blocks, rcu);
         }
     }
+
+    ram_list.num_dirty_blocks = new_num_blocks;
 }
 
 static void ram_block_add(RAMBlock *new_block, Error **errp)
@@ -1846,11 +1834,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     bool free_on_error = false;
-    ram_addr_t old_ram_size, new_ram_size;
+    ram_addr_t ram_size;
     Error *err = NULL;
 
-    old_ram_size = last_ram_page();
-
     qemu_mutex_lock_ramlist();
     new_block->offset = find_ram_offset(new_block->max_length);
 
@@ -1901,11 +1887,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         }
     }
 
-    new_ram_size = MAX(old_ram_size,
-              (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS);
-    if (new_ram_size > old_ram_size) {
-        dirty_memory_extend(old_ram_size, new_ram_size);
-    }
+    ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
+    dirty_memory_extend(ram_size);
     /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
      * QLIST (which has an RCU-friendly variant) does not have insertion at
      * tail, so save the last element in last_block.
-- 
2.39.5



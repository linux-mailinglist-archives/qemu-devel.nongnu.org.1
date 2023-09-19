Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FCC7A5FA8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY17-0003uZ-Kn; Tue, 19 Sep 2023 06:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0A-00035c-Ur
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY07-0001tJ-Sa
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZO9iYkpCO8FB1WSwAveYvxpF+2W+rGaDxEnkBbGNzv0=;
 b=e5Th19Z845h7gxb2mh7fowTDwdWPKaZcZNI7hvugutPi2b/w/bdVZR0wtAjZduVm8WTDn0
 ZsOPbU6jV67OyRWhKB1kHsgEBVkawPVR8F+fOYBy+7pkIKcrdS4Xc05wjwKClpo7nQsYFD
 SLkcj4So+Lx8nmtjv3K76RfddUCGrCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-_RntCIpdNFKWxWaIDXiQXA-1; Tue, 19 Sep 2023 06:30:33 -0400
X-MC-Unique: _RntCIpdNFKWxWaIDXiQXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0913811E86
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C13A40C6EC0;
 Tue, 19 Sep 2023 10:30:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [GIT PULL 02/12] softmmu/physmem: Distinguish between file access
 mode and mmap protection
Date: Tue, 19 Sep 2023 12:30:19 +0200
Message-ID: <20230919103029.235736-3-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There is a difference between how we open a file and how we mmap it,
and we want to support writable private mappings of readonly files. Let's
define RAM_READONLY and RAM_READONLY_FD flags, to replace the single
"readonly" parameter for file-related functions.

In memory_region_init_ram_from_fd() and memory_region_init_ram_from_file(),
initialize mr->readonly based on the new RAM_READONLY flag.

While at it, add some RAM_* flags we missed to add to the list of accepted
flags in the documentation of some functions.

No change in functionality intended. We'll make use of both flags next
and start setting them independently for memory-backend-file.

Message-ID: <20230906120503.359863-3-david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem-file.c |  4 ++--
 include/exec/memory.h   | 14 ++++++++++----
 include/exec/ram_addr.h |  8 ++++----
 softmmu/memory.c        |  8 ++++----
 softmmu/physmem.c       | 21 ++++++++++-----------
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index b4335a80e6..ef2d5533af 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -55,13 +55,13 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags |= fb->readonly ? RAM_READONLY | RAM_READONLY_FD : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     ram_flags |= RAM_NAMED_FILE;
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                      backend->size, fb->align, ram_flags,
-                                     fb->mem_path, fb->offset, fb->readonly,
-                                     errp);
+                                     fb->mem_path, fb->offset, errp);
     g_free(name);
 #endif
 }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 68284428f8..cc68249eda 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -235,6 +235,12 @@ typedef struct IOMMUTLBEvent {
 /* RAM is an mmap-ed named file */
 #define RAM_NAMED_FILE (1 << 9)
 
+/* RAM is mmap-ed read-only */
+#define RAM_READONLY (1 << 10)
+
+/* RAM FD is opened read-only */
+#define RAM_READONLY_FD (1 << 11)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -1331,10 +1337,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @align: alignment of the region base address; if 0, the default alignment
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
- *             RAM_NORESERVE,
+ *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *             RAM_READONLY_FD
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
- * @readonly: true to open @path for reading, false for read/write.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1348,7 +1354,6 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint32_t ram_flags,
                                       const char *path,
                                       ram_addr_t offset,
-                                      bool readonly,
                                       Error **errp);
 
 /**
@@ -1360,7 +1365,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
  * @name: the name of the region.
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
- *             RAM_NORESERVE, RAM_PROTECTED.
+ *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *             RAM_READONLY_FD
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9f2e3893f5..90676093f5 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -108,10 +108,10 @@ long qemu_maxrampagesize(void);
  *  @size: the size in bytes of the ram block
  *  @mr: the memory region where the ram block is
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
- *              RAM_NORESERVE.
+ *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *              RAM_READONLY_FD
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
- *  @readonly: true to open @path for reading, false for read/write.
  *  @errp: pointer to Error*, to store an error if it happens
  *
  * Return:
@@ -120,10 +120,10 @@ long qemu_maxrampagesize(void);
  */
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   off_t offset, bool readonly, Error **errp);
+                                   off_t offset, Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
-                                 bool readonly, Error **errp);
+                                 Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..2cb60ec9b8 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1620,18 +1620,17 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint32_t ram_flags,
                                       const char *path,
                                       ram_addr_t offset,
-                                      bool readonly,
                                       Error **errp)
 {
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
-    mr->readonly = readonly;
+    mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
     mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
-                                             offset, readonly, &err);
+                                             offset, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
@@ -1651,10 +1650,11 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->readonly = !!(ram_flags & RAM_READONLY);
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
-                                           false, &err);
+                                           &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..7e03ed7e3e 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1350,7 +1350,6 @@ static int file_ram_open(const char *path,
 static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
-                            bool readonly,
                             bool truncate,
                             off_t offset,
                             Error **errp)
@@ -1408,7 +1407,7 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    qemu_map_flags = readonly ? QEMU_MAP_READONLY : 0;
+    qemu_map_flags = (block->flags & RAM_READONLY) ? QEMU_MAP_READONLY : 0;
     qemu_map_flags |= (block->flags & RAM_SHARED) ? QEMU_MAP_SHARED : 0;
     qemu_map_flags |= (block->flags & RAM_PMEM) ? QEMU_MAP_SYNC : 0;
     qemu_map_flags |= (block->flags & RAM_NORESERVE) ? QEMU_MAP_NORESERVE : 0;
@@ -1876,7 +1875,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
-                                 bool readonly, Error **errp)
+                                 Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
@@ -1884,7 +1883,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
-                          RAM_PROTECTED | RAM_NAMED_FILE)) == 0);
+                          RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
+                          RAM_READONLY_FD)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1919,8 +1919,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, readonly,
-                                     !file_size, offset, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
+                                     errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -1939,20 +1939,19 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   off_t offset, bool readonly, Error **errp)
+                                   off_t offset, Error **errp)
 {
     int fd;
     bool created;
     RAMBlock *block;
 
-    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
-                       errp);
+    fd = file_ram_open(mem_path, memory_region_name(mr),
+                       !!(ram_flags & RAM_READONLY_FD), &created, errp);
     if (fd < 0) {
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, readonly,
-                                   errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
-- 
2.41.0



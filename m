Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D070770DFDD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TXN-0006MU-Q1; Tue, 23 May 2023 11:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1TXK-0006LI-F1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1TXI-0003tc-5X
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684854171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/PjFCg85HVzzzgepl+QhPAdh71/1M7KxgoStFVxtnE=;
 b=bnn5eoviUMbGH2xwXzCsxBuK5+Ufz3GddfmqzJ2C1vRShYJifXJ7ARaN3mupfiTQ4XcrOB
 /mJm5t2/GbMnawYsHn0OYUGSrnAeyTiB9a9+HlINKkHe3BoU6I5Hlykv3Nv5jQzRawvtfi
 YhjuLWmhGGaj1Mqwq433vaZkFAGWYVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-Rw5UTWsYM9OarmeSTMCz2A-1; Tue, 23 May 2023 11:02:47 -0400
X-MC-Unique: Rw5UTWsYM9OarmeSTMCz2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 228CA185A7B4;
 Tue, 23 May 2023 15:02:44 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 952D6492B0A;
 Tue, 23 May 2023 15:02:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 1/1] hostmem-file: add offset option
Date: Tue, 23 May 2023 17:02:40 +0200
Message-Id: <20230523150240.365055-2-david@redhat.com>
In-Reply-To: <20230523150240.365055-1-david@redhat.com>
References: <20230523150240.365055-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Add an option for hostmem-file to start the memory object at an offset
into the target file. This is useful if multiple memory objects reside
inside the same target file, such as a device node.

In particular, it's useful to map guest memory directly into /dev/mem
for experimentation.

To make this work consistently, also fix up all places in QEMU that
expect fd offsets to be 0.

Signed-off-by: Alexander Graf <graf@amazon.com>
Message-Id: <20230403221421.60877-1-graf@amazon.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem-file.c | 40 +++++++++++++++++++++++++++++++++++++++-
 hw/virtio/vhost-user.c  |  1 +
 include/exec/memory.h   |  2 ++
 include/exec/ram_addr.h |  3 ++-
 include/exec/ramblock.h |  1 +
 qapi/qom.json           |  5 +++++
 qemu-options.hx         |  6 +++++-
 softmmu/memory.c        |  3 ++-
 softmmu/physmem.c       | 17 ++++++++++++-----
 9 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 25141283c4..38ea65bec5 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -27,6 +27,7 @@ struct HostMemoryBackendFile {
 
     char *mem_path;
     uint64_t align;
+    uint64_t offset;
     bool discard_data;
     bool is_pmem;
     bool readonly;
@@ -58,7 +59,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                      backend->size, fb->align, ram_flags,
-                                     fb->mem_path, fb->readonly, errp);
+                                     fb->mem_path, fb->offset, fb->readonly,
+                                     errp);
     g_free(name);
 #endif
 }
@@ -125,6 +127,36 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     fb->align = val;
 }
 
+static void file_memory_backend_get_offset(Object *o, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    uint64_t val = fb->offset;
+
+    visit_type_size(v, name, &val, errp);
+}
+
+static void file_memory_backend_set_offset(Object *o, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(o);
+    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
+    uint64_t val;
+
+    if (host_memory_backend_mr_inited(backend)) {
+        error_setg(errp, "cannot change property '%s' of %s", name,
+                   object_get_typename(o));
+        return;
+    }
+
+    if (!visit_type_size(v, name, &val, errp)) {
+        return;
+    }
+    fb->offset = val;
+}
+
 #ifdef CONFIG_LIBPMEM
 static bool file_memory_backend_get_pmem(Object *o, Error **errp)
 {
@@ -197,6 +229,12 @@ file_backend_class_init(ObjectClass *oc, void *data)
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);
+    object_class_property_add(oc, "offset", "int",
+        file_memory_backend_get_offset,
+        file_memory_backend_set_offset,
+        NULL, NULL);
+    object_class_property_set_description(oc, "offset",
+        "Offset into the target file (ex: 1G)");
 #ifdef CONFIG_LIBPMEM
     object_class_property_add_bool(oc, "pmem",
         file_memory_backend_get_pmem, file_memory_backend_set_pmem);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e3ec8727da..74a2a28663 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -473,6 +473,7 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
     assert((uintptr_t)addr == addr);
     mr = memory_region_from_host((void *)(uintptr_t)addr, offset);
     *fd = memory_region_get_fd(mr);
+    *offset += mr->ram_block->fd_offset;
 
     return mr;
 }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6f24a3dd46..c3661b2276 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1326,6 +1326,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE,
  * @path: the path in which to allocate the RAM.
+ * @offset: offset within the file referenced by path
  * @readonly: true to open @path for reading, false for read/write.
  * @errp: pointer to Error*, to store an error if it happens.
  *
@@ -1339,6 +1340,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint64_t align,
                                       uint32_t ram_flags,
                                       const char *path,
+                                      ram_addr_t offset,
                                       bool readonly,
                                       Error **errp);
 
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f4fb6a2111..90a8269290 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -110,6 +110,7 @@ long qemu_maxrampagesize(void);
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE.
  *  @mem_path or @fd: specify the backing file or device
+ *  @offset: Offset into target file
  *  @readonly: true to open @path for reading, false for read/write.
  *  @errp: pointer to Error*, to store an error if it happens
  *
@@ -119,7 +120,7 @@ long qemu_maxrampagesize(void);
  */
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   bool readonly, Error **errp);
+                                   off_t offset, bool readonly, Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd, off_t offset,
                                  bool readonly, Error **errp);
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index adc03df59c..69c6a53902 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -40,6 +40,7 @@ struct RAMBlock {
     QLIST_ENTRY(RAMBlock) next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
+    uint64_t fd_offset;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/qapi/qom.json b/qapi/qom.json
index f61badaba4..7f92ea43e8 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -647,6 +647,10 @@
 #     selects a default alignment (currently the page size).
 #     (default: 0)
 #
+# @offset: the offset into the target file that the region starts at. You
+#     can use this option to back multiple regions with a single file. Must
+#     be a multiple of the page size. (default: 0) (since 8.1)
+#
 # @discard-data: if true, the file contents can be destroyed when QEMU
 #     exits, to avoid unnecessarily flushing data to the backing file.
 #     Note that @discard-data is only an optimization, and QEMU might
@@ -668,6 +672,7 @@
 { 'struct': 'MemoryBackendFileProperties',
   'base': 'MemoryBackendProperties',
   'data': { '*align': 'size',
+            '*offset': 'size',
             '*discard-data': 'bool',
             'mem-path': 'str',
             '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
diff --git a/qemu-options.hx b/qemu-options.hx
index e4566149ee..b37eb9662b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4949,7 +4949,7 @@ SRST
     they are specified. Note that the 'id' property must be set. These
     objects are placed in the '/objects' path.
 
-    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,readonly=on|off``
+    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off``
         Creates a memory file backend object, which can be used to back
         the guest RAM with huge pages.
 
@@ -5019,6 +5019,10 @@ SRST
         such cases, users can specify the required alignment via this
         option.
 
+        The ``offset`` option specifies the offset into the target file
+        that the region starts at. You can use this parameter to back
+        multiple regions with a single file.
+
         The ``pmem`` option specifies whether the backing file specified
         by ``mem-path`` is in host persistent memory that can be
         accessed using the SNIA NVM programming model (e.g. Intel
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 9ee4131d75..7d9494ce70 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1619,6 +1619,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       uint64_t align,
                                       uint32_t ram_flags,
                                       const char *path,
+                                      ram_addr_t offset,
                                       bool readonly,
                                       Error **errp)
 {
@@ -1630,7 +1631,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
     mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
-                                             readonly, &err);
+                                             offset, readonly, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index efaed36773..9d7e172260 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1369,6 +1369,11 @@ static void *file_ram_alloc(RAMBlock *block,
         error_setg(errp, "alignment 0x%" PRIx64
                    " must be a power of two", block->mr->align);
         return NULL;
+    } else if (offset % block->page_size) {
+        error_setg(errp, "offset 0x%" PRIx64
+                   " must be multiples of page size 0x%zx",
+                   offset, block->page_size);
+        return NULL;
     }
     block->mr->align = MAX(block->page_size, block->mr->align);
 #if defined(__s390x__)
@@ -1400,7 +1405,7 @@ static void *file_ram_alloc(RAMBlock *block,
      * those labels. Therefore, extending the non-empty backend file
      * is disabled as well.
      */
-    if (truncate && ftruncate(fd, memory)) {
+    if (truncate && ftruncate(fd, offset + memory)) {
         perror("ftruncate");
     }
 
@@ -1416,6 +1421,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     block->fd = fd;
+    block->fd_offset = offset;
     return area;
 }
 #endif
@@ -1889,7 +1895,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     size = HOST_PAGE_ALIGN(size);
     file_size = get_file_size(fd);
-    if (file_size > 0 && file_size < size) {
+    if (file_size > offset && file_size < (offset + size)) {
         error_setg(errp, "backing store size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
                    file_size, size);
@@ -1929,7 +1935,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
-                                   bool readonly, Error **errp)
+                                   off_t offset, bool readonly, Error **errp)
 {
     int fd;
     bool created;
@@ -1941,7 +1947,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, readonly, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset, readonly,
+                                   errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
@@ -2075,7 +2082,7 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                 flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
                 if (block->fd >= 0) {
                     area = mmap(vaddr, length, PROT_READ | PROT_WRITE,
-                                flags, block->fd, offset);
+                                flags, block->fd, offset + block->fd_offset);
                 } else {
                     flags |= MAP_ANONYMOUS;
                     area = mmap(vaddr, length, PROT_READ | PROT_WRITE,
-- 
2.40.1



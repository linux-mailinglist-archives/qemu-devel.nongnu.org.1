Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99D737567
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhOB-0000Np-5P; Tue, 20 Jun 2023 15:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO8-0000C7-El
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:40 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO2-0002kt-FS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:36 -0400
Received: from lenovo-t14s ([37.171.229.63]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybX9-1ptVk61r4P-00yy3R; Tue, 20 Jun 2023 21:50:59 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/2] memory: introduce memory_region_init_ram_protected()
Date: Tue, 20 Jun 2023 21:50:53 +0200
Message-ID: <20230620195054.23929-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620195054.23929-1-lvivier@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EJVtUpoY47Tr7eMNH5B198kRra5rIHZHGEi7gfSMIKUJ8lU0x7R
 uvEQJsgCr+6pMhJEL7j7LchcbjZTRw0j4pnpcOm6NDouC8XlmpjA4JSQaCxwRef64uo7Qpj
 zrAIX/2wW6RkloU+rDjpVCtA/EEyzybsxaJuJX7i1lMwp8P0ejHky4qFHeL96VKLpgmn/ma
 DBhS1LOGhMP1MT/AwGbYg==
UI-OutboundReport: notjunk:1;M01:P0:JM4QiIPumpA=;BeQSXh/bX+qcGjDQXYIp8BZXdTr
 S6dXU0odj8WncqxGeKp+/vwabvO6ZaZBphzjAqJm7osHMi0Gfec/HfTxgGX76KaI/p9g0M50y
 vhMv17daYLYE/4AU7lrcTFU9ptdu7OqDO/b1YgRpFSEjJdQMUGZT0D0DgYbq3N1+zqF8JzREI
 yaL+A/N4DPGwXfwZ0poI4CislwItV8Xi6MsDI2oq97e0voNXLU+AzLprZUzKc1pQL8BHw8Zy3
 Q1fHFZIaISZlVmAF5bIO7/rXXSy4EqlxwCDYFmDKTSlW+j59F7KfBZqcYzCSoR/PGxvyj3DVk
 595JKpX3cbIuwba3SL3Pz2/P3zLGmveunC9JGa8H4drtnB3ubS5+FTGiD4qr4e+HPhyxg1Vsy
 m49JNw3OlE/pJmsffAoZ/CJ7mYSG7OYzd0BjWu/w80z8EtsqgJ7p3LsFPcRIslgnNuUhBzpH1
 oy1kMKX7/rnCmQteSBYSKCVavzNvze3NpIYlSuRvvaaz7MkI8cHfl0YRBkqsVKn5LRmO/ztrA
 Y/hn3K8TkYqfsIPzjSZqUkQIW+HJho8W/V4ifnR0cIhAPUeLvRazu5dmdSQp1YscnmSm5evuK
 GoE1kc77d83R3aZAwvfauMPjZqwipIiaSKJ1YR7TzoiSsWfkBGMzBpEgtCS0O7PJ/k4btMMRg
 Go3Z4rJOzz7S3l/It3rI7RRQb/wCIFJ5NFOZQVguHQ==
Received-SPF: permerror client-ip=217.72.192.75;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Commit 56918a126a ("memory: Add RAM_PROTECTED flag to skip IOMMU mappings")
has introduced the RAM_PROTECTED flag to denote "protected" memory.

This flags is only used with qemu_ram_alloc_from_fd() for now.

To be able to register memory region with this flag, define
memory_region_init_ram_protected() and declare the flag as valid in
qemu_ram_alloc_internal() and qemu_ram_alloc().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/exec/memory.h | 33 +++++++++++++++++++++++++++++++++
 softmmu/memory.c      | 33 +++++++++++++++++++++++++++------
 softmmu/physmem.c     |  4 ++--
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 47c2e0221c35..d8760015c381 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1520,6 +1520,39 @@ void memory_region_init_iommu(void *_iommu_mr,
                               const char *name,
                               uint64_t size);
 
+/**
+ * memory_region_init_ram_protected - Initialize RAM memory region.  Accesses
+ *                                    into the region will modify memory
+ *                                    directly.
+ *
+ * The memory is created with the RAM_PROTECTED flag, for memory that
+ * looks and acts like RAM but inaccessible via normal mechanisms,
+ * including DMA.
+ *
+ * @mr: the #MemoryRegion to be initialized
+ * @owner: the object that tracks the region's reference count (must be
+ *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
+ * @name: name of the memory region
+ * @size: size of the region in bytes
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * This function allocates RAM for a board model or device, and
+ * arranges for it to be migrated (by calling vmstate_register_ram()
+ * if @owner is a DeviceState, or vmstate_register_ram_global() if
+ * @owner is NULL).
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ */
+void memory_region_init_ram_protected(MemoryRegion *mr,
+                                      Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp);
+
 /**
  * memory_region_init_ram - Initialize RAM memory region.  Accesses into the
  *                          region will modify memory directly.
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce7028..952c87277353 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3551,16 +3551,18 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-void memory_region_init_ram(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+static void memory_region_init_ram_flags(MemoryRegion *mr,
+                                         Object *owner,
+                                         const char *name,
+                                         uint64_t size,
+                                         uint32_t ram_flags,
+                                         Error **errp)
 {
     DeviceState *owner_dev;
     Error *err = NULL;
 
-    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
+    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, ram_flags,
+                                           &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -3575,6 +3577,25 @@ void memory_region_init_ram(MemoryRegion *mr,
     vmstate_register_ram(mr, owner_dev);
 }
 
+void memory_region_init_ram_protected(MemoryRegion *mr,
+                                      Object *owner,
+                                      const char *name,
+                                      uint64_t size,
+                                      Error **errp)
+{
+        memory_region_init_ram_flags(mr, owner, name, size, RAM_PROTECTED,
+                                     errp);
+}
+
+void memory_region_init_ram(MemoryRegion *mr,
+                            Object *owner,
+                            const char *name,
+                            uint64_t size,
+                            Error **errp)
+{
+        memory_region_init_ram_flags(mr, owner, name, size, 0, errp);
+}
+
 void memory_region_init_rom(MemoryRegion *mr,
                             Object *owner,
                             const char *name,
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6bdd944fe880..bf66c81e7255 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1978,7 +1978,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     Error *local_err = NULL;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE)) == 0);
+                          RAM_NORESERVE | RAM_PROTECTED)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
     size = HOST_PAGE_ALIGN(size);
@@ -2012,7 +2012,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_PROTECTED)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
-- 
2.41.0



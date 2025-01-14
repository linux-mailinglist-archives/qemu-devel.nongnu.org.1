Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21669A10D9C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 18:25:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkeK-0004m1-Ok; Tue, 14 Jan 2025 12:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeC-0004kb-J0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXke9-0004RI-KT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:11 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC1Jig021418;
 Tue, 14 Jan 2025 17:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=suvOzlC5rmbwSVpgbiHlcYi9rem2fvXpQ11p7DNzeB0=; b=
 lXxscgP6ZTOhe2FxziZipIr0Xn5UIvpq+6Tr/VKLCMdS15xO/eFjuMZQEsH5qyo9
 ELGGaXapdKKw2AjhBEAw1KHONPUigohzGJMAKEc3wVYxOEKb7TcplPXoByJHCvIA
 AhR/lVUO6rp/0Bj76YBFXfgpjFXuh/YN/yMN25HT4ZweupLVhiNqJN9jcOZQpsak
 vRnsUclZWE2cAwpUqnFOvyx4jYVsewyQ3VlVA552mpCKw580FC32cMNvA5IKJmAa
 PP4pR+chprm1iN4/mCka7+M1mSL62Drwhr1vurKbm3yzVZFOZx4BZktKMaZ2kZD8
 4Kd6q9vy9zaT+SIh/TM2gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcpc09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EFjJh7020272; Tue, 14 Jan 2025 17:24:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq65m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtXc013352;
 Tue, 14 Jan 2025 17:24:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-5; Tue, 14 Jan 2025 17:24:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 04/24] physmem: fd-based shared memory
Date: Tue, 14 Jan 2025 09:23:34 -0800
Message-Id: <1736875434-106563-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-GUID: d-Jlms5o0UUui1cff1sNOqPibz8PpQVP
X-Proofpoint-ORIG-GUID: d-Jlms5o0UUui1cff1sNOqPibz8PpQVP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor rather than using
MAP_ANON, so the memory can be accessed in another process by passing and
mmap'ing the fd.  This will allow CPR to support memory-backend-ram and
memory-backend-shm objects, provided the user creates them with share=on.

Use memfd_create if available because it has no constraints.  If not, use
POSIX shm_open.  However, allocation on the opened fd may fail if the shm
mount size is too small, even if the system has free memory, so for backwards
compatibility fall back to qemu_anon_ram_alloc/MAP_ANON on failure.

For backwards compatibility on Windows, always use MAP_ANON.  share=on has
no purpose there, but the syntax is accepted, and must continue to work.

Lastly, quietly fall back to MAP_ANON if the system does not support
qemu_ram_alloc_from_fd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c    | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 system/trace-events |  1 +
 util/memfd.c        | 16 ++++++++++++---
 3 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 4d13761..e435564 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -48,6 +48,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "system/dma.h"
@@ -1948,6 +1949,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
                                  bool grow,
                                  Error **errp)
 {
+    ERRP_GUARD();
     RAMBlock *new_block;
     Error *local_err = NULL;
     int64_t file_size, file_align;
@@ -2068,6 +2070,25 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 }
 #endif
 
+#ifdef CONFIG_POSIX
+/*
+ * Create MAP_SHARED RAMBlocks by mmap'ing a file descriptor, so it can be
+ * shared with another process if CPR is being used.  Use memfd if available
+ * because it has no size limits, else use POSIX shm.
+ */
+static int qemu_ram_get_shared_fd(const char *name, Error **errp)
+{
+    int fd;
+
+    if (qemu_memfd_check(0)) {
+        fd = qemu_memfd_create(name, 0, 0, 0, 0, errp);
+    } else {
+        fd = qemu_shm_alloc(0, errp);
+    }
+    return fd;
+}
+#endif
+
 static
 RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   qemu_ram_resize_cb resized,
@@ -2081,6 +2102,41 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
+    assert(max_size >= size);
+
+#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
+    if (!host) {
+        if (ram_flags & RAM_SHARED) {
+            const char *name = memory_region_name(mr);
+            int fd = qemu_ram_get_shared_fd(name, errp);
+
+            if (fd < 0) {
+                return NULL;
+            }
+
+            /* Use same alignment as qemu_anon_ram_alloc */
+            mr->align = QEMU_VMALLOC_ALIGN;
+
+            /*
+             * This can fail if the shm mount size is too small, or alloc from
+             * fd is not supported, but previous QEMU versions that called
+             * qemu_anon_ram_alloc for anonymous shared memory could have
+             * succeeded.  Quietly fail and fall back.
+             */
+            new_block = qemu_ram_alloc_from_fd(size, max_size, resized, mr,
+                                               ram_flags, fd, 0, false, NULL);
+            if (new_block) {
+                trace_qemu_ram_alloc_shared(name, new_block->used_length,
+                                            new_block->max_length, fd,
+                                            new_block->host);
+                return new_block;
+            }
+
+            close(fd);
+            /* fall back to anon allocation */
+        }
+    }
+#endif
 
     align = qemu_real_host_page_size();
     align = MAX(align, TARGET_PAGE_SIZE);
@@ -2092,7 +2148,6 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->resized = resized;
     new_block->used_length = size;
     new_block->max_length = max_size;
-    assert(max_size >= size);
     new_block->fd = -1;
     new_block->guest_memfd = -1;
     new_block->page_size = qemu_real_host_page_size();
diff --git a/system/trace-events b/system/trace-events
index 5bbc3fb..be12ebf 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -33,6 +33,7 @@ address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
diff --git a/util/memfd.c b/util/memfd.c
index 8a2e906..07beab1 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -194,17 +194,27 @@ bool qemu_memfd_alloc_check(void)
 /**
  * qemu_memfd_check():
  *
- * Check if host supports memfd.
+ * Check if host supports memfd.  Cache the answer for the common case flags=0.
  */
 bool qemu_memfd_check(unsigned int flags)
 {
 #ifdef CONFIG_LINUX
-    int mfd = memfd_create("test", flags | MFD_CLOEXEC);
+    int mfd;
+    static int memfd_check = MEMFD_TODO;
 
+    if (!flags && memfd_check != MEMFD_TODO) {
+        return memfd_check;
+    }
+
+    mfd = memfd_create("test", flags | MFD_CLOEXEC);
     if (mfd >= 0) {
         close(mfd);
-        return true;
     }
+    if (!flags) {
+        memfd_check = (mfd >= 0) ? MEMFD_OK : MEMFD_KO;
+    }
+    return (mfd >= 0);
+
 #endif
 
     return false;
-- 
1.8.3.1



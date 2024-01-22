Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1C836854
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:33:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwHc-000106-Ev; Mon, 22 Jan 2024 10:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHa-0000zf-Tp
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHW-0006sW-Kp
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MAZG7J008571; Mon, 22 Jan 2024 15:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=11ww8B8IFOmtIDARralUgn017Bo5hTfDvcm8UwiUJGc=;
 b=SS7Ukn3uGIHd0Q4EDXojITiis1hVArZj/ZcV9BOjoR6ejOU7eop5DxnHakFCN8lVppYq
 y+rzZoUldWwjj7SvUimLhSGEWYvg0WZYEzoJVO/0tciS/kemYpeJbcQuQlD4BcOaak3P
 4E631GAZ2fgw3HyeVw2z7iLmcqDVtYbXJKyD5/1TzCBI7ffj7ZSHQVGe3apjnVH0HZex
 2ZsRxV+PtSHW4u27dEu7ugTTSNpt4tJjxI5nZmvEkP4VUxPb3QUHrGimsFZvZoojzUPE
 1GxMAp6LhwjfCySV5S8xlkX5y4b/IuGalcJFxJ/FoeWNja2Q/D9v4122aEtD6/pLNSpr Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abuvkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40ME7XQl004207; Mon, 22 Jan 2024 15:32:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs32payu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:09 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MFRHlP010298;
 Mon, 22 Jan 2024 15:32:09 GMT
Received: from linux-3.us.oracle.com (dhcp-10-154-125-89.vpn.oracle.com
 [10.154.125.89])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vs32payn2-3; Mon, 22 Jan 2024 15:32:09 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v2 2/2] oslib-posix: initialize backend memory objects in
 parallel
Date: Mon, 22 Jan 2024 09:32:19 -0600
Message-Id: <20240122153219.2885749-3-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122153219.2885749-1-mark.kanda@oracle.com>
References: <20240122153219.2885749-1-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220106
X-Proofpoint-GUID: j9RvaoQuMGeq8RG0IJC8ju_wBAC6y11i
X-Proofpoint-ORIG-GUID: j9RvaoQuMGeq8RG0IJC8ju_wBAC6y11i
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

QEMU initializes preallocated backend memory as the objects are parsed from
the command line. This is not optimal in some cases (e.g. memory spanning
multiple NUMA nodes) because the memory objects are initialized in series.

Allow the initialization to occur in parallel. In order to ensure optimal
thread placement, parallel initialization requires prealloc context threads
to be in use.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
---
 backends/hostmem.c     |  8 ++++++--
 hw/virtio/virtio-mem.c |  4 ++--
 include/qemu/osdep.h   | 14 ++++++++++++--
 system/vl.c            |  6 ++++++
 util/oslib-posix.c     | 27 +++++++++++++++++----------
 util/oslib-win32.c     |  8 +++++++-
 6 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..8f602dc86f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
+#include "hw/qdev-core.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
@@ -235,9 +236,10 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         int fd = memory_region_get_fd(&backend->mr);
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
+        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
 
         if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
-                               backend->prealloc_context, errp)) {
+                               backend->prealloc_context, async, errp)) {
             return;
         }
         backend->prealloc = true;
@@ -323,6 +325,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
 
     if (!bc->alloc) {
         return;
@@ -398,7 +401,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
                                                 ptr, sz,
                                                 backend->prealloc_threads,
-                                                backend->prealloc_context, errp)) {
+                                                backend->prealloc_context,
+                                                async, errp)) {
         return;
     }
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 99ab989852..ffd119ebac 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         int fd = memory_region_get_fd(&vmem->memdev->mr);
         Error *local_err = NULL;
 
-        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
             static bool warned;
 
             /*
@@ -1248,7 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
     int fd = memory_region_get_fd(&vmem->memdev->mr);
     Error *local_err = NULL;
 
-    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
         error_report_err(local_err);
         return -ENOMEM;
     }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9a405bed89..d6e074c515 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -672,17 +672,27 @@ typedef struct ThreadContext ThreadContext;
  * @area: start address of the are to preallocate
  * @sz: the size of the area to preallocate
  * @max_threads: maximum number of threads to use
+ * @tc: prealloc context threads pointer, NULL if not in use
+ * @async: request asynchronous preallocation, requires @tc
  * @errp: returns an error if this function fails
  *
  * Preallocate memory (populate/prefault page tables writable) for the virtual
  * memory area starting at @area with the size of @sz. After a successful call,
  * each page in the area was faulted in writable at least once, for example,
- * after allocating file blocks for mapped files.
+ * after allocating file blocks for mapped files. When using @async,
+ * wait_mem_prealloc() is required to wait for the prealloction threads to
+ * terminate and associated cleanup.
  *
  * Return: true on success, else false setting @errp with error.
  */
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp);
+                       ThreadContext *tc, bool async, Error **errp);
+
+/**
+ * Wait for any outstanding memory prealloc initialization
+ * to complete.
+ */
+int wait_mem_prealloc(void);
 
 /**
  * qemu_get_pid_name:
diff --git a/system/vl.c b/system/vl.c
index 53850a1daf..5696c53ace 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2010,6 +2010,12 @@ static void qemu_create_late_backends(void)
 
     object_option_foreach_add(object_create_late);
 
+    /* Wait for any outstanding memory prealloc init to complete */
+    if (wait_mem_prealloc()) {
+        perror("memory preallocation failed");
+        exit(1);
+    }
+
     if (tpm_init() < 0) {
         exit(1);
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 26bf2f2883..72b17e4a1f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -417,7 +417,7 @@ static inline int get_memset_num_threads(size_t hpagesize, size_t numpages,
 }
 
 static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
-                           int max_threads, ThreadContext *tc,
+                           int max_threads, ThreadContext *tc, bool async,
                            bool use_madv_populate_write)
 {
     static gsize initialized = 0;
@@ -438,7 +438,7 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
 
     if (use_madv_populate_write) {
         /* Avoid creating a single thread for MADV_POPULATE_WRITE */
-        if (context->num_threads == 1) {
+        if (context->num_threads == 1 && !async) {
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
                 return -errno;
@@ -480,7 +480,7 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     return 0;
 }
 
-static int wait_mem_prealloc(void)
+int wait_mem_prealloc(void)
 {
     int i, ret = 0;
     MemsetContext *context, *next_context;
@@ -519,7 +519,7 @@ static bool madv_populate_write_possible(char *area, size_t pagesize)
 }
 
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
 {
     static gsize initialized;
     int ret;
@@ -561,7 +561,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     }
 
     /* touch pages simultaneously */
-    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc,
+    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc, async,
                           use_madv_populate_write);
     if (ret) {
         error_setg_errno(errp, -ret,
@@ -570,12 +570,19 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
         goto err;
     }
 
-    ret = wait_mem_prealloc();
-    if (ret) {
-        error_setg_errno(errp, -ret,
-                         "qemu_prealloc_mem: failed waiting for memory prealloc");
-        rv = false;
+    /*
+     * Async prealloc is only allowed when using MADV_POPULATE_WRITE and
+     * prealloc context (to ensure optimal thread placement).
+     */
+    if (!async || !use_madv_populate_write || !tc) {
+        ret = wait_mem_prealloc();
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                "qemu_prealloc_mem: failed waiting for memory prealloc");
+            rv = false;
+        }
     }
+
 err:
     if (!use_madv_populate_write) {
         ret = sigaction(SIGBUS, &sigbus_oldact, NULL);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c4a5f05a49..50284348e8 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -265,7 +265,7 @@ int getpagesize(void)
 }
 
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
 {
     int i;
     size_t pagesize = qemu_real_host_page_size();
@@ -278,6 +278,12 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     return true;
 }
 
+int wait_mem_prealloc(void)
+{
+    /* async prealloc not supported */
+    return 0;
+}
+
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
2.39.3



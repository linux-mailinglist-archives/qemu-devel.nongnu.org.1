Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AD726407
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uvv-0006LT-Nk; Wed, 07 Jun 2023 11:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6uvs-0006LA-39
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:18:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6uvq-00069J-5w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:18:43 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357Eb2be019428; Wed, 7 Jun 2023 15:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=GbIkksUVst8UxspLOjvwv+WpIqxFdS01YhCMvOSXJi0=;
 b=Ag70DhDJKMNKSdRo3Eoc00lNPU4hm64z6N5+wd+ATozOsvBQVI3Gx7h+ctsgwwwNhOHo
 UNzRxW1QHr0O2BQ9X2IRjrh2ebRP685d81Jl0ANB15Ps9p59iL2/V8+Y3fjMxYrxhGaA
 6GaG8pRjMlvwRNwKfuzOSSqWTpLCxw1QVpNo+wvycQ39L+ebcooT/x7lHEblRZZGL6RL
 XfO8O07X7QhQ+Xg40/uuVOAQFlAwwHlRWZNUJVH0outRMTeHFWAnEnsVVPJ5VvE1XJjt
 4X+AVLlCrjxwkPn34HqqAeIvh8rgliXJneoP/GhOgrgJNqVifZKYs9Tdl/XSbQ93Fp3s Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sj2yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:18:39 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357FHMw7037135; Wed, 7 Jun 2023 15:18:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6hck6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:18:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357FG55e036162;
 Wed, 7 Jun 2023 15:18:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r2a6hck5y-1; Wed, 07 Jun 2023 15:18:37 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3] memory: RAM_NAMED_FILE flag
Date: Wed,  7 Jun 2023 08:18:36 -0700
Message-Id: <1686151116-253260-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070130
X-Proofpoint-GUID: UcFRVgvalRrE9JA0PQ-otssSUFv2hAco
X-Proofpoint-ORIG-GUID: UcFRVgvalRrE9JA0PQ-otssSUFv2hAco
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

migrate_ignore_shared() is an optimization that avoids copying memory
that is visible and can be mapped on the target.  However, a
memory-backend-ram or a memory-backend-memfd block with the RAM_SHARED
flag set is not migrated when migrate_ignore_shared() is true.  This is
wrong, because the block has no named backing store, and its contents will
be lost.  To fix, ignore shared memory iff it is a named file.  Define a
new flag RAM_NAMED_FILE to distinguish this case.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-file.c   | 1 +
 include/exec/cpu-common.h | 1 +
 include/exec/memory.h     | 3 +++
 migration/ram.c           | 3 ++-
 qapi/migration.json       | 4 ++--
 softmmu/physmem.c         | 7 ++++++-
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 38ea65b..b4335a8 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -57,6 +57,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
+    ram_flags |= RAM_NAMED_FILE;
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                      backend->size, fb->align, ram_flags,
                                      fb->mem_path, fb->offset, fb->readonly,
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e5a55ed..87dc9a7 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -93,6 +93,7 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
 bool qemu_ram_is_migratable(RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_named_file(RAMBlock *rb);
 int qemu_ram_get_fd(RAMBlock *rb);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c3661b2..47c2e02 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -232,6 +232,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM that isn't accessible through normal means. */
 #define RAM_PROTECTED (1 << 8)
 
+/* RAM is an mmap-ed named file */
+#define RAM_NAMED_FILE (1 << 9)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/migration/ram.c b/migration/ram.c
index 88a6c82..cc98da3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -197,7 +197,8 @@ static bool postcopy_preempt_active(void)
 bool ramblock_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
-           (migrate_ignore_shared() && qemu_ram_is_shared(block));
+           (migrate_ignore_shared() && qemu_ram_is_shared(block) &&
+            qemu_ram_is_named_file(block));
 }
 
 #undef RAMBLOCK_FOREACH
diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c..5bb5ab8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -465,8 +465,8 @@
 #     block devices (and thus take locks) immediately at the end of
 #     migration.  (since 3.0)
 #
-# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
-#     (since 4.0)
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory that is
+#     accessible on the destination machine. (since 4.0)
 #
 # @validate-uuid: Send the UUID of the source to allow the destination
 #     to ensure it is the same.  (since 4.2)
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 9d7e172..a8f742a 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1570,6 +1570,11 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
+bool qemu_ram_is_named_file(RAMBlock *rb)
+{
+    return rb->flags & RAM_NAMED_FILE;
+}
+
 int qemu_ram_get_fd(RAMBlock *rb)
 {
     return rb->fd;
@@ -1880,7 +1885,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
-                          RAM_PROTECTED)) == 0);
+                          RAM_PROTECTED | RAM_NAMED_FILE)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
-- 
1.8.3.1



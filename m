Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DBA44E5D
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 22:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn287-0003wo-TP; Tue, 25 Feb 2025 16:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tn284-0003w8-KB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:06:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tn280-0005DT-2J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:06:12 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXeUb007885;
 Tue, 25 Feb 2025 21:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=a6dbZwfY
 B5m9xHSsJzgk0Ss1P7iIA2o9uR/X5lMQK2s=; b=cwGdJSfP3s0EbT777aGIHfWP
 2dKrR8JsUo0sWyG/Ub+YZtJbN3N+sXtMjrYTg+NPsduthCRf9yjD3vNIOjK4US1l
 KTdzrJ/O4psiQ5guh1xoSz5VwHJwsepEuXkJq8eXvBrlXC6IiH1MpO/h9PS+/Ncd
 oDMJdHNHuWMnZ4/UhZM2rRl6d8sApQFbgY1KQVrrGLT4SDBE7H1n9X1IVmOBnBCW
 dGvtKL/kqsbKU2FsA3UO5Uv9mWmzfhUiXzELOZBLUI5P8Qs2gBepErYZ/zobGMb8
 Q17RfhKps+Jq+h/3HPZkbb6QzX8YUgTm3icRRw9IYZfNqxBhIKUdlsYbEOz/HQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bpa1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 21:06:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51PKGiUl012522; Tue, 25 Feb 2025 21:06:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51b2p16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 21:06:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PL64Ot019500;
 Tue, 25 Feb 2025 21:06:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44y51b2p0n-1; Tue, 25 Feb 2025 21:06:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4] migration: ram block cpr blockers
Date: Tue, 25 Feb 2025 13:06:03 -0800
Message-Id: <1740517563-245516-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_07,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250126
X-Proofpoint-ORIG-GUID: SjPIWOQF_8DktFRrL69FelCNBtq5dyJR
X-Proofpoint-GUID: SjPIWOQF_8DktFRrL69FelCNBtq5dyJR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
in the migration stream file and recreate them later, because the physical
memory for the blocks is pinned and registered for vfio.  Add a blocker
for volatile ram blocks.

Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
sufficient for CPR, but it has not been tested yet.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h   |  3 +++
 include/exec/ramblock.h |  1 +
 migration/savevm.c      |  2 ++
 system/physmem.c        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9f73b59..ea5d33a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3184,6 +3184,9 @@ bool ram_block_discard_is_disabled(void);
  */
 bool ram_block_discard_is_required(void);
 
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
+void ram_block_del_cpr_blocker(RAMBlock *rb);
+
 #endif
 
 #endif
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd10..64484cd 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -39,6 +39,7 @@ struct RAMBlock {
     /* RCU-enabled, writes protected by the ramlist lock */
     QLIST_ENTRY(RAMBlock) next;
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
+    Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
     int guest_memfd;
diff --git a/migration/savevm.c b/migration/savevm.c
index bc375db..85a3559 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3315,12 +3315,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
     qemu_ram_set_idstr(mr->ram_block,
                        memory_region_name(mr), dev);
     qemu_ram_set_migratable(mr->ram_block);
+    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
 }
 
 void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_unset_idstr(mr->ram_block);
     qemu_ram_unset_migratable(mr->ram_block);
+    ram_block_del_cpr_blocker(mr->ram_block);
 }
 
 void vmstate_register_ram_global(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 67c9db9..4ffa977 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -70,7 +70,10 @@
 
 #include "qemu/pmem.h"
 
+#include "qapi/qapi-types-migration.h"
+#include "migration/blocker.h"
 #include "migration/cpr.h"
+#include "migration/options.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1899,6 +1902,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        error_setg(&new_block->cpr_blocker,
+                   "Memory region %s uses guest_memfd, "
+                   "which is not supported with CPR.",
+                   memory_region_name(new_block->mr));
+        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
+                                  MIG_MODE_CPR_TRANSFER,
+                                  -1);
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
@@ -4059,3 +4070,60 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+/*
+ * Return true if ram is compatible with CPR.  Do not exclude rom,
+ * because the rom file could change in new QEMU.
+ */
+static bool ram_is_cpr_compatible(RAMBlock *rb)
+{
+    MemoryRegion *mr = rb->mr;
+
+    if (!mr || !memory_region_is_ram(mr)) {
+        return true;
+    }
+
+    /* Ram device is remapped in new QEMU */
+    if (memory_region_is_ram_device(mr)) {
+        return true;
+    }
+
+    /* Named files are remapped in new QEMU, same contents if shared (no COW) */
+    if (qemu_ram_is_shared(rb) && qemu_ram_is_named_file(rb)) {
+        return true;
+    }
+
+    /* A file descriptor is remapped in new QEMU */
+    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
+        return true;
+    }
+
+    return false;
+}
+
+/*
+ * Add a blocker for each volatile ram block.  This function should only be
+ * called after we know that the block is migratable.  Non-migratable blocks
+ * are either re-created in new QEMU, or are handled specially, or are covered
+ * by a device-level CPR blocker.
+ */
+void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
+{
+    assert(qemu_ram_is_migratable(rb));
+
+    if (ram_is_cpr_compatible(rb)) {
+        return;
+    }
+
+    error_setg(&rb->cpr_blocker,
+               "Memory region %s is not compatible with CPR. share=on is "
+               "required for memory-backend objects, and aux-ram-share=on is "
+               "required.", memory_region_name(rb->mr));
+    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
+                              -1);
+}
+
+void ram_block_del_cpr_blocker(RAMBlock *rb)
+{
+    migrate_del_blocker(&rb->cpr_blocker);
+}
-- 
1.8.3.1



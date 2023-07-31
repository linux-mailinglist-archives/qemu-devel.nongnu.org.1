Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A014769CA0
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpr-0003nb-VL; Mon, 31 Jul 2023 12:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpp-0003gs-6V
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:29 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpn-0001LE-9j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821207; x=1722357207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/dXf+igjdEHFljunA6/Y/7Okg+auCCSxG402x9zxZbs=;
 b=RiduMP4j0YOV5jpgr8ue4G6PeyuCb52e54o0WeVQAxGM4lm7tDFFI5oM
 g6eu5gh6kVRLfs7NtyiP6BIk0gJo1c9LrfRxJnV7Reirz57A2IMHkgDrM
 RN9ls/Xq5g5fk3t+IIBYdiWVFFtkN97FMIdGL+YsZ3oCg9qEXs3s7NSPn
 rRgVr3RTl+QktlPk6lSCSvtaeWrlJkFE8Q2exJ4wz2aSVd/rNuaO7m3XK
 9IZt1jUPLDTBZahFAc6sKyFBD35QuGCl8wQSWZCSQR9YfhsNIaUbhHOmn
 JTPPYaayyFePXL1yEpC2kPyIwsnaJJq6ptZAnloHQk2u1OUS/3uQG2Gcn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993558"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984310"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984310"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:52 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 14/19] physmem: Add ram_block_convert_range
Date: Mon, 31 Jul 2023 12:21:56 -0400
Message-Id: <20230731162201.271114-15-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Chao Peng <chao.p.peng@linux.intel.com>

This new routine adds support for memory conversion between
shared/private memory for gmem fd based private ram_block.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/cpu-common.h |  2 ++
 softmmu/physmem.c         | 61 ++++++++++++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c9a..558684b9f246 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -157,6 +157,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private);
 
 #endif
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 05c981e5c18e..2acc8bee5b33 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3415,15 +3415,9 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
-/*
- * Unmap pages of memory from start to start+length such that
- * they a) read as 0, b) Trigger whatever fault mechanism
- * the OS provides for postcopy.
- * The pages must be unmapped by the end of the function.
- * Returns: 0 on success, none-0 on failure
- *
- */
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+static int ram_block_discard_range_fd(RAMBlock *rb, uint64_t start,
+                                      size_t length, int fd)
+
 {
     int ret = -1;
 
@@ -3449,8 +3443,8 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
-        need_fallocate = rb->fd != -1;
+        need_madvise = (rb->page_size == qemu_host_page_size) && (rb->fd == fd);
+        need_fallocate = fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
              * if read, and for hugetlbfs also causes it to be unmapped
@@ -3475,7 +3469,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                                  " users of the file", __func__);
             }
 
-            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+            ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                             start, length);
             if (ret) {
                 ret = -errno;
@@ -3498,7 +3492,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * fallocate'd away).
              */
 #if defined(CONFIG_MADVISE)
-            if (qemu_ram_is_shared(rb) && rb->fd < 0) {
+            if (qemu_ram_is_shared(rb) && fd < 0) {
                 ret = madvise(host_startaddr, length, QEMU_MADV_REMOVE);
             } else {
                 ret = madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
@@ -3528,6 +3522,20 @@ err:
     return ret;
 }
 
+/*
+ * Unmap pages of memory from start to start+length such that
+ * they a) read as 0, b) Trigger whatever fault mechanism
+ * the OS provides for postcopy.
+ *
+ * The pages must be unmapped by the end of the function.
+ * Returns: 0 on success, none-0 on failure.
+ */
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+{
+    return ram_block_discard_range_fd(rb, start, length, rb->fd);
+}
+
+
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
@@ -3715,3 +3723,30 @@ bool ram_block_discard_is_required(void)
     return qatomic_read(&ram_block_discard_required_cnt) ||
            qatomic_read(&ram_block_coordinated_discard_required_cnt);
 }
+
+int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
+                            bool shared_to_private)
+{
+    int fd;
+
+    if (!rb || rb->gmem_fd < 0) {
+        return -1;
+    }
+
+    if (!QEMU_PTR_IS_ALIGNED(start, rb->page_size) ||
+        !QEMU_PTR_IS_ALIGNED(length, rb->page_size)) {
+        return -1;
+    }
+
+    if (length > rb->max_length) {
+        return -1;
+    }
+
+    if (shared_to_private) {
+        fd = rb->fd;
+    } else {
+        fd = rb->gmem_fd;
+    }
+
+    return ram_block_discard_range_fd(rb, start, length, fd);
+}
-- 
2.34.1



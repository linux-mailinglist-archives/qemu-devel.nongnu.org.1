Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8215769C99
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVpp-0003eE-1N; Mon, 31 Jul 2023 12:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpm-0003Yl-Q9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:26 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpl-0001LE-39
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821205; x=1722357205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FHpLYKCG5XsNyQYsZISCBt3MZkpY6KPjFJu1ItFTkyA=;
 b=a2ousdTPz5cyzqLX2Kf/mt8GmxZiowoOXqxLNarwW1RqnTtADoUyCDam
 hQryEwp3EZ3A85NGklJBu1rWPULzuXBhitC/2DKtEHkM0n90+4ruMsAXz
 lAFCqzm4+eRwbrFwzXMl+LrZXBCyy6QUBlMTFOjtg/ylWu2lNgZJ9/V9k
 4RBtwTGmbGkONfUTk30XcB6sqrTcB1lQmbFvneFVY2ABuYbE1tKarm86V
 Jka3PRE5szIFVUBYZLIzc5P2FDS/v9jXHtY3rOJFQGV5FXbNtuG7MBjUe
 qrt49/o/a0O/LNs7KuT2l1Cpb9OVsyF+jNaj9xOm3RXMmUfj+rkeGQ00W A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993543"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993543"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984304"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984304"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:47 -0700
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
Subject: [RFC PATCH 13/19] physmem: replace function name with __func__ in
 ram_block_discard_range()
Date: Mon, 31 Jul 2023 12:21:55 -0400
Message-Id: <20230731162201.271114-14-xiaoyao.li@intel.com>
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

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 softmmu/physmem.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 8f64128de0b5..05c981e5c18e 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3430,16 +3430,15 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
     uint8_t *host_startaddr = rb->host + start;
 
     if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
-        error_report("ram_block_discard_range: Unaligned start address: %p",
-                     host_startaddr);
+        error_report("%s: Unaligned start address: %p",
+                     __func__, host_startaddr);
         goto err;
     }
 
     if ((start + length) <= rb->max_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
-            error_report("ram_block_discard_range: Unaligned length: %zx",
-                         length);
+            error_report("%s: Unaligned length: %zx", __func__, length);
             goto err;
         }
 
@@ -3469,27 +3468,26 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * file.
              */
             if (!qemu_ram_is_shared(rb)) {
-                warn_report_once("ram_block_discard_range: Discarding RAM"
+                warn_report_once("%s: Discarding RAM"
                                  " in private file mappings is possibly"
                                  " dangerous, because it will modify the"
                                  " underlying file and will affect other"
-                                 " users of the file");
+                                 " users of the file", __func__);
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                             start, length);
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to fallocate "
-                             "%s:%" PRIx64 " +%zx (%d)",
-                             rb->idstr, start, length, ret);
+                error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
+                             __func__, rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: fallocate not available/file"
+            error_report("%s: fallocate not available/file"
                          "%s:%" PRIx64 " +%zx (%d)",
-                         rb->idstr, start, length, ret);
+                         __func__, rb->idstr, start, length, ret);
             goto err;
 #endif
         }
@@ -3507,25 +3505,23 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to discard range "
+                error_report("%s: Failed to discard range "
                              "%s:%" PRIx64 " +%zx (%d)",
-                             rb->idstr, start, length, ret);
+                             __func__, rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: MADVISE not available"
-                         "%s:%" PRIx64 " +%zx (%d)",
-                         rb->idstr, start, length, ret);
+            error_report("%s: MADVISE not available %s:%" PRIx64 " +%zx (%d)",
+                         __func__, rb->idstr, start, length, ret);
             goto err;
 #endif
         }
         trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
                                       need_madvise, need_fallocate, ret);
     } else {
-        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
-                     "/%zx/" RAM_ADDR_FMT")",
-                     rb->idstr, start, length, rb->max_length);
+        error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
+                     __func__, rb->idstr, start, length, rb->max_length);
     }
 
 err:
-- 
2.34.1



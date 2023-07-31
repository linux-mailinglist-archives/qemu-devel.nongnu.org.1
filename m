Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8E769C92
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVox-0001hq-FK; Mon, 31 Jul 2023 12:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVou-0001X4-0I
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:32 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVos-00010F-5e
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821150; x=1722357150;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dRjJnplBZqshOVUlL2HsM+HSmg8sekLwwBqcDcf81FM=;
 b=fOrEadhRE86wgCpGRZRyVUhFrje3JG/3VHuE2f4iRWB5TcfoIv4iLdhG
 ossGRNJg0d/OwDapI9b4piTXvqcZ/elf1BQKb0OBncWB74SXNnNIQIcEH
 jslVOGUE2vD/n97xb8uy4tSMoMN0XIcwN3lc42tXlOZyGIp8ALA64xEge
 vTnAEfzO6M1ecb3g1LEwQ63WOxKuzpsfmIhIEUHsvxYsz+oDRv+vB3r+Y
 EICjdOZOGWU93k7ZOMQHIFqAwWd292PCv8UyJqBcDYVaRgx7Tppjxpn9+
 eZ1er4dgPIowDo8U09YWC5b+/KA4J+cx0mBIEF00j+cLXu/QcZu4naPih w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993396"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984045"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984045"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:01 -0700
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
Subject: [RFC PATCH 03/19] RAMBlock: Support KVM gmemory
Date: Mon, 31 Jul 2023 12:21:45 -0400
Message-Id: <20230731162201.271114-4-xiaoyao.li@intel.com>
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

Add KVM gmem support to RAMBlock so we can have both normal
hva based memory and gmem fd based memory in one RAMBlock.

The gmem part is represented by the gmem_fd.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/exec/memory.h   | 8 ++++++++
 include/exec/ramblock.h | 1 +
 softmmu/memory.c        | 9 +++++++++
 softmmu/physmem.c       | 2 ++
 4 files changed, 20 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc9e..61e31c7b9874 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1376,6 +1376,14 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     int fd,
                                     ram_addr_t offset,
                                     Error **errp);
+/**
+ * memory_region_set_gmem_fd:  Set RAM memory region with a restricted fd.
+ *
+ * @mr: the #MemoryRegion to be set.
+ * @fd: the fd to provide restricted memory.
+ */
+void memory_region_set_gmem_fd(MemoryRegion *mr, int fd);
+
 #endif
 
 /**
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 69c6a5390293..0d158b3909c9 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -41,6 +41,7 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     uint64_t fd_offset;
+    int gmem_fd;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce7028..4f8f8c0a02e6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1661,6 +1661,15 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
         error_propagate(errp, err);
     }
 }
+
+void memory_region_set_gmem_fd(MemoryRegion *mr, int fd)
+{
+    if (mr->ram_block) {
+        assert(fd >= 0);
+        mr->ram_block->gmem_fd = fd;
+    }
+}
+
 #endif
 
 void memory_region_init_ram_ptr(MemoryRegion *mr,
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1fe..8f64128de0b5 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1920,6 +1920,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
+    new_block->gmem_fd = -1;
     new_block->host = file_ram_alloc(new_block, size, fd, readonly,
                                      !file_size, offset, errp);
     if (!new_block->host) {
@@ -1990,6 +1991,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
+    new_block->gmem_fd = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A873721A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeZU-0003aR-F0; Tue, 20 Jun 2023 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZP-0003ZE-8Y
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:07 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZN-00054S-KH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687279865; x=1718815865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZGYds0W9a52MmZEls/WsrzhjgIIBAfJQiVVeEQy7Yn8=;
 b=MK0otCkaWlmq6mBe73BhSKvQ27lMm6yRnDTb/ZrXh7k9brFthHvYJzWj
 CZf6QGQZjzkGG1afeIkPg/hC9pqu4xuR1WV5mvLgYSVm5NgofzLMuTz6p
 qtD5fzVwIdeIiihdOZaLxYgkZMwcb8BTk6y4/y3U+oA4UHPHcnF//D4T4
 J0/VbH6TlO/rM7e1qOzE+c/0yBpgqpQTzXcDcdWpsQQZbBqP8Zd1YvQbH
 vkEkjJD18xTgcaazt3qU6ddosoa3UH6rbUi4XH3Gwr81seTbZWL+OI3yp
 tMOZ3By18j9ZB1RQ5sqbNglExY9PEInzEY+0mSQ/JwJtkSsFfvyPWvzSu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389218035"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="389218035"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691499960"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="691499960"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:55 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 2/3] exec/memory: Add symbol for memory listener priority for
 dev backend
Date: Tue, 20 Jun 2023 09:50:48 -0700
Message-Id: <8314d91688030d7004e96958f12e2c83fb889245.1687279702.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687279702.git.isaku.yamahata@intel.com>
References: <cover.1687279702.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=isaku.yamahata@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add MEMORY_LISTNER_PRIORITY_DEV_BAKCNED for the symbolic value for memory
listener to replace the hard-coded value 10 for the device backend.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 accel/kvm/kvm-all.c               | 2 +-
 hw/remote/proxy-memory-listener.c | 2 +-
 hw/virtio/vhost.c                 | 2 +-
 include/exec/memory.h             | 1 +
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 36ed4ca246b5..ae6ecf8326d1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1800,7 +1800,7 @@ static MemoryListener kvm_io_listener = {
     .name = "kvm-io",
     .eventfd_add = kvm_io_ioeventfd_add,
     .eventfd_del = kvm_io_ioeventfd_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_DEV_BAKCNED,
 };
 
 int kvm_set_irq(KVMState *s, int irq, int level)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index 18d96a1d04dc..a7f53a0ba464 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -217,7 +217,7 @@ void proxy_memory_listener_configure(ProxyMemoryListener *proxy_listener,
     proxy_listener->listener.commit = proxy_memory_listener_commit;
     proxy_listener->listener.region_add = proxy_memory_listener_region_addnop;
     proxy_listener->listener.region_nop = proxy_memory_listener_region_addnop;
-    proxy_listener->listener.priority = 10;
+    proxy_listener->listener.priority = MEMORY_LISTENER_PRIORITY_DEV_BAKCNED;
     proxy_listener->listener.name = "proxy";
 
     memory_listener_register(&proxy_listener->listener,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23da579ce290..75f7418369cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1445,7 +1445,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .log_sync = vhost_log_sync,
         .log_global_start = vhost_log_global_start,
         .log_global_stop = vhost_log_global_stop,
-        .priority = 10
+        .priority = MEMORY_LISTENER_PRIORITY_DEV_BAKCNED
     };
 
     hdev->iommu_listener = (MemoryListener) {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6d95d5917544..5c9e04bf1208 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -812,6 +812,7 @@ struct IOMMUMemoryRegion {
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
+#define MEMORY_LISTENER_PRIORITY_DEV_BAKCNED    10
 
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
-- 
2.25.1



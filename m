Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA8079A55B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbsg-0001JJ-64; Mon, 11 Sep 2023 04:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsV-0001FO-3e; Mon, 11 Sep 2023 04:02:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsQ-00027X-Q5; Mon, 11 Sep 2023 04:02:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29C9120AF0;
 Mon, 11 Sep 2023 11:02:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 725E627245;
 Mon, 11 Sep 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 3680128 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 03/51] memory: prevent dma-reentracy issues
Date: Mon, 11 Sep 2023 11:01:54 +0300
Message-Id: <20230911080225.3680068-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexander Bulekov <alxndr@bu.edu>

Add a flag to the DeviceState, when a device is engaged in PIO/MMIO/DMA.
This flag is set/checked prior to calling a device's MemoryRegion
handlers, and set when device code initiates DMA.  The purpose of this
flag is to prevent two types of DMA-based reentrancy issues:

1.) mmio -> dma -> mmio case
2.) bh -> dma write -> mmio case

These issues have led to problems such as stack-exhaustion and
use-after-frees.

Summary of the problem from Peter Maydell:
https://lore.kernel.org/qemu-devel/CAFEAcA_23vc7hE3iaM-JVA6W38LK4hJoWae5KcknhPRD5fPBZA@mail.gmail.com

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/62
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/540
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/541
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/556
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/557
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/827
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1282
Resolves: CVE-2023-0330

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230427211013.2994127-2-alxndr@bu.edu>
[thuth: Replace warn_report() with warn_report_once()]
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit a2e1753b8054344f32cf94f31c6399a58794a380)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 91f8a2395a..124628ada4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -741,6 +741,8 @@ struct MemoryRegion {
     bool is_iommu;
     RAMBlock *ram_block;
     Object *owner;
+    /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
+    DeviceState *dev;
 
     const MemoryRegionOps *ops;
     void *opaque;
@@ -765,6 +767,9 @@ struct MemoryRegion {
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
     RamDiscardManager *rdm; /* Only for RAM */
+
+    /* For devices designed to perform re-entrant IO into their own IO MRs */
+    bool disable_reentrancy_guard;
 };
 
 struct IOMMUMemoryRegion {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 785dd5a56e..886f6bb79e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -162,6 +162,10 @@ struct NamedClockList {
     QLIST_ENTRY(NamedClockList) node;
 };
 
+typedef struct {
+    bool engaged_in_io;
+} MemReentrancyGuard;
+
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
@@ -194,6 +198,9 @@ struct DeviceState {
     int alias_required_for_version;
     ResettableState reset;
     GSList *unplug_blockers;
+
+    /* Is the device currently in mmio/pio/dma? Used to prevent re-entrancy */
+    MemReentrancyGuard mem_reentrancy_guard;
 };
 
 struct DeviceListener {
diff --git a/softmmu/memory.c b/softmmu/memory.c
index bc0be3f62c..61569f8306 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -542,6 +542,18 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         access_size_max = 4;
     }
 
+    /* Do not allow more than one simultaneous access to a device's IO Regions */
+    if (mr->dev && !mr->disable_reentrancy_guard &&
+        !mr->ram_device && !mr->ram && !mr->rom_device && !mr->readonly) {
+        if (mr->dev->mem_reentrancy_guard.engaged_in_io) {
+            warn_report_once("Blocked re-entrant IO on MemoryRegion: "
+                             "%s at addr: 0x%" HWADDR_PRIX,
+                             memory_region_name(mr), addr);
+            return MEMTX_ACCESS_ERROR;
+        }
+        mr->dev->mem_reentrancy_guard.engaged_in_io = true;
+    }
+
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
@@ -556,6 +568,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
                         access_mask, attrs);
         }
     }
+    if (mr->dev) {
+        mr->dev->mem_reentrancy_guard.engaged_in_io = false;
+    }
     return r;
 }
 
@@ -1170,6 +1185,7 @@ static void memory_region_do_init(MemoryRegion *mr,
     }
     mr->name = g_strdup(name);
     mr->owner = owner;
+    mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
     mr->ram_block = NULL;
 
     if (name) {
-- 
2.39.2



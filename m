Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B47708D9
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0KG-0005oe-2Q; Fri, 04 Aug 2023 15:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0KD-0005Zo-EF; Fri, 04 Aug 2023 15:19:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0KB-0007DU-DW; Fri, 04 Aug 2023 15:19:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B2D951846D;
 Fri,  4 Aug 2023 22:17:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 41EE21B8B0;
 Fri,  4 Aug 2023 22:16:55 +0300 (MSK)
Received: (nullmailer pid 1875769 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 59/63] hw/i386/intel_iommu: Fix endianness problems
 related to VTD_IR_TableEntry
Date: Fri,  4 Aug 2023 22:16:42 +0300
Message-Id: <20230804191647.1875608-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

The code already tries to do some endianness handling here, but
currently fails badly:
- While it already swaps the data when logging errors / tracing, it fails
  to byteswap the value before e.g. accessing entry->irte.present
- entry->irte.source_id is swapped with le32_to_cpu(), though this is
  a 16-bit value
- The whole union is apparently supposed to be swapped via the 64-bit
  data[2] array, but the struct is a mixture between 32 bit values
  (the first 8 bytes) and 64 bit values (the second 8 bytes), so this
  cannot work as expected.

Fix it by converting the struct to two proper 64-bit bitfields, and
by swapping the values only once for everybody right after reading
the data from memory.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-3-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 642ba89672279fbdd14016a90da239c85e845d18)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 255a881ad0..03becd6384 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3327,14 +3327,15 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         return -VTD_FR_IR_ROOT_INVAL;
     }
 
-    trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+    entry->data[0] = le64_to_cpu(entry->data[0]);
+    entry->data[1] = le64_to_cpu(entry->data[1]);
+
+    trace_vtd_ir_irte_get(index, entry->data[1], entry->data[0]);
 
     if (!entry->irte.present) {
         error_report_once("%s: detected non-present IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
-                          __func__, index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+                          __func__, index, entry->data[1], entry->data[0]);
         return -VTD_FR_IR_ENTRY_P;
     }
 
@@ -3342,14 +3343,13 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         entry->irte.__reserved_2) {
         error_report_once("%s: detected non-zero reserved IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
-                          __func__, index, le64_to_cpu(entry->data[1]),
-                          le64_to_cpu(entry->data[0]));
+                          __func__, index, entry->data[1], entry->data[0]);
         return -VTD_FR_IR_IRTE_RSVD;
     }
 
     if (sid != X86_IOMMU_SID_INVALID) {
         /* Validate IRTE SID */
-        source_id = le32_to_cpu(entry->irte.source_id);
+        source_id = entry->irte.source_id;
         switch (entry->irte.sid_vtype) {
         case VTD_SVT_NONE:
             break;
@@ -3403,7 +3403,7 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
     irq->trigger_mode = irte.irte.trigger_mode;
     irq->vector = irte.irte.vector;
     irq->delivery_mode = irte.irte.delivery_mode;
-    irq->dest = le32_to_cpu(irte.irte.dest_id);
+    irq->dest = irte.irte.dest_id;
     if (!iommu->intr_eime) {
 #define  VTD_IR_APIC_DEST_MASK         (0xff00ULL)
 #define  VTD_IR_APIC_DEST_SHIFT        (8)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 89dcbc5e1e..7fa0a695c8 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -178,37 +178,39 @@ enum {
 union VTD_IR_TableEntry {
     struct {
 #if HOST_BIG_ENDIAN
-        uint32_t __reserved_1:8;     /* Reserved 1 */
-        uint32_t vector:8;           /* Interrupt Vector */
-        uint32_t irte_mode:1;        /* IRTE Mode */
-        uint32_t __reserved_0:3;     /* Reserved 0 */
-        uint32_t __avail:4;          /* Available spaces for software */
-        uint32_t delivery_mode:3;    /* Delivery Mode */
-        uint32_t trigger_mode:1;     /* Trigger Mode */
-        uint32_t redir_hint:1;       /* Redirection Hint */
-        uint32_t dest_mode:1;        /* Destination Mode */
-        uint32_t fault_disable:1;    /* Fault Processing Disable */
-        uint32_t present:1;          /* Whether entry present/available */
+        uint64_t dest_id:32;         /* Destination ID */
+        uint64_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t vector:8;           /* Interrupt Vector */
+        uint64_t irte_mode:1;        /* IRTE Mode */
+        uint64_t __reserved_0:3;     /* Reserved 0 */
+        uint64_t __avail:4;          /* Available spaces for software */
+        uint64_t delivery_mode:3;    /* Delivery Mode */
+        uint64_t trigger_mode:1;     /* Trigger Mode */
+        uint64_t redir_hint:1;       /* Redirection Hint */
+        uint64_t dest_mode:1;        /* Destination Mode */
+        uint64_t fault_disable:1;    /* Fault Processing Disable */
+        uint64_t present:1;          /* Whether entry present/available */
 #else
-        uint32_t present:1;          /* Whether entry present/available */
-        uint32_t fault_disable:1;    /* Fault Processing Disable */
-        uint32_t dest_mode:1;        /* Destination Mode */
-        uint32_t redir_hint:1;       /* Redirection Hint */
-        uint32_t trigger_mode:1;     /* Trigger Mode */
-        uint32_t delivery_mode:3;    /* Delivery Mode */
-        uint32_t __avail:4;          /* Available spaces for software */
-        uint32_t __reserved_0:3;     /* Reserved 0 */
-        uint32_t irte_mode:1;        /* IRTE Mode */
-        uint32_t vector:8;           /* Interrupt Vector */
-        uint32_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t present:1;          /* Whether entry present/available */
+        uint64_t fault_disable:1;    /* Fault Processing Disable */
+        uint64_t dest_mode:1;        /* Destination Mode */
+        uint64_t redir_hint:1;       /* Redirection Hint */
+        uint64_t trigger_mode:1;     /* Trigger Mode */
+        uint64_t delivery_mode:3;    /* Delivery Mode */
+        uint64_t __avail:4;          /* Available spaces for software */
+        uint64_t __reserved_0:3;     /* Reserved 0 */
+        uint64_t irte_mode:1;        /* IRTE Mode */
+        uint64_t vector:8;           /* Interrupt Vector */
+        uint64_t __reserved_1:8;     /* Reserved 1 */
+        uint64_t dest_id:32;         /* Destination ID */
 #endif
-        uint32_t dest_id;            /* Destination ID */
-        uint16_t source_id;          /* Source-ID */
 #if HOST_BIG_ENDIAN
         uint64_t __reserved_2:44;    /* Reserved 2 */
         uint64_t sid_vtype:2;        /* Source-ID Validation Type */
         uint64_t sid_q:2;            /* Source-ID Qualifier */
+        uint64_t source_id:16;       /* Source-ID */
 #else
+        uint64_t source_id:16;       /* Source-ID */
         uint64_t sid_q:2;            /* Source-ID Qualifier */
         uint64_t sid_vtype:2;        /* Source-ID Validation Type */
         uint64_t __reserved_2:44;    /* Reserved 2 */
-- 
2.39.2



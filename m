Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4976C97B
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 11:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR89v-0001kh-BU; Wed, 02 Aug 2023 05:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qR89t-0001fF-GD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qR89r-0001Ur-Pa
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690968522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qp0I8Mq2UmQQnUcgjrid3l8HRykFuudzEVVkqv05p/0=;
 b=Ib5mBGzqLHIHLpyz7D19xZ2qCT+YkW8d8hbxHYfNMqPpalmL05SFeDzS9K3fHXWmY5ADnk
 Xb9O8vEfEAJ8+TIi8g57wm9VhqHROKvHlcyIq/vAH2EvXFcv4Q1w/GBh/8D+f9ub+Qlp9Q
 uwb/6kj8i+TmxKjsHMG/xEgg4iKw+gY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-6ffQvTSWNR-U6zRdURao0g-1; Wed, 02 Aug 2023 05:28:41 -0400
X-MC-Unique: 6ffQvTSWNR-U6zRdURao0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D21888D541;
 Wed,  2 Aug 2023 09:28:40 +0000 (UTC)
Received: from thuth.com (dhcp-192-205.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77A9C1121325;
 Wed,  2 Aug 2023 09:28:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
Date: Wed,  2 Aug 2023 11:28:37 +0200
Message-Id: <20230802092837.153689-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 Note: There are more endianness issues in the code, I haven't figured
       out all of them yet, Linux fails to boot in the guest when I use
       this device on a s390x host. But I wanted to publish this patch
       now already since this should also fix the "issue" with the Clang
       ms_struct packing that we recently discussed on the mailing list.

 include/hw/i386/intel_iommu.h | 50 ++++++++++++++++++-----------------
 hw/i386/intel_iommu.c         | 16 +++++------
 2 files changed, 34 insertions(+), 32 deletions(-)

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
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b9b629d1b1..3ca71df369 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3328,14 +3328,15 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
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
 
@@ -3343,14 +3344,13 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
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
@@ -3404,7 +3404,7 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
     irq->trigger_mode = irte.irte.trigger_mode;
     irq->vector = irte.irte.vector;
     irq->delivery_mode = irte.irte.delivery_mode;
-    irq->dest = le32_to_cpu(irte.irte.dest_id);
+    irq->dest = irte.irte.dest_id;
     if (!iommu->intr_eime) {
 #define  VTD_IR_APIC_DEST_MASK         (0xff00ULL)
 #define  VTD_IR_APIC_DEST_SHIFT        (8)
-- 
2.39.3



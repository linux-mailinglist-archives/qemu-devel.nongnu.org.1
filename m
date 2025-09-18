Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4211BB20276
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 10:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulOKM-000453-UA; Mon, 11 Aug 2025 04:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1ulOKE-00043x-6O
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:56:15 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1ulOK8-0003Vp-6S
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 04:56:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0pMm3BLrz6M57w;
 Mon, 11 Aug 2025 16:53:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 016F41404C4;
 Mon, 11 Aug 2025 16:55:51 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.146.213) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 10:55:50 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>, 
 <jonathan.cameron@huawei.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v6 4/8] hw/cxl/events: Updates for rev3.2 DRAM event record
Date: Mon, 11 Aug 2025 09:55:26 +0100
Message-ID: <20250811085530.2263-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250811085530.2263-1-shiju.jose@huawei.com>
References: <20250811085530.2263-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.213]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev3.2 section 8.2.10.2.1.2 Table 8-58, DRAM event record
has updated with following new fields.
1. Component Identifier
2. Sub-channel of the memory event location
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Volatile Memory Error Count at Event
5. Memory Event Sub-Type

Add updates for the above spec changes in the CXL DRAM event
reporting and QMP command to inject DRAM event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 42 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  7 +++++++
 include/hw/cxl/cxl_events.h |  9 ++++++--
 qapi/cxl.json               | 21 ++++++++++++++++++-
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1a8ca533fa..c359a8b65c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1783,6 +1783,13 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_ROW                              BIT(5)
 #define CXL_DRAM_VALID_COLUMN                           BIT(6)
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+#define CXL_DRAM_VALID_COMPONENT                        BIT(8)
+#define CXL_DRAM_VALID_COMPONENT_ID_FORMAT              BIT(9)
+#define CXL_DRAM_VALID_SUB_CHANNEL                      BIT(10)
+
+#define CXL_DRAM_EV_DESC_UCE                            BIT(0)
+#define CXL_DRAM_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_DRAM_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                uint32_t flags,
@@ -1802,6 +1809,12 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm, bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1888,6 +1901,35 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
         valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
     }
 
+    if (component_id) {
+        strncpy((char *)dram.component_id, component_id,
+                sizeof(dram.component_id) - 1);
+        valid_flags |= CXL_DRAM_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_DRAM_VALID_COMPONENT_ID_FORMAT;
+        }
+    }
+
+    if (has_sub_channel) {
+        dram.sub_channel = sub_channel;
+        valid_flags |= CXL_DRAM_VALID_SUB_CHANNEL;
+    }
+
+    if (has_cme_ev_flags) {
+        dram.cme_ev_flags = cme_ev_flags;
+    } else {
+        dram.cme_ev_flags = 0;
+    }
+
+    if (has_cvme_count) {
+        descriptor |= CXL_DRAM_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(dram.cvme_count, cvme_count);
+    } else {
+        st24_le_p(dram.cvme_count, 0);
+    }
+
+    dram.sub_type = sub_type;
+
     stw_le_p(&dram.validity_flags, valid_flags);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 2047e97846..231dda263f 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -53,6 +53,13 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
                                bool has_column, uint16_t column,
                                bool has_correction_mask,
                                uint64List *correction_mask,
+                               const char *component_id,
+                               bool has_comp_id_pldm,
+                               bool is_comp_id_pldm,
+                               bool has_sub_channel, uint8_t sub_channel,
+                               bool has_cme_ev_flags, uint8_t cme_ev_flags,
+                               bool has_cvme_count, uint32_t cvme_count,
+                               uint8_t sub_type,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 352f9891bd..a3c5f2ec20 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -138,7 +138,7 @@ typedef struct CXLEventGenMedia {
 
 /*
  * DRAM Event Record
- * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
+ * CXL r3.2 Section 8.2.10.2.1.2: Table 8-58
  * All fields little endian.
  */
 typedef struct CXLEventDram {
@@ -156,7 +156,12 @@ typedef struct CXLEventDram {
     uint8_t row[3];
     uint16_t column;
     uint64_t correction_mask[4];
-    uint8_t reserved[0x17];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    uint8_t cme_ev_flags;
+    uint8_t cvme_count[3];
+    uint8_t sub_type;
+    uint8_t reserved;
 } QEMU_PACKED CXLEventDram;
 
 /*
diff --git a/qapi/cxl.json b/qapi/cxl.json
index a245632f92..c2f8b03224 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -166,6 +166,21 @@
 # @correction-mask: Bits within each nibble.  Used in order of bits
 #     set in the nibble-mask.  Up to 4 nibbles may be covered.
 #
+# @component-id: Device specific component identifier for the event.
+#     May describe a field replaceable sub-component of the device.
+#
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @sub-channel: The sub-channel of the memory event location.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cvme-count: Corrected volatile memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLDRAMEvent',
@@ -174,7 +189,11 @@
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
             '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
-            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ],
+            '*component-id': 'str', '*is-comp-id-pldm':'bool',
+            '*sub-channel':'uint8',
+            '*cme-ev-flags':'uint8', '*cvme-count':'uint32',
+            'sub-type':'uint8'
            }}
 
 ##
-- 
2.43.0



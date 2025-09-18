Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2990BB1DAF7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Aug 2025 17:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2nc-0005OA-6p; Thu, 07 Aug 2025 11:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2n3-0005DL-0B
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:35 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uk2n0-0003zY-9v
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:44:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4byWcp1vPNz6DB5D;
 Thu,  7 Aug 2025 23:42:18 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 08B64140277;
 Thu,  7 Aug 2025 23:44:07 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.37) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Aug 2025 17:44:06 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>, 
 <jonathan.cameron@huawei.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v5 2/7] hw/cxl/events: Updates for rev3.2 general media event
 record
Date: Thu, 7 Aug 2025 16:43:41 +0100
Message-ID: <20250807154346.2209-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250807154346.2209-1-shiju.jose@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.37]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CXL spec rev3.2 section 8.2.10.2.1.1 Table 8-57, general media event
table has updated with following new fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type
4. Support for component ID in the PLDM format.

Add updates for the above spec changes in the CXL general media event
reporting and QMP command to inject general media event.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  6 ++++++
 include/hw/cxl/cxl_events.h |  7 +++++--
 qapi/cxl.json               | 15 ++++++++++++++-
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index aa6e5c1a08..1a8ca533fa 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1646,6 +1646,11 @@ static const QemuUUID memory_module_uuid = {
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
 #define CXL_GMER_VALID_COMPONENT                        BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT              BIT(4)
+
+#define CXL_GMER_EV_DESC_UCE                            BIT(0)
+#define CXL_GMER_EV_DESC_THRESHOLD_EVENT                BIT(1)
+#define CXL_GMER_EV_DESC_POISON_LIST_OVERFLOW_EVENT     BIT(2)
 
 static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
 {
@@ -1677,6 +1682,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1737,10 +1748,28 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         strncpy((char *)gem.component_id, component_id,
                 sizeof(gem.component_id) - 1);
         valid_flags |= CXL_GMER_VALID_COMPONENT;
+        if (has_comp_id_pldm && is_comp_id_pldm) {
+            valid_flags |= CXL_GMER_VALID_COMPONENT_ID_FORMAT;
+        }
     }
 
     stw_le_p(&gem.validity_flags, valid_flags);
 
+    if (has_cme_ev_flags) {
+        gem.cme_ev_flags = cme_ev_flags;
+    } else {
+        gem.cme_ev_flags = 0;
+    }
+
+    if (has_cme_count) {
+        descriptor |= CXL_GMER_EV_DESC_THRESHOLD_EVENT;
+        st24_le_p(gem.cme_count, cme_count);
+    } else {
+        st24_le_p(gem.cme_count, 0);
+    }
+
+    gem.sub_type = sub_type;
+
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 91b1478114..2047e97846 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -27,6 +27,12 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         bool has_rank, uint8_t rank,
                                         bool has_device, uint32_t device,
                                         const char *component_id,
+                                        bool has_comp_id_pldm,
+                                        bool is_comp_id_pldm,
+                                        bool has_cme_ev_flags,
+                                        uint8_t cme_ev_flags,
+                                        bool has_cme_count, uint32_t cme_count,
+                                        uint8_t sub_type,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4d9cfdb621..352f9891bd 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -115,10 +115,10 @@ typedef struct CXLEventInterruptPolicy {
 
 /*
  * General Media Event Record
- * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
+ * CXL r3.2 Section 8.2.10.2.1.1; Table 8-57
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
-#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x29
 typedef struct CXLEventGenMedia {
     CXLEventRecordHdr hdr;
     uint64_t phys_addr;
@@ -130,6 +130,9 @@ typedef struct CXLEventGenMedia {
     uint8_t rank;
     uint8_t device[3];
     uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t cme_ev_flags;
+    uint8_t cme_count[3];
+    uint8_t sub_type;
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
diff --git a/qapi/cxl.json b/qapi/cxl.json
index a9a1d99de3..4655169735 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -90,6 +90,16 @@
 # @component-id: Device specific component identifier for the event.
 #     May describe a field replaceable sub-component of the device.
 #
+# @is-comp-id-pldm: This flag specifies whether the device-specific
+#     component identifier format follows PLDM.
+#
+# @cme-ev-flags: Advanced programmable corrected memory error
+#     threshold event flags.
+#
+# @cme-count: Corrected memory error count at event.
+#
+# @sub-type: Memory event sub-type.
+#
 # Since: 8.1
 ##
 { 'struct': 'CXLGeneralMediaEvent',
@@ -97,7 +107,10 @@
   'data': { 'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
-            '*device': 'uint32', '*component-id': 'str' } }
+            '*device': 'uint32', '*component-id': 'str',
+            '*is-comp-id-pldm':'bool',
+            '*cme-ev-flags':'uint8', '*cme-count':'uint32',
+            'sub-type':'uint8' } }
 
 ##
 # @cxl-inject-general-media-event:
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD9AF5E0C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 18:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzyT-0000FT-7W; Wed, 02 Jul 2025 12:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzyG-0000AH-Bc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:06:06 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzyD-00082p-0N
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:06:04 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPrB3WMfz6L5XD;
 Thu,  3 Jul 2025 00:05:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C9AA51404FF;
 Thu,  3 Jul 2025 00:05:56 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 18:05:56 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Date: Wed, 2 Jul 2025 17:02:13 +0100
Message-ID: <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  6 +--
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 96ef9be444..76af75d2d0 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..a05d7cb5b7 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,5 +16,10 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bf1710b251..1fc453f70d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -121,6 +121,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3390,6 +3391,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
+static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    struct {
+        uint8_t reg_id;
+        uint8_t rsvd[3];
+        uint64_t block_sz;
+        uint8_t flags;
+        uint8_t rsvd2[3];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
+     * This command shall fail with Unsupported when the Sanitize on Release
+     * field does not match the region’s configuration... and the device
+     * does not support reconfiguration of the Sanitize on Release setting.
+     *
+     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
+     * doesn't match.
+     */
+    if ((in->flags & 0x1) != (region->flags & 0x1)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->reg_id >= DCD_MAX_NUM_REGION) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that no extents are in the region being reconfigured */
+    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that new block size is supported */
+    if (!test_bit(BIT((int) log2(in->block_sz)),
+                  &region->supported_blk_size_bitmask)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* Return success if new block size == current block size */
+    if (in->block_sz == region->block_size) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    /* Free bitmap and create new one for new block size. */
+    qemu_mutex_lock(&region->bitmap_lock);
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+    qemu_mutex_unlock(&region->bitmap_lock);
+    region->block_size = in->block_sz;
+
+    /* Create event record and insert into event log */
+    cxl_assign_event_header(&dcEvent.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(dcEvent),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    dcEvent.validity_flags = 1;
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_DYNAMIC_CAP,
+                         (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3508,6 +3587,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0 },
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0 },
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b872a26173..ee554a77be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
-                                    const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
-- 
2.48.1



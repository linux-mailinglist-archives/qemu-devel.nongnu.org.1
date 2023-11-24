Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7887F75C3
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6WdD-0002Uv-Ic; Fri, 24 Nov 2023 08:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1r6Wd8-0002Oj-P3
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:54:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1r6Wd5-00016V-3U
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:54:02 -0500
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ScGcy3JCgz6K9Cs;
 Fri, 24 Nov 2023 21:52:18 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 13:53:45 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Date: Fri, 24 Nov 2023 21:53:36 +0800
Message-ID: <20231124135338.1191-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231124135338.1191-1-shiju.jose@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle. The patrol scrub control allows the request to
configure patrol scrub input configurations.

The patrol scrub control allows the requester to specify the number of
hours for which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1bbc9a48a6..5a6f4e4029 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {
 } QEMU_PACKED CXLSupportedFeatureEntry;
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_MAX
 };
 
@@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
     CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
 };
 
+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
+static const QemuUUID patrol_scrub_uuid = {
+    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
+};
+
+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
+
+/* CXL memdev patrol scrub control attributes */
+struct CXLMemPatrolScrubReadAttrbs {
+        uint8_t scrub_cycle_cap;
+        uint16_t scrub_cycle;
+        uint8_t scrub_flags;
+} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
+
+typedef struct CXLMemPatrolScrubWriteAttrbs {
+    uint8_t scrub_cycle_hr;
+    uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
+
+typedef struct CXLMemPatrolScrubSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemPatrolScrubWriteAttrbs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
+
 /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     uint16_t feat_entries = 0;
 
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     }
     req_entries = (get_feats_in->count -
@@ -884,6 +916,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     entry = 0;
     while (entry < req_entries) {
         switch (index) {
+        case  CXL_FEATURE_PATROL_SCRUB:
+            /* Fill supported feature entry for device patrol scrub control */
+            get_feats_out->feat_entries[entry] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = patrol_scrub_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
+                /* Bit[0] : 1, feature attributes changeable */
+                .attrb_flags = 0x1,
+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+            /* Set default value for device patrol scrub read attributes */
+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
+                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
+                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
+            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
+            break;
         default:
             break;
         }
@@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
+        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
+                                             get_feature->offset;
+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
+                               get_feature->count : bytes_to_copy;
+        memcpy(payload_out,
+               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
+    CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
+
+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ps_set_feature = (void *)payload_in;
+        ps_write_attrbs = &ps_set_feature->feat_data;
+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
+                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
+        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
+        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
+                          ps_write_attrbs->scrub_flags & 0x1;
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     return CXL_MBOX_SUCCESS;
 }
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D47DAF5DF7
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 18:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzvX-0002z7-8E; Wed, 02 Jul 2025 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzvG-0002xz-7F
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:02:59 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uWzvE-0007JH-5z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:02:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPjn6H2Zz6L5ZN;
 Wed,  2 Jul 2025 23:59:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7BB5C1402F4;
 Thu,  3 Jul 2025 00:02:51 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 18:02:51 +0200
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 01/11] hw/cxl: fix DC extent capacity tracking
Date: Wed, 2 Jul 2025 17:02:07 +0100
Message-ID: <20250702160219.989731-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
extents in different states including added, pending, etc.

Before the change, for the in-device extent number tracking purpose, we only
have "total_extent_count" defined, which only tracks the number of
extents accepted. However, we need to track number of extents in other
states also, for now it is extents pending-to-add.

To fix that, we introduce a new counter for dynamic capacity
"nr_extents_accepted" which explicitly tracks number of the extents
accepted by the hosts, and fix "total_extent_count" to include
both accepted and pending extents counting.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  3 ++-
 hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
 hw/mem/cxl_type3.c          |  1 +
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ed6cd50c67..a151e19da8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -618,6 +618,7 @@ struct CXLType3Dev {
         CXLDCExtentList extents;
         CXLDCExtentGroupList extents_pending;
         uint32_t total_extent_count;
+        uint32_t nr_extents_accepted;
         uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
@@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
                                                     uint16_t shared_seq);
 void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
                                        CXLDCExtentGroup *group);
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
 void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                  uint64_t len);
 void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 299f232f26..0b615ea37a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     uint16_t out_pl_len, size;
     CXLDCExtent *ent;
 
-    if (start_extent_id > ct3d->dc.total_extent_count) {
+    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
 
     stl_le_p(&out->count, record_count);
-    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
     stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
 
     if (record_count > 0) {
@@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
     QTAILQ_INSERT_TAIL(list, group, node);
 }
 
-void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
+uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group = QTAILQ_FIRST(list);
+    uint32_t extents_deleted = 0;
 
     QTAILQ_REMOVE(list, group, node);
     QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
         cxl_remove_extent_from_extent_list(&group->list, ent);
+        extents_deleted++;
     }
     g_free(group);
+
+    return extents_deleted;
 }
 
 /*
@@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLUpdateDCExtentListInPl *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
-    uint32_t i;
+    uint32_t i, num;
     uint64_t dpa, len;
     CXLRetCode ret;
 
@@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     }
 
     if (in->num_entries_updated == 0) {
-        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+        ct3d->dc.total_extent_count -= num;
         return CXL_MBOX_SUCCESS;
     }
 
@@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
+        ct3d->dc.nr_extents_accepted += 1;
         ct3_set_region_block_backed(ct3d, dpa, len);
     }
     /* Remove the first extent group in the pending list */
-    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
+    ct3d->dc.total_extent_count -= num;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -3160,7 +3167,7 @@ free_and_exit:
         }
         *updated_list_size = 0;
     } else {
-        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
+        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
     }
 
     return ret;
@@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
         ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
         cxl_remove_extent_from_extent_list(&updated_list, ent);
     }
-    ct3d->dc.total_extent_count = updated_list_size;
+    ct3d->dc.total_extent_count += (updated_list_size -
+                                    ct3d->dc.nr_extents_accepted);
+
+    ct3d->dc.nr_extents_accepted = updated_list_size;
 
     return CXL_MBOX_SUCCESS;
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 94e7274912..f283178d88 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     }
     if (group) {
         cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
+        dcd->dc.total_extent_count += num_extents;
     }
 
     /*
-- 
2.48.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0651928868
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 14:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhkE-0000w9-0W; Fri, 05 Jul 2024 08:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhkA-0000sy-Rk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:08:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhk8-0003tu-AI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:08:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsjG3Xxzz6HJcc;
 Fri,  5 Jul 2024 20:08:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A694A140A30;
 Fri,  5 Jul 2024 20:08:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:08:46 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Date: Fri, 5 Jul 2024 13:06:43 +0100
Message-ID: <20240705120643.959422-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
References: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

Iterate over the list keeping the output payload size into account,
returning the results from a previous scan media operation. The
scan media operation does not fail prematurely due to device being
out of storage, so this implementation does not deal with the
retry/restart functionality.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230908073152.4386-5-dave@stgolabs.net
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Tweak - update references to point to CXL r3.1 given lack of
easy availability of r3.0.
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 85 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0509d961c3..cc98553583 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -499,6 +499,7 @@ struct CXLType3Dev {
     /* Poison Injection - backup */
     CXLPoisonList poison_list_bkp;
     CXLPoisonList scan_media_results;
+    bool scan_media_hasrun;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e3d3575b02..e87089474a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -85,6 +85,7 @@ enum {
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
         #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1346,6 +1347,8 @@ static void __do_scan_media(CXLType3Dev *ct3d)
         ct3d->poison_list_cnt == results_cnt) {
         cxl_clear_poison_list_overflowed(ct3d);
     }
+    /* scan media has run since last conventional reset */
+    ct3d->scan_media_hasrun = true;
 }
 
 /*
@@ -1450,6 +1453,85 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.4.6: Get Scan Media Results
+ */
+static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct get_scan_media_results_out_pl {
+        uint64_t dpa_restart;
+        uint64_t length;
+        uint8_t flags;
+        uint8_t rsvd1;
+        uint16_t count;
+        uint8_t rsvd2[0xc];
+        struct {
+            uint64_t addr;
+            uint32_t length;
+            uint32_t resv;
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_scan_media_results_out_pl *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLPoisonList *scan_media_results = &ct3d->scan_media_results;
+    CXLPoison *ent, *next;
+    uint16_t total_count = 0, record_count = 0, i = 0;
+    uint16_t out_pl_len;
+
+    if (!ct3d->scan_media_hasrun) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /*
+     * Calculate limits, all entries are within the same address range of the
+     * last scan media call.
+     */
+    QLIST_FOREACH(ent, scan_media_results, node) {
+        size_t rec_size = record_count * sizeof(out->records[0]);
+
+        if (sizeof(*out) + rec_size < CXL_MAILBOX_MAX_PAYLOAD_SIZE) {
+            record_count++;
+        }
+        total_count++;
+    }
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    QLIST_FOREACH_SAFE(ent, scan_media_results, node, next) {
+        uint64_t start, stop;
+
+        if (i == record_count) {
+            break;
+        }
+
+        start = ROUND_DOWN(ent->start, 64ull);
+        stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
+        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
+        i++;
+
+        /* consume the returning entry */
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    stw_le_p(&out->count, record_count);
+    if (total_count > record_count) {
+        out->flags = (1 << 0); /* More Media Error Records */
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 /*
  * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
  * (Opcode: 4800h)
@@ -2067,6 +2149,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
         cmd_media_scan_media, 17, BACKGROUND_OPERATION },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
+        "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
+        cmd_media_get_scan_media_results, 0, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447570C17F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16ty-0007TK-FO; Mon, 22 May 2023 10:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q16tn-0007P6-Qh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:52:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q16tl-0000kn-OP
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:52:35 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ0g55vYmz6J6Xr;
 Mon, 22 May 2023 22:48:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:52:31 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric
 Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Subject: [PATCH v7 4/4] hw/cxl: Add clear poison mailbox command support.
Date: Mon, 22 May 2023 15:50:29 +0100
Message-ID: <20230522145029.6370-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522145029.6370-1-Jonathan.Cameron@huawei.com>
References: <20230522145029.6370-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Current implementation is very simple so many of the corner
cases do not exist (e.g. fragmenting larger poison list entries)

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7:  Use definition instead of 64.
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 37 +++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 32c234ea91..73328a52cf 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -298,6 +298,7 @@ struct CXLType3Class {
                         uint64_t offset);
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
+    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 };
 
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6c476ad7f4..e3401b6be8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -65,6 +65,7 @@ enum {
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -512,6 +513,85 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len_unused)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    struct clear_poison_pl {
+        uint64_t dpa;
+        uint8_t data[64];
+    };
+    CXLPoison *ent;
+    uint64_t dpa;
+
+    struct clear_poison_pl *in = (void *)cmd->payload;
+
+    dpa = ldq_le_p(&in->dpa);
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /* Clearing a region with no poison is not an error so always do so */
+    if (cvc->set_cacheline) {
+        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+    }
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        /*
+         * Test for contained in entry. Simpler than general case
+         * as clearing 64 bytes and entries 64 byte aligned
+         */
+        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
+            break;
+        }
+    }
+    if (!ent) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    QLIST_REMOVE(ent, node);
+    ct3d->poison_list_cnt--;
+
+    if (dpa > ent->start) {
+        CXLPoison *frag;
+        /* Cannot overflow as replacing existing entry */
+
+        frag = g_new0(CXLPoison, 1);
+
+        frag->start = ent->start;
+        frag->length = dpa - ent->start;
+        frag->type = ent->type;
+
+        QLIST_INSERT_HEAD(poison_list, frag, node);
+        ct3d->poison_list_cnt++;
+    }
+
+    if (dpa + CXL_CACHE_LINE_SIZE < ent->start + ent->length) {
+        CXLPoison *frag;
+
+        if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+            cxl_set_poison_list_overflowed(ct3d);
+        } else {
+            frag = g_new0(CXLPoison, 1);
+
+            frag->start = dpa + CXL_CACHE_LINE_SIZE;
+            frag->length = ent->start + ent->length - frag->start;
+            frag->type = ent->type;
+            QLIST_INSERT_HEAD(poison_list, frag, node);
+            ct3d->poison_list_cnt++;
+        }
+    }
+    /* Any fragments have been added, free original entry */
+    g_free(ent);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -543,6 +623,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
         cmd_media_inject_poison, 8, 0 },
+    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
+        cmd_media_clear_poison, 72, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ab600735eb..d751803188 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
      */
 }
 
+static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace *as;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
+
+    if (!vmr && !pmr) {
+        return false;
+    }
+
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+        return false;
+    }
+
+    if (vmr) {
+        if (dpa_offset < memory_region_size(vmr)) {
+            as = &ct3d->hostvmem_as;
+        } else {
+            as = &ct3d->hostpmem_as;
+            dpa_offset -= memory_region_size(vmr);
+        }
+    } else {
+        as = &ct3d->hostpmem_as;
+    }
+
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+                        CXL_CACHE_LINE_SIZE);
+    return true;
+}
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
 {
         ct3d->poison_list_overflowed = true;
@@ -1168,6 +1204,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
+    cvc->set_cacheline = set_cacheline;
 }
 
 static const TypeInfo ct3d_info = {
-- 
2.39.2



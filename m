Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB430797B74
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJYj-0002lT-Bi; Thu, 07 Sep 2023 14:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYg-0002k9-9m
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJYa-0005rS-10
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694110600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTs5Z3x6mFaNjZuqkr8tBEpT8govuyyCToVdW0jv/j0=;
 b=dDObo8YXRif0fFlbaPS74ui8nMd6YdsLJpjZudRAQXP2XVFvowQHqauO4QYqE+8RG8K6Xy
 hMu3qFY93+4RbnRNwGNFt1/5XBcC7jhLLFRZeQtmevIT9s9YEZAdZ6YEgX4iqn4wtiQoeP
 eZuzCcBfXEIiFk5vkzqWLYjJkWHHNEM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-O9EqS-MrN5K0xLGeAyDsTA-1; Thu, 07 Sep 2023 14:16:38 -0400
X-MC-Unique: O9EqS-MrN5K0xLGeAyDsTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39CC429AB458;
 Thu,  7 Sep 2023 18:16:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C21A403171;
 Thu,  7 Sep 2023 18:16:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/5] hw/ufs: Support for Query Transfer Requests
Date: Thu,  7 Sep 2023 14:16:26 -0400
Message-ID: <20230907181628.1594401-4-stefanha@redhat.com>
In-Reply-To: <20230907181628.1594401-1-stefanha@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

This commit makes the UFS device support query
and nop out transfer requests.

The next patch would be support for UFS logical
unit and scsi command transfer request.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: ff7a5f0fd26761936a553ffb89d3df0ba62844e9.1693980783.git.jeuk20.kim@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/ufs/ufs.h        |  46 +++
 hw/ufs/ufs.c        | 988 +++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/trace-events |   1 +
 3 files changed, 1033 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index d9d195caec..3d1b2cff4e 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -18,6 +18,32 @@
 #define UFS_MAX_LUS 32
 #define UFS_BLOCK_SIZE 4096
 
+typedef enum UfsRequestState {
+    UFS_REQUEST_IDLE = 0,
+    UFS_REQUEST_READY = 1,
+    UFS_REQUEST_RUNNING = 2,
+    UFS_REQUEST_COMPLETE = 3,
+    UFS_REQUEST_ERROR = 4,
+} UfsRequestState;
+
+typedef enum UfsReqResult {
+    UFS_REQUEST_SUCCESS = 0,
+    UFS_REQUEST_FAIL = 1,
+} UfsReqResult;
+
+typedef struct UfsRequest {
+    struct UfsHc *hc;
+    UfsRequestState state;
+    int slot;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuReq req_upiu;
+    UtpUpiuRsp rsp_upiu;
+
+    /* for scsi command */
+    QEMUSGList *sg;
+} UfsRequest;
+
 typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
@@ -30,6 +56,12 @@ typedef struct UfsHc {
     UfsReg reg;
     UfsParams params;
     uint32_t reg_size;
+    UfsRequest *req_list;
+
+    DeviceDescriptor device_desc;
+    GeometryDescriptor geometry_desc;
+    Attributes attributes;
+    Flags flags;
 
     qemu_irq irq;
     QEMUBH *doorbell_bh;
@@ -39,4 +71,18 @@ typedef struct UfsHc {
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
+typedef enum UfsQueryFlagPerm {
+    UFS_QUERY_FLAG_NONE = 0x0,
+    UFS_QUERY_FLAG_READ = 0x1,
+    UFS_QUERY_FLAG_SET = 0x2,
+    UFS_QUERY_FLAG_CLEAR = 0x4,
+    UFS_QUERY_FLAG_TOGGLE = 0x8,
+} UfsQueryFlagPerm;
+
+typedef enum UfsQueryAttrPerm {
+    UFS_QUERY_ATTR_NONE = 0x0,
+    UFS_QUERY_ATTR_READ = 0x1,
+    UFS_QUERY_ATTR_WRITE = 0x2,
+} UfsQueryAttrPerm;
+
 #endif /* HW_UFS_UFS_H */
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index df87f2a6d5..56a8ec286b 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -15,10 +15,221 @@
 #include "ufs.h"
 
 /* The QEMU-UFS device follows spec version 3.1 */
-#define UFS_SPEC_VER 0x00000310
+#define UFS_SPEC_VER 0x0310
 #define UFS_MAX_NUTRS 32
 #define UFS_MAX_NUTMRS 8
 
+static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
+{
+    hwaddr hi = addr + size - 1;
+
+    if (hi < addr) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    if (!FIELD_EX32(u->reg.cap, CAP, 64AS) && (hi >> 32)) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
+}
+
+static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
+                                  int size)
+{
+    hwaddr hi = addr + size - 1;
+    if (hi < addr) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    if (!FIELD_EX32(u->reg.cap, CAP, 64AS) && (hi >> 32)) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
+}
+
+static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
+
+static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
+{
+    hwaddr utrl_base_addr = (((hwaddr)u->reg.utrlbau) << 32) + u->reg.utrlba;
+    hwaddr utrd_addr = utrl_base_addr + slot * sizeof(UtpTransferReqDesc);
+
+    return utrd_addr;
+}
+
+static inline hwaddr ufs_get_req_upiu_base_addr(const UtpTransferReqDesc *utrd)
+{
+    uint32_t cmd_desc_base_addr_lo =
+        le32_to_cpu(utrd->command_desc_base_addr_lo);
+    uint32_t cmd_desc_base_addr_hi =
+        le32_to_cpu(utrd->command_desc_base_addr_hi);
+
+    return (((hwaddr)cmd_desc_base_addr_hi) << 32) + cmd_desc_base_addr_lo;
+}
+
+static inline hwaddr ufs_get_rsp_upiu_base_addr(const UtpTransferReqDesc *utrd)
+{
+    hwaddr req_upiu_base_addr = ufs_get_req_upiu_base_addr(utrd);
+    uint32_t rsp_upiu_byte_off =
+        le16_to_cpu(utrd->response_upiu_offset) * sizeof(uint32_t);
+    return req_upiu_base_addr + rsp_upiu_byte_off;
+}
+
+static MemTxResult ufs_dma_read_utrd(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    hwaddr utrd_addr = ufs_get_utrd_addr(u, req->slot);
+    MemTxResult ret;
+
+    ret = ufs_addr_read(u, utrd_addr, &req->utrd, sizeof(req->utrd));
+    if (ret) {
+        trace_ufs_err_dma_read_utrd(req->slot, utrd_addr);
+    }
+    return ret;
+}
+
+static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    hwaddr req_upiu_base_addr = ufs_get_req_upiu_base_addr(&req->utrd);
+    UtpUpiuReq *req_upiu = &req->req_upiu;
+    uint32_t copy_size;
+    uint16_t data_segment_length;
+    MemTxResult ret;
+
+    /*
+     * To know the size of the req_upiu, we need to read the
+     * data_segment_length in the header first.
+     */
+    ret = ufs_addr_read(u, req_upiu_base_addr, &req_upiu->header,
+                        sizeof(UtpUpiuHeader));
+    if (ret) {
+        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
+        return ret;
+    }
+    data_segment_length = be16_to_cpu(req_upiu->header.data_segment_length);
+
+    copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
+                data_segment_length;
+
+    ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
+    if (ret) {
+        trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
+    }
+    return ret;
+}
+
+static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    uint16_t prdt_len = le16_to_cpu(req->utrd.prd_table_length);
+    uint16_t prdt_byte_off =
+        le16_to_cpu(req->utrd.prd_table_offset) * sizeof(uint32_t);
+    uint32_t prdt_size = prdt_len * sizeof(UfshcdSgEntry);
+    g_autofree UfshcdSgEntry *prd_entries = NULL;
+    hwaddr req_upiu_base_addr, prdt_base_addr;
+    int err;
+
+    assert(!req->sg);
+
+    if (prdt_size == 0) {
+        return MEMTX_OK;
+    }
+    prd_entries = g_new(UfshcdSgEntry, prdt_size);
+
+    req_upiu_base_addr = ufs_get_req_upiu_base_addr(&req->utrd);
+    prdt_base_addr = req_upiu_base_addr + prdt_byte_off;
+
+    err = ufs_addr_read(u, prdt_base_addr, prd_entries, prdt_size);
+    if (err) {
+        trace_ufs_err_dma_read_prdt(req->slot, prdt_base_addr);
+        return err;
+    }
+
+    req->sg = g_malloc0(sizeof(QEMUSGList));
+    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
+
+    for (uint16_t i = 0; i < prdt_len; ++i) {
+        hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
+        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
+        qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
+    }
+    return MEMTX_OK;
+}
+
+static MemTxResult ufs_dma_read_upiu(UfsRequest *req)
+{
+    MemTxResult ret;
+
+    ret = ufs_dma_read_utrd(req);
+    if (ret) {
+        return ret;
+    }
+
+    ret = ufs_dma_read_req_upiu(req);
+    if (ret) {
+        return ret;
+    }
+
+    ret = ufs_dma_read_prdt(req);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static MemTxResult ufs_dma_write_utrd(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    hwaddr utrd_addr = ufs_get_utrd_addr(u, req->slot);
+    MemTxResult ret;
+
+    ret = ufs_addr_write(u, utrd_addr, &req->utrd, sizeof(req->utrd));
+    if (ret) {
+        trace_ufs_err_dma_write_utrd(req->slot, utrd_addr);
+    }
+    return ret;
+}
+
+static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    hwaddr rsp_upiu_base_addr = ufs_get_rsp_upiu_base_addr(&req->utrd);
+    uint32_t rsp_upiu_byte_len =
+        le16_to_cpu(req->utrd.response_upiu_length) * sizeof(uint32_t);
+    uint16_t data_segment_length =
+        be16_to_cpu(req->rsp_upiu.header.data_segment_length);
+    uint32_t copy_size = sizeof(UtpUpiuHeader) +
+                         UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
+                         data_segment_length;
+    MemTxResult ret;
+
+    if (copy_size > rsp_upiu_byte_len) {
+        copy_size = rsp_upiu_byte_len;
+    }
+
+    ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
+    if (ret) {
+        trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
+    }
+    return ret;
+}
+
+static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
+{
+    MemTxResult ret;
+
+    ret = ufs_dma_write_rsp_upiu(req);
+    if (ret) {
+        return ret;
+    }
+
+    return ufs_dma_write_utrd(req);
+}
+
 static void ufs_irq_check(UfsHc *u)
 {
     PCIDevice *pci = PCI_DEVICE(u);
@@ -32,6 +243,41 @@ static void ufs_irq_check(UfsHc *u)
     }
 }
 
+static void ufs_process_db(UfsHc *u, uint32_t val)
+{
+    unsigned long doorbell;
+    uint32_t slot;
+    uint32_t nutrs = u->params.nutrs;
+    UfsRequest *req;
+
+    val &= ~u->reg.utrldbr;
+    if (!val) {
+        return;
+    }
+
+    doorbell = val;
+    slot = find_first_bit(&doorbell, nutrs);
+
+    while (slot < nutrs) {
+        req = &u->req_list[slot];
+        if (req->state == UFS_REQUEST_ERROR) {
+            trace_ufs_err_utrl_slot_error(req->slot);
+            return;
+        }
+
+        if (req->state != UFS_REQUEST_IDLE) {
+            trace_ufs_err_utrl_slot_busy(req->slot);
+            return;
+        }
+
+        trace_ufs_process_db(slot);
+        req->state = UFS_REQUEST_READY;
+        slot = find_next_bit(&doorbell, nutrs, slot + 1);
+    }
+
+    qemu_bh_schedule(u->doorbell_bh);
+}
+
 static void ufs_process_uiccmd(UfsHc *u, uint32_t val)
 {
     trace_ufs_process_uiccmd(val, u->reg.ucmdarg1, u->reg.ucmdarg2,
@@ -95,7 +341,8 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data, unsigned size)
         u->reg.utrlbau = data;
         break;
     case A_UTRLDBR:
-        /* Not yet supported */
+        ufs_process_db(u, data);
+        u->reg.utrldbr |= data;
         break;
     case A_UTRLRSR:
         u->reg.utrlrsr = data;
@@ -173,6 +420,665 @@ static const MemoryRegionOps ufs_mmio_ops = {
     },
 };
 
+static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
+                                  uint8_t flags, uint8_t response,
+                                  uint8_t scsi_status,
+                                  uint16_t data_segment_length)
+{
+    memcpy(&req->rsp_upiu.header, &req->req_upiu.header, sizeof(UtpUpiuHeader));
+    req->rsp_upiu.header.trans_type = trans_type;
+    req->rsp_upiu.header.flags = flags;
+    req->rsp_upiu.header.response = response;
+    req->rsp_upiu.header.scsi_status = scsi_status;
+    req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
+}
+
+static UfsReqResult ufs_exec_nop_cmd(UfsRequest *req)
+{
+    trace_ufs_exec_nop_cmd(req->slot);
+    ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_NOP_IN, 0, 0, 0, 0);
+    return UFS_REQUEST_SUCCESS;
+}
+
+/*
+ * This defines the permission of flags based on their IDN. There are some
+ * things that are declared read-only, which is inconsistent with the ufs spec,
+ * because we want to return an error for features that are not yet supported.
+ */
+static const int flag_permission[UFS_QUERY_FLAG_IDN_COUNT] = {
+    [UFS_QUERY_FLAG_IDN_FDEVICEINIT] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET,
+    /* Write protection is not supported */
+    [UFS_QUERY_FLAG_IDN_PERMANENT_WPE] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_PWR_ON_WPE] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_BKOPS_EN] = UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET |
+                                    UFS_QUERY_FLAG_CLEAR |
+                                    UFS_QUERY_FLAG_TOGGLE,
+    [UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE] =
+        UFS_QUERY_FLAG_READ | UFS_QUERY_FLAG_SET | UFS_QUERY_FLAG_CLEAR |
+        UFS_QUERY_FLAG_TOGGLE,
+    /* Purge Operation is not supported */
+    [UFS_QUERY_FLAG_IDN_PURGE_ENABLE] = UFS_QUERY_FLAG_NONE,
+    /* Refresh Operation is not supported */
+    [UFS_QUERY_FLAG_IDN_REFRESH_ENABLE] = UFS_QUERY_FLAG_NONE,
+    /* Physical Resource Removal is not supported */
+    [UFS_QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_BUSY_RTC] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE] = UFS_QUERY_FLAG_READ,
+    /* Write Booster is not supported */
+    [UFS_QUERY_FLAG_IDN_WB_EN] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN] = UFS_QUERY_FLAG_READ,
+    [UFS_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8] = UFS_QUERY_FLAG_READ,
+};
+
+static inline QueryRespCode ufs_flag_check_idn_valid(uint8_t idn, int op)
+{
+    if (idn >= UFS_QUERY_FLAG_IDN_COUNT) {
+        return UFS_QUERY_RESULT_INVALID_IDN;
+    }
+
+    if (!(flag_permission[idn] & op)) {
+        if (op == UFS_QUERY_FLAG_READ) {
+            trace_ufs_err_query_flag_not_readable(idn);
+            return UFS_QUERY_RESULT_NOT_READABLE;
+        }
+        trace_ufs_err_query_flag_not_writable(idn);
+        return UFS_QUERY_RESULT_NOT_WRITEABLE;
+    }
+
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static const int attr_permission[UFS_QUERY_ATTR_IDN_COUNT] = {
+    /* booting is not supported */
+    [UFS_QUERY_ATTR_IDN_BOOT_LU_EN] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_POWER_MODE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_OOO_DATA_EN] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_BKOPS_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PURGE_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_MAX_DATA_IN] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_MAX_DATA_OUT] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_DYN_CAP_NEEDED] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_REF_CLK_FREQ] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_CONF_DESC_LOCK] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_MAX_NUM_OF_RTT] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_EE_CONTROL] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_EE_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_SECONDS_PASSED] = UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_CNTX_CONF] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_FFU_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_PSA_STATE] = UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE] =
+        UFS_QUERY_ATTR_READ | UFS_QUERY_ATTR_WRITE,
+    [UFS_QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_CASE_ROUGH_TEMP] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_HIGH_TEMP_BOUND] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_LOW_TEMP_BOUND] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_THROTTLING_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_FLUSH_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE] = UFS_QUERY_ATTR_READ,
+    /* refresh operation is not supported */
+    [UFS_QUERY_ATTR_IDN_REFRESH_STATUS] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_REFRESH_FREQ] = UFS_QUERY_ATTR_READ,
+    [UFS_QUERY_ATTR_IDN_REFRESH_UNIT] = UFS_QUERY_ATTR_READ,
+};
+
+static inline QueryRespCode ufs_attr_check_idn_valid(uint8_t idn, int op)
+{
+    if (idn >= UFS_QUERY_ATTR_IDN_COUNT) {
+        return UFS_QUERY_RESULT_INVALID_IDN;
+    }
+
+    if (!(attr_permission[idn] & op)) {
+        if (op == UFS_QUERY_ATTR_READ) {
+            trace_ufs_err_query_attr_not_readable(idn);
+            return UFS_QUERY_RESULT_NOT_READABLE;
+        }
+        trace_ufs_err_query_attr_not_writable(idn);
+        return UFS_QUERY_RESULT_NOT_WRITEABLE;
+    }
+
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static QueryRespCode ufs_exec_query_flag(UfsRequest *req, int op)
+{
+    UfsHc *u = req->hc;
+    uint8_t idn = req->req_upiu.qr.idn;
+    uint32_t value;
+    QueryRespCode ret;
+
+    ret = ufs_flag_check_idn_valid(idn, op);
+    if (ret) {
+        return ret;
+    }
+
+    if (idn == UFS_QUERY_FLAG_IDN_FDEVICEINIT) {
+        value = 0;
+    } else if (op == UFS_QUERY_FLAG_READ) {
+        value = *(((uint8_t *)&u->flags) + idn);
+    } else if (op == UFS_QUERY_FLAG_SET) {
+        value = 1;
+    } else if (op == UFS_QUERY_FLAG_CLEAR) {
+        value = 0;
+    } else if (op == UFS_QUERY_FLAG_TOGGLE) {
+        value = *(((uint8_t *)&u->flags) + idn);
+        value = !value;
+    } else {
+        trace_ufs_err_query_invalid_opcode(op);
+        return UFS_QUERY_RESULT_INVALID_OPCODE;
+    }
+
+    *(((uint8_t *)&u->flags) + idn) = value;
+    req->rsp_upiu.qr.value = cpu_to_be32(value);
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static uint32_t ufs_read_attr_value(UfsHc *u, uint8_t idn)
+{
+    switch (idn) {
+    case UFS_QUERY_ATTR_IDN_BOOT_LU_EN:
+        return u->attributes.boot_lun_en;
+    case UFS_QUERY_ATTR_IDN_POWER_MODE:
+        return u->attributes.current_power_mode;
+    case UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
+        return u->attributes.active_icc_level;
+    case UFS_QUERY_ATTR_IDN_OOO_DATA_EN:
+        return u->attributes.out_of_order_data_en;
+    case UFS_QUERY_ATTR_IDN_BKOPS_STATUS:
+        return u->attributes.background_op_status;
+    case UFS_QUERY_ATTR_IDN_PURGE_STATUS:
+        return u->attributes.purge_status;
+    case UFS_QUERY_ATTR_IDN_MAX_DATA_IN:
+        return u->attributes.max_data_in_size;
+    case UFS_QUERY_ATTR_IDN_MAX_DATA_OUT:
+        return u->attributes.max_data_out_size;
+    case UFS_QUERY_ATTR_IDN_DYN_CAP_NEEDED:
+        return be32_to_cpu(u->attributes.dyn_cap_needed);
+    case UFS_QUERY_ATTR_IDN_REF_CLK_FREQ:
+        return u->attributes.ref_clk_freq;
+    case UFS_QUERY_ATTR_IDN_CONF_DESC_LOCK:
+        return u->attributes.config_descr_lock;
+    case UFS_QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
+        return u->attributes.max_num_of_rtt;
+    case UFS_QUERY_ATTR_IDN_EE_CONTROL:
+        return be16_to_cpu(u->attributes.exception_event_control);
+    case UFS_QUERY_ATTR_IDN_EE_STATUS:
+        return be16_to_cpu(u->attributes.exception_event_status);
+    case UFS_QUERY_ATTR_IDN_SECONDS_PASSED:
+        return be32_to_cpu(u->attributes.seconds_passed);
+    case UFS_QUERY_ATTR_IDN_CNTX_CONF:
+        return be16_to_cpu(u->attributes.context_conf);
+    case UFS_QUERY_ATTR_IDN_FFU_STATUS:
+        return u->attributes.device_ffu_status;
+    case UFS_QUERY_ATTR_IDN_PSA_STATE:
+        return be32_to_cpu(u->attributes.psa_state);
+    case UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE:
+        return be32_to_cpu(u->attributes.psa_data_size);
+    case UFS_QUERY_ATTR_IDN_REF_CLK_GATING_WAIT_TIME:
+        return u->attributes.ref_clk_gating_wait_time;
+    case UFS_QUERY_ATTR_IDN_CASE_ROUGH_TEMP:
+        return u->attributes.device_case_rough_temperaure;
+    case UFS_QUERY_ATTR_IDN_HIGH_TEMP_BOUND:
+        return u->attributes.device_too_high_temp_boundary;
+    case UFS_QUERY_ATTR_IDN_LOW_TEMP_BOUND:
+        return u->attributes.device_too_low_temp_boundary;
+    case UFS_QUERY_ATTR_IDN_THROTTLING_STATUS:
+        return u->attributes.throttling_status;
+    case UFS_QUERY_ATTR_IDN_WB_FLUSH_STATUS:
+        return u->attributes.wb_buffer_flush_status;
+    case UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE:
+        return u->attributes.available_wb_buffer_size;
+    case UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST:
+        return u->attributes.wb_buffer_life_time_est;
+    case UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE:
+        return be32_to_cpu(u->attributes.current_wb_buffer_size);
+    case UFS_QUERY_ATTR_IDN_REFRESH_STATUS:
+        return u->attributes.refresh_status;
+    case UFS_QUERY_ATTR_IDN_REFRESH_FREQ:
+        return u->attributes.refresh_freq;
+    case UFS_QUERY_ATTR_IDN_REFRESH_UNIT:
+        return u->attributes.refresh_unit;
+    }
+    return 0;
+}
+
+static void ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
+{
+    switch (idn) {
+    case UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL:
+        u->attributes.active_icc_level = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_MAX_DATA_IN:
+        u->attributes.max_data_in_size = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_MAX_DATA_OUT:
+        u->attributes.max_data_out_size = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_REF_CLK_FREQ:
+        u->attributes.ref_clk_freq = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_MAX_NUM_OF_RTT:
+        u->attributes.max_num_of_rtt = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_EE_CONTROL:
+        u->attributes.exception_event_control = cpu_to_be16(value);
+        break;
+    case UFS_QUERY_ATTR_IDN_SECONDS_PASSED:
+        u->attributes.seconds_passed = cpu_to_be32(value);
+        break;
+    case UFS_QUERY_ATTR_IDN_PSA_STATE:
+        u->attributes.psa_state = value;
+        break;
+    case UFS_QUERY_ATTR_IDN_PSA_DATA_SIZE:
+        u->attributes.psa_data_size = cpu_to_be32(value);
+        break;
+    }
+}
+
+static QueryRespCode ufs_exec_query_attr(UfsRequest *req, int op)
+{
+    UfsHc *u = req->hc;
+    uint8_t idn = req->req_upiu.qr.idn;
+    uint32_t value;
+    QueryRespCode ret;
+
+    ret = ufs_attr_check_idn_valid(idn, op);
+    if (ret) {
+        return ret;
+    }
+
+    if (op == UFS_QUERY_ATTR_READ) {
+        value = ufs_read_attr_value(u, idn);
+    } else {
+        value = be32_to_cpu(req->req_upiu.qr.value);
+        ufs_write_attr_value(u, idn, value);
+    }
+
+    req->rsp_upiu.qr.value = cpu_to_be32(value);
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static const RpmbUnitDescriptor rpmb_unit_desc = {
+    .length = sizeof(RpmbUnitDescriptor),
+    .descriptor_idn = 2,
+    .unit_index = UFS_UPIU_RPMB_WLUN,
+    .lu_enable = 0,
+};
+
+static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
+{
+    uint8_t lun = req->req_upiu.qr.index;
+
+    if (lun != UFS_UPIU_RPMB_WLUN && lun > UFS_MAX_LUS) {
+        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
+        return UFS_QUERY_RESULT_INVALID_INDEX;
+    }
+
+    if (lun == UFS_UPIU_RPMB_WLUN) {
+        memcpy(&req->rsp_upiu.qr.data, &rpmb_unit_desc, rpmb_unit_desc.length);
+    } else {
+        /* unit descriptor is not yet supported */
+        return UFS_QUERY_RESULT_INVALID_INDEX;
+    }
+
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static inline StringDescriptor manufacturer_str_desc(void)
+{
+    StringDescriptor desc = {
+        .length = 0x12,
+        .descriptor_idn = UFS_QUERY_DESC_IDN_STRING,
+    };
+    desc.UC[0] = cpu_to_be16('R');
+    desc.UC[1] = cpu_to_be16('E');
+    desc.UC[2] = cpu_to_be16('D');
+    desc.UC[3] = cpu_to_be16('H');
+    desc.UC[4] = cpu_to_be16('A');
+    desc.UC[5] = cpu_to_be16('T');
+    return desc;
+}
+
+static inline StringDescriptor product_name_str_desc(void)
+{
+    StringDescriptor desc = {
+        .length = 0x22,
+        .descriptor_idn = UFS_QUERY_DESC_IDN_STRING,
+    };
+    desc.UC[0] = cpu_to_be16('Q');
+    desc.UC[1] = cpu_to_be16('E');
+    desc.UC[2] = cpu_to_be16('M');
+    desc.UC[3] = cpu_to_be16('U');
+    desc.UC[4] = cpu_to_be16(' ');
+    desc.UC[5] = cpu_to_be16('U');
+    desc.UC[6] = cpu_to_be16('F');
+    desc.UC[7] = cpu_to_be16('S');
+    return desc;
+}
+
+static inline StringDescriptor product_rev_level_str_desc(void)
+{
+    StringDescriptor desc = {
+        .length = 0x0a,
+        .descriptor_idn = UFS_QUERY_DESC_IDN_STRING,
+    };
+    desc.UC[0] = cpu_to_be16('0');
+    desc.UC[1] = cpu_to_be16('0');
+    desc.UC[2] = cpu_to_be16('0');
+    desc.UC[3] = cpu_to_be16('1');
+    return desc;
+}
+
+static const StringDescriptor null_str_desc = {
+    .length = 0x02,
+    .descriptor_idn = UFS_QUERY_DESC_IDN_STRING,
+};
+
+static QueryRespCode ufs_read_string_desc(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    uint8_t index = req->req_upiu.qr.index;
+    StringDescriptor desc;
+
+    if (index == u->device_desc.manufacturer_name) {
+        desc = manufacturer_str_desc();
+        memcpy(&req->rsp_upiu.qr.data, &desc, desc.length);
+    } else if (index == u->device_desc.product_name) {
+        desc = product_name_str_desc();
+        memcpy(&req->rsp_upiu.qr.data, &desc, desc.length);
+    } else if (index == u->device_desc.serial_number) {
+        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.length);
+    } else if (index == u->device_desc.oem_id) {
+        memcpy(&req->rsp_upiu.qr.data, &null_str_desc, null_str_desc.length);
+    } else if (index == u->device_desc.product_revision_level) {
+        desc = product_rev_level_str_desc();
+        memcpy(&req->rsp_upiu.qr.data, &desc, desc.length);
+    } else {
+        trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, index);
+        return UFS_QUERY_RESULT_INVALID_INDEX;
+    }
+    return UFS_QUERY_RESULT_SUCCESS;
+}
+
+static inline InterconnectDescriptor interconnect_desc(void)
+{
+    InterconnectDescriptor desc = {
+        .length = sizeof(InterconnectDescriptor),
+        .descriptor_idn = UFS_QUERY_DESC_IDN_INTERCONNECT,
+    };
+    desc.bcd_unipro_version = cpu_to_be16(0x180);
+    desc.bcd_mphy_version = cpu_to_be16(0x410);
+    return desc;
+}
+
+static QueryRespCode ufs_read_desc(UfsRequest *req)
+{
+    UfsHc *u = req->hc;
+    QueryRespCode status;
+    uint8_t idn = req->req_upiu.qr.idn;
+    uint16_t length = be16_to_cpu(req->req_upiu.qr.length);
+    InterconnectDescriptor desc;
+
+    switch (idn) {
+    case UFS_QUERY_DESC_IDN_DEVICE:
+        memcpy(&req->rsp_upiu.qr.data, &u->device_desc, sizeof(u->device_desc));
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    case UFS_QUERY_DESC_IDN_UNIT:
+        status = ufs_read_unit_desc(req);
+        break;
+    case UFS_QUERY_DESC_IDN_GEOMETRY:
+        memcpy(&req->rsp_upiu.qr.data, &u->geometry_desc,
+               sizeof(u->geometry_desc));
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    case UFS_QUERY_DESC_IDN_INTERCONNECT: {
+        desc = interconnect_desc();
+        memcpy(&req->rsp_upiu.qr.data, &desc, sizeof(InterconnectDescriptor));
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    }
+    case UFS_QUERY_DESC_IDN_STRING:
+        status = ufs_read_string_desc(req);
+        break;
+    case UFS_QUERY_DESC_IDN_POWER:
+        /* mocking of power descriptor is not supported */
+        memset(&req->rsp_upiu.qr.data, 0, sizeof(PowerParametersDescriptor));
+        req->rsp_upiu.qr.data[0] = sizeof(PowerParametersDescriptor);
+        req->rsp_upiu.qr.data[1] = UFS_QUERY_DESC_IDN_POWER;
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    case UFS_QUERY_DESC_IDN_HEALTH:
+        /* mocking of health descriptor is not supported */
+        memset(&req->rsp_upiu.qr.data, 0, sizeof(DeviceHealthDescriptor));
+        req->rsp_upiu.qr.data[0] = sizeof(DeviceHealthDescriptor);
+        req->rsp_upiu.qr.data[1] = UFS_QUERY_DESC_IDN_HEALTH;
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    default:
+        length = 0;
+        trace_ufs_err_query_invalid_idn(req->req_upiu.qr.opcode, idn);
+        status = UFS_QUERY_RESULT_INVALID_IDN;
+    }
+
+    if (length > req->rsp_upiu.qr.data[0]) {
+        length = req->rsp_upiu.qr.data[0];
+    }
+    req->rsp_upiu.qr.opcode = req->req_upiu.qr.opcode;
+    req->rsp_upiu.qr.idn = req->req_upiu.qr.idn;
+    req->rsp_upiu.qr.index = req->req_upiu.qr.index;
+    req->rsp_upiu.qr.selector = req->req_upiu.qr.selector;
+    req->rsp_upiu.qr.length = cpu_to_be16(length);
+
+    return status;
+}
+
+static QueryRespCode ufs_exec_query_read(UfsRequest *req)
+{
+    QueryRespCode status;
+    switch (req->req_upiu.qr.opcode) {
+    case UFS_UPIU_QUERY_OPCODE_NOP:
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    case UFS_UPIU_QUERY_OPCODE_READ_DESC:
+        status = ufs_read_desc(req);
+        break;
+    case UFS_UPIU_QUERY_OPCODE_READ_ATTR:
+        status = ufs_exec_query_attr(req, UFS_QUERY_ATTR_READ);
+        break;
+    case UFS_UPIU_QUERY_OPCODE_READ_FLAG:
+        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_READ);
+        break;
+    default:
+        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
+        status = UFS_QUERY_RESULT_INVALID_OPCODE;
+        break;
+    }
+
+    return status;
+}
+
+static QueryRespCode ufs_exec_query_write(UfsRequest *req)
+{
+    QueryRespCode status;
+    switch (req->req_upiu.qr.opcode) {
+    case UFS_UPIU_QUERY_OPCODE_NOP:
+        status = UFS_QUERY_RESULT_SUCCESS;
+        break;
+    case UFS_UPIU_QUERY_OPCODE_WRITE_DESC:
+        /* write descriptor is not supported */
+        status = UFS_QUERY_RESULT_NOT_WRITEABLE;
+        break;
+    case UFS_UPIU_QUERY_OPCODE_WRITE_ATTR:
+        status = ufs_exec_query_attr(req, UFS_QUERY_ATTR_WRITE);
+        break;
+    case UFS_UPIU_QUERY_OPCODE_SET_FLAG:
+        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_SET);
+        break;
+    case UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG:
+        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_CLEAR);
+        break;
+    case UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG:
+        status = ufs_exec_query_flag(req, UFS_QUERY_FLAG_TOGGLE);
+        break;
+    default:
+        trace_ufs_err_query_invalid_opcode(req->req_upiu.qr.opcode);
+        status = UFS_QUERY_RESULT_INVALID_OPCODE;
+        break;
+    }
+
+    return status;
+}
+
+static UfsReqResult ufs_exec_query_cmd(UfsRequest *req)
+{
+    uint8_t query_func = req->req_upiu.header.query_func;
+    uint16_t data_segment_length;
+    QueryRespCode status;
+
+    trace_ufs_exec_query_cmd(req->slot, req->req_upiu.qr.opcode);
+    if (query_func == UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST) {
+        status = ufs_exec_query_read(req);
+    } else if (query_func == UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST) {
+        status = ufs_exec_query_write(req);
+    } else {
+        status = UFS_QUERY_RESULT_GENERAL_FAILURE;
+    }
+
+    data_segment_length = be16_to_cpu(req->rsp_upiu.qr.length);
+    ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_QUERY_RSP, 0, status, 0,
+                          data_segment_length);
+
+    if (status != UFS_QUERY_RESULT_SUCCESS) {
+        return UFS_REQUEST_FAIL;
+    }
+    return UFS_REQUEST_SUCCESS;
+}
+
+static void ufs_exec_req(UfsRequest *req)
+{
+    UfsReqResult req_result;
+
+    if (ufs_dma_read_upiu(req)) {
+        return;
+    }
+
+    switch (req->req_upiu.header.trans_type) {
+    case UFS_UPIU_TRANSACTION_NOP_OUT:
+        req_result = ufs_exec_nop_cmd(req);
+        break;
+    case UFS_UPIU_TRANSACTION_COMMAND:
+        /* Not yet implemented */
+        req_result = UFS_REQUEST_FAIL;
+        break;
+    case UFS_UPIU_TRANSACTION_QUERY_REQ:
+        req_result = ufs_exec_query_cmd(req);
+        break;
+    default:
+        trace_ufs_err_invalid_trans_code(req->slot,
+                                         req->req_upiu.header.trans_type);
+        req_result = UFS_REQUEST_FAIL;
+    }
+
+    ufs_complete_req(req, req_result);
+}
+
+static void ufs_process_req(void *opaque)
+{
+    UfsHc *u = opaque;
+    UfsRequest *req;
+    int slot;
+
+    for (slot = 0; slot < u->params.nutrs; slot++) {
+        req = &u->req_list[slot];
+
+        if (req->state != UFS_REQUEST_READY) {
+            continue;
+        }
+        trace_ufs_process_req(slot);
+        req->state = UFS_REQUEST_RUNNING;
+
+        ufs_exec_req(req);
+    }
+}
+
+static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
+{
+    UfsHc *u = req->hc;
+    assert(req->state == UFS_REQUEST_RUNNING);
+
+    if (req_result == UFS_REQUEST_SUCCESS) {
+        req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_SUCCESS);
+    } else {
+        req->utrd.header.dword_2 = cpu_to_le32(UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    }
+
+    trace_ufs_complete_req(req->slot);
+    req->state = UFS_REQUEST_COMPLETE;
+    qemu_bh_schedule(u->complete_bh);
+}
+
+static void ufs_clear_req(UfsRequest *req)
+{
+    if (req->sg != NULL) {
+        qemu_sglist_destroy(req->sg);
+        g_free(req->sg);
+        req->sg = NULL;
+    }
+
+    memset(&req->utrd, 0, sizeof(req->utrd));
+    memset(&req->req_upiu, 0, sizeof(req->req_upiu));
+    memset(&req->rsp_upiu, 0, sizeof(req->rsp_upiu));
+}
+
+static void ufs_sendback_req(void *opaque)
+{
+    UfsHc *u = opaque;
+    UfsRequest *req;
+    int slot;
+
+    for (slot = 0; slot < u->params.nutrs; slot++) {
+        req = &u->req_list[slot];
+
+        if (req->state != UFS_REQUEST_COMPLETE) {
+            continue;
+        }
+
+        if (ufs_dma_write_upiu(req)) {
+            req->state = UFS_REQUEST_ERROR;
+            continue;
+        }
+
+        /*
+         * TODO: UTP Transfer Request Interrupt Aggregation Control is not yet
+         * supported
+         */
+        if (le32_to_cpu(req->utrd.header.dword_2) != UFS_OCS_SUCCESS ||
+            le32_to_cpu(req->utrd.header.dword_0) & UFS_UTP_REQ_DESC_INT_CMD) {
+            u->reg.is = FIELD_DP32(u->reg.is, IS, UTRCS, 1);
+        }
+
+        u->reg.utrldbr &= ~(1 << slot);
+        u->reg.utrlcnr |= (1 << slot);
+
+        trace_ufs_sendback_req(req->slot);
+
+        ufs_clear_req(req);
+        req->state = UFS_REQUEST_IDLE;
+    }
+
+    ufs_irq_check(u);
+}
+
 static bool ufs_check_constraints(UfsHc *u, Error **errp)
 {
     if (u->params.nutrs > UFS_MAX_NUTRS) {
@@ -203,6 +1109,23 @@ static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
     u->irq = pci_allocate_irq(pci_dev);
 }
 
+static void ufs_init_state(UfsHc *u)
+{
+    u->req_list = g_new0(UfsRequest, u->params.nutrs);
+
+    for (int i = 0; i < u->params.nutrs; i++) {
+        u->req_list[i].hc = u;
+        u->req_list[i].slot = i;
+        u->req_list[i].sg = NULL;
+        u->req_list[i].state = UFS_REQUEST_IDLE;
+    }
+
+    u->doorbell_bh = qemu_bh_new_guarded(ufs_process_req, u,
+                                         &DEVICE(u)->mem_reentrancy_guard);
+    u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
+                                         &DEVICE(u)->mem_reentrancy_guard);
+}
+
 static void ufs_init_hc(UfsHc *u)
 {
     uint32_t cap = 0;
@@ -220,6 +1143,52 @@ static void ufs_init_hc(UfsHc *u)
     cap = FIELD_DP32(cap, CAP, CS, 0);
     u->reg.cap = cap;
     u->reg.ver = UFS_SPEC_VER;
+
+    memset(&u->device_desc, 0, sizeof(DeviceDescriptor));
+    u->device_desc.length = sizeof(DeviceDescriptor);
+    u->device_desc.descriptor_idn = UFS_QUERY_DESC_IDN_DEVICE;
+    u->device_desc.device_sub_class = 0x01;
+    u->device_desc.number_lu = 0x00;
+    u->device_desc.number_wlu = 0x04;
+    /* TODO: Revisit it when Power Management is implemented */
+    u->device_desc.init_power_mode = 0x01; /* Active Mode */
+    u->device_desc.high_priority_lun = 0x7F; /* Same Priority */
+    u->device_desc.spec_version = cpu_to_be16(UFS_SPEC_VER);
+    u->device_desc.manufacturer_name = 0x00;
+    u->device_desc.product_name = 0x01;
+    u->device_desc.serial_number = 0x02;
+    u->device_desc.oem_id = 0x03;
+    u->device_desc.ud_0_base_offset = 0x16;
+    u->device_desc.ud_config_p_length = 0x1A;
+    u->device_desc.device_rtt_cap = 0x02;
+    u->device_desc.queue_depth = u->params.nutrs;
+    u->device_desc.product_revision_level = 0x04;
+
+    memset(&u->geometry_desc, 0, sizeof(GeometryDescriptor));
+    u->geometry_desc.length = sizeof(GeometryDescriptor);
+    u->geometry_desc.descriptor_idn = UFS_QUERY_DESC_IDN_GEOMETRY;
+    u->geometry_desc.max_number_lu = (UFS_MAX_LUS == 32) ? 0x1 : 0x0;
+    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4KB */
+    u->geometry_desc.allocation_unit_size = 0x1; /* 4KB */
+    u->geometry_desc.min_addr_block_size = 0x8; /* 4KB */
+    u->geometry_desc.max_in_buffer_size = 0x8;
+    u->geometry_desc.max_out_buffer_size = 0x8;
+    u->geometry_desc.rpmb_read_write_size = 0x40;
+    u->geometry_desc.data_ordering =
+        0x0; /* out-of-order data transfer is not supported */
+    u->geometry_desc.max_context_id_number = 0x5;
+    u->geometry_desc.supported_memory_types = cpu_to_be16(0x8001);
+
+    memset(&u->attributes, 0, sizeof(u->attributes));
+    u->attributes.max_data_in_size = 0x08;
+    u->attributes.max_data_out_size = 0x08;
+    u->attributes.ref_clk_freq = 0x01; /* 26 MHz */
+    /* configure descriptor is not supported */
+    u->attributes.config_descr_lock = 0x01;
+    u->attributes.max_num_of_rtt = 0x02;
+
+    memset(&u->flags, 0, sizeof(u->flags));
+    u->flags.permanently_disable_fw_update = 1;
 }
 
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
@@ -230,10 +1199,24 @@ static void ufs_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
+    ufs_init_state(u);
     ufs_init_hc(u);
     ufs_init_pci(u, pci_dev);
 }
 
+static void ufs_exit(PCIDevice *pci_dev)
+{
+    UfsHc *u = UFS(pci_dev);
+
+    qemu_bh_delete(u->doorbell_bh);
+    qemu_bh_delete(u->complete_bh);
+
+    for (int i = 0; i < u->params.nutrs; i++) {
+        ufs_clear_req(&u->req_list[i]);
+    }
+    g_free(u->req_list);
+}
+
 static Property ufs_props[] = {
     DEFINE_PROP_STRING("serial", UfsHc, params.serial),
     DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
@@ -252,6 +1235,7 @@ static void ufs_class_init(ObjectClass *oc, void *data)
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
     pc->realize = ufs_realize;
+    pc->exit = ufs_exit;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
     pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
     pc->class_id = PCI_CLASS_STORAGE_UFS;
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index d1badcad10..665e1a942b 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -18,6 +18,7 @@ ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu
 ufs_err_dma_read_prdt(uint32_t slot, uint64_t addr) "failed to read prdt. UTRLDBR slot %"PRIu32", prdt addr %"PRIu64""
 ufs_err_dma_write_utrd(uint32_t slot, uint64_t addr) "failed to write utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_write_rsp_upiu(uint32_t slot, uint64_t addr) "failed to write rsp upiu. UTRLDBR slot %"PRIu32", response upiu addr %"PRIu64""
+ufs_err_utrl_slot_error(uint32_t slot) "UTRLDBR slot %"PRIu32" is in error"
 ufs_err_utrl_slot_busy(uint32_t slot) "UTRLDBR slot %"PRIu32" is busy"
 ufs_err_unsupport_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is not yet supported"
 ufs_err_invalid_register_offset(uint32_t offset) "Register offset 0x%"PRIx32" is invalid"
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429988AF47
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 20:05:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropd0-0001JW-BJ; Mon, 25 Mar 2024 15:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcw-0001AL-9z
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:58 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropct-0004p5-JX
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:58 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-22a353217c3so736821fac.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393494; x=1711998294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3vP3x9GTrRSsmfUjcE/YCCno0V4KVPXGg0cR6uT4I8=;
 b=XMrBETSe3p0Y7HwI6Yub1UiGTATD3WphK8EoCf5iF3ulYall3Ast6wvkpc1w2rcsvu
 mUv9onyvlmdtnMbsLukYy/BKhPvXl3MhQduPIWlj3iyqq0AtxkwwZ1+9qMvA8N8MFurh
 /qxQ+2JtvmJfzRncxasebclcrlLFjOq59CjR2RG0U52LjXZJqVyYKz+bnwCf0i9buIR+
 ny6Y6zMX3Jv74BO8JE0P7NA1UtEIefO7W2wBWdS1ih83ZbHZ8tlFGSfafreegT+e8k8C
 dEp7gvlzQL4PaxuD5h6iws+lkPvC89q441d+16JAr8Ml2bSTgcLayUtTqAfJio5scP7R
 CP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393494; x=1711998294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3vP3x9GTrRSsmfUjcE/YCCno0V4KVPXGg0cR6uT4I8=;
 b=nutx7QEM4rnvGhp3Dc6WSIw6+BFVtRvgmAd5nutKA8MJ3Sj8xfOhP4sY9gx3Dcr0Bq
 Pf8qsYH/uynVFI4bhUkRZFjhYx4hk2F3bmw1SnDH34N3z+TDoHMGsCvk+w238/tCGfaJ
 0JfbXRpQlkjRxOuSEOVSkDEdIf6wuPhhXs/V7wmudSTJlSCSJ1CFmm5nwza+uEhxw3Lw
 LRv46U2eoyWlC2p+Cns7JC8GLAg3CRpzPUxRnIQrxeM7fvyJZJwYk2L/ELcb434qZjtC
 4tqteFmwhtYAe+424Q87R5u4NdAomy24DHuBVJi8M94i+FmrzLVpC01G8G4g3rHs+Fma
 rA7g==
X-Gm-Message-State: AOJu0YxY0XEAMpQQr8pAD2GSW7Rm8djq4EOZqYpjQ2NSVrSCWyAjFgs9
 ucNIoLv729draJ0gqV7CNXYBnUazoKOHA2kfz4HWGk2ar9CeW18dNM56HoUu
X-Google-Smtp-Source: AGHT+IHHdO2UVy3f/phSyaNBb+ZONnyKcOG5/x+wtGWZrfvuPNU1iNTlmuDJ6E75KhK0r1fhZ58Rcw==
X-Received: by 2002:a05:6871:3426:b0:22a:5423:45ff with SMTP id
 nh38-20020a056871342600b0022a542345ffmr1873641oac.40.1711393493524; 
 Mon, 25 Mar 2024 12:04:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:04:53 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Date: Mon, 25 Mar 2024 12:02:27 -0700
Message-ID: <20240325190339.696686-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=nifan.cxl@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Fan Ni <fan.ni@samsung.com>

To simulate FM functionalities for initiating Dynamic Capacity Add
(Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
add/release dynamic capacity extents requests.

With the change, we allow to release an extent only when its DPA range
is contained by a single accepted extent in the device. That is to say,
extent superset release is not supported yet.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each 128MiB long)
to region 0 (starting at DPA offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "region-id": 0,
      "extents": [
      {
          "offset": 0,
          "len": 134217728
      },
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MiB from region 0
(DPA offset 128MiB) looks like below:

{ "execute": "cxl-release-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "region-id": 0,
      "extents": [
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  26 ++--
 hw/mem/cxl_type3.c          | 252 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  14 ++
 include/hw/cxl/cxl_device.h |   8 ++
 include/hw/cxl/cxl_events.h |  18 +++
 qapi/cxl.json               |  61 ++++++++-
 6 files changed, 367 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a9eca516c8..7094e007b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1407,7 +1407,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
  * Check whether any bit between addr[nr, nr+size) is set,
  * return true if any bit is set, otherwise return false
  */
-static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                               unsigned long size)
 {
     unsigned long res = find_next_bit(addr, size + nr, nr);
@@ -1446,7 +1446,7 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
     return NULL;
 }
 
-static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint64_t dpa,
                                              uint64_t len,
                                              uint8_t *tag,
@@ -1552,10 +1552,11 @@ static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
 
         range_init_nofail(&range1, dpa, len);
 
-        /*
-         * TODO: once the pending extent list is added, check against
-         * the list will be added here.
-         */
+        /* host-accepted DPA range must be contained by pending extent */
+        if (!cxl_extents_contains_dpa_range(&ct3d->dc.extents_pending,
+                                            dpa, len)) {
+            return CXL_MBOX_INVALID_PA;
+        }
 
         /* to-be-added range should not overlap with range already accepted */
         QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
@@ -1585,9 +1586,13 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     CXLDCExtentList *extent_list = &ct3d->dc.extents;
     uint32_t i;
     uint64_t dpa, len;
+    CXLDCExtent *ent;
     CXLRetCode ret;
 
     if (in->num_entries_updated == 0) {
+        /* Always remove the first pending extent when response received. */
+        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
         return CXL_MBOX_SUCCESS;
     }
 
@@ -1604,6 +1609,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
     ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
     if (ret != CXL_MBOX_SUCCESS) {
+        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
         return ret;
     }
 
@@ -1613,10 +1620,9 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
-        /*
-         * TODO: we will add a pending extent list based on event log record
-         * and process the list according here.
-         */
+
+        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
     }
 
     return CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 951bd79a82..74cb64e843 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         ct3d->dc.total_capacity += region->len;
     }
     QTAILQ_INIT(&ct3d->dc.extents);
+    QTAILQ_INIT(&ct3d->dc.extents_pending);
 
     return true;
 }
@@ -685,6 +686,10 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
+    QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents_pending, node, ent_next) {
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending,
+                                           ent);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -1449,7 +1454,8 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return CXL_EVENT_TYPE_FAIL;
     case CXL_EVENT_LOG_FATAL:
         return CXL_EVENT_TYPE_FATAL;
-/* DCD not yet supported */
+    case CXL_EVENT_LOG_DYNCAP:
+        return CXL_EVENT_TYPE_DYNAMIC_CAP;
     default:
         return -EINVAL;
     }
@@ -1700,6 +1706,250 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
+/*
+ * Check whether the range [dpa, dpa + len -1] has overlaps with extents in
+ * the list.
+ * Return value: return true if has overlaps; otherwise, return false
+ */
+static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                           uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
+    Range range1, range2;
+
+    if (!list) {
+        return false;
+    }
+
+    range_init_nofail(&range1, dpa, len);
+    QTAILQ_FOREACH(ent, list, node) {
+        range_init_nofail(&range2, ent->start_dpa, ent->len);
+        if (range_overlaps_range(&range1, &range2)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * Check whether the range [dpa, dpa + len -1] is contained by extents in
+ * the list.
+ * Will check multiple extents containment once superset release is added.
+ * Return value: return true if range is contained; otherwise, return false
+ */
+bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
+{
+    CXLDCExtent *ent;
+    Range range1, range2;
+
+    if (!list) {
+        return false;
+    }
+
+    range_init_nofail(&range1, dpa, len);
+    QTAILQ_FOREACH(ent, list, node) {
+        range_init_nofail(&range2, ent->start_dpa, ent->len);
+        if (range_contains_range(&range2, &range1)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * The main function to process dynamic capacity event. Currently DC extents
+ * add/release requests are processed.
+ */
+static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
+                                             CXLDCEventType type, uint16_t hid,
+                                             uint8_t rid,
+                                             CXLDCExtentRecordList *records,
+                                             Error **errp)
+{
+    Object *obj;
+    CXLEventDynamicCapacity dCap = {};
+    CXLEventRecordHdr *hdr = &dCap.hdr;
+    CXLType3Dev *dcd;
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+    uint32_t num_extents = 0;
+    CXLDCExtentRecordList *list;
+    g_autofree CXLDCExtentRaw *extents = NULL;
+    uint8_t enc_log;
+    uint64_t dpa, offset, len, block_size;
+    int i, rc;
+    g_autofree unsigned long *blk_bitmap = NULL;
+
+    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve CXL type 3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "region id is too large");
+        return;
+    }
+    block_size = dcd->dc.regions[rid].block_size;
+    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
+
+    /* Sanity check and count the extents */
+    list = records;
+    while (list) {
+        offset = list->value->offset;
+        len = list->value->len;
+        dpa = offset + dcd->dc.regions[rid].base;
+
+        if (len == 0) {
+            error_setg(errp, "extent with 0 length is not allowed");
+            return;
+        }
+
+        if (offset % block_size || len % block_size) {
+            error_setg(errp, "dpa or len is not aligned to region block size");
+            return;
+        }
+
+        if (offset + len > dcd->dc.regions[rid].len) {
+            error_setg(errp, "extent range is beyond the region end");
+            return;
+        }
+
+        /* No duplicate or overlapped extents are allowed */
+        if (test_any_bits_set(blk_bitmap, offset / block_size,
+                              len / block_size)) {
+            error_setg(errp, "duplicate or overlapped extents are detected");
+            return;
+        }
+        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
+
+        num_extents++;
+        if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents_pending,
+                                               dpa, len)) {
+                error_setg(errp,
+                           "cannot release extent with pending DPA range");
+                return;
+            }
+            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
+                                                dpa, len)) {
+                error_setg(errp,
+                           "cannot release extent with non-existing DPA range");
+                return;
+            }
+        }
+        list = list->next;
+    }
+    if (num_extents == 0) {
+        error_setg(errp, "no valid extents to send to process");
+        return;
+    }
+
+    /* Create extent list for event being passed to host */
+    i = 0;
+    list = records;
+    extents = g_new0(CXLDCExtentRaw, num_extents);
+    while (list) {
+        offset = list->value->offset;
+        len = list->value->len;
+        dpa = dcd->dc.regions[rid].base + offset;
+
+        extents[i].start_dpa = dpa;
+        extents[i].len = len;
+        memset(extents[i].tag, 0, 0x10);
+        extents[i].shared_seq = 0;
+        list = list->next;
+        i++;
+    }
+
+    /*
+     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
+     *
+     * All Dynamic Capacity event records shall set the Event Record Severity
+     * field in the Common Event Record Format to Informational Event. All
+     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
+     * Event Log.
+     */
+    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
+                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+
+    dCap.type = type;
+    /* FIXME: for now, validity flag is cleared */
+    dCap.validity_flags = 0;
+    stw_le_p(&dCap.host_id, hid);
+    /* only valid for DC_REGION_CONFIG_UPDATED event */
+    dCap.updated_region_id = 0;
+    /*
+     * FIXME: for now, the "More" flag is cleared as there is only one
+     * extent associating with each record and tag-based release is
+     * not supported.
+     */
+    dCap.flags = 0;
+    for (i = 0; i < num_extents; i++) {
+        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
+               sizeof(CXLDCExtentRaw));
+
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending,
+                                             extents[i].start_dpa,
+                                             extents[i].len,
+                                             extents[i].tag,
+                                             extents[i].shared_seq);
+        }
+
+        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
+                             (CXLEventRecordRaw *)&dCap)) {
+            cxl_event_irq_assert(dcd);
+        }
+    }
+}
+
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
+                                  CXLDCExtentRecordList  *records,
+                                  Error **errp)
+{
+   qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
+                                    DC_EVENT_ADD_CAPACITY, 0,
+                                    region_id, records, errp);
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
+                                      CXLDCExtentRecordList  *records,
+                                      Error **errp)
+{
+    qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
+                                     DC_EVENT_RELEASE_CAPACITY, 0,
+                                     region_id, records, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 3e1851e32b..d913b11b4d 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -67,3 +67,17 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
+                                  CXLDCExtentRecordList  *records,
+                                  Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
+                                      CXLDCExtentRecordList  *records,
+                                      Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index df3511e91b..b84063d9f4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -494,6 +494,7 @@ struct CXLType3Dev {
          */
         uint64_t total_capacity; /* 256M aligned */
         CXLDCExtentList extents;
+        CXLDCExtentList extents_pending;
         uint32_t total_extent_count;
         uint32_t ext_list_gen_seq;
 
@@ -555,4 +556,11 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
 void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
                                         CXLDCExtent *extent);
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
+                                      uint64_t len, uint8_t *tag,
+                                      uint16_t shared_seq);
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+                       unsigned long size);
+bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 5170b8dbf8..38cadaa0f3 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,4 +166,22 @@ typedef struct CXLEventMemoryModule {
     uint8_t reserved[0x3d];
 } QEMU_PACKED CXLEventMemoryModule;
 
+/*
+ * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
+ * All fields little endian.
+ */
+typedef struct CXLEventDynamicCapacity {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t validity_flags;
+    uint16_t host_id;
+    uint8_t updated_region_id;
+    uint8_t flags;
+    uint8_t reserved2[2];
+    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+    uint8_t reserved[0x18];
+    uint32_t extents_avail;
+    uint32_t tags_avail;
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8cc4c72fa9..2645004666 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -19,13 +19,16 @@
 #
 # @fatal: Fatal Event Log
 #
+# @dyncap: Dynamic Capacity Event Log
+#
 # Since: 8.1
 ##
 { 'enum': 'CxlEventLog',
   'data': ['informational',
            'warning',
            'failure',
-           'fatal']
+           'fatal',
+           'dyncap']
  }
 
 ##
@@ -361,3 +364,59 @@
 ##
 {'command': 'cxl-inject-correctable-error',
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
+
+##
+# @CXLDCExtentRecord:
+#
+# Record of a single extent to add/release
+#
+# @offset: offset to the start of the region where the extent to be operated
+# @len: length of the extent
+#
+# Since: 9.0
+##
+{ 'struct': 'CXLDCExtentRecord',
+  'data': {
+      'offset':'uint64',
+      'len': 'uint64'
+  }
+}
+
+##
+# @cxl-add-dynamic-capacity:
+#
+# Command to start add dynamic capacity extents flow. The device will
+# have to acknowledged the acceptance of the extents before they are usable.
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: id of the region where the extent to add
+# @extents: Extents to add
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-add-dynamic-capacity',
+  'data': { 'path': 'str',
+            'region-id': 'uint8',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
+
+##
+# @cxl-release-dynamic-capacity:
+#
+# Command to start release dynamic capacity extents flow. The host will
+# need to respond to indicate that it has released the capacity before it
+# is made unavailable for read and write and can be re-added.
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: id of the region where the extent to release
+# @extents: Extents to release
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-release-dynamic-capacity',
+  'data': { 'path': 'str',
+            'region-id': 'uint8',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
-- 
2.43.0



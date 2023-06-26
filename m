Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0273DF6B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKY-0001hO-L7; Mon, 26 Jun 2023 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKW-0001cP-6p
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKU-0002l8-1a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+QhAsN/XuaZ11bEG8Ru5fkaUsTR7CPbUnVIC/HsX/ME=;
 b=AOscxSQj3kzAXYrqsFv8YHUwKD/AyIamJ7W0xzbCSJfcNt9FSLM8jPuQBDEGFjGcWRzJ3Q
 E7PyQsbnNykGHZAzlUFBbxlS6KiTLNVCA/1clTBx3BorzYllqELClMsBSM0zlDtAWpHako
 qjhiEC7rfIout6hJUnLDP0Vrq86bMdw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-IVt0GAgINWSTlOVyATWCAA-1; Mon, 26 Jun 2023 08:28:23 -0400
X-MC-Unique: IVt0GAgINWSTlOVyATWCAA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f9b003507bso15727315e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782502; x=1690374502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QhAsN/XuaZ11bEG8Ru5fkaUsTR7CPbUnVIC/HsX/ME=;
 b=EWfpTgehMs41lzz5oc+ZKaIWDsUl2E7p8Z52yha0WdD/RF6WZ8FuaL/Ok6mPsD8g5e
 qd0Pw/I+NFQ7FAxsxekMSDsdPowx+9MkZMGYAo+uXo8Slt8RXGqStBU5geUweGObdDkK
 VuDW0rFfXan8lyB/IWqJRtD697ghnvlXaA9k8GlcD8xst4fUpAw67D4Jsom/pGR27lT2
 CmJww4QIihkIRfKwHaC5PlU08s2gCqyC6VL1EFg+jjKlb5ef5SQHkwcTAvboMOhb8Ft0
 j2nT9dkC0tB8veExhiumeqbE1/8kPc6+IDIR2SVV/YMy40+pTdi261TaX59eyO2uc9sq
 uqNg==
X-Gm-Message-State: AC+VfDxmafN0qzZ03dQMXNyjQ27rLUdX4oOYa44XA65qPwKWTuKGaaUn
 O2MHOOD8S+dbPyI7E28phx7ytngx8sSo8EGm96fXcbxMGLUwnpS2ZqGsM6mebjDVzGOib0lw9x2
 palMPDIxu7Xekdr7FashLQmE0lyb2BeZsZ6Dq9fIp5iu0GDlbpm/MecKvrjyjdloud1So
X-Received: by 2002:a05:600c:2119:b0:3fb:407e:9b31 with SMTP id
 u25-20020a05600c211900b003fb407e9b31mr542960wml.37.1687782502091; 
 Mon, 26 Jun 2023 05:28:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72B8bFPZaL8BkUvfbAuUoozMVOmyjVFb018ko+Klw5mrWAF0+TRsaGuTvxwSJ1EDaeizwcEw==
X-Received: by 2002:a05:600c:2119:b0:3fb:407e:9b31 with SMTP id
 u25-20020a05600c211900b003fb407e9b31mr542935wml.37.1687782501490; 
 Mon, 26 Jun 2023 05:28:21 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 a10-20020a1cf00a000000b003f8fb02c413sm7600506wmb.8.2023.06.26.05.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:21 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Ira Weiny <ira.weiny@intel.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 10/53] hw/cxl/events: Add injection of DRAM events
Message-ID: <b90a324eda7113b62b558aad43e2166eb52567d2.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
provides information related to DRAM devices.

Example injection command in QMP:

{ "execute": "cxl-inject-dram-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "rank": 17,
        "nibble-mask": 37421234,
        "bank-group": 7,
        "bank": 11,
        "row": 2,
        "column": 77,
        "correction-mask": [33, 44, 55,66]
    }}

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-7-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/cxl.json               |  61 +++++++++++++++++++
 include/hw/cxl/cxl_events.h |  23 +++++++
 hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  13 ++++
 4 files changed, 213 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index d509430844..2ad310387c 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -79,6 +79,67 @@
             '*channel': 'uint8', '*rank': 'uint8',
             '*device': 'uint32', '*component-id': 'str' } }
 
+##
+# @cxl-inject-dram-event:
+#
+# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2).
+# This event type is reported via one of the event logs specified via
+# the log parameter.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: Event log to add the event to
+#
+# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
+#     Record Format, Event Record Flags for subfield definitions.
+#
+# @dpa: Device Physical Address (relative to @path device).  Note
+#     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
+#     Event Record, Physical Address.
+#
+# @descriptor: Memory Event Descriptor with additional memory event
+#     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
+#     Event Descriptor for bit definitions.
+#
+# @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
+#     DRAM Event Record, Memory Event Type for possible values.
+#
+# @transaction-type: Type of first transaction that caused the event
+#     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
+#     Transaction Type for possible values.
+#
+# @channel: The channel of the memory event location.  A channel is an
+#     interface that can be independently accessed for a transaction.
+#
+# @rank: The rank of the memory event location.  A rank is a set of
+#     memory devices on a channel that together execute a transaction.
+#
+# @nibble-mask: Identifies one or more nibbles that the error affects
+#
+# @bank-group: Bank group of the memory event location, incorporating
+#     a number of Banks.
+#
+# @bank: Bank of the memory event location.  A single bank is accessed
+#     per read or write of the memory.
+#
+# @row: Row address within the DRAM.
+#
+# @column: Column address within the DRAM.
+#
+# @correction-mask: Bits within each nibble.  Used in order of bits
+#     set in the nibble-mask.  Up to 4 nibbles may be covered.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-dram-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'dpa': 'uint64', 'descriptor': 'uint8',
+            'type': 'uint8', 'transaction-type': 'uint8',
+            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
+            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
+            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
+           }}
+
 ##
 # @cxl-inject-poison:
 #
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index b189193f4c..a39e30d973 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -123,4 +123,27 @@ typedef struct CXLEventGenMedia {
     uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
 } QEMU_PACKED CXLEventGenMedia;
 
+/*
+ * DRAM Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
+ * All fields little endian.
+ */
+typedef struct CXLEventDram {
+    CXLEventRecordHdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint16_t validity_flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint64_t correction_mask[4];
+    uint8_t reserved[0x17];
+} QEMU_PACKED CXLEventDram;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b1618779d2..3c07b1b7a3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1196,6 +1196,11 @@ static const QemuUUID gen_media_uuid = {
                  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
 };
 
+static const QemuUUID dram_uuid = {
+    .data = UUID(0x601dcbb3, 0x9c06, 0x4eab, 0xb8, 0xaf,
+                 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+};
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1292,6 +1297,117 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 }
 
+#define CXL_DRAM_VALID_CHANNEL                          BIT(0)
+#define CXL_DRAM_VALID_RANK                             BIT(1)
+#define CXL_DRAM_VALID_NIBBLE_MASK                      BIT(2)
+#define CXL_DRAM_VALID_BANK_GROUP                       BIT(3)
+#define CXL_DRAM_VALID_BANK                             BIT(4)
+#define CXL_DRAM_VALID_ROW                              BIT(5)
+#define CXL_DRAM_VALID_COLUMN                           BIT(6)
+#define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
+
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint64_t dpa, uint8_t descriptor,
+                               uint8_t type, uint8_t transaction_type,
+                               bool has_channel, uint8_t channel,
+                               bool has_rank, uint8_t rank,
+                               bool has_nibble_mask, uint32_t nibble_mask,
+                               bool has_bank_group, uint8_t bank_group,
+                               bool has_bank, uint8_t bank,
+                               bool has_row, uint32_t row,
+                               bool has_column, uint16_t column,
+                               bool has_correction_mask, uint64List *correction_mask,
+                               Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventDram dram;
+    CXLEventRecordHdr *hdr = &dram.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
+    uint16_t valid_flags = 0;
+    uint8_t enc_log;
+    int rc;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+        return;
+    }
+    ct3d = CXL_TYPE3(obj);
+    cxlds = &ct3d->cxl_dstate;
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    memset(&dram, 0, sizeof(dram));
+    cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    stq_le_p(&dram.phys_addr, dpa);
+    dram.descriptor = descriptor;
+    dram.type = type;
+    dram.transaction_type = transaction_type;
+
+    if (has_channel) {
+        dram.channel = channel;
+        valid_flags |= CXL_DRAM_VALID_CHANNEL;
+    }
+
+    if (has_rank) {
+        dram.rank = rank;
+        valid_flags |= CXL_DRAM_VALID_RANK;
+    }
+
+    if (has_nibble_mask) {
+        st24_le_p(dram.nibble_mask, nibble_mask);
+        valid_flags |= CXL_DRAM_VALID_NIBBLE_MASK;
+    }
+
+    if (has_bank_group) {
+        dram.bank_group = bank_group;
+        valid_flags |= CXL_DRAM_VALID_BANK_GROUP;
+    }
+
+    if (has_bank) {
+        dram.bank = bank;
+        valid_flags |= CXL_DRAM_VALID_BANK;
+    }
+
+    if (has_row) {
+        st24_le_p(dram.row, row);
+        valid_flags |= CXL_DRAM_VALID_ROW;
+    }
+
+    if (has_column) {
+        stw_le_p(&dram.column, column);
+        valid_flags |= CXL_DRAM_VALID_COLUMN;
+    }
+
+    if (has_correction_mask) {
+        int count = 0;
+        while (correction_mask && count < 4) {
+            stq_le_p(&dram.correction_mask[count],
+                     correction_mask->value);
+            count++;
+            correction_mask = correction_mask->next;
+        }
+        valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
+    }
+
+    stw_le_p(&dram.validity_flags, valid_flags);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return;
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 4dfbdf9268..e904c5d089 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -13,6 +13,19 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp) {}
 
+void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint64_t dpa, uint8_t descriptor,
+                               uint8_t type, uint8_t transaction_type,
+                               bool has_channel, uint8_t channel,
+                               bool has_rank, uint8_t rank,
+                               bool has_nibble_mask, uint32_t nibble_mask,
+                               bool has_bank_group, uint8_t bank_group,
+                               bool has_bank, uint8_t bank,
+                               bool has_row, uint32_t row,
+                               bool has_column, uint16_t column,
+                               bool has_correction_mask, uint64List *correction_mask,
+                               Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
MST



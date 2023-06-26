Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BD73DF3D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKO-00011r-6D; Mon, 26 Jun 2023 08:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKM-00010p-N1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKK-0002dl-Cc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctNdhPChoMKnkBU3Q/zPm8VRBg89QlSJY0fP+5jZP4w=;
 b=H4GI+u/MoFLbWdngyeygvluSkYrpG10tESohFlzTDm3aG8c5I7KHih+NbhALOHSDqfr4oz
 0d3+gsN/A+/eON+2i5iiUNc2VFfq6XoBwKTdPzqN02GJcpeU1jRjpfmPa8yF7RMZeNFHVc
 lWiPynYat0s0VYGBvnZUI94d7PmYXts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JPx6BFIvMH6-ZeKw8x5vZw-1; Mon, 26 Jun 2023 08:28:12 -0400
X-MC-Unique: JPx6BFIvMH6-ZeKw8x5vZw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so23985325e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782491; x=1690374491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctNdhPChoMKnkBU3Q/zPm8VRBg89QlSJY0fP+5jZP4w=;
 b=Xecd0x7uvrvMxrkC+kY/T1ewVfPAe29FSP/1ZwWvJ/vuVWdbyCs9vwYX2q+L+s0qAG
 R+kuXTGBMIhwy4kpKYBDkFkClMT4odb5ZZfjWnVu1Pb5KwhuSRvw47BmilbWxgNJH/MM
 SB0VtuSLo2Ui16M7t3A4PygBQSIMAHyn5brYXaabU7JoEmCi3n58jihhey9M1xlnh2yC
 UwXHSslNI11gzw+tgMedh2IkdrrjDlsA34pOGy3cs2lDVCTlPIgTJHb8RrThutuloMNN
 YnrB93iLpErY2arlaSVZuEn5r7tGdMTo/iOS7ZKRB+F0widfrEH1XOPjD7v13C0DwSRk
 zZfQ==
X-Gm-Message-State: AC+VfDzktsPGVQSy7LVVGbQsLG6brRFuVIeB7Oaxl6oRZmpHJiSsFZnI
 SYrCH6NOwUZOSxrwYiSj0l9wRXvmgJZFcEQ1DRs1TYdhR5HDDIqGeIHn40wpE2/uuFLKUMrGNWY
 J9rpbum7bWztYCQrHqblVU3ouGM/yGmcvQJ1OgsT7NTWs5NwGcWg3R7ExH1Y4VKpBnhUJ
X-Received: by 2002:a1c:f709:0:b0:3f6:9634:c8d6 with SMTP id
 v9-20020a1cf709000000b003f69634c8d6mr25257038wmh.18.1687782490658; 
 Mon, 26 Jun 2023 05:28:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tCGI+hQXicZvO3SoCfuY2eZd+L7dGtw/n8zIQ2+7iU0BLruXTm1+qcjri7EQdlnzqrN7+gA==
X-Received: by 2002:a1c:f709:0:b0:3f6:9634:c8d6 with SMTP id
 v9-20020a1cf709000000b003f69634c8d6mr25257017wmh.18.1687782490238; 
 Mon, 26 Jun 2023 05:28:10 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 q6-20020a7bce86000000b003f7ea771b5dsm7612246wmj.1.2023.06.26.05.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:09 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 07/53] hw/cxl/events: Wire up get/clear event mailbox commands
Message-ID: <22d7e3be0714f39bae43bd0c05f6e6d149a47b13.1687782442.git.mst@redhat.com>
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

From: Ira Weiny <ira.weiny@intel.com>

CXL testing is benefited from an artificial event log injection
mechanism.

Add an event log infrastructure to insert, get, and clear events from
the various logs available on a device.

Replace the stubbed out CXL Get/Clear Event mailbox commands with
commands that operate on the new infrastructure.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  25 +++++
 include/hw/cxl/cxl_events.h |  55 +++++++++
 hw/cxl/cxl-events.c         | 217 ++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  40 ++++++-
 hw/mem/cxl_type3.c          |   1 +
 hw/cxl/meson.build          |   1 +
 6 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 hw/cxl/cxl-events.c

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9f8ee85f8a..d3aec1bc0e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -111,6 +111,20 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+typedef struct CXLEvent {
+    CXLEventRecordRaw data;
+    QSIMPLEQ_ENTRY(CXLEvent) node;
+} CXLEvent;
+
+typedef struct CXLEventLog {
+    uint16_t next_handle;
+    uint16_t overflow_err_count;
+    uint64_t first_overflow_timestamp;
+    uint64_t last_overflow_timestamp;
+    QemuMutex lock;
+    QSIMPLEQ_HEAD(, CXLEvent) events;
+} CXLEventLog;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
@@ -161,6 +175,8 @@ typedef struct cxl_device_state {
     uint64_t mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
+
+    CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
@@ -353,6 +369,15 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
+void cxl_event_init(CXLDeviceState *cxlds);
+bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
+                      CXLEventRecordRaw *event);
+CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
+                                 uint8_t log_type, int max_recs,
+                                 uint16_t *len);
+CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
+                                   CXLClearEventPayload *pl);
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index aeb3b0590e..d4aaa894f1 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -10,6 +10,8 @@
 #ifndef CXL_EVENTS_H
 #define CXL_EVENTS_H
 
+#include "qemu/uuid.h"
+
 /*
  * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
  *
@@ -25,4 +27,57 @@ typedef enum CXLEventLogType {
     CXL_EVENT_TYPE_MAX
 } CXLEventLogType;
 
+/*
+ * Common Event Record Format
+ * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+typedef struct CXLEventRecordHdr {
+    QemuUUID id;
+    uint8_t length;
+    uint8_t flags[3];
+    uint16_t handle;
+    uint16_t related_handle;
+    uint64_t timestamp;
+    uint8_t maint_op_class;
+    uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
+} QEMU_PACKED CXLEventRecordHdr;
+
+#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
+typedef struct CXLEventRecordRaw {
+    CXLEventRecordHdr hdr;
+    uint8_t data[CXL_EVENT_RECORD_DATA_LENGTH];
+} QEMU_PACKED CXLEventRecordRaw;
+#define CXL_EVENT_RECORD_SIZE (sizeof(CXLEventRecordRaw))
+
+/*
+ * Get Event Records output payload
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
+ */
+#define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
+#define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
+typedef struct CXLGetEventPayload {
+    uint8_t flags;
+    uint8_t reserved1;
+    uint16_t overflow_err_count;
+    uint64_t first_overflow_timestamp;
+    uint64_t last_overflow_timestamp;
+    uint16_t record_count;
+    uint8_t reserved2[0xa];
+    CXLEventRecordRaw records[];
+} QEMU_PACKED CXLGetEventPayload;
+#define CXL_EVENT_PAYLOAD_HDR_SIZE (sizeof(CXLGetEventPayload))
+
+/*
+ * Clear Event Records input payload
+ * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ */
+typedef struct CXLClearEventPayload {
+    uint8_t event_log;      /* CXLEventLogType */
+    uint8_t clear_flags;
+    uint8_t nr_recs;
+    uint8_t reserved[3];
+    uint16_t handle[];
+} CXLClearEventPayload;
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
new file mode 100644
index 0000000000..5da1b76b97
--- /dev/null
+++ b/hw/cxl/cxl-events.c
@@ -0,0 +1,217 @@
+/*
+ * CXL Event processing
+ *
+ * Copyright(C) 2023 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/typedefs.h"
+#include "qemu/error-report.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_events.h"
+
+/* Artificial limit on the number of events a log can hold */
+#define CXL_TEST_EVENT_OVERFLOW 8
+
+static void reset_overflow(CXLEventLog *log)
+{
+    log->overflow_err_count = 0;
+    log->first_overflow_timestamp = 0;
+    log->last_overflow_timestamp = 0;
+}
+
+void cxl_event_init(CXLDeviceState *cxlds)
+{
+    CXLEventLog *log;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        log = &cxlds->event_logs[i];
+        log->next_handle = 1;
+        log->overflow_err_count = 0;
+        log->first_overflow_timestamp = 0;
+        log->last_overflow_timestamp = 0;
+        qemu_mutex_init(&log->lock);
+        QSIMPLEQ_INIT(&log->events);
+    }
+}
+
+static CXLEvent *cxl_event_get_head(CXLEventLog *log)
+{
+    return QSIMPLEQ_FIRST(&log->events);
+}
+
+static CXLEvent *cxl_event_get_next(CXLEvent *entry)
+{
+    return QSIMPLEQ_NEXT(entry, node);
+}
+
+static int cxl_event_count(CXLEventLog *log)
+{
+    CXLEvent *event;
+    int rc = 0;
+
+    QSIMPLEQ_FOREACH(event, &log->events, node) {
+        rc++;
+    }
+
+    return rc;
+}
+
+static bool cxl_event_empty(CXLEventLog *log)
+{
+    return QSIMPLEQ_EMPTY(&log->events);
+}
+
+static void cxl_event_delete_head(CXLDeviceState *cxlds,
+                                  CXLEventLogType log_type,
+                                  CXLEventLog *log)
+{
+    CXLEvent *entry = cxl_event_get_head(log);
+
+    reset_overflow(log);
+    QSIMPLEQ_REMOVE_HEAD(&log->events, node);
+    if (cxl_event_empty(log)) {
+        cxl_event_set_status(cxlds, log_type, false);
+    }
+    g_free(entry);
+}
+
+/*
+ * return true if an interrupt should be generated as a result
+ * of inserting this event.
+ */
+bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
+                      CXLEventRecordRaw *event)
+{
+    uint64_t time;
+    CXLEventLog *log;
+    CXLEvent *entry;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return false;
+    }
+
+    time = cxl_device_get_timestamp(cxlds);
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+
+    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
+        if (log->overflow_err_count == 0) {
+            log->first_overflow_timestamp = time;
+        }
+        log->overflow_err_count++;
+        log->last_overflow_timestamp = time;
+        return false;
+    }
+
+    entry = g_new0(CXLEvent, 1);
+
+    memcpy(&entry->data, event, sizeof(*event));
+
+    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
+    log->next_handle++;
+    /* 0 handle is never valid */
+    if (log->next_handle == 0) {
+        log->next_handle++;
+    }
+    entry->data.hdr.timestamp = cpu_to_le64(time);
+
+    QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
+    cxl_event_set_status(cxlds, log_type, true);
+
+    /* Count went from 0 to 1 */
+    return cxl_event_count(log) == 1;
+}
+
+CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
+                                 uint8_t log_type, int max_recs,
+                                 uint16_t *len)
+{
+    CXLEventLog *log;
+    CXLEvent *entry;
+    uint16_t nr;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < max_recs; nr++) {
+        memcpy(&pl->records[nr], &entry->data, CXL_EVENT_RECORD_SIZE);
+        entry = cxl_event_get_next(entry);
+    }
+
+    if (!cxl_event_empty(log)) {
+        pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
+    }
+
+    if (log->overflow_err_count) {
+        pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
+        pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
+        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
+        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
+    }
+
+    pl->record_count = cpu_to_le16(nr);
+    *len = CXL_EVENT_PAYLOAD_HDR_SIZE + (CXL_EVENT_RECORD_SIZE * nr);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
+{
+    CXLEventLog *log;
+    uint8_t log_type;
+    CXLEvent *entry;
+    int nr;
+
+    log_type = pl->event_log;
+
+    if (log_type >= CXL_EVENT_TYPE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log = &cxlds->event_logs[log_type];
+
+    QEMU_LOCK_GUARD(&log->lock);
+    /*
+     * Must itterate the queue twice.
+     * "The device shall verify the event record handles specified in the input
+     * payload are in temporal order. If the device detects an older event
+     * record that will not be cleared when Clear Event Records is executed,
+     * the device shall return the Invalid Handle return code and shall not
+     * clear any of the specified event records."
+     *   -- CXL 3.0 8.2.9.2.3
+     */
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
+        uint16_t handle = pl->handle[nr];
+
+        /* NOTE: Both handles are little endian. */
+        if (handle == 0 || entry->data.hdr.handle != handle) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        entry = cxl_event_get_next(entry);
+    }
+
+    entry = cxl_event_get_head(log);
+    for (nr = 0; entry && nr < pl->nr_recs; nr++) {
+        cxl_event_delete_head(cxlds, log_type, log);
+        entry = cxl_event_get_head(log);
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d7e114aaae..3f46538048 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
@@ -95,11 +96,46 @@ struct cxl_cmd {
         return CXL_MBOX_SUCCESS;                                          \
     }
 
-DEFINE_MAILBOX_HANDLER_ZEROED(events_get_records, 0x20);
-DEFINE_MAILBOX_HANDLER_NOP(events_clear_records);
 DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
+static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxlds,
+                                         uint16_t *len)
+{
+    CXLGetEventPayload *pl;
+    uint8_t log_type;
+    int max_recs;
+
+    if (cmd->in < sizeof(log_type)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    log_type = *((uint8_t *)cmd->payload);
+
+    pl = (CXLGetEventPayload *)cmd->payload;
+    memset(pl, 0, sizeof(*pl));
+
+    max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
+                CXL_EVENT_RECORD_SIZE;
+    if (max_recs > 0xFFFF) {
+        max_recs = 0xFFFF;
+    }
+
+    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
+}
+
+static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
+                                           CXLDeviceState *cxlds,
+                                           uint16_t *len)
+{
+    CXLClearEventPayload *pl;
+
+    pl = (CXLClearEventPayload *)cmd->payload;
+    *len = 0;
+    return cxl_event_clear_records(cxlds, pl);
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                                CXLDeviceState *cxl_dstate,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d751803188..ec5a384885 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -724,6 +724,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         goto err_release_cdat;
     }
 
+    cxl_event_init(&ct3d->cxl_dstate);
     return;
 
 err_release_cdat:
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index 1f9aa2ea1f..e261ff3881 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -5,6 +5,7 @@ system_ss.add(when: 'CONFIG_CXL',
                    'cxl-mailbox-utils.c',
                    'cxl-host.c',
                    'cxl-cdat.c',
+                   'cxl-events.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
-- 
MST



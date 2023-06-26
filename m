Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE673DF35
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKR-0001Ag-4I; Mon, 26 Jun 2023 08:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKO-00012A-43
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKL-0002f6-P1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ilGqUyOuwXdX2jgpH+sgMrGmrKAcuD6YkMqh6lWY1yI=;
 b=ZED/y8OPolYyFAY6bXJrtBQjxVOF5oZbFzZyU9w+mvZ4/YjT+OPqqYidLUGFqzGlvYTqrg
 Q8+XWMYCAO6oxYndTRoTVd4TiN+ZfHgSdy9VFxINOSK8lkzXWmODt45kJSc0sJbDKLSC3Y
 +VGUf85bRlG7oaFjUnrOB0ZCX1ogJl4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-g8Fpz2ecNp-o-aPzFpaTkA-1; Mon, 26 Jun 2023 08:28:15 -0400
X-MC-Unique: g8Fpz2ecNp-o-aPzFpaTkA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313e896c998so1043869f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782493; x=1690374493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilGqUyOuwXdX2jgpH+sgMrGmrKAcuD6YkMqh6lWY1yI=;
 b=fucnCXp3yIdF2E1LlANh3dq7T7z0u/LNPou5oJ3xpPDk1TwPo+pAr0JEvSPYn0+qbX
 wUx6x5exOmB9IV4YjOutTPlBld6zS/1SGZBh/VapHusKvQs9jO09Qd2Zjpmw7tQIEBNw
 AwOBMSTd5IbS64Za74XPmNi5JWyViRSOwl5PF9XheXduNEukW3Z0BV1elpREu8Okupk5
 NhQnJTyE52mBDGnLDwLG++I6lHI5Yduvj9BIl5oEU7GMbTkWkSUunIeO9ORAhBC0jer9
 Oll1+aYFL1/rK6K1BJVikXw+O6pFdzhGqUnfY5r4BpKdTMKn5WcSk+kVu37eUzmRd47V
 VWkw==
X-Gm-Message-State: AC+VfDxe0BjuXyTjL36jlPkSOL2W35eyezEPJzFeJIK1ufVB4BbS2+YC
 qzfzcgAfdHN3pwdYGGKiza8yUxZ9oNceXBfVQlCwY+yDIeULZK074JUDy/78wG6hI5rE54Dc1bJ
 l0HZgxWTd66sXYOC/uVs6m2MQWEwuN3LioIFe74+9COt2mYuRal+keGMgzeeUe8QkJtJb
X-Received: by 2002:a5d:4d0d:0:b0:313:f4e4:9dd with SMTP id
 z13-20020a5d4d0d000000b00313f4e409ddmr1250461wrt.62.1687782493458; 
 Mon, 26 Jun 2023 05:28:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xrdtrj9AsdVSN1QPlw5M1eGMtPDCd5c+eebIhnNP84RHLqdphe4flaKnyzS1tFiV1rYk8Sg==
X-Received: by 2002:a5d:4d0d:0:b0:313:f4e4:9dd with SMTP id
 z13-20020a5d4d0d000000b00313f4e409ddmr1250442wrt.62.1687782493106; 
 Mon, 26 Jun 2023 05:28:13 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u12-20020adfdd4c000000b0030903d44dbcsm7292150wrm.33.2023.06.26.05.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:12 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 08/53] hw/cxl/events: Add event interrupt support
Message-ID: <6676bb973ba53d60886b06213ec98fbd736d66a1.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
commands.  Enable those commands to control interrupts for each of the
event log types.

Skip the standard input mailbox length on the Set command due to DCD
being optional.  Perform the checks separately.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   6 +-
 include/hw/cxl/cxl_events.h |  23 ++++++++
 hw/cxl/cxl-events.c         |  33 ++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 106 +++++++++++++++++++++++++++++-------
 hw/mem/cxl_type3.c          |   4 +-
 5 files changed, 147 insertions(+), 25 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d3aec1bc0e..1978730fba 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -121,6 +121,8 @@ typedef struct CXLEventLog {
     uint16_t overflow_err_count;
     uint64_t first_overflow_timestamp;
     uint64_t last_overflow_timestamp;
+    bool irq_enabled;
+    int irq_vec;
     QemuMutex lock;
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
@@ -369,7 +371,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
-void cxl_event_init(CXLDeviceState *cxlds);
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
 bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
                       CXLEventRecordRaw *event);
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
@@ -378,6 +380,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
 
+void cxl_event_irq_assert(CXLType3Dev *ct3d);
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index d4aaa894f1..4bf8b7aa08 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -80,4 +80,27 @@ typedef struct CXLClearEventPayload {
     uint16_t handle[];
 } CXLClearEventPayload;
 
+/**
+ * Event Interrupt Policy
+ *
+ * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ */
+typedef enum CXLEventIntMode {
+    CXL_INT_NONE     = 0x00,
+    CXL_INT_MSI_MSIX = 0x01,
+    CXL_INT_FW       = 0x02,
+    CXL_INT_RES      = 0x03,
+} CXLEventIntMode;
+#define CXL_EVENT_INT_MODE_MASK 0x3
+#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
+typedef struct CXLEventInterruptPolicy {
+    uint8_t info_settings;
+    uint8_t warn_settings;
+    uint8_t failure_settings;
+    uint8_t fatal_settings;
+    uint8_t dyn_cap_settings;
+} QEMU_PACKED CXLEventInterruptPolicy;
+/* DCD is optional but other fields are not */
+#define CXL_EVENT_INT_SETTING_MIN_LEN 4
+
 #endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 5da1b76b97..d161d57456 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -13,6 +13,8 @@
 #include "qemu/bswap.h"
 #include "qemu/typedefs.h"
 #include "qemu/error-report.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
@@ -26,7 +28,7 @@ static void reset_overflow(CXLEventLog *log)
     log->last_overflow_timestamp = 0;
 }
 
-void cxl_event_init(CXLDeviceState *cxlds)
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num)
 {
     CXLEventLog *log;
     int i;
@@ -37,9 +39,16 @@ void cxl_event_init(CXLDeviceState *cxlds)
         log->overflow_err_count = 0;
         log->first_overflow_timestamp = 0;
         log->last_overflow_timestamp = 0;
+        log->irq_enabled = false;
+        log->irq_vec = start_msg_num++;
         qemu_mutex_init(&log->lock);
         QSIMPLEQ_INIT(&log->events);
     }
+
+    /* Override -- Dynamic Capacity uses the same vector as info */
+    cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP].irq_vec =
+                      cxlds->event_logs[CXL_EVENT_TYPE_INFO].irq_vec;
+
 }
 
 static CXLEvent *cxl_event_get_head(CXLEventLog *log)
@@ -215,3 +224,25 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *
 
     return CXL_MBOX_SUCCESS;
 }
+
+void cxl_event_irq_assert(CXLType3Dev *ct3d)
+{
+    CXLDeviceState *cxlds = &ct3d->cxl_dstate;
+    PCIDevice *pdev = &ct3d->parent_obj;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        CXLEventLog *log = &cxlds->event_logs[i];
+
+        if (!log->irq_enabled || cxl_event_empty(log)) {
+            continue;
+        }
+
+        /*  Notifies interrupt, legacy IRQ is not supported */
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, log->irq_vec);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, log->irq_vec);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3f46538048..02f9b5a870 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -80,25 +80,6 @@ struct cxl_cmd {
     uint8_t *payload;
 };
 
-#define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
-    uint16_t __zero##name = size;                                         \
-    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
-                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        *len = __zero##name;                                              \
-        memset(cmd->payload, 0, *len);                                    \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-#define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
-    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
-                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-
-DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
-DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
-
 static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
                                          CXLDeviceState *cxlds,
                                          uint16_t *len)
@@ -136,6 +117,88 @@ static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
     return cxl_event_clear_records(cxlds, pl);
 }
 
+static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+                                                  CXLDeviceState *cxlds,
+                                                  uint16_t *len)
+{
+    CXLEventInterruptPolicy *policy;
+    CXLEventLog *log;
+
+    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    memset(policy, 0, sizeof(*policy));
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    if (log->irq_enabled) {
+        policy->info_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    if (log->irq_enabled) {
+        policy->warn_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    if (log->irq_enabled) {
+        policy->failure_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    if (log->irq_enabled) {
+        policy->fatal_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
+    if (log->irq_enabled) {
+        /* Dynamic Capacity borrows the same vector as info */
+        policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
+    }
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
+                                                  CXLDeviceState *cxlds,
+                                                  uint16_t *len)
+{
+    CXLEventInterruptPolicy *policy;
+    CXLEventLog *log;
+
+    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    policy = (CXLEventInterruptPolicy *)cmd->payload;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    log->irq_enabled = (policy->warn_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    log->irq_enabled = (policy->failure_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    log->irq_enabled = (policy->fatal_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    /* DCD is optional */
+    if (*len < sizeof(*policy)) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
+    log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                                CXLDeviceState *cxl_dstate,
@@ -611,9 +674,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
         cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
-        cmd_events_get_interrupt_policy, 0, 0 },
+                                      cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
-        cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+                                      cmd_events_set_interrupt_policy,
+                                      ~0, IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ec5a384885..c9e347f42b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -659,7 +659,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 1;
+    unsigned short msix_num = 6;
     int i, rc;
 
     QTAILQ_INIT(&ct3d->error_list);
@@ -723,8 +723,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     if (rc) {
         goto err_release_cdat;
     }
+    cxl_event_init(&ct3d->cxl_dstate, 2);
 
-    cxl_event_init(&ct3d->cxl_dstate);
     return;
 
 err_release_cdat:
-- 
MST



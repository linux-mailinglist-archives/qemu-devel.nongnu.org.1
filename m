Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DF73DF29
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlKG-0000z0-BP; Mon, 26 Jun 2023 08:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKD-0000wX-VU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKC-0002Yq-0x
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wPDxc9YqI6AoJHyJER4tPjBxwE7SdPofbV/3jbPeXFo=;
 b=eUbfBfBjVDfyePrPlxx2DGDjtAMsoTbVrHdEjxv6N6hSljS/pKnJgQc3TdIsZ+lKr2ezCa
 jyVre74UVbos7ueoNa5yXP/q7YYC1YTRFAs9dXz9pRfpvSOEB1a1UJAE6FIzB9Dkj8cIPq
 EJxc+XG5er58QQrPiVGd40jKIL7edbI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-TkAUlja9O3qmCckg9pN1Mg-1; Mon, 26 Jun 2023 08:28:06 -0400
X-MC-Unique: TkAUlja9O3qmCckg9pN1Mg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313f442806dso379353f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782484; x=1690374484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPDxc9YqI6AoJHyJER4tPjBxwE7SdPofbV/3jbPeXFo=;
 b=PlaRJ1CXLF2GFfoY8Y+BiapzTOcDmHy53IBPeCpogv7A9BzNU86sWiTqVw1TtcMbGO
 K521yC++2/FPO0WHgdz+ZjMRY9Mn9BEwULOxrK+jgXcqqP63EeRp29DyQOaZfL9sYfEK
 vi25Evqw/41BTQkLofJ4cb4FsudV6rciY4GKwqJRcFfnjFZYvgMZT6E79R7C4sAS4uIk
 SYgupAh7SXEI5v+FTbIacwViFkKwo1BNAt+qGOVwYd6fwi9leaa4xNNZM0opJqknLppi
 Z2ZFg4Ti6rfYXWBS0cHO6ZljrywqHJJrWYMNuJos+C4YuoDM0SwpAMh1jHtpz9Sojsq3
 pGhw==
X-Gm-Message-State: AC+VfDxrwlY4fCthkz7a5Abq/KC+rCzL+3BZgxARUODeHXp11L59mhS5
 +Hm20KJsejUvNChVW6SmW5bLkyf94jfU/SEYRNo5utK3vP9wxIBp7UZHTIQAjaAn+B3yAuIBM4t
 KuMmysynqNrPWKpbSpG/XWzR2IXVUkgAqt9jYmK7oUk5zc6vBVhIzq3PvJ1piTcw/dZ6i
X-Received: by 2002:a05:6000:1c4:b0:313:f462:768 with SMTP id
 t4-20020a05600001c400b00313f4620768mr1289404wrx.14.1687782484356; 
 Mon, 26 Jun 2023 05:28:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MhjRp5VSwfh/TZshU9I+MfWNXNi/I5vOel3UoaGSr297QFv7HQjuORiIJZwTzzcvLvgephQ==
X-Received: by 2002:a05:6000:1c4:b0:313:f462:768 with SMTP id
 t4-20020a05600001c400b00313f4620768mr1289384wrx.14.1687782484077; 
 Mon, 26 Jun 2023 05:28:04 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4c83000000b0030497b3224bsm7242259wrs.64.2023.06.26.05.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:03 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 05/53] hw/cxl/events: Add event status register
Message-ID: <d7b84ddc3b99ae4dcac052a03817aeeab9d12514.1687782442.git.mst@redhat.com>
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

The device status register block was defined.  However, there were no
individual registers nor any data wired up.

Define the event status register [CXL 3.0; 8.2.8.3.1] as part of the
device status register block.  Wire up the register and initialize the
event status for each log.

To support CXL 3.0 the version of the device status register block needs
to be 2.  Change the macro to allow for setting the version.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230530133603.16934-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 23 +++++++++++++++++---
 include/hw/cxl/cxl_events.h | 28 ++++++++++++++++++++++++
 hw/cxl/cxl-device-utils.c   | 43 ++++++++++++++++++++++++++++++++-----
 3 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/cxl/cxl_events.h

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 73328a52cf..16993f7098 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -13,6 +13,7 @@
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
+#include "hw/cxl/cxl_events.h"
 
 /*
  * The following is how a CXL device's Memory Device registers are laid out.
@@ -86,7 +87,16 @@ typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
-    MemoryRegion device;
+    struct {
+        MemoryRegion device;
+        union {
+            uint8_t dev_reg_state[CXL_DEVICE_STATUS_REGISTERS_LENGTH];
+            uint16_t dev_reg_state16[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 2];
+            uint32_t dev_reg_state32[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 4];
+            uint64_t dev_reg_state64[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 8];
+        };
+        uint64_t event_status;
+    };
     MemoryRegion memory_device;
     struct {
         MemoryRegion caps;
@@ -141,6 +151,9 @@ REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte access
     FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
     FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
 
+void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
+                          bool available);
+
 /*
  * Helper macro to initialize capability headers for CXL devices.
  *
@@ -175,7 +188,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
 
-#define cxl_device_cap_init(dstate, reg, cap_id)                           \
+#define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
         int which = R_CXL_DEV_##reg##_CAP_HDR0;                            \
@@ -183,7 +196,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
             FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0,          \
                        CAP_ID, cap_id);                                    \
         cap_hdrs[which] = FIELD_DP32(                                      \
-            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);    \
+            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, ver);  \
         cap_hdrs[which + 1] =                                              \
             FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,      \
                        CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);          \
@@ -192,6 +205,10 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
                        CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);          \
     } while (0)
 
+/* CXL 3.0 8.2.8.3.1 Event Status Register */
+REG64(CXL_DEV_EVENT_STATUS, 0)
+    FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
+
 /* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
new file mode 100644
index 0000000000..aeb3b0590e
--- /dev/null
+++ b/include/hw/cxl/cxl_events.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU CXL Events
+ *
+ * Copyright (c) 2022 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_EVENTS_H
+#define CXL_EVENTS_H
+
+/*
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ *
+ * Define these as the bit position for the event status register for ease of
+ * setting the status.
+ */
+typedef enum CXLEventLogType {
+    CXL_EVENT_TYPE_INFO          = 0,
+    CXL_EVENT_TYPE_WARN          = 1,
+    CXL_EVENT_TYPE_FAIL          = 2,
+    CXL_EVENT_TYPE_FATAL         = 3,
+    CXL_EVENT_TYPE_DYNAMIC_CAP   = 4,
+    CXL_EVENT_TYPE_MAX
+} CXLEventLogType;
+
+#endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 86e1cea8ce..517f06d869 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -41,7 +41,20 @@ static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
 
 static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    return 0;
+    CXLDeviceState *cxl_dstate = opaque;
+
+    switch (size) {
+    case 1:
+        return cxl_dstate->dev_reg_state[offset];
+    case 2:
+        return cxl_dstate->dev_reg_state16[offset / size];
+    case 4:
+        return cxl_dstate->dev_reg_state32[offset / size];
+    case 8:
+        return cxl_dstate->dev_reg_state64[offset / size];
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
@@ -236,7 +249,27 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                                 &cxl_dstate->memory_device);
 }
 
-static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
+void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
+                          bool available)
+{
+    if (available) {
+        cxl_dstate->event_status |= (1 << log_type);
+    } else {
+        cxl_dstate->event_status &= ~(1 << log_type);
+    }
+
+    ARRAY_FIELD_DP64(cxl_dstate->dev_reg_state64, CXL_DEV_EVENT_STATUS,
+                     EVENT_STATUS, cxl_dstate->event_status);
+}
+
+static void device_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    CXLEventLogType log;
+
+    for (log = 0; log < CXL_EVENT_TYPE_MAX; log++) {
+        cxl_event_set_status(cxl_dstate, log, false);
+    }
+}
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
@@ -258,13 +291,13 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
 
-    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1);
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
     device_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
     mailbox_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
     cxl_initialize_mailbox(cxl_dstate);
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE685481E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Feb 2024 12:21:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFV-0005ld-Kr; Wed, 14 Feb 2024 06:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFO-0005cc-41
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFJ-0007Oi-U4
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2Fy7C90mQ0ERPj+zUleNb8jOASiAWlxxZfrJZwybPk=;
 b=Bqwkcc6tS71xdWOee6KjYRcYRfj3xc9hSrSOdOigINqSrB+2/tsSzGA+orCIsVGoBmRCWO
 5DRaAXxyq7d5TyoysWDDZNejA+c8hB68MYViRpYFCb1ECT7Hg8NxnI1Ln9VnzsGkg3672r
 S72my6m7AuOX4yTL060I6Zwo7sel1/A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-gXU18v20Onq8ifCT-wqY9Q-1; Wed, 14 Feb 2024 06:16:07 -0500
X-MC-Unique: gXU18v20Onq8ifCT-wqY9Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5621455776fso941546a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909366; x=1708514166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2Fy7C90mQ0ERPj+zUleNb8jOASiAWlxxZfrJZwybPk=;
 b=VKM+kDEESdUF/E/V0fljsDzKR7FFvYgMa7iywIpjsuQP11U6MQQV7nCX1EInHyXdt2
 zTP6D2x9fyf2NmGIcUq1Jzara7Mz6/TRbD4fA/Foc9MGoYVJMRUP+6N3dSua0NafykYe
 ZABKVaq5avRkOZlkTlmPYF4np6qPxMCwApyJjiAMe0J42fetB/1MwsF4d/u28oH9E22b
 FDV6kgIsJk3euxgFVVuuw3knduIxGvRV6VoJHEeRiPsjuqTx7uzTaTz2Py2uuZjuyoIo
 URlFt+Pzx9nmLdNkg3iYF8lTfV8tpFm1blalYG2TrSpiF1cOL38ttQXqNM9CleSr1ZZ6
 Itvw==
X-Gm-Message-State: AOJu0YzmmyEIf7xfn32dquCLETaO5h6OnXca27UGEFKGNHFRlOcRXPwx
 L+vTd+e/6m3hPzAMnr+iWegJ82GizJOD3tU9wVbu/jeyefart2KjHgj7Ww0IYzLjBLbC6X2b320
 NWQYCzQQpQvxvA8dMDJZ5NM/Pc2mO8ye9VhhTitHoXJ9KbbiIvSAYNBmLdsJnWDqNo33XV10bMO
 n4SXc0OfQiVw6iCyXZkC98EBDJF1oZdg==
X-Received: by 2002:a05:6402:22ca:b0:562:9e4f:6bd1 with SMTP id
 dm10-20020a05640222ca00b005629e4f6bd1mr1067624edb.9.1707909365644; 
 Wed, 14 Feb 2024 03:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt6oiEKAwiv5l5VAXXM5lKgT5yG3ZH/VZmxaBeO1PRIa7N2fmC93eAx1rJ17PlX4ZThGT1fQ==
X-Received: by 2002:a05:6402:22ca:b0:562:9e4f:6bd1 with SMTP id
 dm10-20020a05640222ca00b005629e4f6bd1mr1067598edb.9.1707909364903; 
 Wed, 14 Feb 2024 03:16:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWaaKcJVOQm0NzdnZnElOBi1WFsBu5bpfG4PIT+CLRybRCY6fHxnM8MmRtLSLeQio9JLkTaA0LaUayS+O+zSWz9hzzbhPzdqBhRI7Afo0uG0ppPBXmJBZAn+xrBV7g9HbCkrlU2ZzUgRZXqZjXhEd7giURyznnQWWmFwUM=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 c3-20020a50d643000000b0056022d78141sm4884035edj.56.2024.02.14.03.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:04 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 53/60] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
Message-ID: <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Previously not all references mentioned any spec version at all.
Given r3.1 is the current specification available for evaluation at
www.computeexpresslink.org update references to refer to that.
Hopefully this won't become a never ending job.

A few structure definitions have been updated to add new fields.
Defaults of 0 and read only are valid choices for these new DVSEC
registers so go with that for now.

There are additional error codes and some of the 'questions' in
the comments are resolved now.

Update documentation reference to point to the CXL r3.1 specification
with naming closer to what is on the cover.

For cases where there are structure version numbers, add defines
so they can be found next to the register definitions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126121636.24611-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_cdat.h      | 10 ++---
 include/hw/cxl/cxl_component.h | 26 ++++++++-----
 include/hw/cxl/cxl_device.h    | 60 +++++++++++++++++++++---------
 include/hw/cxl/cxl_events.h    | 18 ++++-----
 include/hw/cxl/cxl_pci.h       | 67 ++++++++++++++++++++++++----------
 hw/cxl/cxl-component-utils.c   | 17 +++++----
 hw/cxl/cxl-device-utils.c      |  8 ++--
 hw/cxl/cxl-events.c            |  2 +-
 hw/cxl/cxl-mailbox-utils.c     | 49 ++++++++++++++-----------
 hw/mem/cxl_type3.c             |  6 +--
 hw/pci-bridge/cxl_downstream.c |  4 +-
 hw/pci-bridge/cxl_root_port.c  |  4 +-
 hw/pci-bridge/cxl_upstream.c   |  4 +-
 docs/system/devices/cxl.rst    |  3 +-
 14 files changed, 174 insertions(+), 104 deletions(-)

diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
index 7f67638685..8e3d094608 100644
--- a/include/hw/cxl/cxl_cdat.h
+++ b/include/hw/cxl/cxl_cdat.h
@@ -16,17 +16,17 @@
 /*
  * Reference:
  *   Coherent Device Attribute Table (CDAT) Specification, Rev. 1.03, July. 2022
- *   Compute Express Link (CXL) Specification, Rev. 3.0, Aug. 2022
+ *   Compute Express Link (CXL) Specification, Rev. 3.1, Aug. 2023
  */
-/* Table Access DOE - CXL r3.0 8.1.11 */
+/* Table Access DOE - CXL r3.1 8.1.11 */
 #define CXL_DOE_TABLE_ACCESS      2
 #define CXL_DOE_PROTOCOL_CDAT     ((CXL_DOE_TABLE_ACCESS << 16) | CXL_VENDOR_ID)
 
-/* Read Entry - CXL r3.0 8.1.11.1 */
+/* Read Entry - CXL r3.1 8.1.11.1 */
 #define CXL_DOE_TAB_TYPE_CDAT 0
 #define CXL_DOE_TAB_ENT_MAX 0xFFFF
 
-/* Read Entry Request - CXL r3.0 8.1.11.1 Table 8-13 */
+/* Read Entry Request - CXL r3.1 8.1.11.1 Table 8-13 */
 #define CXL_DOE_TAB_REQ 0
 typedef struct CDATReq {
     DOEHeader header;
@@ -35,7 +35,7 @@ typedef struct CDATReq {
     uint16_t entry_handle;
 } QEMU_PACKED CDATReq;
 
-/* Read Entry Response - CXL r3.0 8.1.11.1 Table 8-14 */
+/* Read Entry Response - CXL r3.1 8.1.11.1 Table 8-14 */
 #define CXL_DOE_TAB_RSP 0
 typedef struct CDATRsp {
     DOEHeader header;
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index b5da72b789..0e5d35c263 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -10,7 +10,7 @@
 #ifndef CXL_COMPONENT_H
 #define CXL_COMPONENT_H
 
-/* CXL 2.0 - 8.2.4 */
+/* CXL r3.1 Section 8.2.4: CXL.cache and CXL.mem Registers  */
 #define CXL2_COMPONENT_IO_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_CM_REGION_SIZE 0x1000
 #define CXL2_COMPONENT_BLOCK_SIZE 0x10000
@@ -34,10 +34,11 @@ enum reg_type {
  * Capability registers are defined at the top of the CXL.cache/mem region and
  * are packed. For our purposes we will always define the caps in the same
  * order.
- * CXL 2.0 - 8.2.5 Table 142 for details.
+ * CXL r3.1 Table 8-22: CXL_CAPABILITY_ID Assignment for details.
  */
 
-/* CXL 2.0 - 8.2.5.1 */
+/* CXL r3.1 Section 8.2.4.1: CXL Capability Header Register */
+#define CXL_CAPABILITY_VERSION 1
 REG32(CXL_CAPABILITY_HEADER, 0)
     FIELD(CXL_CAPABILITY_HEADER, ID, 0, 16)
     FIELD(CXL_CAPABILITY_HEADER, VERSION, 16, 4)
@@ -102,12 +103,13 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
 #define CXL_RAS_ERR_HEADER_NUM 32
 /* Offset 0x18 - 0x58 reserved for RAS logs */
 
-/* 8.2.5.10 - CXL Security Capability Structure */
+/* CXL r3.1 Section 8.2.4.18: CXL Security Capability Structure */
 #define CXL_SEC_REGISTERS_OFFSET \
     (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
 #define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
 
 /* CXL r3.1 Section 8.2.4.19: CXL Link Capability Structure */
+#define CXL_LINK_CAPABILITY_VERSION 2
 #define CXL_LINK_REGISTERS_OFFSET \
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
 #define CXL_LINK_REGISTERS_SIZE   0x50
@@ -175,18 +177,24 @@ HDM_DECODER_INIT(1);
 HDM_DECODER_INIT(2);
 HDM_DECODER_INIT(3);
 
-/* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
+/*
+ * CXL r3.1 Section 8.2.4.21: CXL Extended Security Capability Structure
+ * (Root complex only)
+ */
 #define EXTSEC_ENTRY_MAX        256
+#define CXL_EXTSEC_CAP_VERSION 2
 #define CXL_EXTSEC_REGISTERS_OFFSET \
     (CXL_HDM_REGISTERS_OFFSET + CXL_HDM_REGISTERS_SIZE)
 #define CXL_EXTSEC_REGISTERS_SIZE   (8 * EXTSEC_ENTRY_MAX + 4)
 
-/* 8.2.5.14 - CXL IDE Capability Structure */
+/* CXL r3.1 Section 8.2.4.22: CXL IDE Capability Structure */
+#define CXL_IDE_CAP_VERSION 2
 #define CXL_IDE_REGISTERS_OFFSET \
     (CXL_EXTSEC_REGISTERS_OFFSET + CXL_EXTSEC_REGISTERS_SIZE)
-#define CXL_IDE_REGISTERS_SIZE   0x20
+#define CXL_IDE_REGISTERS_SIZE   0x24
 
-/* 8.2.5.15 - CXL Snoop Filter Capability Structure */
+/* CXL r3.1 Section 8.2.4.23 - CXL Snoop Filter Capability Structure */
+#define CXL_SNOOP_CAP_VERSION 1
 #define CXL_SNOOP_REGISTERS_OFFSET \
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
@@ -202,7 +210,7 @@ typedef struct component_registers {
     MemoryRegion component_registers;
 
     /*
-     * 8.2.4 Table 141:
+     * CXL r3.1 Table 8-21: CXL Subsystem Component Register Ranges
      *   0x0000 - 0x0fff CXL.io registers
      *   0x1000 - 0x1fff CXL.cache and CXL.mem
      *   0x2000 - 0xdfff Implementation specific
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9f51c586d7..d8e184c4ba 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -58,18 +58,30 @@
  *
  */
 
-#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10 /* Figure 138 */
-#define CXL_DEVICE_CAP_REG_SIZE 0x10 /* 8.2.8.2 */
-#define CXL_DEVICE_CAPS_MAX 4 /* 8.2.8.2.1 + 8.2.8.5 */
+/* CXL r3.1 Figure 8-12: CXL Device Registers */
+#define CXL_DEVICE_CAP_HDR1_OFFSET 0x10
+/* CXL r3.1 Section 8.2.8.2: CXL Device Capability Header Register */
+#define CXL_DEVICE_CAP_REG_SIZE 0x10
+
+/*
+ * CXL r3.1 Section 8.2.8.2.1: CXL Device Capabilities +
+ * CXL r3.1 Section 8.2.8.5: Memory Device Capabilities
+ */
+#define CXL_DEVICE_CAPS_MAX 4
 #define CXL_CAPS_SIZE \
     (CXL_DEVICE_CAP_REG_SIZE * (CXL_DEVICE_CAPS_MAX + 1)) /* +1 for header */
 
 #define CXL_DEVICE_STATUS_REGISTERS_OFFSET 0x80 /* Read comment above */
-#define CXL_DEVICE_STATUS_REGISTERS_LENGTH 0x8 /* 8.2.8.3.1 */
+/*
+ * CXL r3.1 Section 8.2.8.3: Device Status Registers
+ * As it is the only Device Status Register in CXL r3.1
+ */
+#define CXL_DEVICE_STATUS_REGISTERS_LENGTH 0x8
 
 #define CXL_MAILBOX_REGISTERS_OFFSET \
     (CXL_DEVICE_STATUS_REGISTERS_OFFSET + CXL_DEVICE_STATUS_REGISTERS_LENGTH)
-#define CXL_MAILBOX_REGISTERS_SIZE 0x20 /* 8.2.8.4, Figure 139 */
+/* CXL r3.1 Figure 8-13: Mailbox Registers */
+#define CXL_MAILBOX_REGISTERS_SIZE 0x20
 #define CXL_MAILBOX_PAYLOAD_SHIFT 11
 #define CXL_MAILBOX_MAX_PAYLOAD_SIZE (1 << CXL_MAILBOX_PAYLOAD_SHIFT)
 #define CXL_MAILBOX_REGISTERS_LENGTH \
@@ -83,7 +95,7 @@
     (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
      CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
 
-/* 8.2.8.4.5.1 Command Return Codes */
+/* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
     CXL_MBOX_BG_STARTED = 0x1,
@@ -108,7 +120,17 @@ typedef enum {
     CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
     CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
-    CXL_MBOX_MAX = 0x17
+    CXL_MBOX_INVALID_LOG = 0x17,
+    CXL_MBOX_INTERRUPTED = 0x18,
+    CXL_MBOX_UNSUPPORTED_FEATURE_VERSION = 0x19,
+    CXL_MBOX_UNSUPPORTED_FEATURE_SELECTION_VALUE = 0x1a,
+    CXL_MBOX_FEATURE_TRANSFER_IN_PROGRESS = 0x1b,
+    CXL_MBOX_FEATURE_TRANSFER_OUT_OF_ORDER = 0x1c,
+    CXL_MBOX_RESOURCES_EXHAUSTED = 0x1d,
+    CXL_MBOX_INVALID_EXTENT_LIST = 0x1e,
+    CXL_MBOX_TRANSFER_OUT_OF_ORDER = 0x1f,
+    CXL_MBOX_REQUEST_ABORT_NOTSUP = 0x20,
+    CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
 typedef struct CXLCCI CXLCCI;
@@ -169,7 +191,7 @@ typedef struct CXLCCI {
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
-    /* mmio for device capabilities array - 8.2.8.2 */
+    /* CXL r3.1 Section 8.2.8.3: Device Status Registers */
     struct {
         MemoryRegion device;
         union {
@@ -231,7 +253,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d);
 void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
 
 /*
- * CXL 2.0 - 8.2.8.1 including errata F4
+ * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register
  * Documented as a 128 bit register, but 64 bit accesses and the second
  * 64 bits are currently reserved.
  */
@@ -246,17 +268,18 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
 /*
  * Helper macro to initialize capability headers for CXL devices.
  *
- * In the 8.2.8.2, this is listed as a 128b register, but in 8.2.8, it says:
+ * In CXL r3.1 Section 8.2.8.2: CXL Device Capablity Header Register, this is
+ * listed as a 128b register, but in CXL r3.1 Section 8.2.8: CXL Device Register
+ * Interface, it says:
  * > No registers defined in Section 8.2.8 are larger than 64-bits wide so that
  * > is the maximum access size allowed for these registers. If this rule is not
- * > followed, the behavior is undefined
+ * > followed, the behavior is undefined.
  *
- * CXL 2.0 Errata F4 states further that the layouts in the specification are
- * shown as greater than 128 bits, but implementations are expected to
- * use any size of access up to 64 bits.
+ * > To illustrate how the fields fit together, the layouts ... are shown as
+ * > wider than a 64 bit register. Implemenations are expected to use any size
+ * > accesses for this information up to 64 bits without lost of functionality
  *
- * Here we've chosen to make it 4 dwords. The spec allows any pow2 multiple
- * access to be used for a register up to 64 bits.
+ * Here we've chosen to make it 4 dwords.
  */
 #define CXL_DEVICE_CAPABILITY_HEADER_REGISTER(n, offset)  \
     REG32(CXL_DEV_##n##_CAP_HDR0, offset)                 \
@@ -306,7 +329,8 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
                        CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);          \
     } while (0)
 
-/* CXL 3.0 8.2.8.3.1 Event Status Register */
+/* CXL r3.2 Section 8.2.8.3.1: Event Status Register */
+#define CXL_DEVICE_STATUS_VERSION 2
 REG64(CXL_DEV_EVENT_STATUS, 0)
     FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
 
@@ -348,6 +372,8 @@ REG64(CXL_DEV_BG_CMD_STS, 0x18)
 /* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
+/* CXL r3.1 Section 8.2.8.4.1: Memory Device Status Registers */
+#define CXL_MEM_DEV_STATUS_VERSION 1
 REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, FATAL, 0, 1)
     FIELD(CXL_MEM_DEV_STS, FW_HALT, 1, 1)
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index d778487b7e..5170b8dbf8 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -13,7 +13,7 @@
 #include "qemu/uuid.h"
 
 /*
- * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
  *
  * Define these as the bit position for the event status register for ease of
  * setting the status.
@@ -29,7 +29,7 @@ typedef enum CXLEventLogType {
 
 /*
  * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ * CXL r3.1 section 8.2.9.2.1: Event Records; Table 8-43
  */
 #define CXL_EVENT_REC_HDR_RES_LEN 0xf
 typedef struct CXLEventRecordHdr {
@@ -52,7 +52,7 @@ typedef struct CXLEventRecordRaw {
 
 /*
  * Get Event Records output payload
- * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
+ * CXL r3.1 section 8.2.9.2.2; Table 8-53
  */
 #define CXL_GET_EVENT_FLAG_OVERFLOW     BIT(0)
 #define CXL_GET_EVENT_FLAG_MORE_RECORDS BIT(1)
@@ -70,7 +70,7 @@ typedef struct CXLGetEventPayload {
 
 /*
  * Clear Event Records input payload
- * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
+ * CXL r3.1 section 8.2.9.2.3; Table 8-54
  */
 typedef struct CXLClearEventPayload {
     uint8_t event_log;      /* CXLEventLogType */
@@ -80,10 +80,10 @@ typedef struct CXLClearEventPayload {
     uint16_t handle[];
 } CXLClearEventPayload;
 
-/**
+/*
  * Event Interrupt Policy
  *
- * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ * CXL r3.1 section 8.2.9.2.4; Table 8-55
  */
 typedef enum CXLEventIntMode {
     CXL_INT_NONE     = 0x00,
@@ -106,7 +106,7 @@ typedef struct CXLEventInterruptPolicy {
 
 /*
  * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL r3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
 #define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
@@ -126,7 +126,7 @@ typedef struct CXLEventGenMedia {
 
 /*
  * DRAM Event Record
- * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
+ * CXL r3.1 Section 8.2.9.2.1.2: Table 8-46
  * All fields little endian.
  */
 typedef struct CXLEventDram {
@@ -149,7 +149,7 @@ typedef struct CXLEventDram {
 
 /*
  * Memory Module Event Record
- * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
+ * CXL r3.1 Section 8.2.9.2.1.3: Table 8-47
  * All fields little endian.
  */
 typedef struct CXLEventMemoryModule {
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index ddf01a543b..265db6c407 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -16,9 +16,8 @@
 #define PCIE_DVSEC_HEADER1_OFFSET 0x4 /* Offset from start of extend cap */
 #define PCIE_DVSEC_ID_OFFSET 0x8
 
-#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x38
-#define PCIE_CXL1_DEVICE_DVSEC_REVID 0
-#define PCIE_CXL2_DEVICE_DVSEC_REVID 1
+#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x3C
+#define PCIE_CXL31_DEVICE_DVSEC_REVID 3
 
 #define EXTENSIONS_PORT_DVSEC_LENGTH 0x28
 #define EXTENSIONS_PORT_DVSEC_REVID 0
@@ -29,8 +28,8 @@
 #define GPF_DEVICE_DVSEC_LENGTH 0x10
 #define GPF_DEVICE_DVSEC_REVID 0
 
-#define PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0 0x14
-#define PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0  1
+#define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
+#define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
 
 #define REG_LOC_DVSEC_LENGTH 0x24
 #define REG_LOC_DVSEC_REVID  0
@@ -55,16 +54,26 @@ typedef struct DVSECHeader {
 QEMU_BUILD_BUG_ON(sizeof(DVSECHeader) != 10);
 
 /*
- * CXL 2.0 devices must implement certain DVSEC IDs, and can [optionally]
+ * CXL r3.1 Table 8-2: CXL DVSEC ID Assignment
+ * Devices must implement certain DVSEC IDs, and can [optionally]
  * implement others.
+ * (x) - IDs in Table 8-2.
  *
- * CXL 2.0 Device: 0, [2], 5, 8
- * CXL 2.0 RP: 3, 4, 7, 8
- * CXL 2.0 Upstream Port: [2], 7, 8
- * CXL 2.0 Downstream Port: 3, 4, 7, 8
+ * CXL RCD (D1):         0, [2], [5], 7, [8], A  - Not emulated yet
+ * CXL RCD USP (UP1):    7, [8]                  - Not emulated yet
+ * CXL RCH DSP (DP1):    7, [8]
+ * CXL SLD (D2):         0, [2], 5, 7, 8, [A]
+ * CXL LD (LD):          0, [2], 5, 7, 8
+ * CXL RP (R):           3, 4, 7, 8
+ * CXL Switch USP (USP): [2], 7, 8
+ * CXL Switch DSP (DSP): 3, 4, 7, 8
+ * FM-Owned LD (FMLD):   0, [2], 7, 8, 9
  */
 
-/* CXL 2.0 - 8.1.3 (ID 0001) */
+/*
+ * CXL r3.1 Section 8.1.3: PCIe DVSEC for Devices
+ * DVSEC ID: 0, Revision: 3
+ */
 typedef struct CXLDVSECDevice {
     DVSECHeader hdr;
     uint16_t cap;
@@ -82,10 +91,14 @@ typedef struct CXLDVSECDevice {
     uint32_t range2_size_lo;
     uint32_t range2_base_hi;
     uint32_t range2_base_lo;
-} CXLDVSECDevice;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
+    uint16_t cap3;
+} QEMU_PACKED CXLDVSECDevice;
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x3A);
 
-/* CXL 2.0 - 8.1.5 (ID 0003) */
+/*
+ * CXL r3.1 Section 8.1.5: CXL Extensions DVSEC for Ports
+ * DVSEC ID: 3, Revision: 0
+ */
 typedef struct CXLDVSECPortExt {
     DVSECHeader hdr;
     uint16_t status;
@@ -107,7 +120,10 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExt) != 0x28);
 #define PORT_CONTROL_UNMASK_SBR      1
 #define PORT_CONTROL_ALT_MEMID_EN    4
 
-/* CXL 2.0 - 8.1.6 GPF DVSEC (ID 0004) */
+/*
+ * CXL r3.1 Section 8.1.6: GPF DVSEC for CXL Port
+ * DVSEC ID: 4, Revision: 0
+ */
 typedef struct CXLDVSECPortGPF {
     DVSECHeader hdr;
     uint16_t rsvd;
@@ -116,7 +132,10 @@ typedef struct CXLDVSECPortGPF {
 } CXLDVSECPortGPF;
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortGPF) != 0x10);
 
-/* CXL 2.0 - 8.1.7 GPF DVSEC for CXL Device */
+/*
+ * CXL r3.1 Section 8.1.7: GPF DVSEC for CXL Device
+ * DVSEC ID: 5, Revision 0
+ */
 typedef struct CXLDVSECDeviceGPF {
     DVSECHeader hdr;
     uint16_t phase2_duration;
@@ -124,17 +143,27 @@ typedef struct CXLDVSECDeviceGPF {
 } CXLDVSECDeviceGPF;
 QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDeviceGPF) != 0x10);
 
-/* CXL 2.0 - 8.1.8/8.2.1.3 Flex Bus DVSEC (ID 0007) */
+/*
+ * CXL r3.1 Section 8.1.8: PCIe DVSEC for Flex Bus Port
+ * CXL r3.1 Section 8.2.1.3: Flex Bus Port DVSEC
+ * DVSEC ID: 7, Revision 2
+ */
 typedef struct CXLDVSECPortFlexBus {
     DVSECHeader hdr;
     uint16_t cap;
     uint16_t ctrl;
     uint16_t status;
     uint32_t rcvd_mod_ts_data_phase1;
+    uint32_t cap2;
+    uint32_t ctrl2;
+    uint32_t status2;
 } CXLDVSECPortFlexBus;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x14);
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortFlexBus) != 0x20);
 
-/* CXL 2.0 - 8.1.9 Register Locator DVSEC (ID 0008) */
+/*
+ * CXL r3.1 Section 8.1.9: Register Locator DVSEC
+ * DVSEC ID: 8, Revision 0
+ */
 typedef struct CXLDVSECRegisterLocator {
     DVSECHeader hdr;
     uint16_t rsvd;
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 848bfa20f1..84ab503325 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,7 +13,7 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
-/* CXL r3.0 Section 8.2.4.19.1 CXL HDM Decoder Capability Register */
+/* CXL r3.1 Section 8.2.4.20.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
 {
     switch (count) {
@@ -160,11 +160,11 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
 }
 
 /*
- * 8.2.3
+ * CXL r3.1 Section 8.2.3: Component Register Layout and Definition
  *   The access restrictions specified in Section 8.2.2 also apply to CXL 2.0
  *   Component Registers.
  *
- * 8.2.2
+ * CXL r3.1 Section 8.2.2: Accessing Component Registers
  *   . A 32 bit register shall be accessed as a 4 Bytes quantity. Partial
  *   reads are not permitted.
  *   . A 64 bit register shall be accessed as a 8 Bytes quantity. Partial
@@ -308,7 +308,8 @@ void cxl_component_register_init_common(uint32_t *reg_state,
 
     /* CXL Capability Header Register */
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION,
+        CXL_CAPABILITY_VERSION);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
@@ -328,7 +329,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
     ras_init_common(reg_state, write_msk);
 
-    init_cap_reg(LINK, 4, 2);
+    init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
 
     if (caps < 3) {
         return;
@@ -341,8 +342,8 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(EXTSEC, 6, 1);
-    init_cap_reg(SNOOP, 8, 1);
+    init_cap_reg(EXTSEC, 6, CXL_EXTSEC_CAP_VERSION);
+    init_cap_reg(SNOOP, 8, CXL_SNOOP_CAP_VERSION);
 
 #undef init_cap_reg
 }
@@ -467,7 +468,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     cxl->dvsec_offset += length;
 }
 
-/* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */
+/* CXL r3.1 Section 8.2.4.20.7 CXL HDM Decoder n Control Register */
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
 {
     switch (iw) {
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 9df8738f86..035d034f6d 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -13,7 +13,7 @@
 
 /*
  * Device registers have no restrictions per the spec, and so fall back to the
- * default memory mapped register rules in 8.2:
+ * default memory mapped register rules in CXL r3.1 Section 8.2:
  *   Software shall use CXL.io Memory Read and Write to access memory mapped
  *   register defined in this section. Unless otherwise specified, software
  *   shall restrict the accesses width based on the following:
@@ -393,13 +393,15 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
     ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
 
-    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1,
+                        CXL_DEVICE_STATUS_VERSION);
     device_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
     mailbox_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
+        CXL_MEM_DEV_STATUS_VERSION);
     memdev_reg_init_common(cxl_dstate);
 
     cxl_initialize_mailbox_t3(&ct3d->cci, DEVICE(ct3d),
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index affcf8a34d..d397718b1b 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -204,7 +204,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
      * record that will not be cleared when Clear Event Records is executed,
      * the device shall return the Invalid Handle return code and shall not
      * clear any of the specified event records."
-     *   -- CXL 3.0 8.2.9.2.3
+     *   -- CXL r3.1 Section 8.2.9.2.3: Clear Event Records (0101h)
      */
     entry = cxl_event_get_head(log);
     for (nr = 0; entry && nr < pl->nr_recs; nr++) {
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dc42850767..e5eb97cb91 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -86,7 +86,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
 };
 
-/* CCI Message Format CXL r3.0 Figure 7-19 */
+/* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
 #define CXL_CCI_CAT_REQ 0
@@ -342,7 +342,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL r3.0 section 8.2.9.1.1: Identify (Opcode 0001h) */
+/* CXL r3.1 section 8.2.9.1.1: Identify (Opcode 0001h) */
 static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
                                         uint8_t *payload_in,
                                         size_t len_in,
@@ -403,7 +403,7 @@ static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
     }
 }
 
-/* CXL r3 8.2.9.1.1 */
+/* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
 static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
                                              size_t len_in,
@@ -455,7 +455,7 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL r3.0 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
 static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               uint8_t *payload_in,
                                               size_t len_in,
@@ -463,14 +463,14 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               size_t *len_out,
                                               CXLCCI *cci)
 {
-    /* CXL r3.0 Table 7-18: Get Physical Port State Request Payload */
+    /* CXL r3.1 Table 7-17: Get Physical Port State Request Payload */
     struct cxl_fmapi_get_phys_port_state_req_pl {
         uint8_t num_ports;
         uint8_t ports[];
     } QEMU_PACKED *in;
 
     /*
-     * CXL r3.0 Table 7-20: Get Physical Port State Port Information Block
+     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
      * Format
      */
     struct cxl_fmapi_port_state_info_block {
@@ -491,7 +491,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         uint8_t supported_ld_count;
     } QEMU_PACKED;
 
-    /* CXL r3.0 Table 7-19: Get Physical Port State Response Payload */
+    /* CXL r3.1 Table 7-18: Get Physical Port State Response Payload */
     struct cxl_fmapi_get_phys_port_state_resp_pl {
         uint8_t num_ports;
         uint8_t rsv1[3];
@@ -579,7 +579,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL r3.0 8.2.9.1.2 */
+/* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -609,7 +609,7 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.2.1 */
+/* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
                                                size_t len,
@@ -647,7 +647,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.3.1 */
+/* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
                                     size_t len_in,
@@ -664,7 +664,7 @@ static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.3.2 */
+/* CXL r3.1 Section 8.2.9.4.2: Set Timestamp (Opcode 0301h) */
 static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
                                     size_t len_in,
@@ -683,13 +683,13 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
+/* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
 static const QemuUUID cel_uuid = {
     .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
                  0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
 };
 
-/* 8.2.9.4.1 */
+/* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
 static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -715,7 +715,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.4.2 */
+/* CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h) */
 static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
                                    uint8_t *payload_in,
                                    size_t len_in,
@@ -732,14 +732,11 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     get_log = (void *)payload_in;
 
     /*
-     * 8.2.9.4.2
-     *   The device shall return Invalid Parameter if the Offset or Length
+     * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
+     *   The device shall return Invalid Input if the Offset or Length
      *   fields attempt to access beyond the size of the log as reported by Get
      *   Supported Logs.
      *
-     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
-     * XXX: Spec doesn't address incorrect UUID incorrectness.
-     *
      * The CEL buffer is large enough to fit all commands in the emulation, so
      * the only possible failure would be if the mailbox itself isn't big
      * enough.
@@ -749,7 +746,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     }
 
     if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
-        return CXL_MBOX_UNSUPPORTED;
+        return CXL_MBOX_INVALID_LOG;
     }
 
     /* Store off everything to local variables so we can wipe out the payload */
@@ -760,7 +757,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.5.1.1 */
+/* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
                                              size_t len_in,
@@ -815,6 +812,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.2.1: Get Partition Info (Opcode 4100h) */
 static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
                                               uint8_t *payload_in,
                                               size_t len_in,
@@ -851,6 +849,7 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.2.3: Get LSA (Opcode 4102h) */
 static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
                                    uint8_t *payload_in,
                                    size_t len_in,
@@ -879,6 +878,7 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.2.4: Set LSA (Opcode 4103h) */
 static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
                                    uint8_t *payload_in,
                                    size_t len_in,
@@ -940,7 +940,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
 }
 
 /*
- * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
  *
  * Once the Sanitize command has started successfully, the device shall be
  * placed in the media disabled state. If the command fails or is interrupted
@@ -1018,7 +1018,10 @@ static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
     *len_out = 4;
     return CXL_MBOX_SUCCESS;
 }
+
 /*
+ * CXL r3.1 Section 8.2.9.9.4.1: Get Poison List (Opcode 4300h)
+ *
  * This is very inefficient, but good enough for now!
  * Also the payload will always fit, so no need to handle the MORE flag and
  * make this stateful. We may want to allow longer poison lists to aid
@@ -1103,6 +1106,7 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.4.2: Inject Poison (Opcode 4301h) */
 static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
                                           uint8_t *payload_in,
                                           size_t len_in,
@@ -1146,6 +1150,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.9.4.3: Clear Poison (Opcode 4302h */
 static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 71fcb44613..e8801805b9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -319,7 +319,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                PCIE_CXL_DEVICE_DVSEC_LENGTH,
                                PCIE_CXL_DEVICE_DVSEC,
-                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
+                               PCIE_CXL31_DEVICE_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
@@ -346,9 +346,9 @@ static void build_dvsecs(CXLType3Dev *ct3d)
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
-                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
-                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
 }
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 405a133eef..742da07a01 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -109,9 +109,9 @@ static void build_dvsecs(CXLComponentState *cxl)
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
-                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
-                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECPortGPF){
         .rsvd        = 0,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 8f97697631..62f96994eb 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -129,9 +129,9 @@ static void build_dvsecs(CXLComponentState *cxl)
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
-                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
-                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index d5341b530f..e87eb40177 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -121,9 +121,9 @@ static void build_dvsecs(CXLComponentState *cxl)
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
-                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
-                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
+                               PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
         .rsvd         = 0,
diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 6ab5f72473..10a0e9bc9f 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -411,5 +411,4 @@ References
 
  - Consortium website for specifications etc:
    http://www.computeexpresslink.org
- - Compute Express link Revision 2 specification, October 2020
- - CEDT CFMWS & QTG _DSM ECN May 2021
+ - Compute Express Link (CXL) Specification, Revision 3.1, August 2023
-- 
MST



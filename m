Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AD7E38A5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:16:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5e-000514-Pc; Tue, 07 Nov 2023 05:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5Y-0004un-6b
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5W-0002xj-EL
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Psz1BOwTQBVnWrBi4/EaLOXmxV87kpmQ8siLKG1GMM=;
 b=BibaiojKv4V8vCwJsDhdZJ9VPCPt7K9Xf9VS08H1JVLHgrdtsZnk6/82OH6ep5o9htr9F7
 NBad8aF7XW1ZqfpaWplYl+rcpxRd1m1LZzLkQMp0cNmCG39QhFeirvxAaJmYvwfZt4hPPS
 8/YLCsxN8vDfSL4ARkm1/6H85SzyDcM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-dOP3ND8tNJeyhnaVNLL9pg-1; Tue, 07 Nov 2023 05:13:19 -0500
X-MC-Unique: dOP3ND8tNJeyhnaVNLL9pg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c6f3cd892cso55338661fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351997; x=1699956797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Psz1BOwTQBVnWrBi4/EaLOXmxV87kpmQ8siLKG1GMM=;
 b=Bl/mN6Sm7vqPyW+yRaeAT/VocPojrpXzEYWRvJr6a0s3LZm/uuz/d0kyvEDP05ubEm
 PybylJHQqfiwU+lDV7Z05LoIFldZRXr8++K2Rzw2x4kCAvwmXmv+elvJwYZiK9ei+U0f
 oCuP0pM3PLplYtypH2LcQ//+RtGtOsJiTdA337wZKJ+oxoI2zcAB9lk2+lIByitAYxfk
 2sBOGB85nNW2YZUDlj3v04r02xtYW877/61iNewe/JIlOzxwQ/ijMws1yTZ1o6jz1zP3
 kIll6dtUSayyRqYBBydf9nw3u7o3HnjBWG+1t7+26C5xnUFOAdtcB+QGNOZ7H0iH8w78
 7VpQ==
X-Gm-Message-State: AOJu0YyuWZzVx2IyPegKyC8ZcW1UWja11k0OKIw0N0/wv3jlHjY1hn07
 WrMJGWYP7WjlW5thKQj8lianguTjtDKSbeOxqOxAgQ+koiUfrKfHsGDvC6byn2oI1uYcgrdEtNK
 fN/hOzSyX9wuZ7ktHVd2nLXKIP2c5nP5rlRC+FcT2VY9lKRBk01czHMewQL8Rur1t+49E
X-Received: by 2002:a2e:a9a7:0:b0:2bc:db70:b563 with SMTP id
 x39-20020a2ea9a7000000b002bcdb70b563mr30360221ljq.32.1699351997624; 
 Tue, 07 Nov 2023 02:13:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaUpMu/REQ9YWQSE/IZlcGogyKM2FPtenubdGQLdI/3oj9Z/SHn+vDI+vIbRgbkJpg96oSOA==
X-Received: by 2002:a2e:a9a7:0:b0:2bc:db70:b563 with SMTP id
 x39-20020a2ea9a7000000b002bcdb70b563mr30360196ljq.32.1699351997243; 
 Tue, 07 Nov 2023 02:13:17 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00405c7591b09sm15290202wmq.35.2023.11.07.02.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:16 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 51/63] hw/cxl/mbox: Add Information and Status / Identify
 command
Message-ID: <6cf416c176f11bc093fcc1818d6c9a95136f4c59.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add this command that is only available via out of band CCIs. It replicates
information that can be discovered inband via PCI config space.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 28ea02fcbe..6741698ee7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -11,6 +11,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
@@ -44,6 +45,8 @@
  */
 
 enum {
+    INFOSTAT    = 0x00,
+        #define IS_IDENTIFY   0x1
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -203,6 +206,57 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 section 8.2.9.1.1: Identify (Opcode 0001h) */
+static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in,
+                                        size_t len_in,
+                                        uint8_t *payload_out,
+                                        size_t *len_out,
+                                        CXLCCI *cci)
+{
+    PCIDeviceClass *class = PCI_DEVICE_GET_CLASS(cci->d);
+    struct {
+        uint16_t pcie_vid;
+        uint16_t pcie_did;
+        uint16_t pcie_subsys_vid;
+        uint16_t pcie_subsys_id;
+        uint64_t sn;
+    uint8_t max_message_size;
+        uint8_t component_type;
+    } QEMU_PACKED *is_identify;
+    QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
+
+    is_identify = (void *)payload_out;
+    memset(is_identify, 0, sizeof(*is_identify));
+    is_identify->pcie_vid = class->vendor_id;
+    is_identify->pcie_did = class->device_id;
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
+        is_identify->sn = CXL_USP(cci->d)->sn;
+        /* Subsystem info not defined for a USP */
+        is_identify->pcie_subsys_vid = 0;
+        is_identify->pcie_subsys_id = 0;
+        is_identify->component_type = 0x0; /* Switch */
+    } else if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        PCIDevice *pci_dev = PCI_DEVICE(cci->d);
+
+        is_identify->sn = CXL_TYPE3(cci->d)->sn;
+        /*
+         * We can't always use class->subsystem_vendor_id as
+         * it is not set if the defaults are used.
+         */
+        is_identify->pcie_subsys_vid =
+            pci_get_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID);
+        is_identify->pcie_subsys_id =
+            pci_get_word(pci_dev->config + PCI_SUBSYSTEM_ID);
+        is_identify->component_type = 0x3; /* Type 3 */
+    }
+
+    /* TODO: Allow this to vary across different CCIs */
+    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
+    *len_out = sizeof(*is_identify);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -755,6 +809,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
                          IMMEDIATE_POLICY_CHANGE },
-- 
MST



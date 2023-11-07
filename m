Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E37E3904
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:24:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5T-0004X7-FW; Tue, 07 Nov 2023 05:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5R-0004Wb-M6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5O-0002ww-S5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4NuGQZaHq8Q+4F5F83IqV9aNTAYT6ys0MEYQ1OXl4M=;
 b=USqjpJRyaYK/idNRuvNUfwwQilDRd+BKmNLkRy+qLBdkXgJ6IzfwGgac6w9AdwBrajefVz
 ccxi+tJCnGDd7iLRvqFzdfTA0lWDqMM/0OwwqYV0HDl1wKBXcWejuvFQ/bDFFxlAWPPjZ/
 wO1r51NHBXnnyoTwS7Dfqu1gISRSH+o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-tP1BeqRVPT6GmjOvrqSX7w-1; Tue, 07 Nov 2023 05:13:24 -0500
X-MC-Unique: tP1BeqRVPT6GmjOvrqSX7w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408695c377dso34611815e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352002; x=1699956802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4NuGQZaHq8Q+4F5F83IqV9aNTAYT6ys0MEYQ1OXl4M=;
 b=B0aoRJH3Pjzj0/X8t/WtEVsYxqofFzo2xZiwQBcJV5awY/JD1OI5HLSKUfqEF+loRz
 ZYimpilVNKtIbjkeirRQf7jPvKiKr50RnDXVM04U5MSgVqsuBiuKcdL1Hk5f4Kzo8OHn
 Ao2ArkyPOy8B1u8rElMEremTKBjDJrjJY8691SPHiZnTAX67bN5yZrarJ6J6MpcUYAZ5
 Rymkke2oWN7GlXksS1DYgJvtYtD+uDnv8t/gGGyRsnR0RNllsKpvljNnTZ00VZYg0EdM
 7zhyKt3bxrjLid/4uEdfn48lqRgzXFEV7WbLZRAhzGzXUtz/vljUWMH7xpAuy6K7yI7T
 o/sA==
X-Gm-Message-State: AOJu0Yxn7CK0Q3A/+Ck+1CjpiRHuUxb3k0h4TxDhyCXAuSl9m+GkBy7z
 EK32yv61RRBgd3jMxy0vbqPXd8BsBgKfoYykPkz7YD6BTYlZk08hbDPbCoEzkxhrDxfgOFgZzXy
 hX8FCfI9LamG/GiyfrBSif/hhHgxRfL74IwV9PSdsggq+4UsR8SldX0wbX8BQVgST/lFa
X-Received: by 2002:a05:600c:3c9a:b0:3fe:f74c:b4f6 with SMTP id
 bg26-20020a05600c3c9a00b003fef74cb4f6mr1906041wmb.17.1699352002310; 
 Tue, 07 Nov 2023 02:13:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRuD2sj++FQEJS5RVrslYj7ljlZbcBjrmcmDMzKCI2UT/VYsYTeHwnmWbC/KyF8jWyh0SU5g==
X-Received: by 2002:a05:600c:3c9a:b0:3fe:f74c:b4f6 with SMTP id
 bg26-20020a05600c3c9a00b003fef74cb4f6mr1906027wmb.17.1699352001963; 
 Tue, 07 Nov 2023 02:13:21 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c1c9900b004067e905f44sm15394340wms.9.2023.11.07.02.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:21 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 52/63] hw/cxl/mbox: Add Physical Switch Identify command.
Message-ID: <3314efd276ada18cc0b8beb70b8943f8deb872b7.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Enable it for the switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023160806.13206-9-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl.h           |  6 ++++
 hw/cxl/cxl-mailbox-utils.c     | 65 ++++++++++++++++++++++++++++++++++
 hw/pci-bridge/cxl_downstream.c |  4 +--
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 4944725849..75e47b6864 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -61,4 +61,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 typedef struct CXLUpstreamPort CXLUpstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLUpstreamPort, CXL_USP, TYPE_CXL_USP)
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
+
+#define TYPE_CXL_DSP "cxl-downstream"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
+
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6741698ee7..6ada49d37c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,6 +70,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    PHYSICAL_SWITCH = 0x51,
+        #define IDENTIFY_SWITCH_DEVICE      0x0
 };
 
 
@@ -257,6 +259,67 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
+                                  void *private)
+{
+    uint8_t *bm = private;
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+        uint8_t port = PCIE_PORT(d)->port;
+        bm[port / 8] |= 1 << (port % 8);
+    }
+}
+
+/* CXL r3 8.2.9.1.1 */
+static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    int num_phys_ports = pcie_count_ds_ports(bus);
+
+    struct cxl_fmapi_ident_switch_dev_resp_pl {
+        uint8_t ingress_port_id;
+        uint8_t rsvd;
+        uint8_t num_physical_ports;
+        uint8_t num_vcss;
+        uint8_t active_port_bitmask[0x20];
+        uint8_t active_vcs_bitmask[0x20];
+        uint16_t total_vppbs;
+        uint16_t bound_vppbs;
+        uint8_t num_hdm_decoders_per_usp;
+    } QEMU_PACKED *out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 0x49);
+
+    out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
+    *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
+        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+        .num_vcss = 1, /* Not yet support multiple VCS - potentialy tricky */
+        .active_vcs_bitmask[0] = 0x1,
+        .total_vppbs = num_phys_ports + 1,
+        .bound_vppbs = num_phys_ports + 1,
+        .num_hdm_decoders_per_usp = 4,
+    };
+
+    /* Depends on the CCI type */
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_PCIE_PORT)) {
+        out->ingress_port_id = PCIE_PORT(cci->intf)->port;
+    } else {
+        /* MCTP? */
+        out->ingress_port_id = 0;
+    }
+
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
+                                  out->active_port_bitmask);
+    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
+
+    *len_out = sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -816,6 +879,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
+        cmd_identify_switch_device, 0, 0 },
 };
 
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 8c0f759add..8d99e1e96d 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
 typedef struct CXLDownstreamPort {
@@ -23,9 +24,6 @@ typedef struct CXLDownstreamPort {
     CXLComponentState cxl_cstate;
 } CXLDownstreamPort;
 
-#define TYPE_CXL_DSP "cxl-downstream"
-DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
-
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_DOWNSTREAM_PORT_MSI_NR_VECTOR 1
 #define CXL_DOWNSTREAM_PORT_EXP_OFFSET 0x90
-- 
MST



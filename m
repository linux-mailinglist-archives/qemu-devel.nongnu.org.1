Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 058177E3906
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:24:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J5Z-0004qa-0k; Tue, 07 Nov 2023 05:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5U-0004eF-Jn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5S-0002xL-RZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o15ruDZqaFYFg/HLiletSP9urCgLHFyZ9Ye+iXOkypo=;
 b=HUSSLvgEahDfMjRbGXYSmcgY5+FQzlgMRleKiPltwLo50OyjSjqVf4HXlFLVjQtn/ZlcY8
 MKekidnaJE26XdXoLZfmObOh9cOpveiv+FNwGEgSBHa2uaEMstWGqQM+HNTSMqNtcQgCYR
 yKU8IKhGpY0sDegqMJ2bG1dMjOonjVo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-nuLSyVyhNJOAAQpWri_48g-1; Tue, 07 Nov 2023 05:13:32 -0500
X-MC-Unique: nuLSyVyhNJOAAQpWri_48g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c59a4dcdd0so51379071fa.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352011; x=1699956811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o15ruDZqaFYFg/HLiletSP9urCgLHFyZ9Ye+iXOkypo=;
 b=CLcv55HyOjY5iCszhUAz0wfZzOhnwGxFKvbJFcSFS57eQ9DdyswBeJG8p4PQhU4uE2
 8ydIwe7fmeqZu07cSHy/3ug3nli+CfZaOEmcpvfaXAm7eUhL/c3IYHI5XOLmG4VO+p/H
 VB7qLWzOxmBzhLnAP/jLZ9M1DQaMRXkfUGG820Fcr2lQ9bEklybIvNGwwix72E5a7dTt
 xFYdA0J6OcMM17THOcjNM0OKFT/oErfQzgVwtwoDEM5hLZlEFxPhutYr9gryjrjv6FjJ
 XDxxWhegGJEAo/xYdtJnJVTcLhoaSVdVrhF1YVuOTSf+Mhf9fZ54SEc5CU8k/8ZF7xyM
 VV6A==
X-Gm-Message-State: AOJu0YwmlX5Pt8NRwkK2zhlnPlaZaJUc1WnY32TpkfHWmlgF64iD8qDT
 eO9fPPdcKhrhOSYFEInDCbuImbJBPJ7+PzagvChK5NNf7YZWgCJ9xh+optoTvSC2vxKg2iS1Pn3
 QiOATOBBVE8aPToCoNV1AyDHtIx3puO77CC2m39m0lNaliho9V+WyAUQ/rjhWQvOCqbed
X-Received: by 2002:a2e:a98e:0:b0:2bc:c4af:36b9 with SMTP id
 x14-20020a2ea98e000000b002bcc4af36b9mr30057549ljq.52.1699352010869; 
 Tue, 07 Nov 2023 02:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaANo39hINpnQK0yq1SfiGyAph27fjl0qRC8x3U8HDNQzTj9GKn34QH6x0PTnFxQOm0mvuRA==
X-Received: by 2002:a2e:a98e:0:b0:2bc:c4af:36b9 with SMTP id
 x14-20020a2ea98e000000b002bcc4af36b9mr30057525ljq.52.1699352010449; 
 Tue, 07 Nov 2023 02:13:30 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c358600b004053a6b8c41sm14900658wmq.12.2023.11.07.02.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:29 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 54/63] hw/cxl: Implement Physical Ports status retrieval
Message-ID: <892e3479d7283a38b50e06f42624f5a1ce61d24a.1699351720.git.mst@redhat.com>
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

Add this command for both the Switch CCI in switch upstream ports.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-11-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 128 +++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6ada49d37c..de63fc1a28 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -72,6 +72,7 @@ enum {
         #define CLEAR_POISON           0x2
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
+        #define GET_PHYSICAL_PORT_STATE     0x1
 };
 
 
@@ -320,6 +321,131 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
 
     return CXL_MBOX_SUCCESS;
 }
+
+/* CXL r3.0 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    /* CXL r3.0 Table 7-18: Get Physical Port State Request Payload */
+    struct cxl_fmapi_get_phys_port_state_req_pl {
+        uint8_t num_ports;
+        uint8_t ports[];
+    } QEMU_PACKED *in;
+
+    /*
+     * CXL r3.0 Table 7-20: Get Physical Port State Port Information Block
+     * Format
+     */
+    struct cxl_fmapi_port_state_info_block {
+        uint8_t port_id;
+        uint8_t config_state;
+        uint8_t connected_device_cxl_version;
+        uint8_t rsv1;
+        uint8_t connected_device_type;
+        uint8_t port_cxl_version_bitmask;
+        uint8_t max_link_width;
+        uint8_t negotiated_link_width;
+        uint8_t supported_link_speeds_vector;
+        uint8_t max_link_speed;
+        uint8_t current_link_speed;
+        uint8_t ltssm_state;
+        uint8_t first_lane_num;
+        uint16_t link_state;
+        uint8_t supported_ld_count;
+    } QEMU_PACKED;
+
+    /* CXL r3.0 Table 7-19: Get Physical Port State Response Payload */
+    struct cxl_fmapi_get_phys_port_state_resp_pl {
+        uint8_t num_ports;
+        uint8_t rsv1[3];
+        struct cxl_fmapi_port_state_info_block ports[];
+    } QEMU_PACKED *out;
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    size_t pl_size;
+    int i;
+
+    in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
+    out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
+
+    /* Check if what was requested can fit */
+    if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* For success there should be a match for each requested */
+    out->num_ports = in->num_ports;
+
+    for (i = 0; i < in->num_ports; i++) {
+        struct cxl_fmapi_port_state_info_block *port;
+        /* First try to match on downstream port */
+        PCIDevice *port_dev;
+        uint16_t lnkcap, lnkcap2, lnksta;
+
+        port = &out->ports[i];
+
+        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
+        if (port_dev) { /* DSP */
+            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+                ->devices[0];
+            port->config_state = 3;
+            if (ds_dev) {
+                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    port->connected_device_type = 5; /* Assume MLD for now */
+                } else {
+                    port->connected_device_type = 1;
+                }
+            } else {
+                port->connected_device_type = 0;
+            }
+            port->supported_ld_count = 3;
+        } else if (usp->port == in->ports[i]) { /* USP */
+            port_dev = PCI_DEVICE(usp);
+            port->config_state = 4;
+            port->connected_device_type = 0;
+        } else {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        port->port_id = in->ports[i];
+        /* Information on status of this port in lnksta, lnkcap */
+        if (!port_dev->exp.exp_cap) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        lnksta = port_dev->config_read(port_dev,
+                                       port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
+                                       sizeof(lnksta));
+        lnkcap = port_dev->config_read(port_dev,
+                                       port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
+                                       sizeof(lnkcap));
+        lnkcap2 = port_dev->config_read(port_dev,
+                                        port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
+                                        sizeof(lnkcap2));
+
+        port->max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+        port->negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+        /* No definition for SLS field in linux/pci_regs.h */
+        port->supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+        port->max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+        port->current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+        /* TODO: Track down if we can get the rest of the info */
+        port->ltssm_state = 0x7;
+        port->first_lane_num = 0;
+        port->link_state = 0;
+        port->port_cxl_version_bitmask = 0x2;
+        port->connected_device_cxl_version = 0x2;
+    }
+
+    pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
+    *len_out = pl_size;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -881,6 +1007,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [PHYSICAL_SWITCH][IDENTIFY_SWITCH_DEVICE] = { "IDENTIFY_SWITCH_DEVICE",
         cmd_identify_switch_device, 0, 0 },
+    [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
+        cmd_get_physical_port_state, ~0, 0 },
 };
 
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF47E38EF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:22:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J66-0005Lp-2i; Tue, 07 Nov 2023 05:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5w-0005Kn-7S
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J5u-0002z9-9G
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6V1LJj1Apk6QlNSZxAM3YnC4nWhgSQdoGTs1SUHLn0=;
 b=UofbzWI8QpyrNkjvYINXuD1OsBdazfdeo/K7ugBNyc76wPWJofvxeDhP7gs12CGRNNi8zD
 hMa6LYDXyxnDvE6K3JtahHo5JG4FuxHF2fhLyvoAZrIm19njJ3bEmNi5npcrMqk0PhgZGx
 iHzAPZ6zNS80jL2e/qUROgFoSNCL4xo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-gOagPDn4MB6WFl77e091ag-1; Tue, 07 Nov 2023 05:14:00 -0500
X-MC-Unique: gOagPDn4MB6WFl77e091ag-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32fd35e88fcso1201679f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352038; x=1699956838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6V1LJj1Apk6QlNSZxAM3YnC4nWhgSQdoGTs1SUHLn0=;
 b=C4cPjQRMsWCIsP5ukTAZW8McTX3BomLqle4I9paFpKsC5EC/M4r7Opc/yhqhDKl5EV
 0ZTK9vaOAMutIDdRLiHyDAqDZTmRsq6HnKgQZ9irCmfnpgPc3AeQXpKvw7qrWxvzlLuA
 7JUNiP4Z3iS99jDF4vVeYpstlXyzvbAEeEjw/bXgEP3wWEfE/dRuxSV2sDga+boIKZUG
 KvPsUz54H29t6Z7VhKxfTidm0oSyFIo1uao3QXMBSDWmTOggc9md5AZLtbNGanZ63ERb
 BVoc97AztNGyP5+/her1qJJnoKI5STlxxlikfoO/wt1z99D4YwFGi8tVnaheUdpHzSek
 MgpQ==
X-Gm-Message-State: AOJu0YxyTMrJ7K2kmDNI1SG3qSwTonzFx9pU10p/NVNDTliGYjr3PIHq
 RNqxYlHQ6FGstjMsttrTN8uWYGKSAR0Y4p2oM8Ag+iBVPg5J+SEIq7xocibR+hPSifmvPoVzssh
 OS98NklIqjyB1vK4sRJjri/wOW24YgdADi/oycW5L6CSy/FwG8KSfp/n27UPsskqQVEYo
X-Received: by 2002:a05:6000:b8d:b0:32d:9395:dec6 with SMTP id
 dl13-20020a0560000b8d00b0032d9395dec6mr23208717wrb.67.1699352038564; 
 Tue, 07 Nov 2023 02:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDWh3LhN3goX6/gvfOUaEDECNpOwB92K8VMdLU3Zq6OSv+xzdnUgP7e790c7hIu/JsJlQR/w==
X-Received: by 2002:a05:6000:b8d:b0:32d:9395:dec6 with SMTP id
 dl13-20020a0560000b8d00b0032d9395dec6mr23208699wrb.67.1699352038257; 
 Tue, 07 Nov 2023 02:13:58 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 m2-20020adffe42000000b0032dab20e773sm1911984wrs.69.2023.11.07.02.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:13:57 -0800 (PST)
Date: Tue, 7 Nov 2023 05:13:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 61/63] hw/cxl: Add tunneled command support to mailbox for
 switch cci.
Message-ID: <004e3a93b814ca2d13ee2feb1f9ebacef6c83b9e.1699351720.git.mst@redhat.com>
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

This implementation of tunneling makes the choice that our Type 3 device is
a Logical Device (LD) of a Multi-Logical Device (MLD) that just happens to
only have one LD for now.

Tunneling is supported from a Switch Mailbox CCI (and shortly via MCTP over
I2C connected to the switch MCTP CCI) via an outer level to the FM owned LD
in the MLD Type 3 device. From there an inner tunnel may be used to access
particular LDs.

Protocol wise, the following is what happens in a real system but we
don't emulate the transports - just the destinations and the payloads.

( Host -> Switch Mailbox CCI - in band FM-API mailbox command
  or
  Host -> Switch MCTP CCI - MCTP over I2C using the CXL FM-API
  MCTP Binding.
)
then (if a tunnel command)
Switch -> Type 3 FM Owned LD - MCTP over PCI VDM using the
CXL FM-API binding (addressed by switch port)
then (if unwrapped command also a tunnel command)
Type 3 FM Owned LD to LD0 via internal transport
(addressed by LD number)

or (added shortly)

Host to Type 3 FM Owned MCTP CCI - MCTP over I2C using the
CXL FM-API MCTP Binding.
then (if unwrapped comand is a tunnel comamnd)
Type 3 FM Owned LD to LD0 via internal transport.
(addressed by LD number)

It is worth noting that the tunneling commands over PCI VDM
presumably use the appropriate MCTP binding depending on opcode.
This may be the CXL FMAPI binding or the CXL Memory Device Binding.

Additional commands will need to be added to make this
useful beyond testing the tunneling works.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20231023160806.13206-18-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   9 ++
 hw/cxl/cxl-mailbox-utils.c  | 162 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  11 +++
 3 files changed, 182 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 70aca9024c..61b7f897f7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -279,6 +279,12 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
                             bool *bg_started);
+void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
+                                           DeviceState *intf,
+                                           size_t payload_max);
+
+void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
+                              DeviceState *intf, size_t payload_max);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -397,6 +403,9 @@ struct CXLType3Dev {
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
+    /* Always intialized as no way to know if a VDM might show up */
+    CXLCCI vdm_fm_owned_ld_mctp_cci;
+    CXLCCI ld0_cci;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 693c2cbdcd..b365575097 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,8 +82,132 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+    TUNNEL = 0x53,
+        #define MANAGEMENT_COMMAND     0x0
 };
 
+/* CCI Message Format CXL r3.0 Figure 7-19 */
+typedef struct CXLCCIMessage {
+    uint8_t category;
+#define CXL_CCI_CAT_REQ 0
+#define CXL_CCI_CAT_RSP 1
+    uint8_t tag;
+    uint8_t resv1;
+    uint8_t command;
+    uint8_t command_set;
+    uint8_t pl_length[3];
+    uint16_t rc;
+    uint16_t vendor_specific;
+    uint8_t payload[];
+} QEMU_PACKED CXLCCIMessage;
+
+/* This command is only defined to an MLD FM Owned LD or an MHD */
+static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    PCIDevice *tunnel_target;
+    CXLCCI *target_cci;
+    struct {
+        uint8_t port_or_ld_id;
+        uint8_t target_type;
+        uint16_t size;
+        CXLCCIMessage ccimessage;
+    } QEMU_PACKED *in;
+    struct {
+        uint16_t resp_len;
+        uint8_t resv[2];
+        CXLCCIMessage ccimessage;
+    } QEMU_PACKED *out;
+    size_t pl_length, length_out;
+    bool bg_started;
+    int rc;
+
+    if (cmd->in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    in = (void *)payload_in;
+    out = (void *)payload_out;
+
+    /* Enough room for minimum sized message - no payload */
+    if (in->size < sizeof(in->ccimessage)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+    /* Length of input payload should be in->size + a wrapping tunnel header */
+    if (in->size != len_in - offsetof(typeof(*out), ccimessage)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+    if (in->ccimessage.category != CXL_CCI_CAT_REQ) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->target_type != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "Tunneled Command sent to non existent FM-LD");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /*
+     * Target of a tunnel unfortunately depends on type of CCI readint
+     * the message.
+     * If in a switch, then it's the port number.
+     * If in an MLD it is the ld number.
+     * If in an MHD target type indicate where we are going.
+     */
+    if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_TYPE3)) {
+        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        if (in->port_or_ld_id != 0) {
+            /* Only pretending to have one for now! */
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        target_cci = &ct3d->ld0_cci;
+    } else if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
+        CXLUpstreamPort *usp = CXL_USP(cci->d);
+
+        tunnel_target = pcie_find_port_by_pn(&PCI_BRIDGE(usp)->sec_bus,
+                                             in->port_or_ld_id);
+        if (!tunnel_target) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        tunnel_target =
+            pci_bridge_get_sec_bus(PCI_BRIDGE(tunnel_target))->devices[0];
+        if (!tunnel_target) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        if (object_dynamic_cast(OBJECT(tunnel_target), TYPE_CXL_TYPE3)) {
+            CXLType3Dev *ct3d = CXL_TYPE3(tunnel_target);
+            /* Tunneled VDMs always land on FM Owned LD */
+            target_cci = &ct3d->vdm_fm_owned_ld_mctp_cci;
+        } else {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    } else {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    pl_length = in->ccimessage.pl_length[2] << 16 |
+        in->ccimessage.pl_length[1] << 8 | in->ccimessage.pl_length[0];
+    rc = cxl_process_cci_message(target_cci,
+                                 in->ccimessage.command_set,
+                                 in->ccimessage.command,
+                                 pl_length, in->ccimessage.payload,
+                                 &length_out, out->ccimessage.payload,
+                                 &bg_started);
+    /* Payload should be in place. Rest of CCI header and needs filling */
+    out->resp_len = length_out + sizeof(CXLCCIMessage);
+    st24_le_p(out->ccimessage.pl_length, length_out);
+    out->ccimessage.rc = rc;
+    out->ccimessage.category = CXL_CCI_CAT_RSP;
+    out->ccimessage.command = in->ccimessage.command;
+    out->ccimessage.command_set = in->ccimessage.command_set;
+    out->ccimessage.tag = in->ccimessage.tag;
+    *len_out = length_out + sizeof(*out);
+
+    return CXL_MBOX_SUCCESS;
+}
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
@@ -1171,6 +1295,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
 };
 
 /*
@@ -1347,3 +1473,39 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cci->intf = d;
     cxl_init_cci(cci, payload_max);
 }
+
+static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+};
+
+void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
+                               size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_ld;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
+
+static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
+    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
+                              0 },
+    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
+    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
+                                     cmd_tunnel_management_cmd, ~0, 0 },
+};
+
+void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
+                                           DeviceState *intf,
+                                           size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set_t3_fm_owned_ld_mctp;
+    cci->d = d;
+    cci->intf = intf;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a766c64575..52647b4ac7 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,6 +936,17 @@ static void ct3d_reset(DeviceState *dev)
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
+
+    /*
+     * Bring up an endpoint to target with MCTP over VDM.
+     * This device is emulating an MLD with single LD for now.
+     */
+    cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
+                                          DEVICE(ct3d), DEVICE(ct3d),
+                                          512); /* Max payload made up */
+    cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
+                             512); /* Max payload made up */
+
 }
 
 static Property ct3_props[] = {
-- 
MST



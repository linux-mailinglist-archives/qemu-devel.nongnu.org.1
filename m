Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E47E1AED
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfW-0004qO-E1; Mon, 06 Nov 2023 02:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd4-0000kb-Lj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:39 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020j-Ka
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:33 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5b9a453d3d3so2527885a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254139; x=1699858939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uxHxVRdbxEDyLKKyZhbihDSAvdi/oZuFoZxxmpMsL4=;
 b=JULN4EwvnvZ4rqgUCL5SFN0tB3XnOsc2ZVbpryg6OznGnmIJf7Yru4C1/vhrboTtBh
 A21V1JF0p/95DN21c3Nka//SgAuFtj3MNg64IqzxiGdIxkQHDYvaOxYEhqw3aoiw+wGT
 3lo+Gx6raHLkZs/JsjDT92qcB7keYiQ1+LertlGj+ABRH+8AWm95sQ5+ZapUoFFuysiE
 U2viZfYOcxd4dX6mZ26jlIUDipK747wdrwdfquP0QXg4jcoAqgDAiIdBv/34hKv2EtAe
 EPLR6grA68ihcICTPJ6WS/99qtMbaha6sxs63aNgKCW4j0b2DSB7slcfcskJvlKnoL7a
 lUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254139; x=1699858939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uxHxVRdbxEDyLKKyZhbihDSAvdi/oZuFoZxxmpMsL4=;
 b=f2Z8NN2Uq/rZ5fRYQU5qI1UOs/pToNZtZQHn/F08//lfIwtxMuF8dg164AnUc4YIuU
 imwRMymL0Mo6C8RQDTNO1pL9oVgdQznTb95JWCbXtaBwEgMydcRoD5Fd23rbfm3iW4YH
 TiNmo2RiNEGggsFIARTYtk5qULLosAsA+3QR1f17OBV0eQdifzIBCd3LwMW3EYIQdClQ
 2QblvIZuZbnAFTmWvBn20tEJP26qZH5WSu3SCyCgW2nexldITMqwd8J5v9VQAfc9iYvt
 +v44wULKAOt2ltEHTM+WyeOxSL66D5NV3AYBthZNEKRJCy+TB61l7AGCGgixBudG1NUk
 2Bnw==
X-Gm-Message-State: AOJu0YwBVjLaaeW94HR6687rSJ4zX9jZc9FyhUTm07SMmbX+WvKf2fsY
 p4w3pSOwY5WYT/BwrwAXVNcGmcm5SYHQHphY/vI=
X-Google-Smtp-Source: AGHT+IEpZ4we0iy6GsDzHsI8/EsD1RLBtZguT5RCncJta1RUhupItQ+YMoTjYU0WyFKcP6bR8qpzog==
X-Received: by 2002:a17:90a:f2d7:b0:27d:3439:c141 with SMTP id
 gt23-20020a17090af2d700b0027d3439c141mr21362966pjb.39.1699254139244; 
 Sun, 05 Nov 2023 23:02:19 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 58/71] hw/usb: Constify VMState
Date: Sun,  5 Nov 2023 22:58:14 -0800
Message-Id: <20231106065827.543129-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/usb/bus.c                        |  2 +-
 hw/usb/ccid-card-passthru.c         |  2 +-
 hw/usb/dev-hid.c                    |  4 ++--
 hw/usb/dev-hub.c                    |  8 ++++----
 hw/usb/dev-mtp.c                    |  2 +-
 hw/usb/dev-smartcard-reader.c       |  8 ++++----
 hw/usb/dev-storage.c                |  2 +-
 hw/usb/dev-uas.c                    |  2 +-
 hw/usb/hcd-dwc2.c                   |  4 ++--
 hw/usb/hcd-dwc3.c                   |  2 +-
 hw/usb/hcd-ehci-pci.c               |  2 +-
 hw/usb/hcd-ehci-sysbus.c            |  2 +-
 hw/usb/hcd-ehci.c                   |  2 +-
 hw/usb/hcd-ohci-pci.c               |  2 +-
 hw/usb/hcd-ohci.c                   |  8 ++++----
 hw/usb/hcd-uhci.c                   |  4 ++--
 hw/usb/hcd-xhci-pci.c               |  2 +-
 hw/usb/hcd-xhci-sysbus.c            |  2 +-
 hw/usb/hcd-xhci.c                   | 12 ++++++------
 hw/usb/host-libusb.c                |  2 +-
 hw/usb/imx-usb-phy.c                |  2 +-
 hw/usb/redirect.c                   | 16 ++++++++--------
 hw/usb/u2f-passthru.c               |  2 +-
 hw/usb/u2f.c                        |  2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c |  2 +-
 25 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 92d6ed5626..59c39945dd 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -69,7 +69,7 @@ const VMStateDescription vmstate_usb_device = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = usb_device_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(addr, USBDevice),
         VMSTATE_INT32(state, USBDevice),
         VMSTATE_INT32(remote_wakeup, USBDevice),
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 07ee42f304..a515703904 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -378,7 +378,7 @@ static const VMStateDescription passthru_vmstate = {
     .name = "ccid-card-passthru",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(vscard_in_data, PassthruState),
         VMSTATE_UINT32(vscard_in_pos, PassthruState),
         VMSTATE_UINT32(vscard_in_hdr, PassthruState),
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index bdd6d1ffaf..9e358c934e 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -756,7 +756,7 @@ static const VMStateDescription vmstate_usb_ptr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = usb_ptr_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBHIDState),
         VMSTATE_HID_POINTER_DEVICE(hid, USBHIDState),
         VMSTATE_END_OF_LIST()
@@ -767,7 +767,7 @@ static const VMStateDescription vmstate_usb_kbd = {
     .name = "usb-kbd",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBHIDState),
         VMSTATE_HID_KEYBOARD_DEVICE(hid, USBHIDState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 5703e0e826..06e9537d03 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -623,7 +623,7 @@ static const VMStateDescription vmstate_usb_hub_port = {
     .name = "usb-hub-port",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(wPortStatus, USBHubPort),
         VMSTATE_UINT16(wPortChange, USBHubPort),
         VMSTATE_END_OF_LIST()
@@ -642,7 +642,7 @@ static const VMStateDescription vmstate_usb_hub_port_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = usb_hub_port_timer_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(port_timer, USBHubState),
         VMSTATE_END_OF_LIST()
     },
@@ -652,13 +652,13 @@ static const VMStateDescription vmstate_usb_hub = {
     .name = "usb-hub",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBHubState),
         VMSTATE_STRUCT_ARRAY(ports, USBHubState, MAX_PORTS, 0,
                              vmstate_usb_hub_port, USBHubPort),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_usb_hub_port_timer,
         NULL
     }
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1cac1cd435..7e4a0765ae 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2072,7 +2072,7 @@ static const VMStateDescription vmstate_usb_mtp = {
     .unmigratable = 1,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, MTPState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index be0a4fc3bc..c0d63e0425 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1367,7 +1367,7 @@ static const VMStateDescription bulk_in_vmstate = {
     .name = "CCID BulkIn state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(data, BulkIn),
         VMSTATE_UINT32(len, BulkIn),
         VMSTATE_UINT32(pos, BulkIn),
@@ -1379,7 +1379,7 @@ static const VMStateDescription answer_vmstate = {
     .name = "CCID Answer state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(slot, Answer),
         VMSTATE_UINT8(seq, Answer),
         VMSTATE_END_OF_LIST()
@@ -1390,7 +1390,7 @@ static const VMStateDescription usb_device_vmstate = {
     .name = "usb_device",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(addr, USBDevice),
         VMSTATE_BUFFER(setup_buf, USBDevice),
         VMSTATE_BUFFER(data_buf, USBDevice),
@@ -1404,7 +1404,7 @@ static const VMStateDescription ccid_vmstate = {
     .minimum_version_id = 1,
     .post_load = ccid_post_load,
     .pre_save = ccid_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(dev, USBCCIDState, 1, usb_device_vmstate, USBDevice),
         VMSTATE_UINT8(debug, USBCCIDState),
         VMSTATE_BUFFER(bulk_out_data, USBCCIDState),
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index a496c811a7..341e505bd0 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -572,7 +572,7 @@ static const VMStateDescription vmstate_usb_msd = {
     .name = "usb-storage",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, MSDState),
         VMSTATE_UINT32(mode, MSDState),
         VMSTATE_UINT32(scsi_len, MSDState),
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index f013ded91e..1804cb6799 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -947,7 +947,7 @@ static void usb_uas_realize(USBDevice *dev, Error **errp)
 static const VMStateDescription vmstate_usb_uas = {
     .name = "usb-uas",
     .unmigratable = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, UASDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index a0c4e782b2..222eef82a5 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1391,7 +1391,7 @@ static const VMStateDescription vmstate_dwc2_state_packet = {
     .name = "dwc2/packet",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(devadr, DWC2Packet),
         VMSTATE_UINT32(epnum, DWC2Packet),
         VMSTATE_UINT32(epdir, DWC2Packet),
@@ -1411,7 +1411,7 @@ const VMStateDescription vmstate_dwc2_state = {
     .name = "dwc2",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(glbreg, DWC2State,
                              DWC2_GLBREG_SIZE / sizeof(uint32_t)),
         VMSTATE_UINT32_ARRAY(fszreg, DWC2State,
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 279263489e..09d8e25b97 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -648,7 +648,7 @@ static void usb_dwc3_init(Object *obj)
 static const VMStateDescription vmstate_usb_dwc3 = {
     .name = "usb-dwc3",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, USBDWC3, USB_DWC3_R_MAX),
         VMSTATE_UINT8(cfg.mode, USBDWC3),
         VMSTATE_UINT32(cfg.dwc_usb3_user, USBDWC3),
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 345444a573..0b26db74d8 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -144,7 +144,7 @@ static const VMStateDescription vmstate_ehci_pci = {
     .name        = "ehci",
     .version_id  = 2,
     .minimum_version_id  = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(pcidev, EHCIPCIState),
         VMSTATE_STRUCT(ehci, EHCIPCIState, 2, vmstate_ehci, EHCIState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index a12e218848..bfb774504c 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -25,7 +25,7 @@ static const VMStateDescription vmstate_ehci_sysbus = {
     .name        = "ehci-sysbus",
     .version_id  = 2,
     .minimum_version_id  = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ehci, EHCISysBusState, 2, vmstate_ehci, EHCIState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534c20..a8dcfe373a 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2473,7 +2473,7 @@ const VMStateDescription vmstate_ehci = {
     .minimum_version_id  = 1,
     .pre_save    = usb_ehci_pre_save,
     .post_load   = usb_ehci_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* mmio registers */
         VMSTATE_UINT32(usbcmd, EHCIState),
         VMSTATE_UINT32(usbsts, EHCIState),
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 6b630d35a7..33ed9b6f5a 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -120,7 +120,7 @@ static const VMStateDescription vmstate_ohci = {
     .name = "ohci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
         VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 7ff1b65ced..d73b53f33c 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1984,7 +1984,7 @@ static const VMStateDescription vmstate_ohci_state_port = {
     .name = "ohci-core/port",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctrl, OHCIPort),
         VMSTATE_END_OF_LIST()
     },
@@ -2002,7 +2002,7 @@ static const VMStateDescription vmstate_ohci_eof_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ohci_eof_timer_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(eof_timer, OHCIState),
         VMSTATE_END_OF_LIST()
     },
@@ -2012,7 +2012,7 @@ const VMStateDescription vmstate_ohci_state = {
     .name = "ohci-core",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(sof_time, OHCIState),
         VMSTATE_UINT32(ctl, OHCIState),
         VMSTATE_UINT32(status, OHCIState),
@@ -2049,7 +2049,7 @@ const VMStateDescription vmstate_ohci_state = {
         VMSTATE_BOOL(async_complete, OHCIState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ohci_eof_timer,
         NULL
     }
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 77baaa7a6b..7d3c026dae 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -339,7 +339,7 @@ static const VMStateDescription vmstate_uhci_port = {
     .name = "uhci port",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(ctrl, UHCIPort),
         VMSTATE_END_OF_LIST()
     }
@@ -361,7 +361,7 @@ static const VMStateDescription vmstate_uhci = {
     .version_id = 3,
     .minimum_version_id = 1,
     .post_load = uhci_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, UHCIState),
         VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
         VMSTATE_STRUCT_ARRAY(ports, UHCIState, NB_PORTS, 1,
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 643d4643e4..4423983308 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -178,7 +178,7 @@ static const VMStateDescription vmstate_xhci_pci = {
     .name = "xhci",
     .version_id = 1,
     .post_load = xhci_pci_vmstate_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
         VMSTATE_MSIX(parent_obj, XHCIPciState),
         VMSTATE_STRUCT(xhci, XHCIPciState, 1, vmstate_xhci, XHCIState),
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index faf57b4797..d93bae31f9 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -91,7 +91,7 @@ static Property xhci_sysbus_props[] = {
 static const VMStateDescription vmstate_xhci_sysbus = {
     .name = "xhci-sysbus",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(xhci, XHCISysbusState, 1, vmstate_xhci, XHCIState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..ad40232eb6 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3522,7 +3522,7 @@ static int usb_xhci_post_load(void *opaque, int version_id)
 static const VMStateDescription vmstate_xhci_ring = {
     .name = "xhci-ring",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(dequeue, XHCIRing),
         VMSTATE_BOOL(ccs, XHCIRing),
         VMSTATE_END_OF_LIST()
@@ -3532,7 +3532,7 @@ static const VMStateDescription vmstate_xhci_ring = {
 static const VMStateDescription vmstate_xhci_port = {
     .name = "xhci-port",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(portsc, XHCIPort),
         VMSTATE_END_OF_LIST()
     }
@@ -3541,7 +3541,7 @@ static const VMStateDescription vmstate_xhci_port = {
 static const VMStateDescription vmstate_xhci_slot = {
     .name = "xhci-slot",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(enabled,   XHCISlot),
         VMSTATE_BOOL(addressed, XHCISlot),
         VMSTATE_END_OF_LIST()
@@ -3551,7 +3551,7 @@ static const VMStateDescription vmstate_xhci_slot = {
 static const VMStateDescription vmstate_xhci_event = {
     .name = "xhci-event",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(type,   XHCIEvent),
         VMSTATE_UINT32(ccode,  XHCIEvent),
         VMSTATE_UINT64(ptr,    XHCIEvent),
@@ -3571,7 +3571,7 @@ static bool xhci_er_full(void *opaque, int version_id)
 static const VMStateDescription vmstate_xhci_intr = {
     .name = "xhci-intr",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* registers */
         VMSTATE_UINT32(iman,          XHCIInterrupter),
         VMSTATE_UINT32(imod,          XHCIInterrupter),
@@ -3604,7 +3604,7 @@ const VMStateDescription vmstate_xhci = {
     .name = "xhci-core",
     .version_id = 1,
     .post_load = usb_xhci_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
                                      vmstate_xhci_port, XHCIPort),
         VMSTATE_STRUCT_VARRAY_UINT32(slots, XHCIState, numslots, 1,
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index d7060a42d5..80122b4125 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1753,7 +1753,7 @@ static const VMStateDescription vmstate_usb_host = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = usb_host_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(parent_obj, USBHostDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/imx-usb-phy.c b/hw/usb/imx-usb-phy.c
index 1a97b36a11..18917d7599 100644
--- a/hw/usb/imx-usb-phy.c
+++ b/hw/usb/imx-usb-phy.c
@@ -20,7 +20,7 @@ static const VMStateDescription vmstate_imx_usbphy = {
     .name = TYPE_IMX_USBPHY,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(usbphy, IMXUSBPHYState, USBPHY_MAX),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df867..636eb98e41 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2373,7 +2373,7 @@ static const VMStateDescription usbredir_bulk_receiving_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = usbredir_bulk_receiving_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(bulk_receiving_started, struct endp_data),
         VMSTATE_END_OF_LIST()
     }
@@ -2391,7 +2391,7 @@ static const VMStateDescription usbredir_stream_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = usbredir_stream_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(max_streams, struct endp_data),
         VMSTATE_END_OF_LIST()
     }
@@ -2401,7 +2401,7 @@ static const VMStateDescription usbredir_ep_vmstate = {
     .name = "usb-redir-ep",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(type, struct endp_data),
         VMSTATE_UINT8(interval, struct endp_data),
         VMSTATE_UINT8(interface, struct endp_data),
@@ -2424,7 +2424,7 @@ static const VMStateDescription usbredir_ep_vmstate = {
         VMSTATE_INT32(bufpq_target_size, struct endp_data),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &usbredir_bulk_receiving_vmstate,
         &usbredir_stream_vmstate,
         NULL
@@ -2481,7 +2481,7 @@ static const VMStateDescription usbredir_ep_packet_id_queue_vmstate = {
     .name = "usb-redir-packet-id-queue",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name         = "queue",
             .version_id   = 0,
@@ -2501,7 +2501,7 @@ static const VMStateDescription usbredir_device_info_vmstate = {
     .name = "usb-redir-device-info",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(speed, struct usb_redir_device_connect_header),
         VMSTATE_UINT8(device_class, struct usb_redir_device_connect_header),
         VMSTATE_UINT8(device_subclass, struct usb_redir_device_connect_header),
@@ -2520,7 +2520,7 @@ static const VMStateDescription usbredir_interface_info_vmstate = {
     .name = "usb-redir-interface-info",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(interface_count,
                        struct usb_redir_interface_info_header),
         VMSTATE_UINT8_ARRAY(interface,
@@ -2543,7 +2543,7 @@ static const VMStateDescription usbredir_vmstate = {
     .minimum_version_id = 1,
     .pre_save = usbredir_pre_save,
     .post_load = usbredir_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBRedirDevice),
         VMSTATE_TIMER_PTR(attach_timer, USBRedirDevice),
         {
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index fc93429c9c..b7025d303d 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -512,7 +512,7 @@ static const VMStateDescription u2f_passthru_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = u2f_passthru_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_U2F_KEY(base, U2FPassthruState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index 56001249a4..1fb59cf404 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -305,7 +305,7 @@ const VMStateDescription vmstate_u2f_key = {
     .name = "u2f-key",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, U2FKeyState),
         VMSTATE_UINT8(idle, U2FKeyState),
         VMSTATE_UINT8_2DARRAY(pending_in, U2FKeyState,
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index 1c094aa1a6..6fc453817e 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -196,7 +196,7 @@ static const VMStateDescription vmstate_usb2_ctrl_regs = {
     .name = TYPE_XILINX_VERSAL_USB2_CTRL_REGS,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, VersalUsb2CtrlRegs, USB2_REGS_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
-- 
2.34.1



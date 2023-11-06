Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0967E1AD8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdv-0002ZQ-Ee; Mon, 06 Nov 2023 02:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-0001Ag-Gr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-000203-K7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:37 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28041176e77so3096567a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254134; x=1699858934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MefDazn7hTrYXkNQ0atrl5qviF4eW+DjpQGgXBNYXU=;
 b=i0NvCt6Qn2V+ZG3cWaCHwdGIuCoXA7gJKjS1B8k79ijfvyKLVH3MZDfaIFGUCvUFZo
 xS/pi90F0aTgqGDyLhsjuO9UMralGwSYn83yK0+A7WsG8wYSRmI8KeSNhN6wmFOqx/aY
 TJdEBC0iuf5HzfoVCKNreOcGKM8MBcqhwprhPzxf0SIANmEbZxGIOhpJOVads1NT9tP7
 A3Rl/ygblFLptCJeq020+NVg59p3IxCY9XujAh4Pm4vqszfH9GOKXfSC0EHXi8PJLkiL
 bnu9WhstlrtFYYIwdplIWlAQThX51I+BgyQCCRiDuHUSteFQDDsThHoanDSEha0nILfE
 VyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254134; x=1699858934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MefDazn7hTrYXkNQ0atrl5qviF4eW+DjpQGgXBNYXU=;
 b=iTV4sF5XvbSPPxTxRB1C9o80Z8Tx7Ez/JBpGzIwNeAztKQd94aKkGYebDMoUkF2W23
 68YebAqWwoc8dtz3udgIuQ9+5ki9xahcOUpXv01HOOLVJNk+gkBsS+bcTi2FmF7Pccy/
 qwiw5mGw2colqXDLBh69NaJsU1w/ZlbcRyvily+9qBn4G+6THoh9d+TUEKvhGad5aorE
 riAbO4O24p+6Dc9jtXRyxslT64ylsHf4lSs5PpZwaTyyJd7TkqIDzy+IIN8Ldx496nP+
 xkjh6Hs7ORw5Ue8vseMZ0t7Heup0qFwixg1HY1BSmG7RiTr3zl27Pl3jkpjZ8Q8AUraE
 bpaA==
X-Gm-Message-State: AOJu0Yx6zTDKVCM500o92AhHRsfuYPtbW9KjNMPq3xdMb0tGVGk2G2pw
 IFIA65P8ovyo7osL7puTzhzppONpJl8edYzVd3g=
X-Google-Smtp-Source: AGHT+IEtsea61QZSnBSTNSOEU4zsv65DhP8h3Utl+ah1x7UX+EJPWAubVz7GjG8XxRWmC938J+kfHQ==
X-Received: by 2002:a17:90b:1b11:b0:281:40b:5a84 with SMTP id
 nu17-20020a17090b1b1100b00281040b5a84mr1076322pjb.4.1699254133717; 
 Sun, 05 Nov 2023 23:02:13 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 51/71] hw/scsi: Constify VMState
Date: Sun,  5 Nov 2023 22:58:07 -0800
Message-Id: <20231106065827.543129-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 hw/scsi/esp-pci.c         | 2 +-
 hw/scsi/esp.c             | 8 ++++----
 hw/scsi/lsi53c895a.c      | 2 +-
 hw/scsi/megasas.c         | 4 ++--
 hw/scsi/mptsas.c          | 2 +-
 hw/scsi/scsi-bus.c        | 6 +++---
 hw/scsi/scsi-disk.c       | 2 +-
 hw/scsi/spapr_vscsi.c     | 4 ++--
 hw/scsi/vhost-scsi.c      | 2 +-
 hw/scsi/vhost-user-scsi.c | 2 +-
 hw/scsi/virtio-scsi.c     | 2 +-
 hw/scsi/vmw_pvscsi.c      | 6 +++---
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 4e890db0e2..93b3429e0f 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -333,7 +333,7 @@ static const VMStateDescription vmstate_esp_pci_scsi = {
     .version_id = 2,
     .minimum_version_id = 1,
     .pre_save = esp_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIESPState),
         VMSTATE_BUFFER_UNSAFE(dma_regs, PCIESPState, 0, 8 * sizeof(uint32_t)),
         VMSTATE_UINT8_V(esp.mig_version_id, PCIESPState, 2),
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9b11d8c573..ff90572830 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1237,7 +1237,7 @@ static const VMStateDescription vmstate_esp_pdma = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = esp_pdma_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(pdma_cb, ESPState),
         VMSTATE_END_OF_LIST()
     }
@@ -1248,7 +1248,7 @@ const VMStateDescription vmstate_esp = {
     .version_id = 6,
     .minimum_version_id = 3,
     .post_load = esp_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(rregs, ESPState),
         VMSTATE_BUFFER(wregs, ESPState),
         VMSTATE_INT32(ti_size, ESPState),
@@ -1277,7 +1277,7 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_esp_pdma,
         NULL
     }
@@ -1448,7 +1448,7 @@ static const VMStateDescription vmstate_sysbus_esp_scsi = {
     .version_id = 2,
     .minimum_version_id = 1,
     .pre_save = esp_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_V(esp.mig_version_id, SysBusESPState, 2),
         VMSTATE_STRUCT(esp, SysBusESPState, 0, vmstate_esp, ESPState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 634ed49c2e..34e3b89287 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2205,7 +2205,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
     .minimum_version_id = 0,
     .pre_save = lsi_pre_save,
     .post_load = lsi_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, LSIState),
 
         VMSTATE_INT32(carry, LSIState),
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 32c70c9e99..2d0c607177 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2299,7 +2299,7 @@ static const VMStateDescription vmstate_megasas_gen1 = {
     .name = "megasas",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
         VMSTATE_MSIX(parent_obj, MegasasState),
 
@@ -2317,7 +2317,7 @@ static const VMStateDescription vmstate_megasas_gen2 = {
     .name = "megasas-gen2",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
         VMSTATE_MSIX(parent_obj, MegasasState),
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 75d3ab8bd1..c5d3138c93 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1366,7 +1366,7 @@ static const VMStateDescription vmstate_mptsas = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = mptsas_post_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, MPTSASState),
         VMSTATE_BOOL(msi_in_use, MPTSASState),
         VMSTATE_UINT32(state, MPTSASState),
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index fc4b77fdb0..d27a4b354a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1826,7 +1826,7 @@ static const VMStateDescription vmstate_scsi_sense_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = scsi_sense_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_SUB_ARRAY(sense, SCSIDevice,
                                 SCSI_SENSE_BUF_SIZE_OLD,
                                 SCSI_SENSE_BUF_SIZE - SCSI_SENSE_BUF_SIZE_OLD),
@@ -1838,7 +1838,7 @@ const VMStateDescription vmstate_scsi_device = {
     .name = "SCSIDevice",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(unit_attention.key, SCSIDevice),
         VMSTATE_UINT8(unit_attention.asc, SCSIDevice),
         VMSTATE_UINT8(unit_attention.ascq, SCSIDevice),
@@ -1856,7 +1856,7 @@ const VMStateDescription vmstate_scsi_device = {
         },
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_scsi_sense_state,
         NULL
     }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6691f5edb8..45099fc5e6 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3168,7 +3168,7 @@ static const VMStateDescription vmstate_scsi_disk_state = {
     .name = "scsi-disk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SCSI_DEVICE(qdev, SCSIDiskState),
         VMSTATE_BOOL(media_changed, SCSIDiskState),
         VMSTATE_BOOL(media_event, SCSIDiskState),
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 5bbbef64ef..c75a6c8807 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -605,7 +605,7 @@ static const VMStateDescription vmstate_spapr_vscsi_req = {
     .name = "spapr_vscsi_req",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(crq.raw, vscsi_req),
         VMSTATE_BUFFER(viosrp_iu_buf, vscsi_req),
         VMSTATE_UINT32(qtag, vscsi_req),
@@ -1259,7 +1259,7 @@ static const VMStateDescription vmstate_spapr_vscsi = {
     .name = "spapr_vscsi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SPAPR_VIO(vdev, VSCSIState),
         /* VSCSI state */
         /* ???? */
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d..97a1f75ef1 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -158,7 +158,7 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .name = "virtio-vhost_scsi",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 4486500cac..6577c0e939 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -363,7 +363,7 @@ static const VMStateDescription vmstate_vhost_scsi = {
     .name = "virtio-scsi",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9c751bf296..3076cd7b1b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1303,7 +1303,7 @@ static const VMStateDescription vmstate_virtio_scsi = {
     .name = "virtio-scsi",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 4de34536e9..cd7bf6aa01 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1249,7 +1249,7 @@ static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
 static const VMStateDescription vmstate_pvscsi_pcie_device = {
     .name = "pvscsi/pcie",
     .needed = pvscsi_vmstate_need_pcie_device,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
         VMSTATE_END_OF_LIST()
     }
@@ -1261,7 +1261,7 @@ static const VMStateDescription vmstate_pvscsi = {
     .minimum_version_id = 0,
     .pre_save = pvscsi_pre_save,
     .post_load = pvscsi_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
                             pvscsi_vmstate_test_pci_device, 0,
                             vmstate_pci_device, PCIDevice),
@@ -1290,7 +1290,7 @@ static const VMStateDescription vmstate_pvscsi = {
 
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_pvscsi_pcie_device,
         NULL
     }
-- 
2.34.1



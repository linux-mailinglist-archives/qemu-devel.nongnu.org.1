Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404781AD64
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9et-0008D4-Ui; Wed, 20 Dec 2023 22:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9er-0008AG-OE
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:38 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ep-00070W-Nr
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:37 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67ad5b37147so1787556d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129014; x=1703733814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E2Zk4l5QNKn4te4fcYT5jUoKGYUCkVWAdFMiTl7xTnU=;
 b=qRGxR9mjCXY3mxb7pNJt0eIshozgz6xQnvsRurMcZoGVIepL8Wnwe/oHxz2rpCO10B
 XP1K0Y1Bwj8beWn2CVN4lVnT1A9blUQ5cWJVPPrdjeXX9PnKXX3rpg+o7fvmiurwdvx6
 dPgr8cOXEcafcHBH2aHp7Ubq++aN75m7tUiLw5v54s0yX0kF0NLnY4j0o2R7m26Ubrol
 d2ZEHp3y8eesKyKHbYSRX7OK991gpXfE4nyF4zf5iic7+a7eeOuQnuaRZHyfCmwbErqb
 vghpxBw0ljIIFbCkzpsnTfP/amxtS1b2LZAHzx3mVWpw61p4rD9n+7NVoQ81lxhyNu8+
 u07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129014; x=1703733814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2Zk4l5QNKn4te4fcYT5jUoKGYUCkVWAdFMiTl7xTnU=;
 b=BwagX5vy7HOIYdgrlFxXa17WL90XMpFSmeD/L+s924c+kqFLywBegPwH3xE/f7MR7U
 KvaqLPawQ31kG4jVCPIgNlwIi06l/fpxXGFY28lqXrbilai63SoM8Us+QlPuwe8CEl83
 5DdpG4o5UDWAuIy65rzv8ek5bGTkifogwbnanPOXkuBzT3kGtJc0+sMlhN5Or7sT1B+D
 8YtAEkqa4lao/dpbK+bD4tq7Vl0oWbtQSds0l7YI/3xVIOmd0KFbJx6c2n20oJN4pyqN
 IGiEu5yp/mDXYZ2PDvIOaU4UTwIUwQ9EUohHch2oI6Um2IwIZReeFzeXa2Aa7MvMmxPc
 qZCg==
X-Gm-Message-State: AOJu0YzxOtqxzoqJz1b5Iym7D0PRnJZ6c1cCit/0Dy0LmTWlrIVUdLm4
 1ASZzUesMedvL8L+2ROTCu4Isj42nYZaU4urhjsqF25s
X-Google-Smtp-Source: AGHT+IF9eI565j9n5Hry7wabJIplhigvtFTNUGuP5VNmtYL0k139zkdgvkEmYz8Ua81375zQ2vcGVA==
X-Received: by 2002:a05:6214:2509:b0:67f:2b5:b96a with SMTP id
 gf9-20020a056214250900b0067f02b5b96amr20628541qvb.51.1703129014289; 
 Wed, 20 Dec 2023 19:23:34 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/71] hw/scsi: Constify VMState
Date: Thu, 21 Dec 2023 14:16:32 +1100
Message-Id: <20231221031652.119827-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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
index 780f10559d..bab7594899 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -378,7 +378,7 @@ static const VMStateDescription vmstate_vhost_scsi = {
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



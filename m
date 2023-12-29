Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 006898201B6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPk-0007IM-Rk; Fri, 29 Dec 2023 16:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPj-0007HX-6R
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:07 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPX-0000M4-5t
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:06 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso5599891a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885334; x=1704490134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uWYrugkHEWBc6Cby1jqzi6Op/DM/ZQDlsHv8VnjupHU=;
 b=bfu9xg/siLNpFFfa0qrFl5lGjRTvyRoIHk0C4ELNEtFFNHjML4purtYA5N6G6Dob4T
 vuF4ZozcxbuIZCbc7xTq+dJZp4+Gyapn1tttOWNCBT8kvabBCk6QfZbcwlmC5E4KHf7k
 DAWoLml+Up/YD2PyuG8zyw3fJvAaqlrVfxFgfYHOKL9NINwhYUCyE8xTm9xG75ec14ZX
 UheYSOTFdTNyM8sQAc5bDZgz900I+Na/OwjQhPsrpkAjMVE9Bhh3/2Q5FevyMd1jV26M
 tg5BFzZx1ia3GHMw8uGyxdOrO/J0fINC+H+V00eG783liXeRVNMxSpc6gUsokPhl/Tpw
 KDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885334; x=1704490134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWYrugkHEWBc6Cby1jqzi6Op/DM/ZQDlsHv8VnjupHU=;
 b=EOjKnYpxXfu+Gfk6iNqEXYezeMuQtH0cDv3q2fF2O3cy48Y3GrNsau9lKvGveQ70JJ
 qSLmwjHU1YMsRrHXg2bjqMycEzZzlP9vyWFFeZYkhuDTCuEbrv+MWsv4RiS2pfPhZnBj
 AanChblKtX65yWkvvuj3VddNLO96fDK1jddrwzjeVi/TqZ17REKAl7aHuUBvmaGIM1TJ
 KTWsOWMv+shUMZsg2skPx8wPlU8jSRLfwNGUfRjV732T40vuZxd3XjfGfa47+EQ3RU/7
 6oUXZoqELmr2t/YT2jSAbo04gswLqGIOV8+/L0iN/7ZusZUU7C1JKBkMpRa4UjLPKI3B
 z1Cg==
X-Gm-Message-State: AOJu0Yzj65hZCwmZxW7Rity1Uebu6f05odC8yrQNxUfk+Zu6/n0pwkTO
 v0Nvbp2jpxrhxIzYl2pB3pB0qcNtV5fdjzJYy86nWdtQpkU1GQ==
X-Google-Smtp-Source: AGHT+IEvGcfaZcxXJFr9wwYuRsuGlVFzQ5wkHy4eQLhV29XsUDl3rSuodRq8ciQAipDWEkbLnYm3Aw==
X-Received: by 2002:a05:6a20:471b:b0:18f:97c:8a43 with SMTP id
 ek27-20020a056a20471b00b0018f097c8a43mr14316517pzb.110.1703885333881; 
 Fri, 29 Dec 2023 13:28:53 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/71] hw/scsi: Constify VMState
Date: Sat, 30 Dec 2023 08:23:26 +1100
Message-Id: <20231229212346.147149-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
Message-Id: <20231221031652.119827-52-richard.henderson@linaro.org>
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
index 5b08cbf60a..0a2eb11c56 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1893,7 +1893,7 @@ static const VMStateDescription vmstate_scsi_sense_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = scsi_sense_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_SUB_ARRAY(sense, SCSIDevice,
                                 SCSI_SENSE_BUF_SIZE_OLD,
                                 SCSI_SENSE_BUF_SIZE - SCSI_SENSE_BUF_SIZE_OLD),
@@ -1905,7 +1905,7 @@ const VMStateDescription vmstate_scsi_device = {
     .name = "SCSIDevice",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(unit_attention.key, SCSIDevice),
         VMSTATE_UINT8(unit_attention.asc, SCSIDevice),
         VMSTATE_UINT8(unit_attention.ascq, SCSIDevice),
@@ -1923,7 +1923,7 @@ const VMStateDescription vmstate_scsi_device = {
         },
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_scsi_sense_state,
         NULL
     }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 2e7e1e9a1c..4bd7af9d0c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3137,7 +3137,7 @@ static const VMStateDescription vmstate_scsi_disk_state = {
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
index 6159eb6fec..58a00336c2 100644
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
index af18c4f3d3..a63b1f4948 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -379,7 +379,7 @@ static const VMStateDescription vmstate_vhost_scsi = {
     .name = "virtio-scsi",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ca365a70e9..690aceec45 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1305,7 +1305,7 @@ static const VMStateDescription vmstate_virtio_scsi = {
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



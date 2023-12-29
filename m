Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F7B8201C8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLx-0000dA-Rs; Fri, 29 Dec 2023 16:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLv-0000U4-Mz
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:11 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLt-0007dw-BM
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:11 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-204520717b3so4271215fac.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885108; x=1704489908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMrkYLAKhlidNhCsAe4IjSCxPohHb/FzPsi2dGbb00E=;
 b=wwoXPhUSkKqkizyoIFBrO5tsUEupVSxSwTeRJ5EYjFH228tDdFSPdSFdYCLGl1lcbD
 lR79SeFGa7HjdHI2J0K5+MXVYtCse7S1NJ3deYqpRIR4V7w2tBBp3lhVzKwNak3W9HtH
 pYmtBVIerE7Xil+7bRLYKdk1bxwVNPD06eRjV2c255U8VxGdCR2KoLWC+01vs9toudAL
 uqTXr2fsw1AIESvDyuHey5xK9w20gvVDPrc2rJ/SQcDDrxE32lWm34iJucl+/XbRWLXe
 ruglT12r5vs7jS+MEa+aSr5fqXH/EaaV19DRX2b5eZjkRGwKx5YCzB0znCAri/YXlnK1
 Tm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885108; x=1704489908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMrkYLAKhlidNhCsAe4IjSCxPohHb/FzPsi2dGbb00E=;
 b=cXLR+Dsh1J3uqFcR70D3Qlmk78EhxxZokskWj24fFsqU8b1IWSq+3fcm+3A4OZ+Amq
 kVl9GfphRYczdluCjNL7oGy76uAm6vN5kPwvtfjp4sMK8D5RafB4fo6paycFiGvG70pT
 vzm1nwSAcKowl7tRq9qkeKi3gLSomTLFXLbMTB0Xyc4unK00+//kWlPfks0U0yag6Blm
 2JsRe8Fm8TqwFtiUZgnd/hsuMGFF4SGB3tfipodb1j5vfNBAxKbrRG8w8gRSAluLmijN
 F/EvuSM9o/eDUZyiCtXd3IfGOEdXmfaOKZs18TC3YbYYkSTBHlGbINfMU/ez2Pfnv6Ni
 P8GA==
X-Gm-Message-State: AOJu0YyQHScij5yROx+yXmvXu+NxYBGr5qGrpp5Sfm/T1zRIkfeuesCg
 rDobp7HWFTkaZqd0ID9UlwKsnMiYG9EtKkRUtxZoRvfWtrIyXw==
X-Google-Smtp-Source: AGHT+IGuo/JsQfj4dlG1QTXU3vyNnd/i+tqwOe7KpP5OTsOSgJmGgfx0zwarVmMLsZZJ+ezJMv4gSg==
X-Received: by 2002:a05:6870:3104:b0:204:76d:dbe1 with SMTP id
 v4-20020a056870310400b00204076ddbe1mr13617229oaa.61.1703885108110; 
 Fri, 29 Dec 2023 13:25:08 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/71] hw/ide: Constify VMState
Date: Sat, 30 Dec 2023 08:23:07 +1100
Message-Id: <20231229212346.147149-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
Message-Id: <20231221031652.119827-33-richard.henderson@linaro.org>
---
 hw/ide/ahci-allwinner.c |  2 +-
 hw/ide/ahci.c           |  8 ++++----
 hw/ide/core.c           | 16 ++++++++--------
 hw/ide/ich.c            |  2 +-
 hw/ide/isa.c            |  2 +-
 hw/ide/macio.c          |  2 +-
 hw/ide/microdrive.c     |  2 +-
 hw/ide/mmio.c           |  2 +-
 hw/ide/pci.c            | 10 +++++-----
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 227e747ba7..b173121006 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -97,7 +97,7 @@ static const VMStateDescription vmstate_allwinner_ahci = {
     .name = "allwinner-ahci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AllwinnerAHCIState,
                              ALLWINNER_AHCI_MMIO_SIZE / 4),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index afdc44b8e0..0eb83a6d46 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1685,7 +1685,7 @@ void ahci_reset(AHCIState *s)
 static const VMStateDescription vmstate_ncq_tfs = {
     .name = "ncq state",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sector_count, NCQTransferState),
         VMSTATE_UINT64(lba, NCQTransferState),
         VMSTATE_UINT8(tag, NCQTransferState),
@@ -1700,7 +1700,7 @@ static const VMStateDescription vmstate_ncq_tfs = {
 static const VMStateDescription vmstate_ahci_device = {
     .name = "ahci port",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IDE_BUS(port, AHCIDevice),
         VMSTATE_IDE_DRIVE(port.ifs[0], AHCIDevice),
         VMSTATE_UINT32(port_state, AHCIDevice),
@@ -1817,7 +1817,7 @@ const VMStateDescription vmstate_ahci = {
     .name = "ahci",
     .version_id = 1,
     .post_load = ahci_state_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(dev, AHCIState, ports,
                                      vmstate_ahci_device, AHCIDevice),
         VMSTATE_UINT32(control_regs.cap, AHCIState),
@@ -1833,7 +1833,7 @@ const VMStateDescription vmstate_ahci = {
 
 static const VMStateDescription vmstate_sysbus_ahci = {
     .name = "sysbus-ahci",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_AHCI(ahci, SysbusAHCIState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 8a0579bff4..9c4a812902 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2918,7 +2918,7 @@ static const VMStateDescription vmstate_ide_atapi_gesn_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_atapi_gesn_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(events.new_media, IDEState),
         VMSTATE_BOOL(events.eject_request, IDEState),
         VMSTATE_END_OF_LIST()
@@ -2930,7 +2930,7 @@ static const VMStateDescription vmstate_ide_tray_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_tray_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(tray_open, IDEState),
         VMSTATE_BOOL(tray_locked, IDEState),
         VMSTATE_END_OF_LIST()
@@ -2944,7 +2944,7 @@ static const VMStateDescription vmstate_ide_drive_pio_state = {
     .pre_save = ide_drive_pio_pre_save,
     .post_load = ide_drive_pio_post_load,
     .needed = ide_drive_pio_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(req_nb_sectors, IDEState),
         VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
                              vmstate_info_uint8, uint8_t),
@@ -2962,7 +2962,7 @@ const VMStateDescription vmstate_ide_drive = {
     .version_id = 3,
     .minimum_version_id = 0,
     .post_load = ide_drive_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(mult_sectors, IDEState),
         VMSTATE_INT32(identify_set, IDEState),
         VMSTATE_BUFFER_TEST(identify_data, IDEState, is_identify_set),
@@ -2985,7 +2985,7 @@ const VMStateDescription vmstate_ide_drive = {
         VMSTATE_UINT8_V(cdrom_changed, IDEState, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ide_drive_pio_state,
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
@@ -2998,7 +2998,7 @@ static const VMStateDescription vmstate_ide_error_status = {
     .version_id = 2,
     .minimum_version_id = 1,
     .needed = ide_error_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(error_status, IDEBus),
         VMSTATE_INT64_V(retry_sector_num, IDEBus, 2),
         VMSTATE_UINT32_V(retry_nsector, IDEBus, 2),
@@ -3011,12 +3011,12 @@ const VMStateDescription vmstate_ide_bus = {
     .name = "ide_bus",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cmd, IDEBus),
         VMSTATE_UINT8(unit, IDEBus),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ide_error_status,
         NULL
     }
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index d61faab532..49f8eb8a7d 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -83,7 +83,7 @@
 static const VMStateDescription vmstate_ich9_ahci = {
     .name = "ich9_ahci",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, AHCIPCIState),
         VMSTATE_AHCI(ahci, AHCIPCIState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index ea60c08116..cc865c83dc 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -58,7 +58,7 @@ static const VMStateDescription vmstate_ide_isa = {
     .name = "isa-ide",
     .version_id = 3,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IDE_BUS(bus, ISAIDEState),
         VMSTATE_IDE_DRIVES(bus.ifs, ISAIDEState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index dca1cc9efc..0d2c6ba910 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -361,7 +361,7 @@ static const VMStateDescription vmstate_pmac = {
     .name = "ide",
     .version_id = 5,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IDE_BUS(bus, MACIOIDEState),
         VMSTATE_IDE_DRIVES(bus.ifs, MACIOIDEState),
         VMSTATE_BOOL(dma_active, MACIOIDEState),
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 981cfbd97f..a7f415f0fc 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -336,7 +336,7 @@ static const VMStateDescription vmstate_microdrive = {
     .name = "microdrive",
     .version_id = 3,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(opt, MicroDriveState),
         VMSTATE_UINT8(stat, MicroDriveState),
         VMSTATE_UINT8(pins, MicroDriveState),
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 3aeacab3bb..e8f41c0610 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -110,7 +110,7 @@ static const VMStateDescription vmstate_ide_mmio = {
     .name = "mmio-ide",
     .version_id = 3,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IDE_BUS(bus, MMIOIDEState),
         VMSTATE_IDE_DRIVES(bus.ifs, MMIOIDEState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 810c6b6d98..ca85d8474c 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -501,7 +501,7 @@ static const VMStateDescription vmstate_bmdma_current = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_bmdma_current_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cur_addr, BMDMAState),
         VMSTATE_UINT32(cur_prd_last, BMDMAState),
         VMSTATE_UINT32(cur_prd_addr, BMDMAState),
@@ -515,7 +515,7 @@ static const VMStateDescription vmstate_bmdma_status = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_bmdma_status_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(status, BMDMAState),
         VMSTATE_END_OF_LIST()
     }
@@ -526,7 +526,7 @@ static const VMStateDescription vmstate_bmdma = {
     .version_id = 3,
     .minimum_version_id = 0,
     .pre_save  = ide_bmdma_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cmd, BMDMAState),
         VMSTATE_UINT8(migration_compat_status, BMDMAState),
         VMSTATE_UINT32(addr, BMDMAState),
@@ -535,7 +535,7 @@ static const VMStateDescription vmstate_bmdma = {
         VMSTATE_UINT8(migration_retry_unit, BMDMAState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_bmdma_current,
         &vmstate_bmdma_status,
         NULL
@@ -562,7 +562,7 @@ const VMStateDescription vmstate_ide_pci = {
     .version_id = 3,
     .minimum_version_id = 0,
     .post_load = ide_pci_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIIDEState),
         VMSTATE_STRUCT_ARRAY(bmdma, PCIIDEState, 2, 0,
                              vmstate_bmdma, BMDMAState),
-- 
2.34.1



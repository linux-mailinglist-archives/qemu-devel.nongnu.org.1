Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 559CB81AD4D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ag-0004lD-Kf; Wed, 20 Dec 2023 22:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ac-0004bc-3Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:14 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aZ-00044E-T3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:13 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-78106c385a1so20254485a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128751; x=1703733551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwTu2uwZKwQsQgRXhNqghxLsmgTtqvnKVK7hajFstQ8=;
 b=DmGtFkiM/PO43XMiRyCKd6SF2kULlpAo8zvqIMLvFm+GvRUGNRtBiYML8tlbB5PkRj
 /t4qCpKaUgjbTFWHKTl2hEE/g39DgI3vRsl+ltc4PXxL8MRoNlIYRp2PhylaMQDHyA6S
 77l6kOXdHcbhlB+KMXPUEm/b9Lh1lZ61bRQt45vYyGmVu/ZCzCKwNn0jkja/I3yRIAoC
 CHTJkyfkKqM5yqentbn+1SKWQavezn6wbbMv9g+BAjWR+BbW2ag4T2Dwzqgd3mn7aWBQ
 JXDe+pNXclWGM549frK9Pm6yIzjWshShzxG3ahsaXPuV3DNvHxnTEyqm/mqn7QbbyerY
 m82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128751; x=1703733551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwTu2uwZKwQsQgRXhNqghxLsmgTtqvnKVK7hajFstQ8=;
 b=Vhly/rzVMMhyRTYKt1dOvjF5f1Wo0iKMZy8gyVVLZztQQ8BhvrfjNhsJEauryqZJFn
 tRS1diD1U6t+CvD5AHiDuFTz7SPLk8NCuffb9uev6jvWq5D9PcPlESBbM5VrGH2bT7f+
 OE7ZXOrqG2avkewGreqBTSMoq2HHffmISMF5pwPYNoiXRResSVMcXqC3W2fejw+mSc2q
 2q6oO/mpr179wk/uW+2kyhizP3eAuj52w87vgo+EHHDOnR+yzbp80BAJ3Unh3HZbMxgF
 qvvZdf7GL/wC7x4UpD1mkkj0ZrzWFWRwb035IlDtPa2xSZiPRVlC+ba3QERCEZSi1Bnm
 ffmA==
X-Gm-Message-State: AOJu0Yz2IEMDdb9lZwfeqj63XUolluVUSvtox8PfzGaVSCqB8cuFJS9u
 qST4SfzJuhounJPbUjEl+aCfn97Yh9950EmFfnmkvAdZ
X-Google-Smtp-Source: AGHT+IFqKLzqaj1Ytx9vwFdyedo9PUGC4jhX2lTXrOXttjq3+pdt2vPPG2ST6LcGNF50azUsOYtOqg==
X-Received: by 2002:a37:ad03:0:b0:77f:64b:4b1d with SMTP id
 f3-20020a37ad03000000b0077f064b4b1dmr23307442qkm.115.1703128750974; 
 Wed, 20 Dec 2023 19:19:10 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/71] hw/ide: Constify VMState
Date: Thu, 21 Dec 2023 14:16:13 +1100
Message-Id: <20231221031652.119827-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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



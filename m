Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4B7E1AC4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta8-0005YT-HS; Mon, 06 Nov 2023 01:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZf-0004e8-8f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:08 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZb-0001Rz-90
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:02 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5bd85b1939aso297733a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253937; x=1699858737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhdGHofk/UGIfI32XkKyDOcSGvASTJZn9goVP8U1UKc=;
 b=zLI9hXrPzHKGUEGP3LsP4vmV/oL3nDhzCkZ44oydkT+q0C5gBn9Op37uplCXaKr5+3
 wKl9NFxFmgRfjcyj24aIUInM7cmCZOWMTRO8uWTRpPkbKBoqTQsuRG5WEgN2/Cab0vi0
 sFT1IqXtTTaGzM6CHSKhm6+2oCl5BlQIYDcNjsYQTYU1XwgBYCo46shbTdW4i6F1I03A
 jqUnb0FcrxKHX0cxLjgA4hw7awgzExVVa8/YA2mT5db+wqP8fzuAkaPea0U86xmiRISs
 aMfJD0JIfi+gPrtjz/3kW90MIDUZ0LPRpnRGVkcLX90In+80Ut7orlzDv6mJzxigenic
 AN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253937; x=1699858737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhdGHofk/UGIfI32XkKyDOcSGvASTJZn9goVP8U1UKc=;
 b=JyfRqdu6PLCjwv9R0jbBJjoxAtzPKV3/XJhCoOgruKJw3IRJK4xUSUeGxPet5TIQCI
 ni6X1XdfjUPRgchyR1KBDlXW68NG29yEIK8MToi2zDV8dJO9LLJPHukABZMWUCh5a1eo
 pl53iJFIc+BXZhKAcZjyf1PQbVX9zbZ2yw43XpXKSqyPRPWhM6UFuxC/WzwdZ6tRd78t
 2wFMDmC6V7lUskmsOF43pITTP13yxSd6TyOZ8L1m9yIO7TUuQEWX5azim+ih+YIJQdWk
 vMcnODjKjgAj6xWATnLZ1SLWTqg9oYbNJPCl280xqRA79Hu1YLUA2YvfAdRiMB2tfHuj
 3/0g==
X-Gm-Message-State: AOJu0YwW5yr2eHb6Q8j9XWjcMWl+gCEuUXuTEwd65MyKwx0LKvcJmST1
 kGce0a2t7HsfvljGfGfKa1RuSkECeqmmhftvees=
X-Google-Smtp-Source: AGHT+IHcIOPwPbvWB0Qy2KJTRv7sJInNRTCuU4rfGooJzqjZVT5Aai2ZHK/gUF4y9RsuQqIptmVDTw==
X-Received: by 2002:a05:6a20:914e:b0:16b:b824:b25c with SMTP id
 x14-20020a056a20914e00b0016bb824b25cmr23836681pzc.25.1699253937172; 
 Sun, 05 Nov 2023 22:58:57 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 32/71] hw/ide: Constify VMState
Date: Sun,  5 Nov 2023 22:57:48 -0800
Message-Id: <20231106065827.543129-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index fcc5476e9e..3fc7949504 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1661,7 +1661,7 @@ void ahci_reset(AHCIState *s)
 static const VMStateDescription vmstate_ncq_tfs = {
     .name = "ncq state",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sector_count, NCQTransferState),
         VMSTATE_UINT64(lba, NCQTransferState),
         VMSTATE_UINT8(tag, NCQTransferState),
@@ -1676,7 +1676,7 @@ static const VMStateDescription vmstate_ncq_tfs = {
 static const VMStateDescription vmstate_ahci_device = {
     .name = "ahci port",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_IDE_BUS(port, AHCIDevice),
         VMSTATE_IDE_DRIVE(port.ifs[0], AHCIDevice),
         VMSTATE_UINT32(port_state, AHCIDevice),
@@ -1793,7 +1793,7 @@ const VMStateDescription vmstate_ahci = {
     .name = "ahci",
     .version_id = 1,
     .post_load = ahci_state_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(dev, AHCIState, ports,
                                      vmstate_ahci_device, AHCIDevice),
         VMSTATE_UINT32(control_regs.cap, AHCIState),
@@ -1809,7 +1809,7 @@ const VMStateDescription vmstate_ahci = {
 
 static const VMStateDescription vmstate_sysbus_ahci = {
     .name = "sysbus-ahci",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_AHCI(ahci, SysbusAHCIState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/ide/core.c b/hw/ide/core.c
index b5e0dcd29b..c87e015c6d 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2906,7 +2906,7 @@ static const VMStateDescription vmstate_ide_atapi_gesn_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_atapi_gesn_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(events.new_media, IDEState),
         VMSTATE_BOOL(events.eject_request, IDEState),
         VMSTATE_END_OF_LIST()
@@ -2918,7 +2918,7 @@ static const VMStateDescription vmstate_ide_tray_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_tray_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(tray_open, IDEState),
         VMSTATE_BOOL(tray_locked, IDEState),
         VMSTATE_END_OF_LIST()
@@ -2932,7 +2932,7 @@ static const VMStateDescription vmstate_ide_drive_pio_state = {
     .pre_save = ide_drive_pio_pre_save,
     .post_load = ide_drive_pio_post_load,
     .needed = ide_drive_pio_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(req_nb_sectors, IDEState),
         VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
                              vmstate_info_uint8, uint8_t),
@@ -2950,7 +2950,7 @@ const VMStateDescription vmstate_ide_drive = {
     .version_id = 3,
     .minimum_version_id = 0,
     .post_load = ide_drive_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(mult_sectors, IDEState),
         VMSTATE_INT32(identify_set, IDEState),
         VMSTATE_BUFFER_TEST(identify_data, IDEState, is_identify_set),
@@ -2973,7 +2973,7 @@ const VMStateDescription vmstate_ide_drive = {
         VMSTATE_UINT8_V(cdrom_changed, IDEState, 3),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_ide_drive_pio_state,
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
@@ -2986,7 +2986,7 @@ static const VMStateDescription vmstate_ide_error_status = {
     .version_id = 2,
     .minimum_version_id = 1,
     .needed = ide_error_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(error_status, IDEBus),
         VMSTATE_INT64_V(retry_sector_num, IDEBus, 2),
         VMSTATE_UINT32_V(retry_nsector, IDEBus, 2),
@@ -2999,12 +2999,12 @@ const VMStateDescription vmstate_ide_bus = {
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
index a25b352537..841c9cc1d2 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -417,7 +417,7 @@ static const VMStateDescription vmstate_bmdma_current = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_bmdma_current_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cur_addr, BMDMAState),
         VMSTATE_UINT32(cur_prd_last, BMDMAState),
         VMSTATE_UINT32(cur_prd_addr, BMDMAState),
@@ -431,7 +431,7 @@ static const VMStateDescription vmstate_bmdma_status = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ide_bmdma_status_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(status, BMDMAState),
         VMSTATE_END_OF_LIST()
     }
@@ -442,7 +442,7 @@ static const VMStateDescription vmstate_bmdma = {
     .version_id = 3,
     .minimum_version_id = 0,
     .pre_save  = ide_bmdma_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(cmd, BMDMAState),
         VMSTATE_UINT8(migration_compat_status, BMDMAState),
         VMSTATE_UINT32(addr, BMDMAState),
@@ -451,7 +451,7 @@ static const VMStateDescription vmstate_bmdma = {
         VMSTATE_UINT8(migration_retry_unit, BMDMAState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_bmdma_current,
         &vmstate_bmdma_status,
         NULL
@@ -478,7 +478,7 @@ const VMStateDescription vmstate_ide_pci = {
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



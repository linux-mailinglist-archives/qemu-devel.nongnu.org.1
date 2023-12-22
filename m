Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55981CAD6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:46:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqy-000817-0G; Fri, 22 Dec 2023 08:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqr-0007fl-Fx
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:11 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqo-0004Ku-O3
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:08 -0500
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso20180135e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252765; x=1703857565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvjT6XGF34uXDpAsXHRV9pyFxLTDv0B0QGWNCMXll/U=;
 b=wDMhQ1aN9dA8xLUKuER82Z+sBFvbrWAluWg+mfSv16Sc/FmRm3Z7/dP/3SMeBIFOGL
 lYAiuHhHUkYU5aDsLPCtFeIJWxeztATdumVG+c5Ewzt5o39gRROLcDrcw7kYfLzpjCD+
 ZP+4QCXnVOlxxtKK1+MWyaUhjcysf67ChDNWAFhg2pCcu/EMnl/ML+l7exZ2bi9NOFlG
 phoEbYbEm40wibUNPmj0y7EqeK/2l6WcA1lYwNiv3E39v1BnCncpqZNm25T9z5DSBYk/
 s0HlS+3vYkKIEMNBFdkAxg+sOJ6YTAzadeOv1OYNBrclJoavdkgfOatInbP0SZ9kKw2h
 w43Q==
X-Gm-Message-State: AOJu0YzXGjtcvUe3X2/sJ6A20rOzokQan9zbZAKiU8wUCvzvhFEZRie+
 pJCGwBYqxra6vM9l1vK2nNpGX7ngcPI=
X-Google-Smtp-Source: AGHT+IHoSpMzgydTb2aKSLS240A2eZHmASFjs8YuLhCGcNyY9aMJzRo1bs7ExSVSNeF/8BtAeRjzrg==
X-Received: by 2002:a05:600c:16ca:b0:40b:5e1a:db89 with SMTP id
 l10-20020a05600c16ca00b0040b5e1adb89mr520264wmn.42.1703252764785; 
 Fri, 22 Dec 2023 05:46:04 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:46:04 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 11/11] next-cube.c: move machine MemoryRegions into NeXTState
Date: Fri, 22 Dec 2023 14:45:27 +0100
Message-ID: <20231222134527.15705-12-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.54; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f54.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These static memory regions are contained within the machine and do not need to
be dynamically allocated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d9a1f234ec..292f13defb 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -74,6 +74,12 @@ typedef struct NextRtc {
 struct NeXTState {
     MachineState parent;
 
+    MemoryRegion rom;
+    MemoryRegion rom2;
+    MemoryRegion dmamem;
+    MemoryRegion bmapm1;
+    MemoryRegion bmapm2;
+
     next_dma dma[10];
 };
 
@@ -967,13 +973,9 @@ static const TypeInfo next_pc_info = {
 
 static void next_cube_init(MachineState *machine)
 {
+    NeXTState *m = NEXT_MACHINE(machine);
     M68kCPU *cpu;
     CPUM68KState *env;
-    MemoryRegion *rom = g_new(MemoryRegion, 1);
-    MemoryRegion *rom2 = g_new(MemoryRegion, 1);
-    MemoryRegion *dmamem = g_new(MemoryRegion, 1);
-    MemoryRegion *bmapm1 = g_new(MemoryRegion, 1);
-    MemoryRegion *bmapm2 = g_new(MemoryRegion, 1);
     MemoryRegion *sysmem = get_system_memory();
     const char *bios_name = machine->firmware ?: ROM_FILE;
     DeviceState *pcdev;
@@ -1008,21 +1010,23 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
     /* BMAP memory */
-    memory_region_init_ram_flags_nomigrate(bmapm1, NULL, "next.bmapmem", 64,
-                                           RAM_SHARED, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x020c0000, bmapm1);
+    memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
+                                           64, RAM_SHARED, &error_fatal);
+    memory_region_add_subregion(sysmem, 0x020c0000, &m->bmapm1);
     /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
-    memory_region_init_alias(bmapm2, NULL, "next.bmapmem2", bmapm1, 0x0, 64);
-    memory_region_add_subregion(sysmem, 0x820c0000, bmapm2);
+    memory_region_init_alias(&m->bmapm2, NULL, "next.bmapmem2", &m->bmapm1,
+                             0x0, 64);
+    memory_region_add_subregion(sysmem, 0x820c0000, &m->bmapm2);
 
     /* KBD */
     sysbus_create_simple(TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
-    memory_region_init_rom(rom, NULL, "next.rom", 0x20000, &error_fatal);
-    memory_region_add_subregion(sysmem, 0x01000000, rom);
-    memory_region_init_alias(rom2, NULL, "next.rom2", rom, 0x0, 0x20000);
-    memory_region_add_subregion(sysmem, 0x0, rom2);
+    memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
+    memory_region_add_subregion(sysmem, 0x01000000, &m->rom);
+    memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
+                             0x20000);
+    memory_region_add_subregion(sysmem, 0x0, &m->rom2);
     if (load_image_targphys(bios_name, 0x01000000, 0x20000) < 8) {
         if (!qtest_enabled()) {
             error_report("Failed to load firmware '%s'.", bios_name);
@@ -1049,9 +1053,9 @@ static void next_cube_init(MachineState *machine)
     next_scsi_init(pcdev, cpu);
 
     /* DMA */
-    memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
-                          0x5000);
-    memory_region_add_subregion(sysmem, 0x02000000, dmamem);
+    memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
+                          "next.dma", 0x5000);
+    memory_region_add_subregion(sysmem, 0x02000000, &m->dmamem);
 }
 
 static void next_machine_class_init(ObjectClass *oc, void *data)
-- 
2.43.0



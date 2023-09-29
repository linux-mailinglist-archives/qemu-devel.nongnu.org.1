Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F137B394E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 20:01:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmHnY-00057N-EE; Fri, 29 Sep 2023 14:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHnP-0004nz-Vv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:01:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHnL-0005or-OY
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 14:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A/BuwvOQKMa2Gm5PySdrDjVIxKU1rvqpEyClG1IWoXU=; b=fW6NSREnKDHZbnWIoH4Xg/EcQj
 y3i1jZrsmuR3bcdPlMFvz9st5RgmFXOOmm0rk38ZFi9FLkZ5m0cfW6ir8YpgF+G6i8fbk7OAX/Wv6
 7Dce2aRDJwh08LyzVVMohpvmaWClXs0Q8A6WkvUVbCJMXSaMktwJMJ27y5icDXN1CWa00VUpzR+TX
 EPiWv22+Uw+Yb2cyBFIOUAQUeQIqoW/ggsWn25/+IWUxx3DVS84xqYIBPifCqRQdyfkdnnc+zNrJ4
 Mniqu1EvjsIDue6U8lO8SlBzAoaEgYNFJkq8pE6MlFonwA+Z1iDBC80Fru1g/byFXjob6GpDgmvEt
 nhUWSQua+aaO5E40QdFu2LCZTv0px1bQIwVbl4Bo1NabG/Pi/7hSLvLjbb1oF7oG+bbF04GBuv0TL
 de5zr922zj2bsGYABFso/6gIg7tWZrYxbJu1pw/oGC4HNEux6uz2JIq6lrAL8hDxFIcX+YeUUo1IV
 lpgaQo0bgxA+gr7udOwQrs0pfCXib2S0U+kJ9gdUTfgRFUPIXTV88H/5l22cwGSENkmw15TFqPVb1
 DtiK1LTHR209KiP3FlemcsfsYAcjJn3ODORcni7wMvYBwABHL6AcTiC/srpFiWFfVStNl4Eh/rrl2
 UUTOuYUWKFlSiFggOkPWk1/3ix1CQYH7OL2WFYdGI=;
Received: from [2a00:23c4:8baf:5f00:c237:5189:8121:f752]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qmHmx-00033Y-EX; Fri, 29 Sep 2023 19:00:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Fri, 29 Sep 2023 18:59:16 +0100
Message-Id: <20230929175917.511133-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
References: <20230929175917.511133-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:c237:5189:8121:f752
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 19/20] q800: add alias for MacOS toolbox ROM at 0x40000000
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the Apple Quadra 800 Developer Note document, the Quadra 800 ROM
consists of 2 ROM code sections based at offsets 0x0 and 0x800000. A/UX attempts
to access the toolbox ROM at the lower offset during startup, so provide a
memory alias to allow the access to succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 5 +++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b5b2cabc33..87665c6407 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -657,6 +657,11 @@ static void q800_machine_init(MachineState *machine)
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
 
+        memory_region_init_alias(&m->rom_alias, NULL, "m68k_mac.rom-alias",
+                                 &m->rom, 0, MACROM_SIZE);
+        memory_region_add_subregion(get_system_memory(), 0x40000000,
+                                    &m->rom_alias);
+
         /* Load MacROM binary */
         if (filename) {
             bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 348eaf4703..a9661f65f6 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -50,6 +50,7 @@ struct Q800MachineState {
     bool easc;
     M68kCPU cpu;
     MemoryRegion rom;
+    MemoryRegion rom_alias;
     GLUEState glue;
     MOS6522Q800VIA1State via1;
     MOS6522Q800VIA2State via2;
-- 
2.39.2



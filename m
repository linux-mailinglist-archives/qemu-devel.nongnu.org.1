Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61307B7A55
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxQE-0007Zk-VX; Wed, 04 Oct 2023 04:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxQ2-0006uy-QE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPr-0007l3-JB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LDAnj05b9ISTPE8LDHJnawABkQ9209MrO7Qu4Ieiarw=; b=iOpiCZzSL+XjsYFnREPp7dVGhV
 5bIm/Sw0plCsNvDEGMgY52B2ZLVaCVeuwcUvNP2u3WIWSSDFD9Bk27nbTiqlZIMqRyKX3tUjMmM6v
 DD4Q08Ku07BbeQtTAklVVFMUFlVIdIhR2BBw6y+KFSoz63Zx/vcXJOe7TNtkSfMbtcYVA393aUPWG
 z64OqOheQxk6vh0JbXdsvB8kAhJF3opTAV+Ko9wAaURaMmP4KBUIUafF8mzFE/5mVLKhIbIMKqC4C
 SOJo7lPOKgzwnS9K0kEFmb4wgx59PBzsJX9Yyrn3fsQnJicXcda9t3wgvru4mP13f3/3uO/+ViqXP
 ya80TYGftG9BewuqR1W7XJHlEe7nLACEGJq9TIZ8YLQQashtbNUfFKkJLTDW5cNL1d8WUiVfGoM+U
 2mS0cWpYHBkVib4xfwOL3h+Ey20keWyu3Rs6MBBWRFC4B4ysyIeU9OMm0l+deinPMhL5+I/eEY+hc
 cwbfcKJoJdPCep5b3rBOYjRup+Wjn87vZHoET/LjVdYUUyZa1I8Vp8H3ZyqMFybzaOO2GZwpsfHgK
 9BXgtLCvVR73MQRxA6E6S8T/Xn/U+B81mS9x/FbXPxAl/53WbHcDHFqfNujTxI8Wgzft7z+Gh3uxD
 v16J0p+lSmxL/0qlRGfOQpZ7vf1+41x7dCauh1UYg=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPW-0006za-4u; Wed, 04 Oct 2023 09:39:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:38:05 +0100
Message-Id: <20231004083806.757242-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 19/20] q800: add alias for MacOS toolbox ROM at 0x40000000
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 27a0b3c08a..1d7cd5ff1c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -660,6 +660,11 @@ static void q800_machine_init(MachineState *machine)
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



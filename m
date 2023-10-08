Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB27BCC98
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpND3-0008Ar-AH; Sun, 08 Oct 2023 02:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCz-00089p-P3
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCy-0007pn-60
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:09 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MDQRy-1qhA0m1WNS-00ATk2; Sun, 08
 Oct 2023 08:24:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 19/20] q800: add alias for MacOS toolbox ROM at 0x40000000
Date: Sun,  8 Oct 2023 08:23:48 +0200
Message-ID: <20231008062349.2733552-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ebkkFYN3NtMW/4LIxJ7zKsqOeMgf+f+VxuV7K14xNgkWdrGeBgv
 orLxSP3vG4i3jtAGLxivjfbzmh98ekqLJGi+oHAqhHrkhX0FxtQtWBqmjaKZ0ARYSZHFE+l
 w7Z/+7U36qSXTJ+ELACb0SoZtWtI5O/AbIokp5KRWijfoe9Ggs9P+dPTJ293OvNsGNsqSXY
 sTRNEGrr6O7FojfTPlx3Q==
UI-OutboundReport: notjunk:1;M01:P0:rnRbITuxG/Y=;YXfBgYgZA1nKzB7s/+iU6+j3N5Y
 BY0AMU8AsL7h5v98FDohBKoOo0NnVmvCUfS4+Oqljwggk/u2viQZUKIJr6jkdOE1xYP6qXOE3
 cLNr7B3e4jDrbtyIPhsjHIohCMCJh919/QJRhBJnBxxNI+doU1r2uip1WIw36Y+8VOQ/BHX0Q
 ybBWQedtox6MW7q7wHSlrmfRf/fda5fcjR6LE3F0oxVUU8+EjKpSssxmEUSdUbQrLbf0w3fCf
 CzZtl+NhH1FzsfDL8mIl2wFq4EqId4AI/drYQLZtgJJlnjNoj0hMOQD2g/Yy7GDLVL2snsIa3
 nm+svXp4aw1JzrEV7/be947pbZQ6cO/0KL5eLqCy/zrIY0k8JOWBhPrQ0qr8hsP/KHKW1EopB
 nLX1pP7l7tMY50KkQp3BCB9e+s+4Zkma8MuUF7lV/MJAx3EaLeKXt5ispA2OX6Yfdz9M0fEgK
 6lrO7MUI97kGB1epTUHiZEH3STerMsxjipAgPcQAPXQn8kWqvRbBa97T9jLdaaGpJZAioPE8J
 wjzB4hAs9Ailo5qMW4Lms+A4gCKX0umG9rVZ5oSyQwvD/SD3HlGwh8FhbxxRd5DOmf+uUOq8u
 qQGBWjHgfMKHs47EAGIHF3S16emdn3Z8+2Vn/BwC9hO0tkPVeE5cDtarWEMtmYV+kWb5HXeHs
 IrW5jQLWdgEMFpreLPb+Jm9eeC9le9gABPPHGOhqwVuQ8C/KcCfdhimGT0zOkqYxcAXkeVTqt
 R6BMfqtMsbSZYQ+6SAFTvn8mtYhkFr9kr8Cj+ICvmafHx3YAnsNB2pD4vpjeyOeUk84imdHVQ
 kzBCaX4dVyHexzXAPNCxLwe2UwIw8NGYY1p5zt/9hgTfOSsrWU6lU4L3jzAlwFY+UzRLq72NS
 AvN3CW9qnDoZFNw==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

According to the Apple Quadra 800 Developer Note document, the Quadra 800 ROM
consists of 2 ROM code sections based at offsets 0x0 and 0x800000. A/UX attempts
to access the toolbox ROM at the lower offset during startup, so provide a
memory alias to allow the access to succeed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-20-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h | 1 +
 hw/m68k/q800.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 348eaf4703d0..a9661f65f695 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 27a0b3c08a98..1d7cd5ff1c31 100644
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
-- 
2.41.0



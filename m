Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552872175F
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nb2-0006Ld-1b; Sun, 04 Jun 2023 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naj-0005SP-21
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nag-0003Qv-3b
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=brwLK4R+JeAc8ypKQkb2TIV3nhS/M5mLv6JQqyF4IOg=; b=yr8QRbEFiXtiAj0g1US2DrNUES
 9EsfjUxTfXw/H7b9RhjpBNKBjzeZdIj1/YHRS6ulAsyaV127etNO+KUjLK5Ja4VRVmfC35wS+Rr0z
 a8QsKfpwNcpLwjyZ6AnUkhf/S0awCqTHSJDYz/mYH1HnhrY4EKktKNW9oAZ2DURSU1KOFifiGJxlA
 JGXxfk2gTr8b5dAyyO/5CMCpvdTTvW5PxKXwLIhuT7X3ZWkwCtk5LgVTVK9+jNAXOcPDavWyePTAR
 7uNp/w3FJ1DyZpjzGM1d0i60QuqkP3m1XFBegkydvQPjvWpgZE/TYy9rjG9opc0V6er46UUGQqLRe
 lUN042Ct1i8pI54kCuRBLRrLYYcTMSLStQA1rYsRmz5PvsBHvNsdpOC4MhTjsLkUn1PCWH68n5JqI
 nRhw9r01jx+oQptF9rmqfUsjNqOIuwCNwph6CuWP1abvJJoOcbFGWKr1vcCBd3PQ2425pl9RslxNQ
 n74ZPqUIPCbs6mYCoDcMfqY7OU6YTcnPmP9osIg9LEBAJBdP+np5mIT4Dda9WHIGdMcwnEo0plsZd
 ViGCs2ExNHTxxnR7AyB9zHxYIoBursO5bi/oExAtqzS+YZr0Z9RTiXcvNJUrkO9sAfe0X77mK1cFP
 iNH2f66lFS0m/o40nonCbLOdlF1NJV9z31dLk7R0Q=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naL-0005pb-Np; Sun, 04 Jun 2023 14:15:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:45 +0100
Message-Id: <20230604131450.428797-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 18/23] q800: move SWIM device to Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Also change the instantiation of the SWIM device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 8 +++++---
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3ab4607134..d6e19ff18c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -406,10 +406,12 @@ static void q800_machine_init(MachineState *machine)
 
     /* SWIM floppy controller */
 
-    dev = qdev_new(TYPE_SWIM);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    object_initialize_child(OBJECT(machine), "swim", &m->swim,
+                            TYPE_SWIM);
+    sysbus = SYS_BUS_DEVICE(&m->swim);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+                                sysbus_mmio_get_region(sysbus, 0));
 
     /* NuBus */
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 8f23e0c4c6..06e095ae29 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,6 +33,7 @@
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
+#include "hw/block/swim.h"
 
 /*
  * The main Q800 machine
@@ -50,6 +51,7 @@ struct Q800MachineState {
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
+    Swim swim;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72C72175A
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nb3-0006UI-0g; Sun, 04 Jun 2023 09:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naf-0005MN-4I
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nac-0003QY-Gi
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=clKmotId3U/HxuPuiq+tTA3PIfrLG6vioCf0pl2bbvM=; b=wicUn9I7FkbxVgFQHcI25aa73X
 nbgn78WGONvRuY8TcP8Tc76+Is7YkoyYDNDF67Op5l5n1ggAY0vkJBv5xhavUm+mAzeqf5SXTsAB5
 mqtnwrBFHXOZ6fqED6bpkyf/EnKBwnacJ5txELbtbGNosIbJxZeKdrpYwQ5iL/RCRtNHxcNZ5N9s+
 fCcxTTWhVot0l1jId03AbdeGC4tangLZkbjjAD85a7rfodVVsMprnvgcoMCuXHe/4D0SW9rOwf1K3
 O4Xg9nXjNhvzxAtvAEZzqY44n7b/w70UfgXeYIpazeF/h5pU/LiU+TUBejEvkjsKmGJBx3Tj6Dq91
 Kig/mdSLuVSL0/MfWOpYamH+zaiRO71AKceuaczp7g2BsH9cpMyJJwmej/QX5kyUx0wPT9dm7xQYS
 Am5j0ER8aFXeGGDDO/dYE7P+MQiKNjzeit1p4drDxu2nNYj+wkB60gbkgm6nLQwrkr8v3zZC68wjb
 WCoortPGkYO02dxb+dRcGVxb3WwsDFASmdVY5UUCzBgBO6Rt1aoGTFRG5ZlZ6b72/XpQNCaFzc/hG
 A6p36gvsSZkV2rvOEI0JL/gXOV7TR09+ALvOG6DTIYeeXaQyLDXnvcCvIfq1xS3imowMI29zYzuA1
 DUw/OBHVQkjkki259AKBSomwf+T2f2pNfcwTxpqww=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naH-0005pb-J3; Sun, 04 Jun 2023 14:15:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:44 +0100
Message-Id: <20230604131450.428797-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 17/23] q800: move ESP device to Q800MachineState
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

Also change the instantiation of the ESP device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 9 +++++----
 include/hw/m68k/q800.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 0a415a7c6a..3ab4607134 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -376,8 +376,9 @@ static void q800_machine_init(MachineState *machine)
 
     /* SCSI */
 
-    dev = qdev_new(TYPE_SYSBUS_ESP);
-    sysbus_esp = SYSBUS_ESP(dev);
+    object_initialize_child(OBJECT(machine), "esp", &m->esp,
+                            TYPE_SYSBUS_ESP);
+    sysbus_esp = SYSBUS_ESP(&m->esp);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = NULL;
     esp->dma_memory_write = NULL;
@@ -385,8 +386,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus_esp->it_shift = 4;
     esp->dma_enabled = 1;
 
-    sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus = SYS_BUS_DEVICE(&m->esp);
+    sysbus_realize(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
     sysbus_connect_irq(sysbus, 0,
                        qemu_irq_invert(
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 36e1bd8e4e..8f23e0c4c6 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -32,6 +32,7 @@
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
+#include "hw/scsi/esp.h"
 
 /*
  * The main Q800 machine
@@ -48,6 +49,7 @@ struct Q800MachineState {
     dp8393xState dp8393x;
     ESCCState escc;
     OrIRQState escc_orgate;
+    SysBusESPState esp;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2



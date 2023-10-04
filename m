Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBF7B7A3F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxPF-000457-9r; Wed, 04 Oct 2023 04:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPD-00042M-Gs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxPB-0007f4-2R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1YYmerWrP1fexZav6nISrGNLIh0dqGrzl0rAYflDWKk=; b=X4vQ8lvw5gTmiCUmrnW56rPcsh
 i6OdGahQ/mXAt9ZevrjWaJHZQVq9Q6lOwejmLIfsKkvloQ/sWrLUxOYRtyG+OeFbbx7H4rgdKl5kj
 Oc7ZLsvAu2i8YRSiv83Ssd1phNBe82+/pQ6zn4ceK3sGhJ8ZKHUS7KE/cxCXC/b0cf8E/Ddmtjs45
 akCIoiQ/XRkkTZ1HTuT+o2mYytKtyLjpNPnuBlb4pIuVR92E+HpHjcFz5IGsyISuotSAsc4i+/D1q
 dOLTPiq2ltym+uY54RP/qYYNcIoY6YK5Iudfql09WAHLCieA9P8CkHdq17w6kK1aXqfLy4UiOTzDU
 gCfU1ilfkq5wT1HePJfwc6ngtnLaCDrulIvo2k5epn8bY7SRtY7dZnfRtE8ojb9ilfv4fepANdyH8
 0Cl9iUplV5np7bjLbD1Px+pm4llUbl5hKoV5MCVv6UXKu5xLRLbYQhShYeFsvTh7KvXCZCw1w8N/r
 mvVHcDUC3IfyHjpIxkb0oL35sJv1g1KFx6BVvcKtAGDaETJrwb9MYPAQvgFzzPLDH4w9I4twoTnUy
 MGWUbwz+hVhNh6zghu/pUm97OsQakQo5h1T73Dz9UgOI/n6QAL1zvj8A6Ca9dbWqykf2WXNeCzJDw
 2FodwQKaISwRu886hO3MQGORtRzdnZZCORh1V9Tdk=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOw-0006za-NP; Wed, 04 Oct 2023 09:38:42 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:37:56 +0100
Message-Id: <20231004083806.757242-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 10/20] q800: add easc bool machine class property to switch
 between ASC and EASC
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

This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
(default) or to original mode. The real Q800 hardware used an EASC chip however
a lot of older software only works with the older ASC chip.

Adding this as a machine parameter allows QEMU to be used as an developer aid
for testing and migrating code from ASC to EASC.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/m68k/q800.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 249fedde7a..ac3115d328 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -484,7 +484,8 @@ static void q800_machine_init(MachineState *machine)
     /* Apple Sound Chip */
 
     object_initialize_child(OBJECT(machine), "asc", &m->asc, TYPE_ASC);
-    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", ASC_TYPE_EASC);
+    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", m->easc ? ASC_TYPE_EASC
+                                                            : ASC_TYPE_ASC);
     if (machine->audiodev) {
         qdev_prop_set_string(DEVICE(&m->asc), "audiodev", machine->audiodev);
     }
@@ -677,6 +678,28 @@ static void q800_machine_init(MachineState *machine)
     }
 }
 
+static bool q800_get_easc(Object *obj, Error **errp)
+{
+    Q800MachineState *ms = Q800_MACHINE(obj);
+
+    return ms->easc;
+}
+
+static void q800_set_easc(Object *obj, bool value, Error **errp)
+{
+    Q800MachineState *ms = Q800_MACHINE(obj);
+
+    ms->easc = value;
+}
+
+static void q800_init(Object *obj)
+{
+    Q800MachineState *ms = Q800_MACHINE(obj);
+
+    /* Default to EASC */
+    ms->easc = true;
+}
+
 static GlobalProperty hw_compat_q800[] = {
     { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
     { "scsi-hd", "vendor", " SEAGATE" },
@@ -710,11 +733,16 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "m68k_mac.ram";
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
+
+    object_class_property_add_bool(oc, "easc", q800_get_easc, q800_set_easc);
+    object_class_property_set_description(oc, "easc",
+        "Set to off to use ASC rather than EASC");
 }
 
 static const TypeInfo q800_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("q800"),
     .parent     = TYPE_MACHINE,
+    .instance_init = q800_init,
     .instance_size = sizeof(Q800MachineState),
     .class_init = q800_machine_class_init,
 };
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 790cf433f3..fbaacd88bd 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -47,6 +47,7 @@
 struct Q800MachineState {
     MachineState parent_obj;
 
+    bool easc;
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82534799733
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeuai-0005mI-1w; Sat, 09 Sep 2023 05:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaf-0005m1-Vn
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuac-0005JX-Qn
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D6N/3Cf2qgjDzEc0mWjGEK7+JHNO8XTzIGyvtL1uekc=; b=aAoS/YU+QCLVPvwUagqS1PULG3
 NzQkvsf6wWeBvODYawIxMd0DNVjUr+UVAvkZbAmWacaee+tR2QWJ/4KWhXJCBHoUrE4QN6N+Y9/9b
 p1z0joBBGWwsycKbrZOnA0OuyX8db26UgpqVzK8ktIY0JDBhKJ93UFjLgHr48dhh/QNcbNx1sGG8q
 +9868ERwlDY6l6N8gpMNWrLvjq+A/6C9B4QVKKncQ2KtfiKm+5DXWkrfFVz/qLqVYGvrCdHelWfKG
 KMM+Jj2FkyByyLiwfKALnzLhv7Vk38+FJeWuTHT8jx4iKJhcmponhBdD/e3yvnXBAMdKMRopsUnD8
 GUrKzSXXClVh7IURsB6H4QCv74yLBy8QTOsNBJBd7PBefk31j49Kbi9NirTNyWaq7TgkXEsKxPV/H
 8qG0RudG4iZrkUkMiy41vJqmICrMvHC6R+7qE6ex4UZBLKEDcWag79pn4f6Voingn2b77jmjxYL7l
 k5ss49VwFF7UcP8jUgUCdWAzjQy8MrdsCNItiQWz6thY2f9gCdbvT4pHJGaWaBpqeLnfFhws053ip
 5fBgsbZDJfNSovN1KFFoGmUntMja3CnfCbxZpERckoibXw47gSbbtH1674aQosmYSy00p8n4Z1pTw
 6MoMUJXLxotMBFvfPiLEh7yl9PGE+8u6sok+e1JP8=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuaV-0000uO-Kq; Sat, 09 Sep 2023 10:49:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:17 +0100
Message-Id: <20230909094827.33871-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/20] q800: add easc bool machine class property to switch
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
---
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/m68k/q800.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ae07aa20ff..5ae7c37760 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -484,7 +484,8 @@ static void q800_machine_init(MachineState *machine)
     /* Apple Sound Chip */
 
     object_initialize_child(OBJECT(machine), "asc", &m->asc, TYPE_ASC);
-    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", ASC_TYPE_EASC);
+    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", m->easc ? ASC_TYPE_EASC
+                                                            : ASC_TYPE_ASC);
     sysbus = SYS_BUS_DEVICE(&m->asc);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
@@ -674,6 +675,28 @@ static void q800_machine_init(MachineState *machine)
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
@@ -706,11 +729,16 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
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



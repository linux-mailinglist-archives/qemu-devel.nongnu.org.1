Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9C70FFDF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmq-0003Uq-0H; Wed, 24 May 2023 17:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vma-0002xv-QG
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmZ-00029j-97
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DzV8atBkeXtd7KUj1w2o2/ZfWsO29RXJehptBwu+h7E=; b=vx3t11SJ9YJRvwTu0WU5M53qZO
 3sbvOJVJe8Sj30L2amkhjqovjeUzbBnQL8/TQO6Tz9ETqeWaGuCi2OaL3/DNr4DC6v99vSlG6V5UX
 SBGgrasBCHXAmhMTSIHDwHxl6Zjkzv95kajCNoz2sGVwA0Y+3UAnmvA+1Ztikl8EPHnijoMysvd8Z
 JXbcnEWjsn5ThTYGzeKg8Yhi/NeWEE4YXehrsRuze2HkPfYRpFNQNdJnyFySjhNnW4r14YoQHelHu
 hoY5AQui7QHxGnBQNOKI1NmbFbFcEJKwMDaO5NoR4bzKPyIhHNxLwrT9IhzM+5MWsvvhA6Wblvudr
 eZqunFNJGYz+G3l3zX40rqe9mSonDMJSwyCPDCeQlaX5gpsX0HF9OX53nKDACE1gLhVPORS57ImLW
 lInJJzaan7+tVJMgrfPreM72vG3fZSRyea+KT4+sUsaoaupkJaxQActllGaU4GuO2jKTklmftXY1L
 i8v5y/AUdNchUdNeLKKNAzjBZbuEVYme1tqK2V21dTZR2TQFiGWbhmxjp46heXyeFtklMP0VYf2AN
 esVx9JOKzinZdqOc9uiMGxbD1LLqHBLXQn7K4Dcc2WyHrulkKbs2djLjfAcdymyN2Ck5xZeDmy+j2
 0vgw9nLA0x6WuTwcaxgRf0LIZ0VE8mm4kUE6qLJN4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmK-0005XR-TW; Wed, 24 May 2023 22:12:17 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:51 +0100
Message-Id: <20230524211104.686087-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/30] q800: add easc bool machine class property to switch
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

This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
(default) or to original mode. The real Q800 hardware used an EASC chip however
a lot of older software only works with the older ASC chip.

Adding this as a machine parameter allows QEMU to be used as an developer aid
for testing and migrating code from ASC to EASC.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/m68k/q800.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ed862f9e9d..1af1a06f64 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -710,7 +710,8 @@ static void q800_machine_init(MachineState *machine)
     /* Apple Sound Chip */
 
     dev = qdev_new(TYPE_ASC);
-    qdev_prop_set_uint8(dev, "asctype", ASC_TYPE_EASC);
+    qdev_prop_set_uint8(dev, "asctype", m->easc ? ASC_TYPE_EASC
+                                                : ASC_TYPE_ASC);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
@@ -886,6 +887,28 @@ static void q800_machine_init(MachineState *machine)
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
@@ -912,11 +935,16 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
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
index 0602d07d3d..0144be5e6e 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -30,6 +30,7 @@
 struct Q800MachineState {
     MachineState parent_obj;
 
+    bool easc;
     M68kCPU *cpu;
     MemoryRegion rom;
     DeviceState *glue;
-- 
2.30.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AE744E66
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 17:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFzKL-0004Rf-GR; Sun, 02 Jul 2023 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKJ-0004RJ-4O
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzKH-0007SK-H0
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 11:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EMVpZkewzdBU5s5V36FPZUP8gSfxVj3WxFjnNF32FeQ=; b=EDOTQZ6db4XYgTP3Ex2dOuYhys
 mqBw8AcSWhcIychmZdzwoqiK4UbPZePWRABQSPX0wfMQS7X7Ylf387++WXVs8+7/RMLewO/AzTunF
 kPnsYFOX5TNfLVeHyf5yOtyf5yApqgoStYgRkQiqYCwc314g387hkgNFAE0basBuwCgQrpYzMFOq8
 QQv3C+KwJ9t+Fi1uKY5EAUvfyrQv59mxu+VwDqudoJ+WZ6IRANElLjTEYo1ic0GI/5UCw+uK4iQgu
 9Pqk1LQmUQ38iMyhpnm69y7L1K7Ia438ZxdJ6cegf60T4l3zkV27+6AajFrMWF0e5C/uXZ4pfRjfr
 Zebe1zjML7yueCmKSJH4btL8FFXbK563pcGcmy+RPBqXytC/1vyCIQUkv8fs5QPnnFfCGRYbagY5K
 zA56HsfICoBI7FNr7m8q+pmkT3mX11HGqsvqjhaLEd17UyHeOyJt/is3h7mPbuPDDF3f9SgZZyVzA
 B4ERJ+QK9QJhbbmYa4c2RhFwt/K/Rrpf9AEoufbvISKovWn6o5bMeiuID29ebWJce14EdYc87VuWv
 EuYwBHewxBFWvRLAkUM+iDj/IRzwgKqxHz+QEGU2dwLSixzc2WSd1GjI8Q5PJ+n0SB86vz1K2hR30
 W4es3uLadElN68JVKjk7/TrHQu+L7HET8nf9gjUuk=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFzK2-0001Ji-3V; Sun, 02 Jul 2023 16:49:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  2 Jul 2023 16:48:27 +0100
Message-Id: <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/21] q800: add easc bool machine class property to switch
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
2.30.2



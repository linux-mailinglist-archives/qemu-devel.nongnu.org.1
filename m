Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122AB7BCCA9
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCu-00086k-Md; Sun, 08 Oct 2023 02:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCs-00086B-Um
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCq-0007mR-5n
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:02 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkIAB-1rIPUC3qGH-00kiLh; Sun, 08
 Oct 2023 08:23:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 10/20] q800: add easc bool machine class property to switch
 between ASC and EASC
Date: Sun,  8 Oct 2023 08:23:39 +0200
Message-ID: <20231008062349.2733552-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z5kHivFIfPWa5li91QFZtd6gZdzjeTycWhJu1OFpRn4NJLBOtyk
 dYXb+RNCBm0Bz/5+6P9K/tGj8kRrzMp4XImiU/cMhuouDLHy+SenZUz+5stu7DlSQ5yARAd
 deEcCu1oMWop7t2oLNImumw03liaJ2bZeDApu9Sz4dEd3CAPvd3PLVY//VvyyCy+B3fv5OZ
 4Q3hKrkEi+VWxXTRnX2ZQ==
UI-OutboundReport: notjunk:1;M01:P0:7kpVW6JFPhg=;C79jfdwdeb2iiZsieBlXtHyTcsB
 4z1T30RQyY/vM8cwpwYAw0ye6Pjt6uJL2o3tOYDZGsJGoXYC+guT5h5k0fNhDcbkAidX/lnJg
 6p0OaDXKR1aixyvn4btzHgS3q9Q6LuA664r23nLBmjZx8igsOEDC3Q1ZZqhRLt1sD1K3N+pim
 zZz9P3/dUdlxd6SD8sqdftIxBxsGIS7gBtql1ntLi2PHAJGa98AMplOO76LjQ1ZnGbWOaHhXD
 jnOO6C9XSEsSNnU4skqsHHe2i9g9LQMWTK/uOTVe4zb6c2ArPMVs087UdZ4k2ftn/iT4weG3w
 tZ7frvv6l6obtKIqUUeDGzE4f5DZR9sRuUqamcahqFjzDukognUhUuRvSXZN3d7WtZ4IIQlip
 rGDffiss5Cy0kMIyGHhSA4J+vdRkBS4Wnujzi1mcD6/XR0QGMHxFCUbT+NQgVYKjfRvxBsqPz
 N07IQBYT7yzuRGKZd5Ioz+xVT/m2H0dSr5GLUzLtvJx9l9tvTuxZvv2RN3vQt3xojRGm/g2IZ
 +dWVxUk6aDBMP5dUm7rSdp1V7PyjRmklrLoPFgWTg6C1OISgcaH93CH2EJZUWt+xjmwt6BGvm
 yS/ffVpClwfmFPC2kiaUxCZSfdYjf88jcfD6hzNmmtfW1whE5Ywoz5S7adktwUTF5UZp0sKAZ
 YFE2hm+5E6KUHmNfYCiSjBTP3uLrGVAjrTw9jVYIphklzXwl6Vq24H9/QEOZtgLEwZ3EW3LmH
 mBoxKnmjT88Z8aNgvnJ9+JKCrJByG+gdziRO7SRzlPRIvGwLiZILu3aZtXc7u0j4jGBZ2pbre
 ldFg3ZGHZBQorEd7WlWsIOFSqCtdjFaDXNiG/fi5COWLV2zHZvsAWEkAbF1iSWjIKaUafMLdY
 Bfp9YyBYFPDrmEw==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
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

This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
(default) or to original mode. The real Q800 hardware used an EASC chip however
a lot of older software only works with the older ASC chip.

Adding this as a machine parameter allows QEMU to be used as an developer aid
for testing and migrating code from ASC to EASC.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231004083806.757242-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  1 +
 hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 790cf433f38d..fbaacd88bd57 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -47,6 +47,7 @@
 struct Q800MachineState {
     MachineState parent_obj;
 
+    bool easc;
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 249fedde7a92..ac3115d32844 100644
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
-- 
2.41.0



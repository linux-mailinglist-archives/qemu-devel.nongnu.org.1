Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 087967CD892
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38e-0001Mq-Bm; Wed, 18 Oct 2023 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38R-0001JT-Hp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:40 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38O-0003Z0-NV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9QwT4MxPz4xc9;
 Wed, 18 Oct 2023 20:46:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9QwR3hRBz4xbC;
 Wed, 18 Oct 2023 20:46:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/22] ramfb-standalone: add migration support
Date: Wed, 18 Oct 2023 11:45:30 +0200
Message-ID: <20231018094531.733211-22-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a "ramfb-dev" section whenever "x-migrate" is turned on. Turn it off
by default on machines <= 8.1 for compatibility reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/core/machine.c             |  1 +
 hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cfd1edfe20b53f2a2e5a7963f63a285fea6fef56..6305f2d7a4bbe25e0c132737bc8ebda83f7fd3a2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@
 
 GlobalProperty hw_compat_8_1[] = {
     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
+    { "ramfb", "x-migrate", "off" },
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 8c0094397f5b384df94cafa87cc854d4353e19f4..a96e7ebcd9fa57989475e25b75599990acbe884f 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/loader.h"
@@ -15,6 +16,7 @@ struct RAMFBStandaloneState {
     SysBusDevice parent_obj;
     QemuConsole *con;
     RAMFBState *state;
+    bool migrate;
 };
 
 static void display_update_wrapper(void *dev)
@@ -40,14 +42,39 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
     ramfb->state = ramfb_setup(errp);
 }
 
+static bool migrate_needed(void *opaque)
+{
+    RAMFBStandaloneState *ramfb = RAMFB(opaque);
+
+    return ramfb->migrate;
+}
+
+static const VMStateDescription ramfb_dev_vmstate = {
+    .name = "ramfb-dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = migrate_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(state, RAMFBStandaloneState, ramfb_vmstate, RAMFBState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ramfb_properties[] = {
+    DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ramfb_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->vmsd = &ramfb_dev_vmstate;
     dc->realize = ramfb_realizefn;
     dc->desc = "ram framebuffer standalone device";
     dc->user_creatable = true;
+    device_class_set_props(dc, ramfb_properties);
 }
 
 static const TypeInfo ramfb_info = {
-- 
2.41.0



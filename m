Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A57A75DD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qisY5-0007CM-0q; Wed, 20 Sep 2023 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qisY1-0007CC-QB
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qisXy-0006uT-Ad
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695198417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G7N9JWckBeFiVD56IwiI8iv3J3sHNMXPObHxvzioJno=;
 b=MzXJTksDUj6sZprDKu1BwGeFysxZkZsNVQdUUBwVhBIkIQPd6iKqNv2ttufEZu4XmFUZcp
 eDjxGvQ5Tw9Wm5Ozun6v2Gzwwnf5p73X1uXBfAGapc/TxhbfwllqxZtjG15F1+lEgDeyrB
 2zLFJFRJeBv8o9LPzY6slHzIInya0OM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-akEXkoVVO42xQ4t5BL0Udg-1; Wed, 20 Sep 2023 04:26:54 -0400
X-MC-Unique: akEXkoVVO42xQ4t5BL0Udg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABEB8858281
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 08:26:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 949752156701;
 Wed, 20 Sep 2023 08:26:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ramfb: implement migration support
Date: Wed, 20 Sep 2023 12:26:51 +0400
Message-ID: <20230920082651.3349712-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implementing RAMFB migration seems quite straightforward. Unfortunately,
current QEMU didn't block migration when RAMFB was used.

Having an extra "ramfb" VMState doesn't seem to "break" migration
forward compatibility. Surprisingly, missing sections are being ignored?

Backward compatiblity however will have this extra error:
qemu: Unknown savevm section or instance 'ramfb' 0. Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1859424

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 1fe6a817cd..116d674348 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
@@ -28,6 +29,8 @@ struct QEMU_PACKED RAMFBCfg {
     uint32_t stride;
 };
 
+typedef struct RAMFBCfg RAMFBCfg;
+
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
@@ -116,6 +119,38 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
     dpy_gfx_update_full(con);
 }
 
+static int ramfb_post_load(void *opaque, int version_id)
+{
+    ramfb_fw_cfg_write(opaque, 0, 0);
+    return 0;
+}
+
+static const VMStateDescription vmstate_ramfb_cfg = {
+    .name = "ramfb-cfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(addr, RAMFBCfg),
+        VMSTATE_UINT32(fourcc, RAMFBCfg),
+        VMSTATE_UINT32(flags, RAMFBCfg),
+        VMSTATE_UINT32(width, RAMFBCfg),
+        VMSTATE_UINT32(height, RAMFBCfg),
+        VMSTATE_UINT32(stride, RAMFBCfg),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_ramfb = {
+    .name = "ramfb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = ramfb_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(cfg, RAMFBState, 0, vmstate_ramfb_cfg, RAMFBCfg),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
@@ -128,6 +163,7 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    vmstate_register(NULL, 0, &vmstate_ramfb, s);
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546E7B50F3
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGqc-0006sC-Dl; Mon, 02 Oct 2023 07:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGqX-0006ra-9H
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGqV-0002VD-Mz
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696245134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8LhizmIJRtDSSnK3WgKAQ1IvZqiUMBGDDQKxZDqFKI=;
 b=eFr/5MyBu53xhgsMZU7uZRzpy2KoS4LDmA9y6sl+pHtpMNCx6p+EbwAXHgS88YTZYCRlZU
 0zX0AeW8JAxWxn+RpFsTvOT3o1aBbMJJTAJjSueR5KkOlK6Nv79xV+n4D0xULmW47GDBtB
 CIcmdc41gJPhbTkD/6ecI/CNQhqgOok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-Ub_8L5k_OY6B7ibGgO7Chg-1; Mon, 02 Oct 2023 07:12:12 -0400
X-MC-Unique: Ub_8L5k_OY6B7ibGgO7Chg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC825817055
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 11:12:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB1B8C15BB8;
 Mon,  2 Oct 2023 11:12:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/5] ramfb: implement migration support
Date: Mon,  2 Oct 2023 15:11:51 +0400
Message-ID: <20231002111154.1002655-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implementing RAMFB migration is quite straightforward. One caveat is to
treat the whole RAMFBCfg as a blob, since that's what is exposed to the
guest directly. This avoid having to fiddle with endianness issues if we
were to migrate fields individually as integers.

The following patches turns the migration only on machine >= 8.2.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1859424

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 79b9754a58..4aaaa7d653 100644
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
@@ -115,6 +118,23 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
     dpy_gfx_update_full(con);
 }
 
+static int ramfb_post_load(void *opaque, int version_id)
+{
+    ramfb_fw_cfg_write(opaque, 0, 0);
+    return 0;
+}
+
+static const VMStateDescription vmstate_ramfb = {
+    .name = "ramfb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = ramfb_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER_UNSAFE(cfg, RAMFBState, 0, sizeof(RAMFBCfg)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
@@ -127,6 +147,7 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
+    vmstate_register(NULL, 0, &vmstate_ramfb, s);
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
-- 
2.41.0



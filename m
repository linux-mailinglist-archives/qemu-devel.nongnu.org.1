Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160D7BD362
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjpU-0007Si-3v; Mon, 09 Oct 2023 02:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjpG-0007QC-N8
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjp5-0004FW-12
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adltbxBS7/jIiugdOlR+9IVi5golY1JaftJuPFsBS3s=;
 b=SCzPf4ak6nUJVLvhg2fL2h0m8Q63/s+FVayt4qI4RoKyiRN7H6wNoBGy0DnFeSUy+3U5t2
 GZMeiZ2mlMo02xZYCGw9UD9mW+YILfkuudjIDTeVrNjO+tCOJ6KvpwWHDQDh7gOMEj3xu5
 S7fnD3X5BO5SPjTgL3NU+W8QTsu1Hgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-7xOF4E2ONi-YPI0xCYzdAw-1; Mon, 09 Oct 2023 02:32:54 -0400
X-MC-Unique: 7xOF4E2ONi-YPI0xCYzdAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE2585A5BE
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 06:32:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E70563F51;
 Mon,  9 Oct 2023 06:32:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 1/3] ramfb: add migration support
Date: Mon,  9 Oct 2023 10:32:45 +0400
Message-ID: <20231009063247.119333-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231009063247.119333-1-marcandre.lureau@redhat.com>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The devices using RAMFB will have to include ramfb_vmstate in their
migration description.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/display/ramfb.h |  4 ++++
 hw/display/ramfb.c         | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index b33a2c467b..a7e0019144 100644
--- a/include/hw/display/ramfb.h
+++ b/include/hw/display/ramfb.h
@@ -1,11 +1,15 @@
 #ifndef RAMFB_H
 #define RAMFB_H
 
+#include "migration/vmstate.h"
+
 /* ramfb.c */
 typedef struct RAMFBState RAMFBState;
 void ramfb_display_update(QemuConsole *con, RAMFBState *s);
 RAMFBState *ramfb_setup(Error **errp);
 
+extern const VMStateDescription ramfb_vmstate;
+
 /* ramfb-standalone.c */
 #define TYPE_RAMFB_DEVICE "ramfb"
 
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index c2b002d534..477ef7272a 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -28,6 +28,8 @@ struct QEMU_PACKED RAMFBCfg {
     uint32_t stride;
 };
 
+typedef struct RAMFBCfg RAMFBCfg;
+
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
@@ -116,6 +118,23 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
     dpy_gfx_update_full(con);
 }
 
+static int ramfb_post_load(void *opaque, int version_id)
+{
+    ramfb_fw_cfg_write(opaque, 0, 0);
+    return 0;
+}
+
+const VMStateDescription ramfb_vmstate = {
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
-- 
2.41.0



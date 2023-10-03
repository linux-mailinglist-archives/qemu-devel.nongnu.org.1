Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F317B64D2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:58:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbDc-0004aF-J9; Tue, 03 Oct 2023 04:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDQ-0004ZS-PF
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDP-00062r-8X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696323433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=di+gjJ7xg7sqlbEKFkCRNq81+BLBzDPze2Tes4z1OAc=;
 b=bxmi6239J0hGLzU0otSNcGItabi2BRvhzsO4AEv+eFSiLIGpa5aOzZT8rFyTRImh+AksR1
 lTXrRlFUznXyKVMSC8pqvuPjJWKfbPEif2v4a/FTO5UbH4mb7BckRlJ59OD4FabKRIigzl
 6SFtx0S7ISpDKcowfbH3++KPLCUD7eI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-hWyyPCKMPMiW7atuLN6z2w-1; Tue, 03 Oct 2023 04:57:01 -0400
X-MC-Unique: hWyyPCKMPMiW7atuLN6z2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16334811E7B
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 08:57:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4B740C6EA8;
 Tue,  3 Oct 2023 08:56:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 3/5] ramfb: add migration support
Date: Tue,  3 Oct 2023 12:56:42 +0400
Message-ID: <20231003085644.1220326-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Implementing RAMFB migration is quite straightforward. One caveat is to
treat the whole RAMFBCfg as a blob, since that's what is exposed to the
guest directly. This avoid having to fiddle with endianness issues if we
were to migrate fields individually as integers.

The devices using RAMFB will have to include ramfb_vmstate in their
migration description.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 79b9754a58..32ccb7053b 100644
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
@@ -115,6 +117,23 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
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



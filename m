Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B77B64D0
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbDW-0004ZK-G7; Tue, 03 Oct 2023 04:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDJ-0004Z1-IK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDH-00062Q-NW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696323426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlftELdBxGJY5aZ5bQGDxYDyRCUFmkbXwjprSdZdJHc=;
 b=YR8hZsc1P52XE+UHU1vy0LYpyj3MtcuZY1ytR8DIud0PVkNL0/H1UrqyJvxb5/+wjY46By
 huUZFyFRaRV4es2vNQR1/vs0a7dw8+hmNKCNe0seDPwQ4Dysklr2kReY8tpxJnKsyWkbxQ
 q/kU1kav/TQ0GfJ0NXc/E6EO1wXfxzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-KExtRzYlNUuRyzSlszg5zQ-1; Tue, 03 Oct 2023 04:57:05 -0400
X-MC-Unique: KExtRzYlNUuRyzSlszg5zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14B5B811E91;
 Tue,  3 Oct 2023 08:57:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 137A82156701;
 Tue,  3 Oct 2023 08:57:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v3 4/5] ramfb-standalone: add migration support
Date: Tue,  3 Oct 2023 12:56:43 +0400
Message-ID: <20231003085644.1220326-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Add a "ramfb-dev" section whenever "x-migrate" is turned on. Turn it off
by default on machines <= 8.1 for compatibility reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c             |  4 +++-
 hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index df40f10dfa..47a07d1d9b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,7 +30,9 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 
-GlobalProperty hw_compat_8_1[] = {};
+GlobalProperty hw_compat_8_1[] = {
+    { "ramfb", "x-migrate", "off" },
+};
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
 GlobalProperty hw_compat_8_0[] = {
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 8c0094397f..a96e7ebcd9 100644
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



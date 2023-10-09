Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3497BD364
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjpU-0007Sb-3R; Mon, 09 Oct 2023 02:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjpG-0007QE-TI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjpC-0004J0-6H
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PqlCMNG44aZ1iVWO6uSjgq/nG4+dxRxaMeBbNTtj54=;
 b=AlSEVRQ64wFeXl001pEKgjWuuHwK/H2eNW5z0p92foGByqtl84l7Om0yWskk44xsltTlrv
 LGeSvWdLW1QO7yA9Bd5q1ML0XQZ8KzqAkY1OU2IBoMJefYKfISzWlKPwSNSYaBPozExizD
 nQqMHqv10sjgbBmhFaIM0s2rg8bmQSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-nSvDXQgrNtSuIO8H0F1HQg-1; Mon, 09 Oct 2023 02:32:59 -0400
X-MC-Unique: nSvDXQgrNtSuIO8H0F1HQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1E541C068D7;
 Mon,  9 Oct 2023 06:32:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92A5240C6EA8;
 Mon,  9 Oct 2023 06:32:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 2/3] ramfb-standalone: add migration support
Date: Mon,  9 Oct 2023 10:32:46 +0400
Message-ID: <20231009063247.119333-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231009063247.119333-1-marcandre.lureau@redhat.com>
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Add a "ramfb-dev" section whenever "x-migrate" is turned on. Turn it off
by default on machines <= 8.1 for compatibility reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/core/machine.c             |  1 +
 hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cfd1edfe20..6305f2d7a4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@
 
 GlobalProperty hw_compat_8_1[] = {
     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
+    { "ramfb", "x-migrate", "off" },
 };
 const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
 
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



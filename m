Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBF7DB88B
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:52:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPpr-0004KV-QN; Mon, 30 Oct 2023 06:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpp-00049B-U6
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpo-0002is-AY
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698662967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ngzny1QtASkwy4IfrDWfVKDSut+nimzaGhnpW+xw2xM=;
 b=OEO0FzIc7v8th96civoKYLQn2JgKK/jke0qy2bKq2Zf7O4S9zZP/vjgNb5xNRaQXMTjhzd
 ICci/tiuFfO0WYGz3OdbkJ31gQSbLQ5zFp3y/sPwegwUrYegwhyTeIvj/V/dZ9PZKbCntX
 hS0w5ReQrzfsqxe4WO+E04NmT8I/hno=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-ft2FurLLNsOXejUIxoMYvA-1; Mon,
 30 Oct 2023 06:49:26 -0400
X-MC-Unique: ft2FurLLNsOXejUIxoMYvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D68753826D23;
 Mon, 30 Oct 2023 10:49:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B174F2026D4C;
 Mon, 30 Oct 2023 10:49:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v7 17/23] ui/spice: SPICE/QXL requires PIXMAN
Date: Mon, 30 Oct 2023 14:47:48 +0400
Message-ID: <20231030104755.124188-18-marcandre.lureau@redhat.com>
In-Reply-To: <20231030104755.124188-1-marcandre.lureau@redhat.com>
References: <20231030104755.124188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 meson.build        |  6 +++++-
 hw/display/Kconfig |  2 +-
 ui/meson.build     | 10 +++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index f3fc1ba68d..0dbad80fcc 100644
--- a/meson.build
+++ b/meson.build
@@ -1015,7 +1015,11 @@ if not get_option('spice_protocol').auto() or have_system
                               method: 'pkg-config')
 endif
 spice = not_found
-if not get_option('spice').auto() or have_system
+if get_option('spice') \
+             .disable_auto_if(not have_system) \
+             .require(pixman.found(),
+                      error_message: 'cannot enable SPICE if pixman is not available') \
+             .allowed()
   spice = dependency('spice-server', version: '>=0.14.0',
                      required: get_option('spice'),
                      method: 'pkg-config')
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 7b3da68d1c..4d8b0cec40 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -93,7 +93,7 @@ config VGA
 
 config QXL
     bool
-    depends on SPICE && PCI
+    depends on SPICE && PCI && PIXMAN
     select VGA
 
 config VIRTIO_GPU
diff --git a/ui/meson.build b/ui/meson.build
index 19723188b5..024f494faf 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -141,12 +141,12 @@ if spice.found()
     'spice-display.c'
   ))
   ui_modules += {'spice-core' : spice_core_ss}
-endif
 
-if spice.found() and gio.found()
-  spice_ss = ss.source_set()
-  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
-  ui_modules += {'spice-app': spice_ss}
+  if gio.found()
+    spice_ss = ss.source_set()
+    spice_ss.add(spice, gio, pixman, files('spice-app.c'))
+    ui_modules += {'spice-app': spice_ss}
+  endif
 endif
 
 keymaps = [
-- 
2.41.0


